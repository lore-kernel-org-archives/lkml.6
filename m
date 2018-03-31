Return-Path: <quytelda@tamalin.org>
X-Google-Smtp-Source: AIpwx4//9xtBuovACGTypObMVJiNzc28P5EMtnB0WTEvjnApgkwqaGkHnBcTf6XHWx+oLtxpr2KF
ARC-Seal: i=1; a=rsa-sha256; t=1522476594; cv=none;
        d=google.com; s=arc-20160816;
        b=qfgu4TPJM//DzNwhgVn/9Br0m/UfcbrfD3PkMu28EQ53Ko1KVufQgnx10JJb0ydQ5D
         l341IeqWy+2/1H/sODDYjPtG7M6e+OYi47pdIr2NwTzp4meZNhe2avh4D46w8a1D32HE
         0fnZ71NsDECBpAWFbLomQ2dTA0+4AoLi5iCC7cbd08i13hAnG/MpyszEBF92/5DvLwCv
         KeMzo/7DMOr8MVMNgmLRiq86NzTwSzZe4/Cy334gbgvBILUHr8ORkKeA+TWrRJ6YymRu
         8Lzzr2gRypewGwQLykM0rAZYt5A2fJhe+0SbszFDK2MxjV7cob7+Q1o+9fy/Gu976Cbh
         jYEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=v7OK5PpuZ/pvLiRsMCLW+Hd9fJSF3tS74Fx/8ThCK68=;
        b=dYr6gzxWKrmDddjYhI4uZW7a3CeMlUYV+U/IbHf0upWTokO3tj3vWYEQugip9IU6Vx
         RSB/elRBCy0PhcRhoXMISzRdxArP6N5o8x9upFL/PHrpF+zc/bhFUi+teXob96Smk9Nx
         BkLd65GhPP27rHa+oC1XEcF19Dhe2m8MQ0SctWkHkR3kaemvD2M8yhU2oGIyt4WBArnU
         6EurrkK0GzYxoI2D9fldAJ0ztCfRt1YjT8oMK3orw1FQfLR7SqFjgjG1wzeX70FQM4Yd
         yONf2FwDmpIdT3YfFXZSRLI180M4Hl11NsJVirSGDVCvXB2OF8kPA3SNpz/qqJ5O2LEl
         R++A==
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
Subject: [PATCH v2 36/75] staging: ks7010: Remove trailing _t from 'struct hostif_adhoc_set_request_t'.
Date: Fri, 30 Mar 2018 23:08:16 -0700
Message-Id: <20180331060855.9452-36-quytelda@tamalin.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180331060855.9452-1-quytelda@tamalin.org>
References: <CAFLvi23=E6QubTGX0=cHjbJGB=Vx5OJ7d16E2R4HZTscmJuuSw@mail.gmail.com>
 <20180331060855.9452-1-quytelda@tamalin.org>
X-Provags-ID: V03:K0:hHWiyfg1lyVOfWHlu5PHdYF5vtSWPHe4QsCcgBVKmhOYVvOgcK0
 YvG7GqUot/ivwA95QWlkh+sA01vUOoPwZJBx/oDj8h1d4wG4A+dy5hV24NrE7CFxs/PohN+
 W4RKeQgwctuzUAHtn0ZrRnQp5gSYsHSFl2HYGsCTAnv0h/DFBPFvCG325eNMLnNiRtPaHMU
 lqb/AYEEQNS89M3fg/C/g==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Vdz/SagjevQ=:++OaHbtyLgVXUI0reT9fnz
 GB1s9TaBTSNYcm642bTUlWL9FCeDb937E4AVrKC588LhdQdyB0Fl545LeCHfHkkpe7qQbUpCS
 4rbA7bJy/0b1hZVTDZuTtM0AwLccGdMxtKDboPcQJ29vdkHNY5g2yuRTlgK8sYQCFNH4cPtZ3
 ydCO0PzZs/4VSsWWtfw3+wBn16yTEoBmsovyu+iseRAFynl18ukF0TSwNdP9xK4WNF13wW7uw
 98khNUtYZVSy5IQjiWHFGBeG6kd/9bqEBfRkPNyODxBD7aMypPz16CKwZ2kbxROpLXr0O6o1X
 RW3lLCeCrHRvLWa3GorAj1jDHNuwuCHdvvN6u+8Z0Q8FAM/asZqr1AXvhnuB1QxARDEPx7U2G
 0ap1O0bEp2JAcphsV/gymOodwlbVu8/l3Z7NOCWwPKCdYv81MW1WCAsJuheuCxU75T/uImgpe
 cHZPf8eZqu4obn0Vm/y02rmnBeosCF27/xJz68szlyQ5HG2Jb9hb409hsQqx03r3u0nbl7DTj
 VNL6dO3IPJ1ZQEdYazv8Dtksu3pvHZhdUhIMia/R48cs5V6EgR6xuFw8AcKVfHPrEpIX4fZdA
 zRD0TfIowKgXsGgA0xpDvHbYs/u9f7r9rT4/j+nhv6n3In0QKyStzkLlST7MgEifRMrtjnBDs
 jyi4eR4AVIVDtcrtyV07ff6+QFVnFlTXTHURz4D6AXgrdhTEJ9/oBh//gs2asfrtLFu7SsQmo
 XpR+rb0SE4eVGV6leoA1RzLLImoHew/o8AJ8NQ==
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596432417813751255?=
X-GMAIL-MSGID: =?utf-8?q?1596432417813751255?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The "_t" suffix is not needed for structure names in this driver, and is a
reflection of an older typedef system that is no longer in place. Replace
all occurences of 'struct hostif_adhoc_set_request_t' with 'struct
hostif_adhoc_set_request'.

Signed-off-by: Quytelda Kahja <quytelda@tamalin.org>
---
 drivers/staging/ks7010/ks_hostif.c | 2 +-
 drivers/staging/ks7010/ks_hostif.h | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/ks7010/ks_hostif.c b/drivers/staging/ks7010/ks_hostif.c
index 3d6ba74cc3e5..de56cda64bb9 100644
--- a/drivers/staging/ks7010/ks_hostif.c
+++ b/drivers/staging/ks7010/ks_hostif.c
@@ -1385,7 +1385,7 @@ void hostif_infrastructure_set_request(struct ks_wlan_private *priv, int event)
 static
 void hostif_adhoc_set_request(struct ks_wlan_private *priv)
 {
-	struct hostif_adhoc_set_request_t *pp;
+	struct hostif_adhoc_set_request *pp;
 
 	pp = hostif_generic_request(sizeof(*pp), HIF_ADH_SET_REQ);
 	if (!pp)
diff --git a/drivers/staging/ks7010/ks_hostif.h b/drivers/staging/ks7010/ks_hostif.h
index 7429304d6691..8574c09b3ab9 100644
--- a/drivers/staging/ks7010/ks_hostif.h
+++ b/drivers/staging/ks7010/ks_hostif.h
@@ -342,13 +342,13 @@ struct hostif_infrastructure_set_request {
 } __packed;
 
 /**
- * struct hostif_adhoc_set_request_t
+ * struct hostif_adhoc_set_request
  * @capability: bit5  : preamble
  *              bit6  : pbcc - Not supported always 0
  *              bit10 : ShortSlotTime
  *              bit13 : DSSS-OFDM - Not supported always 0
  */
-struct hostif_adhoc_set_request_t {
+struct hostif_adhoc_set_request {
 	struct hostif_hdr header;
 	struct hostif_request request;
 	struct ssid ssid;
-- 
2.16.3
