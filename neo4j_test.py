from neo4j import GraphDatabase

# URI examples: "neo4j://localhost", "neo4j+s://xxx.databases.neo4j.io"
URI = "neo4j+s://25783bde.databases.neo4j.io"
AUTH = ("neo4j", "_yLFp-vNefPMZSUSsmz6KOhunTy3mN98oSNPOLdwkUw")

with GraphDatabase.driver(URI, auth=AUTH) as driver:
    driver.verify_connectivity()