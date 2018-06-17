Return-Path: <SRS0=XTOn=JD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B109C5CFC1
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Jun 2018 05:31:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0669D20896
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Jun 2018 05:31:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0669D20896
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tamalin.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754692AbeFQFbv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Jun 2018 01:31:51 -0400
Received: from mout.perfora.net ([74.208.4.197]:40701 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751711AbeFQFbO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jun 2018 01:31:14 -0400
Received: from kahja.local ([73.231.184.107]) by mrelay.perfora.net
 (mreueus002 [74.208.5.2]) with ESMTPSA (Nemesis) id 0LdWVQ-1fvCKB40aA-00iiMe;
 Sun, 17 Jun 2018 07:31:06 +0200
From:   Quytelda Kahja <quytelda@tamalin.org>
To:     gregkh@linuxfoundation.org, hadess@hadess.net, hdegoede@redhat.com,
        Larry.Finger@lwfinger.net
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Quytelda Kahja <quytelda@tamalin.org>
Subject: [PATCH 11/11] staging: rtl8723bs: Add missing curly braces on else statement.
Date:   Sat, 16 Jun 2018 22:30:40 -0700
Message-Id: <20180617053040.5903-11-quytelda@tamalin.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180617053040.5903-1-quytelda@tamalin.org>
References: <20180617053040.5903-1-quytelda@tamalin.org>
X-Provags-ID: V03:K1:ALY9z/GoIZwu2wIbJuUUBvnJvTb6v8SKxRafzAd1FZonVXtpihN
 MpBDA/nj+68EQ1l1zSFm8hH/jgTpynUS55DsKaE4MFl5pZCr/s2oXjJSk1cPlRvE/+2pc+K
 pccRkzKVP801n1XdC0vbl33v0gNSxEMg8rKsLovLG5bm1osE4HhlcZ6fGH+YjORCavlegUS
 A8PqAtP+XHHRmH7J1AK5g==
X-UI-Out-Filterresults: notjunk:1;V01:K0:giTRxIMeNks=:ykI44xOCO7PmwtH3JGcFpE
 t/04g6Gx/MV41p0mFvw1fz1aj9VKQtb2xzBR9/EfkBmDxSnFTrunaVs7yGQkR2ZuPp80ScVw3
 aQiIZXWUdL/dxk27tPf7NbMTsZ2jCvLV9cQ8g+8rJSdj58AO88ms+VTPT1gqk7Kmbwyz6jJX9
 53wVEpxVX/GbDFQjSSjpTbg6EEG6bnc1ubDWyaeIX+SZRfm+yquvMESXJUcpN8VXLTDwfj+rp
 UyejcoPDXN5aY/E3wqa/sIaSo/DS2QJCHzTeGZnezMONXVjSxfuo8KM9wUZi8uvsymKCwYOPj
 Ttus5czsZy5Bsc1UhLhb+bZX/w7EZ3LVPVAkBTaPsjR/POVhGztnptNCYOHD6OkH7dUlMQbU8
 ARR3kmmOFCPG6wFwSo8pzbbcKeEsm5fJJer2BxxdhFNijVpshA8N6wo/bi07w3/WloA4u6TDc
 sm1KfGauiUZpnK5EMIGccFLwhH1wt/c+PxK2bR6mky28O6CmANLIzojq3OwGheFx270iBme67
 HY2FRZKv2EF7grQWLelPS74cnRB2xysccwlsJDrxHm/8hdBCusGZA3jpzIJFNbsk6da+RSHqW
 CjxH6fFxOiV9t2FhkRk2yipFVuPi/TwsPj8f51SgQ2Va5jwxc2u9kxgtI7eZGhFo+AjYgIgIU
 N/TSKNs4hZbGUzYQMOaLNsBwS0EJcS3Di3vy1NK7swcXouUhzekKYbbFRYjGZJsmzro4=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix 'braces {} should be used on all arms of this statement' coding
style problem in 'phy_get_tx_pwr_lmt()'.

Signed-off-by: Quytelda Kahja <quytelda@tamalin.org>
---
 drivers/staging/rtl8723bs/hal/hal_com_phycfg.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8723bs/hal/hal_com_phycfg.c b/drivers/staging/rtl8723bs/hal/hal_com_phycfg.c
index 0e49f0973c12..0d2c61b67d0e 100644
--- a/drivers/staging/rtl8723bs/hal/hal_com_phycfg.c
+++ b/drivers/staging/rtl8723bs/hal/hal_com_phycfg.c
@@ -1780,8 +1780,9 @@ s8 phy_get_tx_pwr_lmt(struct adapter *adapter, u32 reg_pwr_tbl_sel,
 					       [idx_rate_sctn]
 					       [idx_channel]
 					       [rf_path];
-	} else
+	} else {
 		DBG_871X("No power limit table of the specified band\n");
+	}
 
 	/*  combine 5G VHT & HT rate */
 	/*  5G 20M and 40M HT and VHT can cross reference */
-- 
2.17.1

