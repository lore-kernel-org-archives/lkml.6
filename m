Return-Path: <quytelda@tamalin.org>
X-Google-Smtp-Source: AIpwx4/V1ZJmoXP2VP6IHyCKPoX/IrMxqMOjHl0k8cHvc+2Qv4AKsCiEeVZLUf5btg0r4YXgzxA9
ARC-Seal: i=1; a=rsa-sha256; t=1522393778; cv=none;
        d=google.com; s=arc-20160816;
        b=BmMKnbj/Zbr+PpURBQE3ccL/oZ/E+LLVxiuPxoe6MUq7+tyMsrEMqum42CoZBejZX5
         845f2VUMt0DFiVoVjMhmrbhHpnF6PZP0ooS3XxHXJpWC4jdG3Jw0MFX9dsFGVRMm51Y8
         zE1wC8P6JAxtVcuupfE+xqbzJuv7wcj5GkGYnhkP6krCMBhsF+EYSkX8Xpubbd+RGQqI
         ALReCzkSI82hK3EdQTeEINZ13WPSUaoozyI70d1TuEUP62jDVXpDeOe5Fu8vdDIWXFwx
         VS8YPrt3RBPHQWY9UACL3tJmCzAz/6DCzAlF/YDoG0ryQtk+YKuAgqCWxyNUxJXsJfGZ
         u/JA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=F616V9PLk18t5lPFK0eMs+AORGQSKo3eFFtUBAHFa7Q=;
        b=sCKaPKwgIlfO28sj3uNr59NEC7u+aUn4RWUkTn2IwZ0jLnfnFTH2Lbn8YbW4wiWhZo
         +AmPykm5i/CezdSWcnWuG2kDfJqXCXShxBLe8tEMQIj7jxiuUl6KBoSZpEtpWF5YqjRm
         n595orJwNBHbtBFSnueedFiKReEP2X6KIX+LjhRfDFGfsMsyc+ldsqZW5DSNj6b8Y1ul
         E78pZzocFy1DKr6ZZUOg6F+eK5lT+lPXFoC0EjE+466IlpGgSgJgYkUF7yiA2tATBVH3
         BWzb3ZhSZy5htoLEgsLPlMBnaIezrmJEzouNfvrzZp6nM7lLgyqzgNrdm85dnVDSmjKb
         ChVg==
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
Subject: [PATCH 47/76] staging: ks7010: Remove trailing _t from 'struct hostif_sleep_request_t'.
Date: Fri, 30 Mar 2018 00:08:10 -0700
Message-Id: <20180330070842.25224-47-quytelda@tamalin.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180330070842.25224-1-quytelda@tamalin.org>
References: <20180330070842.25224-1-quytelda@tamalin.org>
X-Provags-ID: V03:K0:Vn9dwbJBWMS1AFMI8cA4VZqKmqae1xC6xx+Hp90o+IPkNsC8unv
 0W6eJzY6/VOu3huynlpA14f2Ot40u8L2FewBk2foxoJG9wjRy3p5zm+H8uBz08tQ6Adw+P/
 TRRnl/BIWKsumTqXtv5ciJHVfclRNimBaxUHWaIDYpxvpu2YM6SR/EQCJ05UrrrnQCo4EmK
 Qwbaofwg7y2y7qQRrOb3Q==
X-UI-Out-Filterresults: notjunk:1;V01:K0:X+IJ6NFyU7Y=:bUgzC4ZACoGo4f1PwSgx8V
 yvh+F3Qb+wFSBJCjWS3cVn5v/AVSIJA9eW5l6n6y8z8GgiCx8Oc8fcMZn8lhq0CSiwymQzM7I
 hY8mvKy3PCc7YCWAznwRKuDDvwLGn+6wCSL3784D0Lk6kiM161AHu4XDjLipJS4atdKJ2yNQh
 HqukJCDJoW19xzgsW8ETCwfpq68WeHOk1n/eYDnymYtt28S8HRsPDl2x9zmyBV621NbD07dVK
 vOn31z1Ae8yZboT3wBbpKoCdZ6/7XAVE1h6G53uuT6MLzv9nVg5Fbpn7S+wypCR87Z1UwvlTg
 kCOoMy90s3RnWsbwO0UNBhQh8hwtzJxJb6SkZLubYtugBRZSSFr4X75R6247Kh1+qfKt/Ak3R
 hno3NX7X4Dv9br7I31y8EE0MXhmtttTbwuZw9/6syw3oJBf0iSAt1tq1b6Nu+8rXnPvl7fCTh
 eO+NCqyS1cP2Kqaqu5rc3BLU5/0tI9leXWNjKcnMx3tlLPRmMGBXlEsl+KEHPzqUmjIjGdTph
 O5F21BX2ano5YTqmwxDhY8dhBQ7wcus6OruIgqQYRnjhzQfoKEzaXcuuCePsoq6XLqTDfwvUO
 Yyox3MhHLfU0XBQRDG6X9xsIRe8shhPTEVUI9xq/OaKBtuXMQwFKomAONBZU24/3FHZPAwlJ9
 8N+O0bwXbnXWqWDJf6fxsnHvqwj5dzeZ6CG6z6JbbI1hPXsBXgjyIWFa9mAafcs6LqDdzIzuB
 +evgL1nj4V3k6VeNzyH/4vMQCVt+gtyi9r+PvA==
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596345578939380133?=
X-GMAIL-MSGID: =?utf-8?q?1596345578939380133?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The "_t" suffix is not needed for structure names in this driver, and is a
reflection of an older typedef system that is no longer in place. Replace
all occurences of 'struct hostif_sleep_request_t' with 'struct
hostif_sleep_request'.

Signed-off-by: Quytelda Kahja <quytelda@tamalin.org>
---
 drivers/staging/ks7010/ks_hostif.c | 2 +-
 drivers/staging/ks7010/ks_hostif.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/ks7010/ks_hostif.c b/drivers/staging/ks7010/ks_hostif.c
index 4bd8a285eac5..cb768e861b07 100644
--- a/drivers/staging/ks7010/ks_hostif.c
+++ b/drivers/staging/ks7010/ks_hostif.c
@@ -1483,7 +1483,7 @@ static
 void hostif_sleep_request(struct ks_wlan_private *priv,
 			  enum sleep_mode_type mode)
 {
-	struct hostif_sleep_request_t *pp;
+	struct hostif_sleep_request *pp;
 
 	if (mode == SLP_SLEEP) {
 		pp = hostif_generic_request(sizeof(*pp), HIF_SLEEP_REQ);
diff --git a/drivers/staging/ks7010/ks_hostif.h b/drivers/staging/ks7010/ks_hostif.h
index f6b4b3eecf2b..f570c6d84970 100644
--- a/drivers/staging/ks7010/ks_hostif.h
+++ b/drivers/staging/ks7010/ks_hostif.h
@@ -503,7 +503,7 @@ enum sleep_mode_type {
 	SLP_SLEEP
 };
 
-struct hostif_sleep_request_t {
+struct hostif_sleep_request {
 	struct hostif_hdr header;
 } __packed;
 
-- 
2.16.3
