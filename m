Return-Path: <quytelda@tamalin.org>
X-Google-Smtp-Source: AIpwx4+Y1TuW2xCcax4MN1pUjp7eCD+SIY7o+2OpLWafbtO7jNmSIa7XIv0YJMoB5tEiYs5mp1x8
ARC-Seal: i=1; a=rsa-sha256; t=1522393768; cv=none;
        d=google.com; s=arc-20160816;
        b=HQaVAIIXiJO+aQLOJQ6wae01D9gdLWZjTOH3SYXBW8nSkn+sKtF1AtHYZpGLFfNvtH
         IWfBR/HGaKv9lcedFwJm1ODfGNn2xlCNX76rC9vbobBxPMZlXXXGBRVNo9Boy2mDlbit
         18OsR7oYAelwFSnFPMewDZIHuEeRTd4pPc7D9zQh48Gb/F1ufu10upW6eCN2JvlvB4J4
         BydPlGTInxH7aIDUZvIFA8j4C5O410PYDdRDFl9VH6FCm7M5XdatDbVItv4wqmHiwXw+
         ptMxDARTK0VSiHYVDs+IOBD6siav0Rvty0GNCp2mPjs/VKgWXm0Jj4OsN1nG9aZ4mRWW
         gN9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=4isL3FUWumua108LIaAwfR0GvpZVKEphdXvqN/0Vq9Y=;
        b=MAjrystzN5tGu9/fteyeG8NHYKLZn+GaRx8vPcVlXQqau30kuLLNAZ+4ACCv+e+Tcv
         Qf6Stv9srY5CGfggLxKkn/Ib6Sik5lK8OBIKhI+4KPiZPsPsu65YRUQHylrJWr4NWzPx
         wLH9aPfIguVJExczCRB4POxrh2WE3SEb0b/plhP9vs5/MoN8wi335XMNzWsnBEenPP8r
         mYQcci6va4hFyXao7KggJrgUaYMGfnEDyJ9rU7XwBD89cSp+AvWpFGtmqz3tA9m8tOOm
         rYTklWWf8N0dMuZJUecYvy6DO1DdeY/2UQ4PW022y1qCRc47SZc3bfOL84MpnaPsMcWf
         3K8Q==
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
Subject: [PATCH 34/76] staging: ks7010: Remove trailing _t from 'struct hostif_infrastructure_set_request_t'.
Date: Fri, 30 Mar 2018 00:07:57 -0700
Message-Id: <20180330070842.25224-34-quytelda@tamalin.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180330070842.25224-1-quytelda@tamalin.org>
References: <20180330070842.25224-1-quytelda@tamalin.org>
X-Provags-ID: V03:K0:QailWdaImAhe4PTUWXWn32Ou/cs1/ipncxHyLJ8l3GqlR9ZTSpd
 Xz542KeHbHiahRT3mpjUN5QJu+dGLzmKUQzXxSfKPZVIXmUg797eGOwxNd3BVYHFqp/WJdN
 DvXiXpEoKSOB0s4xKw71kBz8lYJ1/vq5GAU7dcbQR3i9SJQ8b0r/lFF9xIMuBh/tPlHBS6M
 IlaiFZQ5ul9Ac7NlEXlWw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:zC7LJTFLUZI=:cvDsM4jkTq5w/l6uerRxJp
 xNHuVJmtY0ooFXxA+zdS00gnx1GhY6Nzrd9j3XHAaLwtXjTKApNJVYT+tI+m3IHhdo95zO1gN
 f4FqSWTRUccN71DkboEhBnQDWBCno+S9Gvb3iNoGxVRMYfm+bothUMJaaXbcHw/Vj6EBM5Xgz
 0BWgjPKL13RqjztD6gBcSCHS70yOCd/6n2zXmxEqY/4OLp/OZLFcRq5rcSuMQGKGFFqASORpy
 +Gd3D01asQYme5WOeSDSHRrEpW0f/a62DruLNESbTLms40ass/xNVcuOqyEFXjVX+PPoDOsOI
 jEfokE/FyqyPoXljdQs3qnCxP/oA4w6/rv3BBITIW1gdQ6++4iZZj6WEHIKdeF2zPL2QM8Eri
 Z9ksp2jhodI0sEfog4MjMCrMUolLb86HF8RngmPaWDUZnmEOD0LMMfCJGg4vCevu7jmBjk6v+
 hQL5aMqB3YUOUU5grz7qYxHJsclmWlbXgQBVkg5v5vDvdGiCEhHJnljRwwH9jhmElQe85xWgR
 4dn3sx9vH7FM9aBZFpLWoeVjp3bMSmw6NmW4DVM7zljzIlDpK7CBwmuJ24uNMrno73X/IP+8f
 sCUyC+zhMQHivEa2Rzd3DLS2zDdFxV5fMXDq+aZvtGlqS2sVgUKJBCOV2qzo3cTIyQTnpb3sN
 s4muawq3+fqvktGJ+C1OHOyBLXPVpmyattCvarbCmjP9skV/+6mkMvK8hQZj7w2bAiA5/YHOm
 nwgaTQEdm+ME4aCS1aqBldE5yN8WAC3fBF9HSw==
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596345568115879414?=
X-GMAIL-MSGID: =?utf-8?q?1596345568115879414?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The "_t" suffix is not needed for structure names in this driver, and is a
reflection of an older typedef system that is no longer in place. Replace
all occurences of 'struct hostif_infrastructure_set_request_t' with
'struct hostif_infrastructure_set_request'.

Signed-off-by: Quytelda Kahja <quytelda@tamalin.org>
---
 drivers/staging/ks7010/ks_hostif.c | 2 +-
 drivers/staging/ks7010/ks_hostif.h | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/ks7010/ks_hostif.c b/drivers/staging/ks7010/ks_hostif.c
index 8be5d64f291b..3d6ba74cc3e5 100644
--- a/drivers/staging/ks7010/ks_hostif.c
+++ b/drivers/staging/ks7010/ks_hostif.c
@@ -1344,7 +1344,7 @@ void hostif_ps_adhoc_set_request(struct ks_wlan_private *priv)
 static
 void hostif_infrastructure_set_request(struct ks_wlan_private *priv, int event)
 {
-	struct hostif_infrastructure_set_request_t *pp;
+	struct hostif_infrastructure_set_request *pp;
 
 	pp = hostif_generic_request(sizeof(*pp), event);
 	if (!pp)
diff --git a/drivers/staging/ks7010/ks_hostif.h b/drivers/staging/ks7010/ks_hostif.h
index be33a704c7c4..1d79f07f12cc 100644
--- a/drivers/staging/ks7010/ks_hostif.h
+++ b/drivers/staging/ks7010/ks_hostif.h
@@ -373,13 +373,13 @@ struct hostif_ps_adhoc_set_confirm {
 #define AUTH_TYPE_SHARED_KEY  1
 
 /**
- * struct hostif_infrastructure_set_request_t
+ * struct hostif_infrastructure_set_request
  * @capability: bit5  : preamble
  *              bit6  : pbcc - Not supported always 0
  *              bit10 : ShortSlotTime
  *              bit13 : DSSS-OFDM - Not supported always 0
  */
-struct hostif_infrastructure_set_request_t {
+struct hostif_infrastructure_set_request {
 	struct hostif_hdr header;
 	struct hostif_request request;
 	struct ssid ssid;
-- 
2.16.3
