from flask_restful import Resource
import logging as logger
import pymysql

conn = pymysql.connect(host="13.234.48.85", user="root", password="Password@123", database="testing")
mydbconnection = conn.cursor()

class Task(Resource):

    def post(self,id,name):
        logger.debug("Inisde the post method of Task - adding user")
        mydbconnection.execute("INSERT INTO employee(emp_id, emp_name) VALUES(%s, %s);"),200
        #return {"message" : "added user"}
        conn.commit()
        conn.close()


    def get(self,id,name):
        logger.debug("Inisde the get method of Task")
        mydbconnection.execute("SELECT * FROM employee;")
        #return {"message" : mydbconnection.fetchall()},200
        conn.commit()
        conn.close()

    def put(self,id,name):
        logger.debug("Inisde the put method of Task")
        mydbconnection.execute("UPDATE employee names SET emp_name=name WHERE emp_id=id;"),200
        return {"message" : mydbconnection.fetchall()},200
        conn.commit()
        conn.close()

    def delete(self,id):
        logger.debug("Inisde the delete method of Task")
        mydbconnection.execute("DELETE FROM employee WHERE emp_id=id;"),200
        #return {"message" : "Inside delete method"}
        conn.commit()
        conn.close()





