-- Select Data that we are going to be using
SELECT artist_name, track_name, release_date, genre, dating, violence, world, night, shake_the_audience, gospel, romantic, communication, movement, light, spiritual, girls, sadness, feelings, danceability, loudness, acousticness, instrumentalness, valence, energy, topic, age
FROM loyal-lore-407211.Music.music

-- Looking at count by release_date
SELECT release_date, count(*)
FROM loyal-lore-407211.Music.music
GROUP BY release_date
ORDER BY release_date

-- Looking at count by genre
SELECT genre, count(*) AS counts
FROM loyal-lore-407211.Music.music
GROUP BY genre
ORDER BY count(*) DESC

-- Looking at count by topic
SELECT topic, count(*) AS counts
FROM loyal-lore-407211.Music.music
GROUP BY topic
ORDER BY count(*) DESC

-- Which genre has the most sadness song
SELECT genre, count(*) AS counts
FROM loyal-lore-407211.Music.music
WHERE topic = 'sadness'
GROUP BY genre
ORDER BY counts DESC

-- Which genre has the most violent song
SELECT genre, count(*) AS counts
FROM loyal-lore-407211.Music.music
WHERE topic = 'violence'
GROUP BY genre
ORDER BY counts DESC

-- The statistics of danceability
SELECT MIN(danceability) AS minimun, MAX(danceability) AS maximun, AVG(danceability) AS avg
FROM loyal-lore-407211.Music.music

-- Danceability in genres
SELECT genre, AVG(danceability) AS avg
FROM loyal-lore-407211.Music.music
GROUP BY genre
ORDER BY AVG(danceability) DESC

-- Danceability in topic
SELECT topic, AVG(danceability) AS avg
FROM loyal-lore-407211.Music.music
GROUP BY topic
ORDER BY AVG(danceability) DESC

-- Topic of dating in genre
SELECT genre, AVG(dating) AS avg_dating
FROM loyal-lore-407211.Music.music
GROUP BY genre
ORDER BY AVG(dating) DESC

-- What are the commonest topic in Hip Hop
SELECT topic, count(*) AS counts
FROM loyal-lore-407211.Music.music
WHERE genre = 'hip hop'
GROUP BY topic
ORDER BY count(*) DESC

-- Find the oldest tracks in each genre
SELECT genre, artist_name, track_name, release_date
FROM loyal-lore-407211.Music.music AS music_data
WHERE release_date = (
  SELECT MIN(release_date)
  FROM loyal-lore-407211.Music.music AS inner_data
  WHERE inner_data.genre = music_data.genre
)
ORDER BY genre

-- The loudness progress over the years
SELECT release_date, AVG(loudness) AS average_loundness
FROM loyal-lore-407211.Music.music
GROUP BY release_date
ORDER BY release_date

-- The valence score (positivity vibe) for each genre
SELECT genre, AVG(valence) AS avg_valence
FROM loyal-lore-407211.Music.music
GROUP BY genre
ORDER BY avg_valence DESC

-- The valence score (positivity vibe) for each topic
SELECT topic, AVG(valence) AS avg_valence
FROM loyal-lore-407211.Music.music
GROUP BY topic
ORDER BY avg_valence DESC

-- Determine which artist has the highest average valence (musical positivity) for tracks classified as "obscene"
SELECT artist_name, AVG(valence) AS avg_valence
FROM loyal-lore-407211.Music.music
WHERE topic = 'obscene'
GROUP BY artist_name
ORDER BY avg_valence DESC
LIMIT 10

-- Identify the track with the highest energy within each year
SELECT artist_name, track_name, release_date, genre, energy
FROM loyal-lore-407211.Music.music AS outer_data
WHERE energy = (
  SELECT MAX(energy)
  FROM loyal-lore-407211.Music.music AS inner_data
  WHERE inner_data.release_date = outer_data.release_date
)
ORDER BY release_date

-- The acousticness score over time
SELECT release_date, AVG(acousticness) AS avg_acousticness
FROM loyal-lore-407211.Music.music
GROUP BY release_date
ORDER BY release_date

-- Acousticness score in each genre 
SELECT genre, AVG(acousticness) AS avg_acousticness
FROM loyal-lore-407211.Music.music
GROUP BY genre
ORDER BY avg_acousticness

-- The instrumentalness over time
SELECT release_date, AVG(instrumentalness) AS avg_instr
FROM loyal-lore-407211.Music.music
GROUP BY release_date
ORDER BY release_date

-- The diversity of acousticness in genre
SELECT genre, STDDEV(acousticness) AS acous_std, AVG(acousticness) AS acous_avg
FROM loyal-lore-407211.Music.music
GROUP BY genre
ORDER BY acous_std DESC

-- The diversity of loudness in genre
SELECT genre, STDDEV(loudness) AS loud_std, AVG(loudness) AS loud_avg
FROM loyal-lore-407211.Music.music
GROUP BY genre
ORDER BY loud_std DESC

-- The diversity of valence+danceability+energy in genre
SELECT genre, (STDDEV(valence) + STDDEV(danceability) + STDDEV(energy)) / 3 AS avg_std
FROM loyal-lore-407211.Music.music
GROUP BY genre
ORDER BY avg_std DESC

-- The vocal and intrumental tracks percentage in each genre
SELECT genre, 
    CASE 
        WHEN instrumentalness > 0.5 THEN 'Instrumental'
        ELSE 'Vocal'
    END AS track_type,
    COUNT(*) AS track_count,
    COUNT(*) * 100.0 / (
      SELECT COUNT(*) 
      FROM `loyal-lore-407211.Music.music` 
      WHERE genre = m.genre
      ) AS percentage
FROM `loyal-lore-407211.Music.music` AS m
GROUP BY genre, track_type
ORDER BY genre, track_type;

-- Compare the scores of instrumental and vocal tracks
SELECT 
    CASE 
        WHEN instrumentalness > 0.5 THEN 'Instrumental'
        ELSE 'Vocal'
    END AS track_type,
    AVG(acousticness) AS avg_acousticness,
    AVG(energy) AS avg_energy,
    AVG(loudness) AS avg_loudness,
    AVG(valence) AS avg_valence,
    AVG(violence) AS avg_violence
FROM loyal-lore-407211.Music.music
GROUP BY track_type;

