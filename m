Return-Path: <gyedo.park@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1522982836; cv=none;
        d=google.com; s=arc-20160816;
        b=CyLmBvaWAEEV+W/m/iTyQWNgi5POtey0PK17mTv4hfWZigKKoFSdsoQ3Yqxf7C7zck
         CHjuttblJcSuDEnh6d2PFzyEf1m6KbVRb1dQwgk0qvCxq5TCtvGRSW0whsG26ghmWOgf
         b0VXCVwltx2TD03p75VbHpZBSjJD3sVENBJ6fcLMT69A+4CKmiFqthjhLmcMzhV/7i9r
         QPVmdIGJlmEQ4QYtxU3cPN1sGhjS2dDrbpqUB4+Y8g8hzO6meNyrFJLx782ISqs3VIKO
         4BnNmy1nXPpyB2332F+/pUcQW07lD20qUGFCeH3q8OgPgT7Yrgn4u/yUdZhtGGYkoO5L
         D+Ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:content-disposition:mime-version:message-id:subject:cc
         :to:date:from:dkim-signature:arc-authentication-results;
        bh=h1xokyP2l7m8tXkAeOxgZj8B3JXtisMaTnKGLJZutcE=;
        b=ucPHJU48aFqlCLqfOAl3MPawecLjLFfZsCNRE23zj5057UiJ/Gxaw+5+QoFYqlYhhE
         YUgb+s7EXFi3mfTljuPjEbyrR2GoOAJXBUSKkKJP4iKBWkdzM7SFAoxVt4GBjrMOOGho
         k1euukbgXZ7JCo6OfJ7SoOmuFwkVMlgxbpi4C3ELEDMb262ICTegxiGjBGmkQreTuUzX
         +mu2ZRfR0hw5CcXtU78sTJYdzeLizQAAvYxU2crq92LBk/n7xh8zatMf8qFo39UU3EN/
         YXWB/3jcZe4FPUsPXGXfwdlAhJ8N3ARjaAGTRRQjJ9dkBNvVBuxqbXYyCg0TR9Jezjiy
         C+pQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=hnDvGiHp;
       spf=pass (google.com: domain of gyedo.park@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=gyedo.park@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=hnDvGiHp;
       spf=pass (google.com: domain of gyedo.park@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=gyedo.park@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AIpwx4+hp9zGq0avSQI7OeOyvUtNBxQGT+S+qmt9EeyR+j75j/gCc8uyjTMPRTa+IRPbKY3cCKvIcA==
From: GyeDo Park <gyedo.park@gmail.com>
X-Google-Original-From: GyeDo Park <pkdf1030@gmail.com>
Date: Fri, 6 Apr 2018 11:47:23 +0900
To: gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org, kernel-janitor@vger.kernel.org
Subject: [PATCH] staging:rtl8712: required line 80 over and multiple line
Message-ID: <20180406024723.GA20534@h00ker192.168.219.101>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.23.1 (2014-03-12)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596963250005512225?=
X-GMAIL-MSGID: =?utf-8?q?1596963250005512225?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

clean up checkpatch warning:
Warning: line over 80 characters
Warning: Avoid multiple line dereference

Signed-off-by: GyeDo Park <pkdf1030@gmail.com>
---
 drivers/staging/rtl8712/rtl871x_mlme.c | 92 +++++++++++++---------------------
 1 file changed, 36 insertions(+), 56 deletions(-)

diff --git a/drivers/staging/rtl8712/rtl871x_mlme.c b/drivers/staging/rtl8712/rtl871x_mlme.c
index 7824508..db50677 100644
--- a/drivers/staging/rtl8712/rtl871x_mlme.c
+++ b/drivers/staging/rtl8712/rtl871x_mlme.c
@@ -469,9 +469,8 @@ static int is_desired_network(struct _adapter *adapter,
 		bselected = false;
 	if (check_fwstate(&adapter->mlmepriv, WIFI_ADHOC_STATE)) {
 		if (pnetwork->network.InfrastructureMode !=
-			adapter->mlmepriv.cur_network.network.
-			InfrastructureMode)
-			bselected = false;
+		adapter->mlmepriv.cur_network.network.InfrastructureMode)
+		bselected = false;
 	}
 	return bselected;
 }

@@ -721,27 +720,25 @@ void r8712_joinbss_event_callback(struct _adapter *adapter, u8 *pbuf)
 	pnetwork->network.Privacy = le32_to_cpu(pnetwork->network.Privacy);
 	pnetwork->network.Rssi = le32_to_cpu(pnetwork->network.Rssi);
 	pnetwork->network.NetworkTypeInUse =
-		 le32_to_cpu(pnetwork->network.NetworkTypeInUse);
+	      le32_to_cpu(pnetwork->network.NetworkTypeInUse);
 	pnetwork->network.Configuration.ATIMWindow =
-		 le32_to_cpu(pnetwork->network.Configuration.ATIMWindow);
+	      le32_to_cpu(pnetwork->network.Configuration.ATIMWindow);
 	pnetwork->network.Configuration.BeaconPeriod =
-		 le32_to_cpu(pnetwork->network.Configuration.BeaconPeriod);
+	      le32_to_cpu(pnetwork->network.Configuration.BeaconPeriod);
 	pnetwork->network.Configuration.DSConfig =
-		 le32_to_cpu(pnetwork->network.Configuration.DSConfig);
+	      le32_to_cpu(pnetwork->network.Configuration.DSConfig);
 	pnetwork->network.Configuration.FHConfig.DwellTime =
-		 le32_to_cpu(pnetwork->network.Configuration.FHConfig.
-			     DwellTime);
+	      le32_to_cpu(pnetwork->network.Configuration.FHConfig.DwellTime);
 	pnetwork->network.Configuration.FHConfig.HopPattern =
-		 le32_to_cpu(pnetwork->network.Configuration.
-			     FHConfig.HopPattern);
+	      le32_to_cpu(pnetwork->network.Configuration.FHConfig.HopPattern);
 	pnetwork->network.Configuration.FHConfig.HopSet =
-		 le32_to_cpu(pnetwork->network.Configuration.FHConfig.HopSet);
+	      le32_to_cpu(pnetwork->network.Configuration.FHConfig.HopSet);
 	pnetwork->network.Configuration.FHConfig.Length =
-		 le32_to_cpu(pnetwork->network.Configuration.FHConfig.Length);
+	      le32_to_cpu(pnetwork->network.Configuration.FHConfig.Length);
 	pnetwork->network.Configuration.Length =
-		 le32_to_cpu(pnetwork->network.Configuration.Length);
+	      le32_to_cpu(pnetwork->network.Configuration.Length);
 	pnetwork->network.InfrastructureMode =
-		 le32_to_cpu(pnetwork->network.InfrastructureMode);
+	      le32_to_cpu(pnetwork->network.InfrastructureMode);
 	pnetwork->network.IELength = le32_to_cpu(pnetwork->network.IELength);
 #endif

-- 
2.7.4
