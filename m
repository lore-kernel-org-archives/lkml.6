Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BECBAC433F5
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 10:10:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84B2820841
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 10:10:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84B2820841
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziswiler.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727962AbeIBOZm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 10:25:42 -0400
Received: from mout.perfora.net ([74.208.4.196]:55305 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727727AbeIBOZl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 10:25:41 -0400
Received: from localhost.localdomain.ziswiler.net ([89.217.215.226]) by
 mrelay.perfora.net (mreueus001 [74.208.5.2]) with ESMTPA (Nemesis) id
 0Mfoag-1gJYOU0o2G-00NKCV; Sun, 02 Sep 2018 12:10:18 +0200
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH v2 33/37] ARM: tegra: colibri_t20: iris: drop unused i2c_ddc label
Date:   Sun,  2 Sep 2018 12:09:02 +0200
Message-Id: <20180902100906.25792-34-marcel@ziswiler.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180902100906.25792-1-marcel@ziswiler.com>
References: <20180902100906.25792-1-marcel@ziswiler.com>
X-Provags-ID: V03:K1:GtPZ/7zpAGZfm2p1x6xWxBKUY4102KxhTZf3P/WkWx1zUBVmSmU
 Bz7evaEgrV7AWSvMDbcjY4Fr/BUQPtgXy+DqUsGFFzENPIqwwJaCnf6C2JTQIVjUGIz+v9i
 KAYDWl0HpsAZKSFEpyrarTps5r39Kh0TJKfY4s/locknZHhWTgxcH7axoDfp0VVTuZTYerV
 xdOdCKLiCLavR7BsDAQ7w==
X-UI-Out-Filterresults: notjunk:1;V01:K0:t8AcNAmHe38=:RUmoV9ABD2baYs3qIvocQw
 ocCHuaaA6aB+jsmg7CFat0AOpjbS6Um+E/U6KHZLdsHwo4l7H9QityjYQy9yOsrscOwfvpHu5
 2jcx9ZXBCJFMQsb4wuq4QR0/os72j2x8xwdpDgs9lYdaNx6sfJag+WvQ/M8G6q1kaIWumCXZw
 4eZJRxOmB18l7LHBdX/c2QWcsoFq7yERJDEajeQZlqlBVHItY++diTUb8e8dF120mKzxP9qku
 WA8aoyebXJ2ESqaLhpFDXVnbiI4vOfey5NUUUqRmLWzmiPiHyudM7VyM7Eh2Pr33lyOg0rAKc
 mUgjcJIZCtRoGCvD20ZNFpd/lq/mDY3TnHdjs/vrYgtlQEWjDXhYOL0RvHMqH110/EILCZ7wD
 QtlNWSAXCqrTQvMOTRYZCne6LQfL3i/d6a6SAByg8T5/a54P/IVS1cFOECYPFo2G7KS4pLVOy
 OZ2UFpdffbHqVwDBscwdHzzWKf5JXRsL2jUqv4pD1VqONugauAtNtLH3MnIbstr42uX7Qv9St
 hRKxP3KM/vgR0+hs+klXdj4lUawEZedJOIQs7PM+VLmwiln0CKrEf6ySxFahQfiTv356Cktui
 yNaB68od0t6gzKAkr402ryksKLXr/s3lydobT/TTbcvhVEmX4pp6oNpccGpP+D7lfOsgypNL8
 dTIHOMSmQLU++/k6fmkMPWZXpjMZsYvNp3pqdExEqIlNdaYCW/9anBUsd+dX6h6mZFoM=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Drop unused i2c_ddc label.

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

---

Changes in v2: None

 arch/arm/boot/dts/tegra20-colibri-iris.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/tegra20-colibri-iris.dts b/arch/arm/boot/dts/tegra20-colibri-iris.dts
index b16e04dfa31f..00fd2603d780 100644
--- a/arch/arm/boot/dts/tegra20-colibri-iris.dts
+++ b/arch/arm/boot/dts/tegra20-colibri-iris.dts
@@ -139,7 +139,7 @@
 	/* CAM_I2C (I2C3): unused */
 
 	/* DDC_CLOCK/DATA on X3 pin 15/16 (e.g. display EDID) */
-	i2c_ddc: i2c@7000c400 {
+	i2c@7000c400 {
 		status = "okay";
 	};
 
-- 
2.14.4

