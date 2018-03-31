Return-Path: <quytelda@tamalin.org>
X-Google-Smtp-Source: AIpwx4/+44at2Skc0BGR++VAseUWD68FCqcX3T69/6lflpRhYwAgzrBI+DirByogTqwzklBFygLJ
ARC-Seal: i=1; a=rsa-sha256; t=1522476622; cv=none;
        d=google.com; s=arc-20160816;
        b=R9kjFToi+shHc6CL8PnatGragpPKDMo45B/1H01Ek+khAccq1KFu0qxDEalLNRNvZO
         j2sodVHHHO/9Lq4PRKBEJWn1+w6djOkX7Z7Z8lAiy+12Ei6wlnAY6b174DGIVA+lP9qs
         qwRzsyCMUanOJ9++f9MuJ1LPy4WBgm3C8Qkzl5UhfOaC7KCQDBE2JTjcp/7YZAlShBLf
         TYyJNJwkZmQSEHHx6oWuqnKveEjqjHAB5S05nkMxVw1mUfkqb9Kvib70KUybqqwEXOBy
         6c1zNjHgr1Vg8KyRBz5N45ekcUEP/zkizzAwgg+suWtDxOqJRrD28pFrTXrGkrWqbyzL
         fB5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=6ItKiPbgtFG7KLKIZTSWZ0LnG5xVgghnJQI6U6NuX7Y=;
        b=XVoesrshsxbXJBTvBTAJw2R2gxpdg7YPbgfRyPYzCsZnSKP+r5DzN4LIxnOa2UTULw
         /o9ksGac+6z8dEOcNJ+uFy8rHpqILLWN74sAVgO/MXuy8dxJSUvz2MxThxoLaFTAxmxB
         Y83Boz4uHIrXyABZCfonDn1Wm5IAUh0wMUdLQv33WEWU4IxlU+VYeLZD2LhBgc63B8AD
         LwWkJCd+43yC9vA7V3LNt31XIpnrOXHb8CZ8vg07sT33ZpCkBlvyK5xHNyGMNzrpP5OM
         n/wroI1eZsHi+gc+ACPmsohszxZ0B6wwWXglzQUh78gbPA/MjSQHktpn5+HYA67LaH0k
         Xo4A==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 74.208.4.194 is neither permitted nor denied by best guess record for domain of quytelda@tamalin.org) smtp.mailfrom=quytelda@tamalin.org
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 74.208.4.194 is neither permitted nor denied by best guess record for domain of quytelda@tamalin.org) smtp.mailfrom=quytelda@tamalin.org
From: Quytelda Kahja <quytelda@tamalin.org>
To: gregkh@linuxfoundation.org,
	wsa@the-dreams.de
Cc: driverdev-devel@linuxdriverproject.org,
	devel@driverdev.osuosl.org,
	linux-kernel@vger.kernel.org,
	Quytelda Kahja <quytelda@tamalin.org>
Subject: [PATCH v2 67/75] staging: ks7010: Remove trailing _t from 'struct michael_mic_t'.
Date: Fri, 30 Mar 2018 23:08:47 -0700
Message-Id: <20180331060855.9452-67-quytelda@tamalin.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180331060855.9452-1-quytelda@tamalin.org>
References: <CAFLvi23=E6QubTGX0=cHjbJGB=Vx5OJ7d16E2R4HZTscmJuuSw@mail.gmail.com>
 <20180331060855.9452-1-quytelda@tamalin.org>
X-Provags-ID: V03:K0:2jI1YFGL+4TYlb1wVPevNwgcNVxCpY7ELaBz29KAsP49OarorgY
 XOKkXCEwBNpsav1uGCsIwoZkRCMcuEjogAmBUggftXiMuCFNxamZ39fhlvyVF05MHMf/kbH
 PU96RDnmIMwn4+T0SHOri9Udk/Q4vw7iRQCsR0GJZGZKVdAZsQFrNuHVt8gYjeVz7xl4yyL
 cUrUlF8RMxWoUUI2k8ZEA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:LOGAxFHj3Sk=:0pQ9avVrJXtKCw+ODUnCWt
 oXI5E9QYNUneW1pN33fQSh8qiuIn47yvqS7kdfTNYk2k6svMRFZq92zJYvGDhUMTSbbK4yOO4
 vVQSQFUHtHDJssFTJLgmB+dpSJkLFneBG6Sn3hc6U7wmckue6UFfKz/OiKgu3qbZM3EwNPbQ6
 xzIJEy9zhyiw0HCA3F/kdBftUdj2EZ7yKQszTPbKVzfqiu7CXx4rJJYfN+2AQY/ew17qG6ZmN
 miNiKv3hWMxenDER6qE/CuqqVqrxT+9cpwYV4QZWondI3XPt7YWqVDLIFg45Kw04D4weWtkxs
 ATmCgmLlj/uC0n3rqQexyZCMFAxtquFZopeacVbMe6dG7ZuO/j0Zzn6RxHLdKgcCVpxoe5r6a
 86PmQmLz/nge+ru2ILGL3UrpYBAMfBQQNr+Zy3OodgT/IBIIeBxmw3IXgtPVJoeMyr5J2MGjH
 0O4EH9bCsM0/hrz6Io2qO4HvWRulaaybsJEiWfRP3CxSI8AC+M3XB694RilB/keGeObwsksKd
 FUeK1TRtS2WCVGQdVEcPFedPQwYf0Hv6QZg19pHuRpFPd3CokFANuoH2I5YTYV1nRwk8sd6ru
 Dzc9zRD9LKRnMs89g3VKImqnZzRYQoLC5GjB15hpvXVvy8zxPLhlg/wNcDNUZgoEvVMb3IDS7
 7qSFxVaGGmBgQLakGS2WxEbpZymWV/mkBa5OgvD4YttDR0434M3hQOBIsQYPTntqTDcIlrVtj
 C4TnVfgAHYJSJ+2nHkzfptOuzuMN4DxH4qknFQ==
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596432446872444601?=
X-GMAIL-MSGID: =?utf-8?q?1596432446872444601?=
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
