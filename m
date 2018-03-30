Return-Path: <quytelda@tamalin.org>
X-Google-Smtp-Source: AIpwx48jyIhGJbXXs5OkundxbttivbXgMqB2P+qBxIMOBq2US/GeQq6wjvSxrpKkm4Bvuk8wo9Va
ARC-Seal: i=1; a=rsa-sha256; t=1522393770; cv=none;
        d=google.com; s=arc-20160816;
        b=p8c+c2Miwng1ZhbMLv2Us1QFFIzVlTYyWqP530nB5OuaJIbMA/m00l89kabVCM73u+
         gg1yUDKZ6/kkYTXzTM24m3+Eeby7LRdbInHBF6O+ToqgYWRmVZ5paxLfm3tcp8aLMtgy
         O1lyw0nxASqs1IhgFZ9nqv10392SJ3IXM2GPXUCYhLIPKPM8lDItmPAGlgp/8CZq4caS
         SCkQz7amSj5WoTx09tP3WjFR/DL7VPScGK3RnXZOIqXjqVBopEKWwFgnvPYbQZ78Y1A7
         YKahUbCuBrXJOCBurq39HJJp4wx3Ocj+Nngx6PSn5HsrhCbDLt5UP9Z6yYDd3/YczXwg
         fJAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=b+2/YQdIO0ylODOeMeuFwrPJjeFqxKxqCh8IJhoABiI=;
        b=DayBGo1WXQnhQM8j1YokktlakMw2ILJ8l7ISS7S6CRdJbn+Fhgjz0F2/OFbb3RFK0S
         aqX+2lNwEjH0zJUnvYoobobusFENA4RcTUqSao6dINbHxrpsXE6t8EAx0dZ5z8Wl4hCg
         /DB80plFcgGik+8cVbuN6IZV5fyo55WS2iwR12bs/vraVUrPZaa/Z9SjNQfCqcuDecsJ
         X0aumAOgaj/OtE2RoKL/z7KhSA7ke28pJvH+K9h9v5jnEsK+/Jz212zCOYNANQ27kokd
         pCRIIdve89mD8K05U4/DZEdhEoyeJMT5BU+8tpWa4QSx//DpjeG5mUq6Wm9UrzH0cMFH
         VbYA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 74.208.4.196 is neither permitted nor denied by best guess record for domain of quytelda@tamalin.org) smtp.mailfrom=quytelda@tamalin.org
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 74.208.4.196 is neither permitted nor denied by best guess record for domain of quytelda@tamalin.org) smtp.mailfrom=quytelda@tamalin.org
From: Quytelda Kahja <quytelda@tamalin.org>
To: gregkh@linuxfoundation.org,
	wsa@the-dreams.de
Cc: driverdev-devel@linuxdriverproject.org,
	devel@driverdev.osuosl.org,
	linux-kernel@vger.kernel.org,
	Quytelda Kahja <quytelda@tamalin.org>
Subject: [PATCH 37/76] staging: ks7010: Remove trailing _t from 'struct hostif_adhoc_set2_request_t'.
Date: Fri, 30 Mar 2018 00:08:00 -0700
Message-Id: <20180330070842.25224-37-quytelda@tamalin.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180330070842.25224-1-quytelda@tamalin.org>
References: <20180330070842.25224-1-quytelda@tamalin.org>
X-Provags-ID: V03:K0:AKnl1sUaHVsTqTfWimzQkHWy99DCmcGsFxvz5QacgLPbr0N3A7W
 P9neFd9Yi0k3NzCV4MiRcKH0WAix+PwbAzIPY1nai8gov5qHcLDjbGXTq+CUfxh5yK9hrlu
 1Se+ckPkfyIMUe3NGj0pffwlwXzvEM6uQVXjVRj2hfo4JnrwYC3f/OUKetnbe5RKZXHAO/I
 E/jlovgmMoOD2H36/qU7g==
X-UI-Out-Filterresults: notjunk:1;V01:K0:iQx4ERDNF+g=:txAv8Fhqtogn+3J8fyPwVj
 OwTh4k3vFyLETZLQ27oHMhuFf+sfIFTrX0EKVOQz/GWDcBpngTeIToGtJgHF03zaA4C4bnTjS
 2OeXIYZ61lKjfe8gZFGHMk9LzoFvpa5mFcfhQXY3xkCggu74oE33WG7dsXd1qKW8zhJGY6kFW
 uK33WW2Sk3/keDaBbgjT0piLXI4Ccq/8cHrZiSHzh/SQDP6jQE52cJGJrO9MlE29WQgKP+/sg
 eSDdT0KiNqcZ5Ku9Ezo9Xw/+Bq6ddavjVrdYdKxFRt6DDbmIuqV6kp9w9Slv3E/rogT5otZj8
 utVgh5a3sDQMJYgCdtWUOA0/7YUmVgEkOKnEdVviKLVU460bspkOInEOKdylc2SAnZcMh8MWl
 PTeRmESC60Bapke/2ZjDN4qXvlML4VXsx7ND3pMV+a2mUiF28MnDgytvHZ4dwLoZVEPjymnzw
 ja7KvXwvAD1rM1QW2iQ9fSueAK28+Bv4WsvTnS/SJPiyJ0NQIug6yWrYlhvQhVK1M1+TTIhsi
 KRHdyr1cFrQorP3KZYd3UfWjKUk2VkWcS5YhQdOOyRaluOWgvLGg4NU437aOn/dF9wz7m1Uol
 4/uWj9v/D3O0++FyHVj08JirkUeU5cIIv+0uRWAGBAw48KhqRgWyOZwP6BCwC+q4pr/JGKtPA
 6f4vhruYihK0EDhKK0bg8LeCZQ0/2Z4E9sGkDFwlHheQWwOec9e4gnBymOQEXaBkdf5KIh0Xc
 czzh7S9ebCwwr5tV0jSvBTVVBxavzTe+y4xI4w==
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596345570803006543?=
X-GMAIL-MSGID: =?utf-8?q?1596345570803006543?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The "_t" suffix is not needed for structure names in this driver, and is a
reflection of an older typedef system that is no longer in place. Replace
all occurences of 'struct hostif_adhoc_set2_request_t' with 'struct
hostif_adhoc_set2_request'.

Signed-off-by: Quytelda Kahja <quytelda@tamalin.org>
---
 drivers/staging/ks7010/ks_hostif.c | 2 +-
 drivers/staging/ks7010/ks_hostif.h | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/ks7010/ks_hostif.c b/drivers/staging/ks7010/ks_hostif.c
index de56cda64bb9..a177496dd42a 100644
--- a/drivers/staging/ks7010/ks_hostif.c
+++ b/drivers/staging/ks7010/ks_hostif.c
@@ -1404,7 +1404,7 @@ void hostif_adhoc_set_request(struct ks_wlan_private *priv)
 static
 void hostif_adhoc_set2_request(struct ks_wlan_private *priv)
 {
-	struct hostif_adhoc_set2_request_t *pp;
+	struct hostif_adhoc_set2_request *pp;
 
 	pp = hostif_generic_request(sizeof(*pp), HIF_ADH_SET_REQ);
 	if (!pp)
diff --git a/drivers/staging/ks7010/ks_hostif.h b/drivers/staging/ks7010/ks_hostif.h
index 25a00a8f35d8..9ba350ec64ba 100644
--- a/drivers/staging/ks7010/ks_hostif.h
+++ b/drivers/staging/ks7010/ks_hostif.h
@@ -409,13 +409,13 @@ struct hostif_adhoc_set_request {
 } __packed;
 
 /**
- * struct hostif_adhoc_set2_request_t
+ * struct hostif_adhoc_set2_request
  * @capability: bit5  : preamble
  *              bit6  : pbcc - Not supported always 0
  *              bit10 : ShortSlotTime
  *              bit13 : DSSS-OFDM - Not supported always 0
  */
-struct hostif_adhoc_set2_request_t {
+struct hostif_adhoc_set2_request {
 	struct hostif_hdr header;
 	struct hostif_request request;
 	__le16 reserved;
-- 
2.16.3
