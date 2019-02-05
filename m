Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B606C282CC
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 15:42:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BF96217D6
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 15:42:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729983AbfBEPmb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 10:42:31 -0500
Received: from mirror2.csie.ntu.edu.tw ([140.112.30.76]:33662 "EHLO
        wens.csie.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729912AbfBEPm2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 10:42:28 -0500
Received: by wens.csie.org (Postfix, from userid 1000)
        id 76C635FD5E; Tue,  5 Feb 2019 23:42:26 +0800 (CST)
From:   Chen-Yu Tsai <wens@csie.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     Chen-Yu Tsai <wens@csie.org>, linux-mmc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com,
        Chris Blake <chrisrblake93@gmail.com>
Subject: [PATCH v2 3/3] arm64: dts: allwinner: h5: libretech-all-h3-cc: Mark eMMC HS-DDR 3.3V capable
Date:   Tue,  5 Feb 2019 23:42:25 +0800
Message-Id: <20190205154225.14264-4-wens@csie.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190205154225.14264-1-wens@csie.org>
References: <20190205154225.14264-1-wens@csie.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Libre Computer ALL-H3-CC H5 is one of the few boards that can have
its eMMC run at HS-DDR speed mode. Mark it as such.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 .../boot/dts/allwinner/sun50i-h5-libretech-all-h3-cc.dts      | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h5-libretech-all-h3-cc.dts b/arch/arm64/boot/dts/allwinner/sun50i-h5-libretech-all-h3-cc.dts
index 95e113ce8699..d68bdfea2271 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h5-libretech-all-h3-cc.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h5-libretech-all-h3-cc.dts
@@ -12,3 +12,7 @@
 	model = "Libre Computer Board ALL-H3-CC H5";
 	compatible = "libretech,all-h3-cc-h5", "allwinner,sun50i-h5";
 };
+
+&mmc2 {
+	mmc-ddr-3_3v;
+};
-- 
2.20.1

