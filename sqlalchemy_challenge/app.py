import sqlalchemy
from sqlalchemy.ext.automap import automap_base
from sqlalchemy.orm import Session
from sqlalchemy import create_engine, func

import datetime as dt
import numpy as np


from flask import Flask, jsonify

#################################################
# Database Setup
#################################################
engine = create_engine("sqlite:///Resources/hawaii.sqlite")

# reflect an existing database into a new model
Base = automap_base()
# reflect the tables
Base.prepare(engine, reflect=True)
# We can view all of the classes that automap found
Base.classes.keys()
# Save references to each table
Measurement = Base.classes.measurement
Station = Base.classes.station
# Create our session (link) from Python to the DB
session = Session(engine)

#################################################
# Flask Setup
#################################################
app = Flask(__name__)

@app.route("/")
def welcome():
    """List all available api routes."""
    return (
        f"Available Routes:<br/>"
        f"/api/v1.0/precipitation<br/>"
        f"/api/v1.0/stations<br/>"
        f"/api/v1.0/tobs<br/>"
        f"/api/v1.0/$start<br/>"
        f"/api/v1.0/$start/$end<br/>"
    )

@app.route("/api/v1.0/precipitation")
def precipitation():
	dict_prcp = {}
	result = session.query(Measurement).all()
	
	for record in result:
		dict_prcp.update({record.date: record.prcp})

	return jsonify(dict_prcp)


@app.route("/api/v1.0/stations")
def stations():
	stations = []
	result = session.query(Station.station).all()
	stations = list(np.ravel(result))
	return jsonify(stations)


@app.route("/api/v1.0/tobs")
def tobs():

	tobs_previous_year = []

	last_date_point = session.query(Measurement.date).order_by(Measurement.date.desc()).first()
	last_year = last_date_point.date.split('-')[0]
	last_month = last_date_point.date.split('-')[1]
	last_date = last_date_point.date.split('-')[2]

	year_ago = dt.date(int(last_year),int(last_month), int(last_date)) - dt.timedelta(days=365)
	str_year_ago = year_ago.strftime("%Y-%m-%d")

	query_result = session.query(Measurement).filter(Measurement.date > str_year_ago).all()

	for record in query_result:
		tobs_previous_year.append({record.date: record.tobs})

	return jsonify(tobs_previous_year)


@app.route("/api/v1.0/<start>")
def calc_temps(start):
	result = session.query(func.min(Measurement.tobs), func.max(Measurement.tobs), func.avg(Measurement.tobs)).filter(Measurement.date >= start).all()
	return jsonify(result)


@app.route("/api/v1.0/<start>/<end>")
def calc_temps_range(start, end):
	return jsonify(session.query(func.min(Measurement.tobs), func.avg(Measurement.tobs), func.max(Measurement.tobs)).\
        filter(Measurement.date >= start).filter(Measurement.date <= end).all())


if __name__ == "__main__":
    app.run(debug=True)

