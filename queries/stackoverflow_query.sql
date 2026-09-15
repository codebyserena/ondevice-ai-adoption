-- On-Device AI Adoption: Stack Overflow developer-intent signal
--
-- Source: bigquery-public-data.stackoverflow.posts_questions
-- Note: This is a static BigQuery snapshot ending 2022-09-25. It does not
-- update live and cannot capture activity after that date.
--
-- ML Kit naming note: Stack Overflow has no single 'ml-kit' tag. Google's
-- product was originally tagged 'firebase-mlkit' and later 'google-mlkit'
-- after the rebrand away from Firebase. Both are included and should be
-- summed together downstream to represent ML Kit as one series.

SELECT
  EXTRACT(YEAR FROM creation_date) AS year,
  EXTRACT(QUARTER FROM creation_date) AS quarter,
  tag,
  COUNT(*) AS question_count
FROM `bigquery-public-data.stackoverflow.posts_questions`,
  UNNEST(SPLIT(tags, '|')) AS tag
WHERE tag IN ('tensorflow-lite', 'mediapipe', 'coreml', 'onnxruntime', 'firebase-mlkit', 'google-mlkit')
  AND creation_date >= '2021-01-01'
GROUP BY year, quarter, tag
ORDER BY year, quarter, tag
