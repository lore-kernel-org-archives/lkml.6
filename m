Return-Path: <johnfwhitmore@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1526313257; cv=none;
        d=google.com; s=arc-20160816;
        b=zBb1QOSRBK5aTBVYlZA8oW5zcy+WwGtuqiOPNzgI+18ggYE7onV8M29D/0gjudAHYt
         DgBkxxtEh9QPLnhXcyYuD8R/mc2v1gdFVntdWA2SdsshVZwKh1tq9mvzeJFQfU89no1P
         ndCtIL3iaQEzb027rdk1AA4tAeWmyFhgrLcI/5yMVip1nIzGZPMmXUZOlLcXuos0xipW
         5jWfkuGnTAZogcDSgj3W/eDgMbTDAloZdgs43qh0WREtKP1cM44zYssxJUBb05rkdI7p
         v1f4iTBA263fZjQKYRyVuSAQTRhoBjWc4Ws+ozGEluyDFp7spfgPqj+1N1ZdELIp9xUW
         nI1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=hsqLJSeLN4OSGebD5LiSgBwX4EAapiNZuD9DuW893u4=;
        b=D8VOP50XCY0XhscY44ZMvwBuQ92RW9Gui6TMInF2AexDLVxN1YEcc9KSVuv5CakGsz
         eNm9+7Zcbm87ANTNIDDsN4mei+/YgbYtDmOdpS6U8LFf3Ut0TmIV/vQszUtUl4egvxwk
         rIyeDjYkChoAFJMTosRox0oldIQ9mbx4vfetAW9O7c8Mbv1AFfEwQsukdXWEPdCGKUoC
         b4Nsnh4IC5p/Y3hfKipTT8ccPqNPymRalp0dLA43FkTPKGOfs5LMlc7yAk4wRHptfrUm
         UBar3dhxUo7UUaqL1zg7GJeiXQ2oWiHbNA/Tuk4EN1zYalPev2BoydQSK0YeEMX1hwm9
         Oseg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=J8xRc5vD;
       spf=pass (google.com: domain of johnfwhitmore@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=johnfwhitmore@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=J8xRc5vD;
       spf=pass (google.com: domain of johnfwhitmore@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=johnfwhitmore@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AB8JxZrsHgI44okhSISxUGekinvMITpDZGY2ZRU/4S42tgI8Ve6SrcBIVg4FyrWpDdWLOUzcplMerA==
From: John Whitmore <johnfwhitmore@gmail.com>
To: gregkh@linuxfoundation.org
Cc: kstewart@linuxfoundation.org,
	colin.king@canonical.com,
	tglx@linutronix.de,
	devel@driverdev.osuosl.org,
	linux-kernel@vger.kernel.org,
	johnfwhitmore@gmail.com
Subject: [PATCH 09/13] Coding style, corrected bad indentation of a statement.
Date: Mon, 14 May 2018 16:53:14 +0100
Message-Id: <20180514155318.32195-10-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180514155318.32195-1-johnfwhitmore@gmail.com>
References: <20180514155318.32195-1-johnfwhitmore@gmail.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600455450776850671?=
X-GMAIL-MSGID: =?utf-8?q?1600455450776850671?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c b/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c
index 254d536c21d8..f26b01c56d66 100644
--- a/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c
+++ b/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c
@@ -344,7 +344,7 @@ bool IsHTHalfNmodeAPs(struct ieee80211_device *ieee)
 		 (memcmp(net->bssid, LINKSYSWRT350_LINKSYSWRT150_BROADCOM, 3) == 0) ||
 		 (memcmp(net->bssid, NETGEAR834Bv2_BROADCOM, 3) == 0) ||
 		 (net->broadcom_cap_exist))
-		  retValue = true;
+		retValue = true;
 	else if (net->bssht.bdRT2RTAggregation)
 		retValue = true;
 	else
-- 
2.16.3
