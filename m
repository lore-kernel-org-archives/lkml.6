Return-Path: <quytelda@tamalin.org>
X-Google-Smtp-Source: AIpwx49s112BeIPmafoM8ACYu/EpcbOCwd+I5o/WGr3z1mUt1Qdb4ttJOtdvinMQ38kbXDcOOtR5
ARC-Seal: i=1; a=rsa-sha256; t=1522393766; cv=none;
        d=google.com; s=arc-20160816;
        b=AdEZTBwIAoALbwjrJe2vs+ZoWJYsgI5Od2lp4MMhDVRivAC+yxbXGL2O5VHgieAqoY
         ULqT3nGLqcEB7rpL2fJljehUYlJRzKS1uxXo7Tx0+6IfdpQZZqyhftVfTS9empdiN58O
         svvl8dtgNVM905WU0BfUL1BoGizZKGXJaxDojuvFGbwQAEFMAOqaHSeNYp+HnMzCxsMd
         Vci4iSSN1kM0ijjA4tcPw7gSroW4MEoEc3FJWHBZ5HwJS923dTJYjWhGV64My8KZA/ia
         wABH+78eBI5UeBEDgHd1PlgcoyJKwi1jRewNq9V6HZ8ZzY31AAi+p3SZp/IDctwj+JKl
         fToQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=oXM98atHccY5IwyPFasxUdh7+z9I46VUMtPcAE+LJBA=;
        b=jDqzu+Lp2Wy2gpXnTbame00z2t3Ihlj+J3XOtLl/BeEZMtK2/gFxoo2k5hUcxHXYsK
         NBsth8zig0UFeV8mVQOgVPBJ+MkFW3LYVhrgAeGCm+JoY6kznAucN+hmocUGh+bS2VSb
         /js9pk2xbsBaZAeA8xKo7kXGIZ7/79hbYCvarj1Br5UHG2I5fA3NQzHWfQORw/NklPJY
         B25Xc2iWltqAupx2hN/i955gnRuEkjVLX2kIAha+LLEbs80Aj38brvLJIwJu6r7hqnen
         juIWN264MuLn/xsT3J+6JvpboKrjA0xBZND6v9f3dnbOMqftLovLE9VTgOEGoQfryN0k
         TiWw==
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
Subject: [PATCH 32/76] staging: ks7010: Remove trailing _t from 'struct hostif_ps_adhoc_set_request_t'.
Date: Fri, 30 Mar 2018 00:07:55 -0700
Message-Id: <20180330070842.25224-32-quytelda@tamalin.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180330070842.25224-1-quytelda@tamalin.org>
References: <20180330070842.25224-1-quytelda@tamalin.org>
X-Provags-ID: V03:K0:Gzxwc2fLpUVh22DScFcCjz82ubcZSqcewPOffwxZXUDiCh0ybC5
 OuL+pvRPgpO/jFhupfjTAGsnnQ3Yrct9HPlED/HtXXxldDN9C4yg2uxJGalNzTakRUudyMe
 9RVg4Ux3mBNPMS3MnkpjzuNQ8EX6tLmiWQSVywmqsuAT3v8N9EIsgze3Mc1nXvPKaZOhiE2
 1DEY/5mi22SMGiIr7MKEA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:AylMXXtDpi4=:tVZup/J+k5HgE3LjuP5IxK
 g1i+hywxkfxWsD7x26W8gms5BVFdk6yA5+3afxu9eHwiQF9ijFT6Zj3DJghSybTwTcTLKyNyn
 c8KCO7SSRLLeUF3PupDtX+/uLdJWEm59jqMgbccX/GmiR5TuYtQjJrt5IPwnBw+THM2/dF282
 327cxurZDOEvNLiMaxt8ea4ke7P14QfLMGxPzlmcdKomP2oeVsAWTEFcjlP9HfEu7UUP6kPEb
 /pEUIpryZdL30dvJ0GdmnkOn509f7fuwKi0aCBc+vj/q8ZB6P7Uk/bJW64gxttwt/kl9QFV0S
 P1Q0Ddt9FCkb5DYgU1lrExgNxqfqdEiXmA8lK0EJyKRtK4eG1EjFDCDL/HoB4CD5CHYL11poY
 Brm+CYryf7I+KmahX3i2F1158cgWaOhKKdS5FI8JXcGQMen4xqvEAGL/Tqr/2e00B7GD3CjUE
 Q5NYoWqcgjLSgI28IMij/z31K1XcjwFQqJmIgQNHCGBIp7IvW1q/BUdGSETKypUbcvBSMPpAT
 88euLrlPC2+AtajzxdCP7TJ7sdUyt3fktB0t0xGHEadJlYtVjdelNTe5FFG4MhrBh0cHLCEP9
 mySHWn3TOhhMyXZ+5A5ii3Gt03SO/Q2ulb5Q/8x8Tsg2PIKDz5WPZLkrJ1fRI4cHx8aqHRlKU
 wgOY9jY5LpcmbsfVPqqHDXni5zrPW4l4dNpPkkFPjFGuCvLEaVWiVAAx+XMNGpR/bKvpolZCj
 R17mX2T/2Xol3jwjf99zWEt3kivBwTqBLLk1sQ==
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596345565993507236?=
X-GMAIL-MSGID: =?utf-8?q?1596345565993507236?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The "_t" suffix is not needed for structure names in this driver, and is a
reflection of an older typedef system that is no longer in place. Replace
all occurences of 'struct hostif_ps_adhoc_set_request_t' with 'struct
hostif_ps_adhoc_set_request'.

Signed-off-by: Quytelda Kahja <quytelda@tamalin.org>
---
 drivers/staging/ks7010/ks_hostif.c | 2 +-
 drivers/staging/ks7010/ks_hostif.h | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/ks7010/ks_hostif.c b/drivers/staging/ks7010/ks_hostif.c
index 9798e2427f36..8be5d64f291b 100644
--- a/drivers/staging/ks7010/ks_hostif.c
+++ b/drivers/staging/ks7010/ks_hostif.c
@@ -1327,7 +1327,7 @@ static void init_request(struct ks_wlan_private *priv, struct hostif_request *re
 static
 void hostif_ps_adhoc_set_request(struct ks_wlan_private *priv)
 {
-	struct hostif_ps_adhoc_set_request_t *pp;
+	struct hostif_ps_adhoc_set_request *pp;
 
 	pp = hostif_generic_request(sizeof(*pp), HIF_PS_ADH_SET_REQ);
 	if (!pp)
diff --git a/drivers/staging/ks7010/ks_hostif.h b/drivers/staging/ks7010/ks_hostif.h
index ad42c35d0f2d..665114736d17 100644
--- a/drivers/staging/ks7010/ks_hostif.h
+++ b/drivers/staging/ks7010/ks_hostif.h
@@ -352,13 +352,13 @@ struct hostif_request {
 } __packed;
 
 /**
- * struct hostif_ps_adhoc_set_request_t - pseudo adhoc mode
+ * struct hostif_ps_adhoc_set_request - pseudo adhoc mode
  * @capability: bit5  : preamble
  *              bit6  : pbcc - Not supported always 0
  *              bit10 : ShortSlotTime
  *              bit13 : DSSS-OFDM - Not supported always 0
  */
-struct hostif_ps_adhoc_set_request_t {
+struct hostif_ps_adhoc_set_request {
 	struct hostif_hdr header;
 	struct hostif_request request;
 	__le16 channel;
-- 
2.16.3
