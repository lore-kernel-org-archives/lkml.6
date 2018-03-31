Return-Path: <quytelda@tamalin.org>
X-Google-Smtp-Source: AIpwx4/s6OLTzUYlvCHJEh12gCAeeFQBngUaWQJ5okFhKrfogu/w9m8LmvyJID+d7NWHhSY6HxVo
ARC-Seal: i=1; a=rsa-sha256; t=1522476575; cv=none;
        d=google.com; s=arc-20160816;
        b=FIXn8HuSZpxyA2y59v2g9GToDTnjLdN4LCTDiW3GebXuPiIZQqS6cXSI05/iAR5h/P
         KJh5qUXFAaNkPDu/uLyZMIumHkU6e4nvN/XsPHwYlXzqpVJ/Yf2zk8/1ahsEzlvSGSs1
         f9DTGAO5o3FzOQdLMWfTbUjM5bjqDXdjlbZp/VzSsdG2BoyCclBq5i8SkTonHdBLj1UZ
         PS2K6GruYxAJYBKhS0mcD8y7nWtStERkJF05wR5ET0LEhNZF6cesQEOQtR4mlIQGEvOB
         zq4FYNN9QN277R7t61KmodY/dK9QuprQI1GCquiqsqSsZCTk/I15il5rLMbwwI4KG/uQ
         IGhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=aMPcdpds8q4+mJG8eHokPsZLR16I6uLaYkdrcAAVvPI=;
        b=VZ89YGAV5jfhXstcUNdBLdYe6zz/NwB7rw9ZXergjjhIJeKtr4FmVJWnfGXKrupCLB
         KKk1hsnE+JEQ5pjK7dSm1Lwqfqhvz3DzIays3r5/FiAB1CHOE2iRbxXCZsITMryFycM1
         gJjtuu2VXTN7Zc0GfaMxAErumtc2a0RniYr8u3wD/W9xlF8TMjY80S3hmftWgICafi8+
         caLlLCEQ/+9jphx5X+H7aaLKHGSqrHIxE1ebxaxBNinvvF1kHVugGnC7rIRerDC1zMCH
         E0IfSxzIInfm2uqoro17HP7xPJUN6G0LK2Jvv3sEehA9nqvxOPUEjNbM2u44Wxc3PRzi
         NPtQ==
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
Subject: [PATCH v2 15/75] staging: ks7010: Remove trailing _t from 'struct hostif_start_request_t'.
Date: Fri, 30 Mar 2018 23:07:55 -0700
Message-Id: <20180331060855.9452-15-quytelda@tamalin.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180331060855.9452-1-quytelda@tamalin.org>
References: <CAFLvi23=E6QubTGX0=cHjbJGB=Vx5OJ7d16E2R4HZTscmJuuSw@mail.gmail.com>
 <20180331060855.9452-1-quytelda@tamalin.org>
X-Provags-ID: V03:K0:+NaiaLvXEk4j+8benp4/JwALTThOrzuwC19l2Ojmd7UpkIg8GwX
 0kpUKiKNy0X/p0maTJxknlIRl1rrvlYfhvCpzlP6d8ykjeyBt66bzDd0wbzmMgvRQH9KXIY
 jIsA2fidolDonXz4dmR/dw66IOD7bXp/GL1IxP+TkORI8uK60PLKV4JuOsuytQfPhj/LlPR
 enxfZuIjoGUm89+R/dPpQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:qHPPSwuLivg=:y01PVuL8nY70yzQtckylz4
 xZ97TlWF+TZ3EcOkHEXSQH4VzWjSqNcR1rhDaWEoTr8hVSHhoZGw10ZAF2ZjZuMdg+y7CWMux
 wj/vIGub3eXr0ATnKRoCZWJcONp/0t8KfWmxLwpfPpeLzpunm+zQ/P634NE0zwGZpFtNzH/dT
 hp+3DQkvtQwglLIeeUrxmSA8LMijZeX/W7k79Ae3BHc0tUzoLJQbeG72yTV9yhS4sHgLUJ2TT
 MQtnFhyZRd5QQ3c7Xd3t9pS+eNfbo2EDucvsn1ojYGT6MUsAlI4y+Tdo+gi916mACoAmrAjV0
 qvOp7iJsIHGR/sHexgnSNsOhDqHS/Udz7+FBovoijBB7adnpjpIpvUyv7X6Xb4QOoQQ/yxod0
 BVOrgvHtk9OEVJm5KjMVntxf9h8NPTtM54Co9xZElUcBEu0W6F1sxp7Ohzj6YH8F4dWnKYuzL
 LYLyC2HZnm0NKO6cIfmmw9UIO0HPmLijwyPS12OKeRB+XyuR7ZhvEOVT2jscwjSWMCzVlnFnr
 A6q9tJ5YRICWvIbr2uTx47+zKJQL2W1gCOGpNLBZbRwzQs7wMPk/Syvog+gYdJjZ1uBd0UruG
 vpUcbAnwAECtbqat0yQaKzR/llhp+OzTc9VI60X6l/X/jn/hh1DfzCJihMqpUmUl8zzLgwgZd
 aKpfOttoFX2mZ3askNFjEA83Ni2Ce0MjwsiCpU/iGkK81SdqVg9VRZuQQKUeAUJmjbH4UpSFW
 BEgUoWCEHfACYxVOjBAjPzE81KJxoKI5Ow5qYg==
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596432398033507403?=
X-GMAIL-MSGID: =?utf-8?q?1596432398033507403?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The "_t" suffix is not needed for structure names in this driver, and is a
reflection of an older typedef system that is no longer in place. Replace
all occurences of 'struct hostif_start_request_t' with 'struct
hostif_start_request'.

Signed-off-by: Quytelda Kahja <quytelda@tamalin.org>
---
 drivers/staging/ks7010/ks_hostif.c | 2 +-
 drivers/staging/ks7010/ks_hostif.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/ks7010/ks_hostif.c b/drivers/staging/ks7010/ks_hostif.c
index 848307241195..9bfef9c9f64b 100644
--- a/drivers/staging/ks7010/ks_hostif.c
+++ b/drivers/staging/ks7010/ks_hostif.c
@@ -1280,7 +1280,7 @@ void hostif_mib_set_request(struct ks_wlan_private *priv,
 static
 void hostif_start_request(struct ks_wlan_private *priv, unsigned char mode)
 {
-	struct hostif_start_request_t *pp;
+	struct hostif_start_request *pp;
 
 	pp = hostif_generic_request(sizeof(*pp), HIF_START_REQ);
 	if (!pp)
diff --git a/drivers/staging/ks7010/ks_hostif.h b/drivers/staging/ks7010/ks_hostif.h
index 245d954e3be2..ef1e77b40e4e 100644
--- a/drivers/staging/ks7010/ks_hostif.h
+++ b/drivers/staging/ks7010/ks_hostif.h
@@ -187,7 +187,7 @@ enum power_mgmt_mode_type {
 /* #define	RESULT_ALREADY_RUNNING    3 */
 #define	RESULT_ALREADY_RUNNING    7
 
-struct hostif_start_request_t {
+struct hostif_start_request {
 	struct hostif_hdr header;
 	__le16 mode;
 #define MODE_PSEUDO_ADHOC   0
-- 
2.16.3
