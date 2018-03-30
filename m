Return-Path: <quytelda@tamalin.org>
X-Google-Smtp-Source: AIpwx4/ZKU/XvDUMbqIOa4/fZn7/4WUAtLZqb8/IMdpSrYSOT9QEafPyakumuG2shmYV/pA/sxC2
ARC-Seal: i=1; a=rsa-sha256; t=1522393773; cv=none;
        d=google.com; s=arc-20160816;
        b=LIM5kuDr7tzuuVvIzJqY9FZRqmvZ6dVJLqhXNy3Z4CmkcdedlIY4NIuZFAtlTQYw0R
         gILLpBShoMhZ+xppsmi9l1RgzVsc/S1QZPjc9x/8DZB5WmCx0qQ7Qd151u4Cuv7mliga
         wMWncGr2//Ido/Rap9NfbqEgX+e2KoY3TPDlZMVmVapH19MFvlMpLEn/9fa+Med8O8jr
         I2rqbP3W2BOKOF1RDoDewHtwam+/hBgB6hzGxHzjW23KijaRU1tz9EdOy84swS6Etz6U
         ZER3RkR5O7lloxQP25JGUXZB5uu/YwmxJpep78W+XWUrY8HLEuVNzSrUwDgCh1A8FdF2
         g+sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=dEnpxrJgNZCswWfby1iIQ5uDsoaUDh7f28H4F+Jd9KY=;
        b=vfyQsZBzmLwS5jBAWbL/8ZJ+hz3N1QCRaC64zSKC5Cxhc42EQ/q8C2JF2uVnuu2leX
         oYvG79k2vhRjuHxnm7Gr+odqogNHaC32Art0lCZjQWmXLnaYtcWMyBVxaZn/RWOWm9kc
         ht4IztLsekD2G+b61I4KsJnVhvye0Tmaih1dzIpXMr+Y4KL4lGXDcLLlokWDwQcraoCZ
         duJNU6u9KJ7GLBXla+DTSSUEZdsBkeRmcyrCbTTcOAzk1Gqb1DiytD7rkq/++JBvad3g
         Q85Hf2KWji5O4+vUOcUj/IJ34tMgA/6VtZQAgthdS5Q/Wq4yQor/xfTdRUBnuSQX+Ve7
         ZZYg==
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
Subject: [PATCH 41/76] staging: ks7010: Remove trailing _t from 'struct association_response_t'.
Date: Fri, 30 Mar 2018 00:08:04 -0700
Message-Id: <20180330070842.25224-41-quytelda@tamalin.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180330070842.25224-1-quytelda@tamalin.org>
References: <20180330070842.25224-1-quytelda@tamalin.org>
X-Provags-ID: V03:K0:FhDQnccYnHb97MXc2qd4ydq+pzFEYoazF0cltWuCFnh9rkVuGcQ
 LDBiHAEzBC7oho7cdLu7lLsVyK9fTywnKKNiYCA3/DlszTkXQK+E4qM9ONNRz7ye1S9BOQh
 WzxPXYqz2dPvLa9xt8yfgtq95TLXs4jKig00fnyVz6AptH9EvtVDFYkUd5OmK43HhNsn9cb
 8pikc+p1po0+QvV3QA8rw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:RjZ/sx+0MVs=:sfArIxcVL/hP0KyzB+GAgT
 98EAKvhbj5ltdIBDkrhtIcy0pBnVZo5XeJ33K5W8aVURVayTSj6niltJlivin7vvT4/o2OQ0D
 nnQMfOGSLbiNpsRQll9Ytn6sQ546J2swM+vdq187QA8L4APXHaNrNAMUiD/r2d/XcCZz2gN3d
 n9Sy+2W9bgJQs3Xnsid23Ryd3fz4U4wzweePsty1ii8Fx8ZOeXVD0pCXqlg9bgHarQX3zgtkZ
 0RkV6uyR46jyeMpk/iyFZz+iRDj0/e3bLcJtdlg4uEuTGzAwzMiklF2BC4xK8uu+6gzIdrVT6
 NkWNM67CV2zFE7szI1e2V2ATb5EKevfvQUYqtTogRQkzx8BUWRzKrgSzNqwUMjBgEYMStCcoD
 SdfTO/oTvBjqe+JBId0NlZShzfxHfUx9RJ2G345zhzwzIj1aMT6jnySTYS/opl8vv0dbfZW5k
 KWrK0fu/jxFOIFMM+PeWafuJ3HgWDMaE6olztu2GcNHbCvUm/ApGIf2HJOAI0uI+ercWncaNc
 RsvAZkQdBbvI0gPGdxonP1VLUr/2GXNukxYBsJgM4/gjosbPnCwc5o+z7D6nqx9AT7IQ3MyJR
 HoFCyONDJNUCJOdSSAMNKZsPEZuG1hifNQSslsiz8Ge2W8ZTgtQ/X/aRmW2NWdrq6zs53Tq+M
 cnuHuDSr4iJjDDnxiSa8fIYfClilSuVrV8LQEQchsVcd9qzlec2ZsZhepxLgqGtbdGqDybaPL
 iB76dAth9lr/WUEC2UR3P7MjEShK2fH98idT4w==
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596345573813299856?=
X-GMAIL-MSGID: =?utf-8?q?1596345573813299856?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The "_t" suffix is not needed for structure names in this driver, and is a
reflection of an older typedef system that is no longer in place. Replace
all occurences of 'struct association_response_t' with 'struct
association_response'.

Signed-off-by: Quytelda Kahja <quytelda@tamalin.org>
---
 drivers/staging/ks7010/ks_hostif.c | 4 ++--
 drivers/staging/ks7010/ks_hostif.h | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/ks7010/ks_hostif.c b/drivers/staging/ks7010/ks_hostif.c
index 43d06fdda9de..e733a77269df 100644
--- a/drivers/staging/ks7010/ks_hostif.c
+++ b/drivers/staging/ks7010/ks_hostif.c
@@ -864,7 +864,7 @@ static
 void hostif_associate_indication(struct ks_wlan_private *priv)
 {
 	struct association_request *assoc_req;
-	struct association_response_t *assoc_resp;
+	struct association_response *assoc_resp;
 	unsigned char *pb;
 	union iwreq_data wrqu;
 	char buf[IW_CUSTOM_MAX];
@@ -875,7 +875,7 @@ void hostif_associate_indication(struct ks_wlan_private *priv)
 	static const char associnfo_leader1[] = " RespIEs=";
 
 	assoc_req = (struct association_request *)(priv->rxp);
-	assoc_resp = (struct association_response_t *)(assoc_req + 1);
+	assoc_resp = (struct association_response *)(assoc_req + 1);
 	pb = (unsigned char *)(assoc_resp + 1);
 
 	memset(&wrqu, 0, sizeof(wrqu));
diff --git a/drivers/staging/ks7010/ks_hostif.h b/drivers/staging/ks7010/ks_hostif.h
index a1fea8eb89cc..566637b9ac15 100644
--- a/drivers/staging/ks7010/ks_hostif.h
+++ b/drivers/staging/ks7010/ks_hostif.h
@@ -443,7 +443,7 @@ struct association_request {
 	__le16 req_ies_size;
 } __packed;
 
-struct association_response_t {
+struct association_response {
 	u8 type;
 	u8 pad;
 	__le16 capability;
@@ -455,7 +455,7 @@ struct association_response_t {
 struct hostif_associate_indication_t {
 	struct hostif_hdr header;
 	struct association_request assoc_req;
-	struct association_response_t assoc_resp;
+	struct association_response assoc_resp;
 	/* followed by (req_ies_size + resp_ies_size) octets of data */
 	/* reqIEs data *//* respIEs data */
 } __packed;
-- 
2.16.3
