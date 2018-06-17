Return-Path: <SRS0=XTOn=JD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BDBCC5CFC1
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Jun 2018 05:32:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB90620896
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Jun 2018 05:32:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB90620896
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tamalin.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755099AbeFQFcz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Jun 2018 01:32:55 -0400
Received: from mout.perfora.net ([74.208.4.194]:60097 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751736AbeFQFbJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jun 2018 01:31:09 -0400
Received: from kahja.local ([73.231.184.107]) by mrelay.perfora.net
 (mreueus002 [74.208.5.2]) with ESMTPSA (Nemesis) id 0Lb3fT-1fwaIl08pl-00kdN9;
 Sun, 17 Jun 2018 07:30:58 +0200
From:   Quytelda Kahja <quytelda@tamalin.org>
To:     gregkh@linuxfoundation.org, hadess@hadess.net, hdegoede@redhat.com,
        Larry.Finger@lwfinger.net
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Quytelda Kahja <quytelda@tamalin.org>
Subject: [PATCH 02/11] staging: rtl8723bs: Rename PHY_GetTxPowerLimit().
Date:   Sat, 16 Jun 2018 22:30:31 -0700
Message-Id: <20180617053040.5903-2-quytelda@tamalin.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180617053040.5903-1-quytelda@tamalin.org>
References: <20180617053040.5903-1-quytelda@tamalin.org>
X-Provags-ID: V03:K1:eUDNOcpEDNcWSOKsonhZR01Yl4OJHdIrODlgUQ0qAdAdtLLQReS
 tSg1Ixi5FKBbTwKtYBZWnv0Wuq8SY5MAyC5APAyrR+/9qzYRI9X9o0wpFhVkMuwFLRvtZfE
 IdaJ7SC0VIjwqz9sYxf9+P4hDuN/5D7eJn3o6V/1vQv6Q5ayEoLFHpdYZSYHqSK6jhJJNxx
 OJ5A6C+BaDADK7Iz86iGw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Gdp/Y8r4Z8E=:+BAifADXLbcHY/92/wO/Aa
 Xwz5TwY9E3hUlAg+YYjBJWWl5vtff6hcE9qDwcQuKgFoMQ9g6NHIU8W1LvEFdN8ucGcTgQy6a
 QStqDhe3j6df8EJVpFfdLNB6y/GVI4C6mRPB5giF3moEst8NZReY7nIMLiqjpjoaCibH87IT/
 A23D7iZFzfcl0D7jwIDkxCbp7xrvN77WbReV7NNxSdOEosAEtnyyf9PdRrzXMjbiRItUXK62j
 JQlkuzjUti6VGpi4ZxriwYnURxk/yKKKQ0nXJVSoSN+1Wx1vByjTzIyCRlU7AvBpRqTphWuaq
 yJt3LJZ4wxTyuPwVj+Qjq5V3FZ8KLJO+gVNoPKhsPEby4jbp5eWy/JTe1nU/wGUWJZRWG3ITg
 4oNOpVHlqypduoqqYkjxPX4mgq+LyO7Fblmds7SP3I9I32OYy/gM2n/NUlcK4BOQKlT2m0+M1
 WXqsUvF6V3nYwJr+03ZF2pooAd8loz/uR9e08Creq7ODQXcyvdYZt6aP16beZ8bQqZgVLEWFc
 nhQYF783HiKG6PnZm8zP3kg5zGXtIk/xUZAfBxD9Adzoevm5tJVY0T8B8iHO7WE8pK27M7c0k
 8PfInFlYAhOhrozIw5ykSq0tizBb/L6q5CP3DmYtiEwa1GKqjjZ4UGMVzE2jYO0VaviwQv4Dc
 1V/MBH0G2z+VbF6Sixmgcl8m20bww9cuBNviffMWGLkrorVAMJ23OgRv1a3ggWITRvBs=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename camel-case 'PHY_GetTxPowerLimit()' to 'phy_get_tx_pwr_lmt()'.

Signed-off-by: Quytelda Kahja <quytelda@tamalin.org>
---
 drivers/staging/rtl8723bs/hal/hal_com_phycfg.c     | 6 +++---
 drivers/staging/rtl8723bs/hal/rtl8723b_phycfg.c    | 2 +-
 drivers/staging/rtl8723bs/include/hal_com_phycfg.h | 2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/rtl8723bs/hal/hal_com_phycfg.c b/drivers/staging/rtl8723bs/hal/hal_com_phycfg.c
index 5f727a7c16fd..4ab624f5ece0 100644
--- a/drivers/staging/rtl8723bs/hal/hal_com_phycfg.c
+++ b/drivers/staging/rtl8723bs/hal/hal_com_phycfg.c
@@ -1612,9 +1612,9 @@ static s8 phy_GetChannelIndexOfTxPowerLimit(u8 Band, u8 Channel)
 	return channelIndex;
 }
 
-s8 PHY_GetTxPowerLimit(struct adapter *Adapter, u32 RegPwrTblSel,
-		       enum BAND_TYPE Band, enum CHANNEL_WIDTH Bandwidth,
-		       u8 RfPath, u8 DataRate, u8 Channel)
+s8 phy_get_tx_pwr_lmt(struct adapter *Adapter, u32 RegPwrTblSel,
+		      enum BAND_TYPE Band, enum CHANNEL_WIDTH Bandwidth,
+		      u8 RfPath, u8 DataRate, u8 Channel)
 {
 	s16 band        = -1;
 	s16 regulation  = -1;
diff --git a/drivers/staging/rtl8723bs/hal/rtl8723b_phycfg.c b/drivers/staging/rtl8723bs/hal/rtl8723b_phycfg.c
index 50428f688859..78a4828ecb65 100644
--- a/drivers/staging/rtl8723bs/hal/rtl8723b_phycfg.c
+++ b/drivers/staging/rtl8723bs/hal/rtl8723b_phycfg.c
@@ -688,7 +688,7 @@ u8 PHY_GetTxPowerIndex_8723B(
 	txPower = (s8) PHY_GetTxPowerIndexBase(padapter, RFPath, Rate, BandWidth, Channel, &bIn24G);
 	powerDiffByRate = PHY_GetTxPowerByRate(padapter, BAND_ON_2_4G, ODM_RF_PATH_A, RF_1TX, Rate);
 
-	limit = PHY_GetTxPowerLimit(
+	limit = phy_get_tx_pwr_lmt(
 		padapter,
 		padapter->registrypriv.RegPwrTblSel,
 		(u8)(!bIn24G),
diff --git a/drivers/staging/rtl8723bs/include/hal_com_phycfg.h b/drivers/staging/rtl8723bs/include/hal_com_phycfg.h
index c5184315f82f..f841546584a7 100644
--- a/drivers/staging/rtl8723bs/include/hal_com_phycfg.h
+++ b/drivers/staging/rtl8723bs/include/hal_com_phycfg.h
@@ -177,7 +177,7 @@ u8 		Channel,
 	bool		*bIn24G
 	);
 
-s8 PHY_GetTxPowerLimit (struct adapter *adapter, u32 RegPwrTblSel,
+s8 phy_get_tx_pwr_lmt (struct adapter *adapter, u32 RegPwrTblSel,
 			enum BAND_TYPE Band, enum CHANNEL_WIDTH Bandwidth,
 u8 		RfPath,
 u8 		DataRate,
-- 
2.17.1

