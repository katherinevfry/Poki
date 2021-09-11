--1. What grades are stored in the database?

Select *
FROM Grade


--2. What emotions may be associated with a poem?

SELECT *
FROM Emotion

--3. How many poems are in the database?

SELECT COUNT(*) as NumberOfPoems
FROM Poem
--4. Sort authors alphabetically by name. What are the names of the top 76 authors?

SELECT TOP(76) *
FROM Author
Order BY [Name] 

--5. Starting with the above query, add the grade of each of the authors.

SELECT TOP(76) *
FROM Author a
JOIN Grade g
ON a.GradeId = g.Id


--6. Starting with the above query, add the recorded gender of each of the authors.

SELECT TOP(76) *
FROM Author a
JOIN Grade g
ON a.GradeId = g.Id
JOIN Gender gd
ON a.GenderId = gd.Id

--7. What is the total number of words in all poems in the database?

SELECT SUM(WordCount) as TotalWords
FROM Poem

--8. Which poem has the fewest characters?

SELECT TOP(1) Title, SUM(CharCount) as CharC
FROM Poem
GROUP BY Title
ORDER BY CharC

--9. How many authors are in the third grade?

SELECT COUNT(*) as NumOf3rd
FROM Author a
JOIN Grade g
ON a.GradeId = g.Id
WHERE a.GradeId = 3

--10. How many authors are in the first, second or third grades?

SELECT COUNT(*) as FirstSecondThird
FROM Author a
JOIN Grade g
ON a.GradeId = g.Id
WHERE a.GradeId = 3
OR a.GradeId = 1
OR a.GradeId = 2

--11. What is the total number of poems written by fourth graders?

SELECT COUNT(p.Id) as PoemsBy4thGraders
FROM Author a
JOIN Poem p
ON a.Id = p.AuthorId
WHERE a.GradeId = 4

--12. How many poems are there per grade?

SELECT SUM(CASE WHEN a.gradeId = 5 THEN 1 ELSE 0 END) as PoemsBy5thGraders,
	SUM(CASE WHEN a.gradeId = 4 THEN 1 ELSE 0 END) as PoemsBy4thGraders,
	SUM(CASE WHEN a.gradeId = 3 THEN 1 ELSE 0 END) as PoemsBy3rdGraders,
	SUM(CASE WHEN a.gradeId = 2 THEN 1 ELSE 0 END) as PoemsBy2ndGraders,
	SUM(CASE WHEN a.gradeId = 1 THEN 1 ELSE 0 END) as PoemsBy1stGraders
FROM Author a
JOIN Poem p
ON a.Id = p.AuthorId


--13. How many authors are in each grade? (Order your results by grade starting with `1st Grade`)
SELECT COUNT(CASE WHEN a.gradeId = 5 THEN a.Id ELSE NULL END) as Authors5thGraders,
	COUNT(CASE WHEN a.gradeId = 4 THEN a.Id ELSE NULL END) as Authors4thGraders,
	COUNT(CASE WHEN a.gradeId = 3 THEN a.Id ELSE NULL END) as Authors3rdGraders,
	COUNT(CASE WHEN a.gradeId = 2 THEN a.Id ELSE NULL END) as Authors2ndGraders,
	COUNT(CASE WHEN a.gradeId = 1 THEN a.Id ELSE NULL END) as Authors1stGraders
FROM Author a

--14. What is the title of the poem that has the most words?

select TOP(1) Title,
WordCount
From Poem
ORDER BY WordCount DESC

--15. Which author(s) have the most poems? (Remember authors can have the same name.)

select TOP(10) COUNT(Title) as PoemCount,
p.AuthorId
from Poem p
join Author a
on a.Id = p.AuthorId
group by p.AuthorId
order by PoemCount DESC

--16. How many poems have an emotion of sadness?

Select COUNT(p.Id) as SadnessCount
from Poem p
Join PoemEmotion pe
ON p.Id = pe.PoemId
JOIN Emotion e
ON e.Id = pe.EmotionId
WHERE e.Id = 3

--17. How many poems are not associated with any emotion?

select COUNT(CASE WHEN pe.EmotionId is null THEN 1 ELSE 0 END) as NoEmotions
from Poem p
left join PoemEmotion pe
ON p.Id = pe.PoemId

--18. Which emotion is associated with the least number of poems?

select TOP(1) COUNT(pe.EmotionId) as NumberOfTimes,
e.Name
from Emotion e
join PoemEmotion pe
ON e.Id = pe.EmotionId
GROUP BY pe.EmotionId, e.Name
ORDER BY pe.EmotionId 


--19. Which grade has the largest number of poems with an emotion of joy?

select TOP(1) COUNT(GradeId) as JoyCount,
a.GradeId
FROM Author a
JOIN Poem p
ON a.Id = p.AuthorId
Join PoemEmotion pe
ON p.Id = pe.PoemId
JOIN Emotion e
ON e.Id = pe.EmotionId
WHERE pe.EmotionId = 4
GROUP BY GradeId
ORDER BY GradeId DESC

--20. Which gender has the least number of poems with an emotion of fear?

SELECT e.Name as EmotionName,
COUNT(a.GenderId) as EmotionCount,
g.Name as Gender
FROM Author a
JOIN gender g
ON a.GenderId = g.Id
JOIN Poem p
ON a.Id = p.AuthorId
Join PoemEmotion pe
ON p.Id = pe.PoemId
JOIN Emotion e
ON e.Id = pe.EmotionId
WHERE pe.EmotionId = 2
GROUP BY GenderId, g.Name, e.Name
ORDER BY GenderId DESC