-- Number of answers for each question,
-- Top 100 with most answers

SELECT parentId, COUNT(parentId) AS NumQ
FROM Posts
WHERE postTypeId = 2  -- only the answers
GROUP parentId
ORDER BY NumQ DESC
LIMIT 100;




-- Alternative approach to Bonus answer for Assignment 3.



Qid NumAnswers  NumQComment NumTotalComments
^^^^^^^^^^^^^^
Qry1


^^^             ^^^^
Qry2


^^^^                         ^^^^^^^^^
Qry 3


-- Qry1   Table  Qid   NumAnswers


SELECT parentId AS Qid, COUNT(parentId) AS NumAnswers
FROM Posts
WHERE postTypeId = 2
GROUP parentId;




-- Qry2   Table  Qid   NumQComments


SELECT parentId AS Qid, COUNT(Comments.postId) AS NumQComments
FROM Posts
LEFT JOIN Comments
ON   Comments.postId = Post.id
WHERE postTypeId = 1
GROUP parentId;


--- Now join these
-- rearranging the rows to match across the two tables.

SELECT *
FROM ( Query 1) AS A,
LEFT JOIN ( Query2 ) AS B
ON A.Qid = B.Qid;


-- Qry 3 is a little trickier
-- We really do need to join the Answer tuples with the Comments
-- but also count the number of comments on the question.
-- We could simplify this and compute the number of
-- comments on all answers  with the same parentId, i.e., same question
-- Then we we join this, we can add the NumQComments

SELECT parentId, COUNT(DISTINCT Comments.Id) AS NumAnsComments
FROM Posts AS A
LEFT JOIN Comments
ON Comments.postId = A.Id
GROUP BY parentId;


-- Join all three

SELECT A.Qid, NumAnswers, NumQComments, NumAnsComments + NumQComments
FROM ( Query 1) AS A,
LEFT JOIN ( Query2 ) AS B
ON A.Qid = B.Qid
LEFT JOIN ( Query 3) AS C
ON  A.Qid = C.parentId;



