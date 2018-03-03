Return-Path: <arushisinghal19971997@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1520104671; cv=none;
        d=google.com; s=arc-20160816;
        b=I9mjbDFph/3nxm8op5e3fI324nWTP+CYXPQrjcfM01cVMLNWOAivzWW4qUl4g5QZh8
         0QzhjsmX9vE+JdjBMK23cSsWzjxmn3RDUGyGu4GojtcMowQD9T23cZuaycwPwP2rbF26
         40LbK/ZOK349qzJVATcf0/v7larSCfDjcjb17lPjfA9X6hXE2cr2XGTpg7RTkMylhpsc
         P3e9Qfo9tA7gq1LTrNIWxLe+JbTkySQybfQhUQ0EBq65tuO0lsFq06TgwfqRpUlMpYwS
         TR4LCRWHyYPmJmj8VPGeyhZtf8bMkTSloH5MKKvBQrTKl2Im6GRwbWztPTmJJfYD30Hx
         x6pQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:dkim-signature:arc-authentication-results;
        bh=whG8qONH6PPwVNCMWEJmpD3+AAaKh04oB5MWz/Dov3o=;
        b=cURR8T1ZwbMwnToTX9lh1gt9rPKN7iA+C/CTVWZs0mI1/JQSNFewB0nWwCv9S2iuLJ
         gyib+2y271ChSd+OrfZhqeaUhA5U1LKN1CrfAhdublhM0CdcHEzwGduflQ5KTCs0hcq8
         uYdoCLie+jabeI1d0KAFBbhHPWD3P04bPsCa018EWnsAc9Xz02mfPOkfVbiB8TkNuJct
         jkiFqqSxHJYeYatnPe15l6xXqNLnOZY3a1Xi4QRezMCA+WrAurI8PYBVNNZ2Z9AZJbWA
         Y3wtspaQ6T6bxvgpYeLWid8AFHsPaOHM2ShAe45gPjte1vBa6mk7MquSoeY+bPYmnkSt
         zBRw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=AQDxdXC5;
       spf=pass (google.com: domain of arushisinghal19971997@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=arushisinghal19971997@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=AQDxdXC5;
       spf=pass (google.com: domain of arushisinghal19971997@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=arushisinghal19971997@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AG47ELtkZGakFerMFsqR717N0FMrnu+J851ROwKwhNs3lqFxZ8mtP1w3fFKiMKQkNRgM2MCqdkLr8g==
Date: Sun, 4 Mar 2018 00:47:26 +0530
From: Arushi Singhal <arushisinghal19971997@gmail.com>
To: gregkh@linuxfoundation.org
Cc: devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
	outreachy-kernel@googlegroups.com
Subject: [PATCH] staging: rtl8723bs: Remove unnecessary semicolon.
Message-ID: <20180303191726.GA4986@seema-Inspiron-15-3567>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593945276088463100?=
X-GMAIL-MSGID: =?utf-8?q?1593945276088463100?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Remove unnecessary semicolon using semicolon.cocci Coccinelle script.

Signed-off-by: Arushi Singhal <arushisinghal19971997@gmail.com>
Acked-by: Julia Lawall <julia.lawall@lip6.fr>
---
 drivers/staging/rtl8723bs/core/rtw_recv.c       | 2 +-
 drivers/staging/rtl8723bs/hal/rtl8723b_rf6052.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_recv.c b/drivers/staging/rtl8723bs/core/rtw_recv.c
index 9c7c3be..86f995b 100644
--- a/drivers/staging/rtl8723bs/core/rtw_recv.c
+++ b/drivers/staging/rtl8723bs/core/rtw_recv.c
@@ -1785,7 +1785,7 @@ static union recv_frame *recvframe_defrag(struct adapter *adapter,
 		pfhdr->attrib.icv_len = pnfhdr->attrib.icv_len;
 		plist = get_next(plist);
 
-	};
+	}
 
 	/* free the defrag_q queue and return the prframe */
 	rtw_free_recvframe_queue(defrag_q, pfree_recv_queue);
diff --git a/drivers/staging/rtl8723bs/hal/rtl8723b_rf6052.c b/drivers/staging/rtl8723bs/hal/rtl8723b_rf6052.c
index a71b552..f6aeb26 100644
--- a/drivers/staging/rtl8723bs/hal/rtl8723b_rf6052.c
+++ b/drivers/staging/rtl8723bs/hal/rtl8723b_rf6052.c
@@ -163,7 +163,7 @@ static int phy_RF6052_Config_ParaFile(struct adapter *Adapter)
 			break;
 		}
 
-		/*----Restore RFENV control type----*/;
+		/*----Restore RFENV control type----*/
 		switch (eRFPath) {
 		case RF_PATH_A:
 		case RF_PATH_C:
-- 
2.7.4
