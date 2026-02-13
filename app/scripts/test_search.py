import httpx
import sys
import json

API_URL = "http://localhost:8081/api/v1" # docker-compose maps 8081:80

def test_search():
    print("Testing Search API...")
    try:
        payload = {
            "query": "lo lắng quá",
            "emotion_slug": "lo_lang",
            "limit": 3,
            "search_type": "hybrid"
        }
        resp = httpx.post(f"{API_URL}/actions/search", json=payload, timeout=10)
        print(f"Status: {resp.status_code}")
        if resp.status_code == 200:
            data = resp.json()
            print(json.dumps(data, indent=2, ensure_ascii=False))
            if data['success'] and len(data['data']) > 0:
                print("PASS: Search returned results")
            else:
                print("FAIL: No results found or success=False")
        else:
            print(f"FAIL: {resp.text}")
    except Exception as e:
        print(f"Error: {e}")

def test_recommend():
    print("\nTesting Recommend API...")
    try:
        payload = {
            "emotion_slug": "buon",
            "need_slug": "ket_noi",
            "stage": 1,
            "limit": 3
        }
        resp = httpx.post(f"{API_URL}/actions/recommend", json=payload, timeout=10)
        print(f"Status: {resp.status_code}")
        if resp.status_code == 200:
            data = resp.json()
            print(json.dumps(data, indent=2, ensure_ascii=False))
        else:
            print(f"FAIL: {resp.text}")
    except Exception as e:
        print(f"Error: {e}")

if __name__ == "__main__":
    test_search()
    test_recommend()
