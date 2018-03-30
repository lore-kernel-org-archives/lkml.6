Return-Path: <quytelda@tamalin.org>
X-Google-Smtp-Source: AIpwx4/g94AZ3VjGgkFyM77vzolPVjj6614eE10NfmFeEGYLwtetRxHQ/ps3/Q/Bs3BWM7jy1qlX
ARC-Seal: i=1; a=rsa-sha256; t=1522393780; cv=none;
        d=google.com; s=arc-20160816;
        b=GMcV7Z9vdUUF9OBJ6/46Z45qHt2esGWX8JSnqi6Ozfh3G87Zt3GQRWJP6sOyZfqf4D
         wxI2/vO6TH3KPWG/TBoXVJ9vzgGXGM6+eC/mDMncWLjwLHVZ/nZU7MJpZTgcIKwZX0+7
         B5dzLWm5XuOUB0ds4HxxRCkNek9podwn3bLXIhoidwy+sEbkQMBWCcFKzd4uruhYKTX4
         oLQsPhzlSqOdh7kKgmCvn84uPCNK+ghkIAKnw5E94B0JZjnaUNDPnK8H+FYRvvZJitZq
         7OQg8zOZ5IYEFlgEpN9Ao9I8jFkFBl2pEFBaD33kCjgrC2Lovc+VY+gYT+x0Ps+OBmqp
         z+jQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=vbo8ozOcvj06UD1fetRZvOUaoQMX6SV0zBrWhGhbnko=;
        b=qvKQP8dzp9r9jTbiTbh5Tb+fjAXfgyW5/e2xRa5By1M6HXX8EebpQeLpFQqDkdd8bY
         cFj/PjOUJaH1CMmfcCyss9obRbs++QD2ZOvlYFiyuw8CX2InL4R6OThyypFeInNcvBFQ
         fv6n8Y7McmpvZLh8o9wvSBDBoqadJO+WB3YMp1B4T/arwKG4BhefLFghHxeiiqb2Th5e
         VciD/sVaKWIF5i/IZV3j+iwi7JhMiYfHFwrHhqWrgcUKbuzj+rNdhP35j7wqHqAJ7jPJ
         eBAFIHLYuKqqDMqZ8ckdwEZi2J0UEu3klIyhnQGfTFWZ3WxJ8duJEvqt2KYnkm3LhlbA
         HbPg==
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
Subject: [PATCH 49/76] staging: ks7010: Remove trailing _t from 'struct hostif_mic_failure_request_t'.
Date: Fri, 30 Mar 2018 00:08:12 -0700
Message-Id: <20180330070842.25224-49-quytelda@tamalin.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180330070842.25224-1-quytelda@tamalin.org>
References: <20180330070842.25224-1-quytelda@tamalin.org>
X-Provags-ID: V03:K0:KA/pSCy06AejPKyWEr8Yc3h+0Q7P+yD56tpppZ1iDRglcwdvrAc
 izyEkDN4nr0s76vrUM2XLGYHrKlhukAaTwvDFRYW972qw6rbwgvZ7yHlO0NzPp3PZJaJpgA
 /OR0u8BQw9vkyYeNk9Fx8wfxy/uRZDKAL3Mosg53VMg0F1ZRK7/zaVQECPlOnnGbvzCwfNd
 CTBt3KtU2UNjj5hFabyug==
X-UI-Out-Filterresults: notjunk:1;V01:K0:jeAK3mzJMUU=:tOp804AmsMJHIg0K4boniU
 8cK1QfvrloTc9U+I2kqTcSnPqZ8LkhCuEQVO4ui6Lz/npERiovaFNYk0Rx09ptu+Awxpnlmbr
 L8wXAWyXVPjHUWioML+ZAMtFmq6wM0zIbBxxB4LOcgDMQytDmJBvAHHDXUPjZ/aTTbU9o6fOv
 wND3CW0faRS+cxl8XdFSchiodLZB7aMXef8gOIxudmpJwF7/7OI+RHrNCK3A04zaiRMBx6P8a
 QIsWR4wWki6fjlJRvUGiLQRWrHtRgxrbNa+9l5ybGbEOABRM7Kiv+0J3+8iB9HsxcqfDnixoQ
 Lr1ZD7I9pzQR07b3CZdOrfT6EG5h7To9FNqKo92gw2hOqjAUEE3DDZXqfQvWT2eBJtDDXItWD
 33h2OTK0Q0NRED+A+s0bJ5INPqUOfFDtRd4/xWGG7xAT3e1oU50s10kdKo7CLLM7nJuQDqLWC
 wfYBEzAGD55MOlLiXk1qaf4PK9VPOLsh76Fz90aV1ewfUcVSiL91fCpH8t6Ou0DnkSD2cDfy3
 U/tohpwSBzbmsomE+O+GKfwNb+ihsCuhcjCUWhv6rrdbZJ1HtwNGdX6O46d80Jf900s0rb4M4
 UD+UWQDt/c8P5bVQKnI7LtgNuaJ0yFUcj0+QhClqP0TLmWS++fDMw4441wgeier/6dS29dpEe
 AjT4Ocq60LvNwbp+5He8jdiSbFeMre2m+wWr59ho1WMZPnO9h006L3Vwrpk9WQH+ykPpMJHwQ
 ULmbE7TkwvmeAmL86NQxYXWvWDnO/HJhVQyG8A==
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596345580615874257?=
X-GMAIL-MSGID: =?utf-8?q?1596345580615874257?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The "_t" suffix is not needed for structure names in this driver, and is a
reflection of an older typedef system that is no longer in place. Replace
all occurences of 'struct hostif_mic_failure_request_t' with 'struct
hostif_mic_failure_request'.

Signed-off-by: Quytelda Kahja <quytelda@tamalin.org>
---
 drivers/staging/ks7010/ks_hostif.c | 2 +-
 drivers/staging/ks7010/ks_hostif.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/ks7010/ks_hostif.c b/drivers/staging/ks7010/ks_hostif.c
index cb768e861b07..2f732d8bcc4f 100644
--- a/drivers/staging/ks7010/ks_hostif.c
+++ b/drivers/staging/ks7010/ks_hostif.c
@@ -1558,7 +1558,7 @@ void hostif_mic_failure_request(struct ks_wlan_private *priv,
 				unsigned short failure_count,
 				unsigned short timer)
 {
-	struct hostif_mic_failure_request_t *pp;
+	struct hostif_mic_failure_request *pp;
 
 	pp = hostif_generic_request(sizeof(*pp), HIF_MIC_FAILURE_REQ);
 	if (!pp)
diff --git a/drivers/staging/ks7010/ks_hostif.h b/drivers/staging/ks7010/ks_hostif.h
index c34bcc7d9a0b..659e2b895bff 100644
--- a/drivers/staging/ks7010/ks_hostif.h
+++ b/drivers/staging/ks7010/ks_hostif.h
@@ -512,7 +512,7 @@ struct hostif_sleep_confirm {
 	__le16 result_code;
 } __packed;
 
-struct hostif_mic_failure_request_t {
+struct hostif_mic_failure_request {
 	struct hostif_hdr header;
 	__le16 failure_count;
 	__le16 timer;
-- 
2.16.3
