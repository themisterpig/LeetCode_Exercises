SELECT p.firstName, p.LastName, a.city, a.state
FROM Person p
LEFT OUTER JOIN Address a ON p.personID = a.personID;
