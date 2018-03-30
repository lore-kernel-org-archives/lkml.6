Return-Path: <quytelda@tamalin.org>
X-Google-Smtp-Source: AIpwx4/ivrUrglkxGbJCEBi+1XuMIwj7gNFjrmxUbgxhRo+DuKLtOowNRU/FQPPnWn/hwXCo6q/4
ARC-Seal: i=1; a=rsa-sha256; t=1522393795; cv=none;
        d=google.com; s=arc-20160816;
        b=oceNwmfb2u040cm9mx1J2JAphmUZco25uYR/6MrSwEMVQ3dHiYhEH2pCCEdvHFH9ZO
         EsDnYr4ai5ooz2W3L9dWDlRbB0/Ek0n6v8VqZoBftsGpfCR9AK0y/3fvM2r7QB2+PUSh
         /h20lRJjsi3YjJ3micD3H8mSHeHAuS4acSrm6fFlZxQ5KYl5YqhOIrR5BNGvs0ALewX9
         IsTNNkdPjSlm4qRTRGiFmG4qopAsH3Van58jJJ1vyukO0AXnZ6YA/ejs5EhVuLkVUhCs
         ybpZVqYf2jdjAcOr3w7rUdyhEhe6rjmWfG8+Q1ilfUlR8hpgr7g/U4PMPk4LsRmxPSUy
         hBKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=6ItKiPbgtFG7KLKIZTSWZ0LnG5xVgghnJQI6U6NuX7Y=;
        b=tWNsBmsFvlmaut0dXmy3twyhqlpIgbfwAPJiNZiQb8LIdZRTr32mPgm8pfpqLabkI7
         lR/6+NLXA9xmd73QhjbLIRXkUhrAV46BsIc0vj0eHS75OB3fPBX/7HSuiV8J2ZpNklqd
         Z7zeRunWUDf7as73NORfu/Wc5MJcQi2FeufXyXWhkgxjA6XTgkOsz0tcz/sZxjuZsM4r
         9TVMqNzGGjMvswk3wD0mWSXHMBkZLGF6j/I0mZHbaeFuCFS8AiFebeFWRAYxOVA3/We6
         O9JrpAZz6xYm+Bt1Kv3ErybDYUFMvvbZUmhKVmLQECW4wkTUNynerePvwI63zGlc16Vo
         WAtA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 74.208.4.197 is neither permitted nor denied by best guess record for domain of quytelda@tamalin.org) smtp.mailfrom=quytelda@tamalin.org
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 74.208.4.197 is neither permitted nor denied by best guess record for domain of quytelda@tamalin.org) smtp.mailfrom=quytelda@tamalin.org
From: Quytelda Kahja <quytelda@tamalin.org>
To: gregkh@linuxfoundation.org,
	wsa@the-dreams.de
Cc: driverdev-devel@linuxdriverproject.org,
	devel@driverdev.osuosl.org,
	linux-kernel@vger.kernel.org,
	Quytelda Kahja <quytelda@tamalin.org>
Subject: [PATCH 67/76] staging: ks7010: Remove trailing _t from 'struct michael_mic_t'.
Date: Fri, 30 Mar 2018 00:08:30 -0700
Message-Id: <20180330070842.25224-67-quytelda@tamalin.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180330070842.25224-1-quytelda@tamalin.org>
References: <20180330070842.25224-1-quytelda@tamalin.org>
X-Provags-ID: V03:K0:azLFvNPERy/AVxYmzqeivEomqPRYUyULAx3kPCbUAZV0s1GxKZL
 6vlNLgaCF1Pg5SHhhFDs/mlfxz+cJXn34EpLmCIxd6gQOB1BbbDdC8qxC491CMcGYCjUVdN
 8t2FTn9YsyjH2antTW6eLgCA3hZDXYw9FFSsJCNUyDYs+YwLEfYgZdb4ZTWYVjsM+L4b3EE
 GjOQSmvJkdwlX1y3K6bTw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:VgvG+0rIQiw=:u4fMPeqlhACWRkVLwU7dZZ
 BC/d9E9Y9hO7hzK8Tt+MzNBKWogJxpRVjFgduFpbuxGKnqmJ9kcRsPGBMRfpCTaX0/kMAjXLD
 8QLP1eF5+pienRinZ6PY1XFtn9s3/Gubvi8141HcovFMGtoaCFx768VRepzxVkROT+EP7kVXp
 JXR8c1udZNr9LXNSURZQ3jG9ofybO1Yo7wDWjVdZdbwSKmY/TBy85Gb44WniJeZ3J7SzVK/BX
 wd6Cmu8UVU+mUkedoYoBXSzCkWXrWfFxu6Ghht/uPLQjb2sgemRPMgs7DjMOWdLape89ail/3
 AwwCDx4v7+dqEM6T6FvEe4b6FC7t6D+WFgMY1d9zLqanK1L+JDOg8Pi86ITAcCjsWykPTJjrK
 fI+C3T9jmKdtoDBI7fKgXdkzRdB5EK12BxImgo6KWjNbPb+ZAl9484P158d9QJNh34hswOjxi
 U195fwtaqKrTXQz3bZklZqUNdi0XK7IiAc2TXWfVb0+9JHQGYWkp4jHKgti1CRRGV6X5U8898
 SzbnX1B/c7bKnmdUURFeLkEFiHFxIne1mcw3kolxNBbBRwm56H91s4hRdhvLhX27inXUPzdGg
 1gAf1gqyHCD8EeTm02rNNa7sUhW4WhvIMu3i+a5a9q3Dy6oyUJOuIckzvFtJBkpakW4WV/mxz
 vIxlP96xKRYNdAbx0JDbYP6a8pz89mWh19PjkJs1jjQfB8bfe1C6EubJ/7t6JUqElQKFyaOhW
 /gJpq0QZh4uLLRvr+MyxhCZjU8ZHGdyBCwro+A==
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596345596991805350?=
X-GMAIL-MSGID: =?utf-8?q?1596345596991805350?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The "_t" suffix is not needed for structure names in this driver, and is a
reflection of an older typedef system that is no longer in place. Replace
all occurences of 'struct michael_mic_t' with 'struct michael_mic'.

Signed-off-by: Quytelda Kahja <quytelda@tamalin.org>
---
 drivers/staging/ks7010/ks_hostif.c   |  4 ++--
 drivers/staging/ks7010/michael_mic.c | 12 ++++++------
 drivers/staging/ks7010/michael_mic.h |  4 ++--
 3 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/staging/ks7010/ks_hostif.c b/drivers/staging/ks7010/ks_hostif.c
index f87e707e8bd3..1eff78540683 100644
--- a/drivers/staging/ks7010/ks_hostif.c
+++ b/drivers/staging/ks7010/ks_hostif.c
@@ -315,7 +315,7 @@ int hostif_data_indication_wpa(struct ks_wlan_private *priv,
 	char buf[128];
 	unsigned long now;
 	struct mic_failure *mic_failure;
-	struct michael_mic_t michael_mic;
+	struct michael_mic michael_mic;
 	union iwreq_data wrqu;
 	unsigned int key_index = auth_type - 1;
 	struct wpa_key *key = &priv->wpa.key[key_index];
@@ -1065,7 +1065,7 @@ int hostif_data_request(struct ks_wlan_private *priv, struct sk_buff *skb)
 	int result = 0;
 	unsigned short eth_proto;
 	struct ether_hdr *eth_hdr;
-	struct michael_mic_t michael_mic;
+	struct michael_mic michael_mic;
 	unsigned short keyinfo = 0;
 	struct ieee802_1x_hdr *aa1x_hdr;
 	struct wpa_eapol_key *eap_key;
diff --git a/drivers/staging/ks7010/michael_mic.c b/drivers/staging/ks7010/michael_mic.c
index 292eae29c552..51862bcf5f58 100644
--- a/drivers/staging/ks7010/michael_mic.c
+++ b/drivers/staging/ks7010/michael_mic.c
@@ -17,14 +17,14 @@
 
 
 // Reset the state to the empty message.
-static inline void michael_clear(struct michael_mic_t *mic)
+static inline void michael_clear(struct michael_mic *mic)
 {
 	mic->l = mic->k0;
 	mic->r = mic->k1;
 	mic->m_bytes = 0;
 }
 
-static void michael_init(struct michael_mic_t *mic, u8 *key)
+static void michael_init(struct michael_mic *mic, u8 *key)
 {
 	// Set the key
 	mic->k0 = get_unaligned_le32(key);
@@ -34,7 +34,7 @@ static void michael_init(struct michael_mic_t *mic, u8 *key)
 	michael_clear(mic);
 }
 
-static inline void michael_block(struct michael_mic_t *mic)
+static inline void michael_block(struct michael_mic *mic)
 {
 	mic->r ^= rol32(mic->l, 17);
 	mic->l += mic->r;
@@ -47,7 +47,7 @@ static inline void michael_block(struct michael_mic_t *mic)
 	mic->l += mic->r;
 }
 
-static void michael_append(struct michael_mic_t *mic, u8 *src, int bytes)
+static void michael_append(struct michael_mic *mic, u8 *src, int bytes)
 {
 	int addlen;
 
@@ -81,7 +81,7 @@ static void michael_append(struct michael_mic_t *mic, u8 *src, int bytes)
 	}
 }
 
-static void michael_get_mic(struct michael_mic_t *mic, u8 *dst)
+static void michael_get_mic(struct michael_mic *mic, u8 *dst)
 {
 	u8 *data = mic->m;
 
@@ -110,7 +110,7 @@ static void michael_get_mic(struct michael_mic_t *mic, u8 *dst)
 	michael_clear(mic);
 }
 
-void michael_mic_function(struct michael_mic_t *mic, u8 *key,
+void michael_mic_function(struct michael_mic *mic, u8 *key,
 			  u8 *data, int len, u8 priority, u8 *result)
 {
 	u8 pad_data[4] = { priority, 0, 0, 0 };
diff --git a/drivers/staging/ks7010/michael_mic.h b/drivers/staging/ks7010/michael_mic.h
index 894a8d4121a4..d33508070088 100644
--- a/drivers/staging/ks7010/michael_mic.h
+++ b/drivers/staging/ks7010/michael_mic.h
@@ -10,7 +10,7 @@
  */
 
 /* MichaelMIC routine define */
-struct michael_mic_t {
+struct michael_mic {
 	u32 k0;	// Key
 	u32 k1;	// Key
 	u32 l;	// Current state
@@ -20,5 +20,5 @@ struct michael_mic_t {
 	u8 result[8];
 };
 
-void michael_mic_function(struct michael_mic_t *mic, u8 *key,
+void michael_mic_function(struct michael_mic *mic, u8 *key,
 			  u8 *data, int len, u8 priority, u8 *result);
-- 
2.16.3
