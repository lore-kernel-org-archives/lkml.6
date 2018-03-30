Return-Path: <quytelda@tamalin.org>
X-Google-Smtp-Source: AIpwx4+/8PrBrEGQTnU/YEiMyYgatglGCw3G3IBc6X1RhS7lVzpMQTfnoqxJpJcAK2jSKRJWRBk/
ARC-Seal: i=1; a=rsa-sha256; t=1522393789; cv=none;
        d=google.com; s=arc-20160816;
        b=iUf+OYucE1PxzIqGdBTPGl6U+YcbIqBvikAn6Px2Xkxxg6ldDWJeqRQX+ZSOQSWMZf
         TvhrEaS2njoIGUP9L9GQ0C1LPjg0IsomhbDOaBiJWQRJj0VwNQbwmatc14l1NvGxTCcj
         /8K327oK5zekaS+bj38PJrDhmLOAtxhB0W88heA5XOpY8dvpmjMAa15b2QGM4HHRJ15E
         ArpadXs/26eiGZzCBJB0DW+0ASx3ce2KX1LxpFbhuiAx2HTpRWdPuRe8vnNm+I3YYTW0
         7qe9KGjHAPwzAMrYGPD1UAoNg55/7uZwTy/JJPhmMYSriJ8xek5EwDGOtPk3jMqFs6hs
         d4AA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=BWqabdiv8jYowBz+QeWccbe3200L55CcepQj1JDqt9w=;
        b=NTfqEAfvAFUYhKXefXd7WEySoRi4UZijD2Gs5Ydi97pIMzFNLdz2jM4PfGqnq3IHQB
         luRctYiu7IlSnGq34srz8O+MiJWCfCVkx5hZdgHbx1y4nT/odKk48HCq3UA5Fn0XaXZZ
         z5NCalfS7NR7qDs4K0oBTxU5RooQZJuQ1V9tviTW+JDnbzn1PQld3umtxop3yTGemOtP
         He01XXHsw+HwX2XLXf7zMXDtw7lY2th+cEz8D4yKMdlsJN9gD4urevTjLdsY6QOi9Hvh
         TOJ75wSVBzZ6/R6hbc2lw9njG+LeWPpyHepuIqqTLUYZnUjp4REe4IgtqplRSs2WVnKE
         bnxw==
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
Subject: [PATCH 59/76] staging: ks7010: Remove trailing _t from 'struct sleep_status_t'.
Date: Fri, 30 Mar 2018 00:08:22 -0700
Message-Id: <20180330070842.25224-59-quytelda@tamalin.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180330070842.25224-1-quytelda@tamalin.org>
References: <20180330070842.25224-1-quytelda@tamalin.org>
X-Provags-ID: V03:K0:Xp9jisWOri0NaV2A2+Y1Kr24Jo0HRl364KR+5njht016n44/eoT
 rRZaNyjY2N5p+uSM5xLq5mTdwnox8vA4FlEJL+wQsAj9gXf1hy0ybuiiOcVJNEqGxX0UeVB
 +6hLf2yb9i4iNsg0Z9minRQTW+nGwbr5S/ywQ5Bqc1jmRLmYASr+zY9gO1eQSiefPAImhH/
 8fQRpBFEdnl5KTaCCfhQg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:E6Mga65jZqs=:z81EAcNjnRLhOWJ4eeRJJY
 mDTDRm6DNwHdlnFmJV/TiH/McGoM6Kh+zFn9I4ckMrgpsiTAVHPIh3YfVBi6/5vIIvZg1hDyO
 l3mPraIMjFny7ZMUBKsTvFndlWYpIPn8bGwWV98cWVNOS+vJFbqFLJPSx8CnGFJIz4owJQvy4
 9cE0pCCHWq4eh9zzF4WjJ8K/w2BP8GCB79OPq4SR7DMssTlLJAZ/Zg36aOJze1LE/QnSZmWzH
 mvaCGG8FLmFs/gEM5B1c7txQmscZKtK/w38wEoSLxZ+wZrzy0VZkD3eYEBc/ORoUhYxCMBRyE
 UCG1LDNiWxRZLP1Uw4JJGqGx7ouetHJ13kNO7b5zGL4DctW4wNl2SvdkpFMo5wYT+Ue5JUOZp
 VaLeV7k2CQZN1GKijSeA12mU5WsvF2QjXZaLxhkomPxWoQi+0z0ogIeLaKgdy/hGM5izFoJ1O
 ye0r0m4jrNJXQQdIVeHzzChPfppoY5DFIY6QoBBGZYPcZh3Nz1LcTHZdNhNjAuYOYKmo8G8Zb
 ra4jObXnJMvWsfo7cJjeux9gts5jy5eAvf0b1yRRCGopogOczjGPEGtJNUjqYwGEi/mEDfMxV
 jOUgUHken3xmUvB6K0dLvow2lgU32BRFjQ07YimiIqeK8YV56Yu97e3RfA+ZyNTevOHFWv3Av
 m5f9vI224oySEo5WT9dmNZD+oQGb58UItIUawCW/nDzeR/OxJ/CL79Y5p5SIhV50+E73LnGJU
 20wnP/6WOwodA43PX967boQGautEd16bRFB/QyefNCoJLxeWJgRNVhtvrGMn7VWGsEa4qyVfG
 i65ZGRbarL/QWGJ5JoCh0wwbezubZc29lns18ktwgtbrZXduxMbgY6hYWIv2djs96H7lkNnca
 hIiGG3BY7wptoQSAbk5OeJCpU3t8i5U1Mh97d6paICswikht5bgEqoHO1wTUKh
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596345590107407451?=
X-GMAIL-MSGID: =?utf-8?q?1596345590107407451?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The "_t" suffix is not needed for structure names in this driver, and is a
reflection of an older typedef system that is no longer in place. Replace
all occurences of 'struct sleep_status_t' with 'struct sleep_status'.

Signed-off-by: Quytelda Kahja <quytelda@tamalin.org>
---
 drivers/staging/ks7010/ks_wlan.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/ks7010/ks_wlan.h b/drivers/staging/ks7010/ks_wlan.h
index edd13060c24c..d10ad152aa32 100644
--- a/drivers/staging/ks7010/ks_wlan.h
+++ b/drivers/staging/ks7010/ks_wlan.h
@@ -285,7 +285,7 @@ struct power_save_status {
 	atomic_t snooze_guard;
 };
 
-struct sleep_status_t {
+struct sleep_status {
 	atomic_t status;	/* initialvalue 0 */
 	atomic_t doze_request;
 	atomic_t wakeup_request;
@@ -426,7 +426,7 @@ struct ks_wlan_private {
 	struct local_aplist aplist;
 	struct local_ap current_ap;
 	struct power_save_status psstatus;
-	struct sleep_status_t sleepstatus;
+	struct sleep_status sleepstatus;
 	struct wpa_status_t wpa;
 	struct pmk_list_t pmklist;
 	/* wireless parameter */
-- 
2.16.3
