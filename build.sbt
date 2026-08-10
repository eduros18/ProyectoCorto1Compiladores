ThisBuild / scalaVersion := "3.8.4"

name := "ProyectoCorto1Compiladores"
version := "1.0"

libraryDependencies ++= Seq(
  "org.mongodb.scala" %% "mongo-scala-driver" % "5.7.1",
  "org.apache.pdfbox" % "pdfbox" % "3.0.8"
)