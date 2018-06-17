Return-Path: <SRS0=XTOn=JD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7C89C5CFC1
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Jun 2018 05:33:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AAE57208A5
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Jun 2018 05:33:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AAE57208A5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tamalin.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755046AbeFQFcy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Jun 2018 01:32:54 -0400
Received: from mout.perfora.net ([74.208.4.194]:44589 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751763AbeFQFbJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jun 2018 01:31:09 -0400
Received: from kahja.local ([73.231.184.107]) by mrelay.perfora.net
 (mreueus002 [74.208.5.2]) with ESMTPSA (Nemesis) id 0LqSvP-1g7amD2nK5-00e3oN;
 Sun, 17 Jun 2018 07:31:00 +0200
From:   Quytelda Kahja <quytelda@tamalin.org>
To:     gregkh@linuxfoundation.org, hadess@hadess.net, hdegoede@redhat.com,
        Larry.Finger@lwfinger.net
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Quytelda Kahja <quytelda@tamalin.org>
Subject: [PATCH 05/11] staging: rtl8723bs: Remove empty else-if conditional.
Date:   Sat, 16 Jun 2018 22:30:34 -0700
Message-Id: <20180617053040.5903-5-quytelda@tamalin.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180617053040.5903-1-quytelda@tamalin.org>
References: <20180617053040.5903-1-quytelda@tamalin.org>
X-Provags-ID: V03:K1:0q6OGiwRfRf/j7ClfgrAvzWtpw1ocTaMj2OwLPR8/Tsgm/jx+aw
 U9JKXV9qBW2dPEPUT/LE1NXBw8yaDgY/pXsTlFTGm4DicvCYceNYa3DuG5KAAlTRixm0ZMl
 ZTuJdQ6ENk+bvtP3eKmX9VDFH4yCrTU+/y5Zk82xggELoVmtGeXzS/0brxBAnMBN8jeR5Rc
 BlqzxhG08Cgkqs9vmIWaQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Ubm8c/3qCPQ=:fkeXgVMiPU8QIFF3Np20Oh
 Lla/5ftzTsUBYa9XbTb5ZiNPo9IPRTb41PRjAk4dfvsoQUK+pdPvi60RQxGrF5ZoOqSEV8rlF
 +68TvrBBx4a5aIgz7E1V3q1DSw2qPOoi7ZuEBBLgiqskVOlzyHIsOROfYGalaFdZ4TnYPkpS2
 kufZk5Azv9c9FCQeurCYFJXUUBS1nhvxmj82+vgFTDVUs1kSBrLxOraxfAWg3M0QjZrUOtJc0
 /RYk16X1ohPs06z3uDnswTXAsr4WbNPjk+XnwBcQHTcMrukcHiE7soyeok5EAZn6si73Z/+Mt
 ax2Meo8iYtIw2V2YwlcRQHtTsAj+CPOCBR/x4TrwQlVoaX3JyTjdh3TtClkdSqy1AqDUYcnxt
 KtDxmzXiNE1JgZbNXZwXEgGi5rizxuj7m+AtDL8CqyIW/d6ca+Vffe+SHY0Wu1HxLTCxFc2EH
 d16UCc2SNDW3DbO7hwMJDlhBXxEfmSWTk2cZZ1hYxg5docmIemLGrnEUhaLjLJZLuBbygk30P
 HC8LlzmK2kb4ffuEh6uzxtWo4H1Ak5khZk3EmsKupIc+KF1ADM5kbX3GZjqsmeAe79lVkhgHh
 f5eTe25EQkLJUn6Awnc4t4Hb+p62VhTx7ZUkuLggFNuq4+xisZXr3SJj+EDJtz5HNcwRsslhz
 0+IMR0xPQvm7+vCoh9qDcnfa7Tv6cy7jiUfdGsDQdgMl5PUrfyPec4g+hKwmu7SHpIO0=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This else-if conditional block does nothing; remove it.

Signed-off-by: Quytelda Kahja <quytelda@tamalin.org>
---
 drivers/staging/rtl8723bs/hal/hal_com_phycfg.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/staging/rtl8723bs/hal/hal_com_phycfg.c b/drivers/staging/rtl8723bs/hal/hal_com_phycfg.c
index 5d44aee44eb1..6ae646ec3d06 100644
--- a/drivers/staging/rtl8723bs/hal/hal_com_phycfg.c
+++ b/drivers/staging/rtl8723bs/hal/hal_com_phycfg.c
@@ -1751,9 +1751,6 @@ s8 phy_get_tx_pwr_lmt(struct adapter *adapter, u32 reg_pwr_tbl_sel,
 	else if (band_type == BAND_ON_5G)
 		channel = phy_GetChannelIndexOfTxPowerLimit(BAND_ON_5G,
 							    channel);
-	else if (band_type == BAND_ON_BOTH) {
-		/*  BAND_ON_BOTH don't care temporarily */
-	}
 
 	if (idx_band == -1 || idx_regulation == -1 || idx_bandwidth == -1 ||
 	    idx_rate_sctn == -1 || idx_channel == -1) {
-- 
2.17.1

