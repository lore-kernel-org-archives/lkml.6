Return-Path: <quytelda@tamalin.org>
X-Google-Smtp-Source: AIpwx4+zA6UqROzby1vM7+H5pKVxscmmu7axOGQn2cuy5ep1nw4ktXctxHI2xiN1wrdC2YIt86YO
ARC-Seal: i=1; a=rsa-sha256; t=1522476572; cv=none;
        d=google.com; s=arc-20160816;
        b=K4QTlSS7AbbJkkduy85MhKzbfoBnjdlfsFcVslzx4HAmUGgWaiEQKvELHKxRIwn3Lw
         dFLv6Qv1e4g9Qze2nHh95pC8rIxuv0kDV8TcIi6pVEAKPt/9CAFQKFRI+TJgV2W9zpit
         qqbJKnPvEUBQSaMUYykZEd4WxU+TDaRzrYxK3iikLns5jz+ycB3/kkV9wTwjBU0pqcF3
         pKNQ9T5UBoRZlKY4nmcq0vrr50q02McoYzJOwOv2mjOG7pLXCmkAQ/3XcvYq1R/kq/5A
         Vs9L2t9WQrwqonKagSXg9Bab1ZEwIr07GGqghW8H5UOE9z9f38MTvNPzthJpSrjV1kiO
         cjhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=IkLb9Oo8M7qWZYDCyBuj83S7FwRC3B8YCxRuW1IU4i8=;
        b=NiDStTeHAkfUhNS6GnEAJFo9ljr+ikLk+eEpq/R+znFW0WlZZI2DlRABEvOO8NcX79
         nvJg/+R3wiw/6EKnpMFBija975jum4o0reeHow15xU1pMdEaT8UavQUOWmHhFrbUJ0Nb
         cqp6YqHpxF2M7rC4U4vF8wB8U5usv0NBtn3ezGgQkFNk2yXs/1FTiGv9p1AdAdeCsWn3
         BagDcbsuwd+k9+nmkm0WZ0PyjCiBQE0yMxowIc9UIW1sxp0ZQZg9/eIzlEgOzeMypbhh
         zmjpNdNY7wACBhEaDDEHPMVcFwNKV+VWgB25I7JEZvVsnY+PSGm8gy5qV7UjdG4aPRjr
         iwLA==
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
Subject: [PATCH v2 11/75] staging: ks7010: Remove trailing _t from 'struct hostif_mib_set_request_t'.
Date: Fri, 30 Mar 2018 23:07:51 -0700
Message-Id: <20180331060855.9452-11-quytelda@tamalin.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180331060855.9452-1-quytelda@tamalin.org>
References: <CAFLvi23=E6QubTGX0=cHjbJGB=Vx5OJ7d16E2R4HZTscmJuuSw@mail.gmail.com>
 <20180331060855.9452-1-quytelda@tamalin.org>
X-Provags-ID: V03:K0:d6elKTOMGtu5JNqYPwreR8fXZg6nGuRzsfZRiw6mTOSgNsuzr44
 XjTQ6t0stxwW25zNSc3V5dS7iQIl4I6OGO89OV8SOs9OIDoqJOhwXVKpmhKdl54wcO/vgNh
 K2xEWRikoinLcRd6BnuPHaJ/uPaWqyo3ZNvMPy09U7K3an7imSCN87YAilzZmTW5zpCcAQG
 xHzlAo7FXUmkBZCeumySA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:xl992v8C8TY=:Mr1nXpmG5+Zji0BwQcqvmY
 dZfkn21j/Dmts/pa+05SMbjvVodJiIRKAzpOQGFbB3sTNzJ8+X1IuD1alMSzQljiPbUESqjiP
 1hV8HMHh8fBuxp6OpM0rUSEV4mXd6MCIE0k3bGJzugMaxnOpO2kcJaUa4tP6NLjVgVJnRS5pm
 /tFh/UExxYefGROVI39T2ViH0D4fBlwyJXE4LOf2cnDQfm+zz6HbhP2c3P/dTjKEh7+Yr8aek
 MFTOqxhwpRHhRfgQKZ9g4CpGoAqoK8BmIieRmU8FhB1qx5t/Dy9Ac7ANKXy/i22sbfjZC9cGH
 9MtVq93t8yfLcsoGAAZvpMR9FukI6zq5S+rL2//AkMduEqrtd0azUXpPD+cZn+YjSitm8wHiE
 ReIvY14zNvtwdbJr8UU+0YYSEI70Uxo4+D4RW3lBfIsFx5B74p+qB3Zz/Do8+D5n1/C4ATo0p
 85wXEcpKspmMxn9I7ng0+Smfj0zflAX+EIfuS/df1oF1qrGF+vObvqMfK+k/i4womTM3ykHqa
 rojJCAd37ULSgRNXSL5Bitv7n/+xesqmeZ2W2Sroxxp4nuNPMi/O943b3AL3jYmjC8rgXyb8P
 9CN6MJjgpm77b4M9xI4c1wgKvzHUjrUfaIthpkq5zA+nyO5tV6rLPYCs4w0HxyhdqOmon1sR4
 Uvt+YJZFlSMtxyppWF0sSB3ntt1d58W7zmxCKe53/bE3QvLJg/A2XspS1PNMBaom17Cv73der
 tal1xoz4yOptf4iTqChslvc+P6s9nbKiLla2Uw==
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596432394526341946?=
X-GMAIL-MSGID: =?utf-8?q?1596432394526341946?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The "_t" suffix is not needed for structure names in this driver, and is a
reflection of an older typedef system that is no longer in place. Replace
all occurences of 'struct hostif_mib_set_request_t' with 'struct
hostif_mib_set_request'.

Signed-off-by: Quytelda Kahja <quytelda@tamalin.org>
---
 drivers/staging/ks7010/ks_hostif.c | 2 +-
 drivers/staging/ks7010/ks_hostif.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/ks7010/ks_hostif.c b/drivers/staging/ks7010/ks_hostif.c
index cc1e5f441cf0..6295e01d91da 100644
--- a/drivers/staging/ks7010/ks_hostif.c
+++ b/drivers/staging/ks7010/ks_hostif.c
@@ -1258,7 +1258,7 @@ void hostif_mib_set_request(struct ks_wlan_private *priv,
 			    unsigned long mib_attribute, unsigned short size,
 			    unsigned short type, void *vp)
 {
-	struct hostif_mib_set_request_t *pp;
+	struct hostif_mib_set_request *pp;
 
 	if (priv->dev_state < DEVICE_STATE_BOOT)
 		return;
diff --git a/drivers/staging/ks7010/ks_hostif.h b/drivers/staging/ks7010/ks_hostif.h
index e6d6c51ccc43..157f1c2394c3 100644
--- a/drivers/staging/ks7010/ks_hostif.h
+++ b/drivers/staging/ks7010/ks_hostif.h
@@ -156,7 +156,7 @@ struct hostif_mib_value {
 #define MIB_READ_ONLY  2
 #define MIB_WRITE_ONLY 3
 
-struct hostif_mib_set_request_t {
+struct hostif_mib_set_request {
 	struct hostif_hdr header;
 	__le32 mib_attribute;
 	struct hostif_mib_value mib_value;
-- 
2.16.3
