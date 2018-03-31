Return-Path: <quytelda@tamalin.org>
X-Google-Smtp-Source: AIpwx48qg0gDt8B1s+hUqtFvUCPohh/OLqWbXAeinvDpDVkMXwwPzWfajqoOpsLTBiQITUczjdlP
ARC-Seal: i=1; a=rsa-sha256; t=1522476593; cv=none;
        d=google.com; s=arc-20160816;
        b=XXoF0pfqbtP9Snm5+9UfherSiyv4tDhDUdvRJQwkGmEbk70mvlzyZZDn+SyMLkdWyW
         AEGAW4+h3IEh8UciWPv6XYQjFR2/5no7OvXYLUQyLYQG/s5Y71n59GSqNylC/qFkH1zR
         boWyS1fkbASbCjbsHP6JF0ZhbqYf8ZI5HCK3U4swdPrAekHctO0L58I8V6QjNaHmcxbQ
         nNJpoP26+mFgACmQ4FM9KgE6H2V0eoBE+kEU93QcXbV3NACJKD9MIgTxXh0hVssKk2ow
         XEQk/cWDWz9b/XvCxrFVGEbWiRswDFAy6amHjPC8y2Ja+6NC8+ivC9V7GpOTK4t5cboo
         bqVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=Rox9U38mcXoy80bAKgKmnuSXT7Q7cZwDZkWI/aLvYYI=;
        b=nq5cxqAl1QZmDRIPDzqP33ut6uWKs2njPHWTfaa9wksumarcLBtxGZIVlHPtTs3sgn
         oUg2wMifW7EhX8k6iLsKfE61IDi+4cFhNzvrcWQD/IlH9J6fbFq2+x4U9VO44cQn63A+
         O/4+SmJxeWgaLiVYdmAamXscz6NAVAnFiMQxpL7MP4F/9cDqcaUNoH3rRO5pX6ktz3Zo
         mVhUppUWcSqAGPv+idFu05qlS27FWxPXJwNkvRoq7hAlY+ICpc+NXzV+IjAvOpkNnQr0
         tacHOQaF467Ovphc0qC1OKL6pDTZCOrApjNEfv2Iize+hFRAUljKHaxG0HnnJzz/oWCj
         +/zg==
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
Subject: [PATCH v2 34/75] staging: ks7010: Remove trailing _t from 'struct hostif_infrastructure_set_request_t'.
Date: Fri, 30 Mar 2018 23:08:14 -0700
Message-Id: <20180331060855.9452-34-quytelda@tamalin.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180331060855.9452-1-quytelda@tamalin.org>
References: <CAFLvi23=E6QubTGX0=cHjbJGB=Vx5OJ7d16E2R4HZTscmJuuSw@mail.gmail.com>
 <20180331060855.9452-1-quytelda@tamalin.org>
X-Provags-ID: V03:K0:wZoF4DEAz40TzzKVeEI6hpJIQRWFlIC9HUhE6SWTQTNlQtM12l4
 fazYqWYDT/a0C78IY//dA5hIoVFPX1/KG8qJW8y0ct+WjoHUkswH9JiUhAyI302DQW4IJPN
 bErlocUUcMX9dvds6xkDTmGX7/eiJrgBWufaYpz97Udj1Voj/dMhXGmVcVKWHWIR15reqJE
 ZimOLPkK/3oXTZd96K4Qg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:hADRD8hSUw0=:p9vHu89fbJxFI0qennUYKK
 y33EN6NgTD7bc3DIeC3vBKSke8zyHcSok3IF4sSOWZfvgEGM59t8YMZvVIqy7t7+iyp+RLr8n
 UPOFM4zsgaPtFVhalG9wKdDFxhFUbzHzVJkH6cYcNPgozRU63HBsgAcJ86TfUbEwYIqWBb0yA
 PMDoCwSYylrMOWP/mSnyzC3l5UUfwpGBsrqpk+bRKsthq0guGBPLBLUvFuQS1I7oPJc1TdYPT
 D8eht9xqoWg9xBjqGr02h83QWF/GnCYt8PxVwYQfSmQLjmNcY/ngF9bdEc9ScSxyQZ1bqZdCb
 49rTxq856H2FUSHhQRxX24iZHZd+Qscr4gr/7LMhE07Klf2CegcdryUnScKlD1CJj0BF92azZ
 mgsJVvJXaV5+M9C/dv+jvZT2t5rAXBg5jX0FxiYSAfPu8efaZnNudj1Zcmf9+h7cnTEmqbmRP
 SO08IvvkTIMgCGscxiodsUo2rR9umi2U/hqx4zdJawLwyy7HMLqIrtxtUXBykPZw6fU3ppfKo
 vKIn9oo+ihmm9wUCmljttURtsEFp5H2vOWMGJnbdo4aTry14S9Nqxb1BBuamCXqmE3fVki+Du
 CjD8xZVRjm2GdvmulUGPKbeI7LfTlqdd/vwpJz14TaI2QPi4YwHXOjws/AhOmAzJIQL8Fdkce
 pZm77kBk1Y/PF9WyTbSqcoRy5eQI9xr+tvylGqZAhA6cfLRjyH3p8J2DhVRm7Bz1dTTUL9e3E
 dzJaNApy+kvmkFe4MS0Vb9cPsgvbabTFa1jOOA==
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596432415761642060?=
X-GMAIL-MSGID: =?utf-8?q?1596432415761642060?=
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
index baa612236eb2..a4f51f3311a1 100644
--- a/drivers/staging/ks7010/ks_hostif.h
+++ b/drivers/staging/ks7010/ks_hostif.h
@@ -325,13 +325,13 @@ struct hostif_ps_adhoc_set_request {
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
