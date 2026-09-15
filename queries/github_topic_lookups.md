# GitHub Topic Lookups: Shipped-Code Signal

Manual lookups against GitHub's public Search API to capture current, present-day
repo counts by topic tag. No authentication required at this request volume
(unauthenticated limit: 60 requests/hour).

Pulled: September 2026

## Method

For each framework, the request was:

```
GET https://api.github.com/search/repositories?q=topic:<slug>
```

The `total_count` field near the top of the JSON response was recorded.

## Results

| Framework | Topic slug | `total_count` |
|---|---|---|
| TensorFlow Lite | `tensorflow-lite` | 1,418 |
| MediaPipe | `mediapipe` | 6,227 |
| CoreML | `coreml` | 1,294 |
| ONNX Runtime | `onnxruntime` | 1,555 |
| ML Kit | `mlkit` | 450 |

## ML Kit naming note

ML Kit's topic tagging is ambiguous on GitHub, similar to the tag split found
on Stack Overflow. Two related queries were checked:

```
GET https://api.github.com/search/repositories?q=topic:mlkit      → 450 (or 442 pre-recheck)
GET https://api.github.com/search/repositories?q=topic:ml-kit     → 211
GET https://api.github.com/search/repositories?q=topic:firebase-mlkit  → 61
GET https://api.github.com/search/repositories?q=topic:google-mlkit   → 8
```

`mlkit` and `ml-kit` are **not** distinct repo populations — inspecting the
top results for each shows significant overlap (e.g. `googlesamples/mlkit`,
Google's own official sample repo, is tagged with both `mlkit` and `ml-kit`
simultaneously). Summing the two would double-count a large share of repos.

**`mlkit` (450) is used as the final number** since it is the more commonly
applied tag and best represents the framework's GitHub footprint without
double-counting. `firebase-mlkit` and `google-mlkit` are minor, largely
unused variants and are not included in the total.

## Known limitation

This is a **current snapshot only**, not a historical trend. GitHub's free
Search API does not support querying repo-creation counts over time, so this
signal cannot show growth trajectory the way the Trends or Stack Overflow
data can — it answers "how big is the ecosystem today," not "how has it
grown."
