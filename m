Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6382BC43334
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 13:44:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F8EA20862
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 13:44:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="iGBoPUA1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F8EA20862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727351AbeICSE6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 14:04:58 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:53232 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725982AbeICSE6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 14:04:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=Ug+0wQ5vUEvJZzA9IGP9/9TX3eD0qLyhQgfz5y6fLzI=; b=iGBoPUA1GYnB
        eS1KZgxwHg5QxJTUk6jO/U01M2UMfRYse3BKOqGn+AAh3Ss67U3y37tMhSNvj7Le73qnrdcwK7Z0l
        6eN5pHQ35Ody6tuRckdXMFU2TUMqBEhtbjPdMVXxRIoM/wAT3Quzjm0/Jk6ZrowAvW7Wjf9YyYWJa
        MzzSg=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fwp9h-0000GJ-Ox; Mon, 03 Sep 2018 13:44:37 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 7057911227AE; Mon,  3 Sep 2018 14:44:37 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
Cc:     Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, broonie@kernel.org, robh+dt@kernel.org,
        alexandre.belloni@bootlin.com, nicolas.ferre@microchip.com,
        cristian.birsan@microchip.com, florian.meier@koalo.de,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        alsa-devel@alsa-project.org
Subject: Applied "ASoC: mikroe-proto: dt-bindings: add DT bindings for PROTO board" to the asoc tree
In-Reply-To:  <20180831171436.13360-3-codrin.ciubotariu@microchip.com>
Message-Id: <20180903134437.7057911227AE@debutante.sirena.org.uk>
Date:   Mon,  3 Sep 2018 14:44:37 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: mikroe-proto: dt-bindings: add DT bindings for PROTO board

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

From 85e16fdd2f25ef6b08b4275acd5f60fdccfe0973 Mon Sep 17 00:00:00 2001
From: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
Date: Fri, 31 Aug 2018 20:14:36 +0300
Subject: [PATCH] ASoC: mikroe-proto: dt-bindings: add DT bindings for PROTO
 board

DT binding documentation for this new ASoC driver.

Signed-off-by: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 .../bindings/sound/mikroe,mikroe-proto.txt    | 23 +++++++++++++++++++
 .../devicetree/bindings/vendor-prefixes.txt   |  1 +
 2 files changed, 24 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/mikroe,mikroe-proto.txt

diff --git a/Documentation/devicetree/bindings/sound/mikroe,mikroe-proto.txt b/Documentation/devicetree/bindings/sound/mikroe,mikroe-proto.txt
new file mode 100644
index 000000000000..912f8fae11c5
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/mikroe,mikroe-proto.txt
@@ -0,0 +1,23 @@
+Mikroe-PROTO audio board
+
+Required properties:
+  - compatible: "mikroe,mikroe-proto"
+  - dai-format: Must be "i2s".
+  - i2s-controller: The phandle of the I2S controller.
+  - audio-codec: The phandle of the WM8731 audio codec.
+Optional properties:
+  - model: The user-visible name of this sound complex.
+  - bitclock-master: Indicates dai-link bit clock master; for details see simple-card.txt (1).
+  - frame-master: Indicates dai-link frame master; for details see simple-card.txt (1).
+
+(1) : There must be the same master for both bit and frame clocks.
+
+Example:
+	sound {
+		compatible = "mikroe,mikroe-proto";
+		model = "wm8731 @ sama5d2_xplained";
+		i2s-controller = <&i2s0>;
+		audio-codec = <&wm8731>;
+		dai-format = "i2s";
+        };
+};
diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
index 2c3fc512e746..f26bf667e530 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.txt
+++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
@@ -235,6 +235,7 @@ micrel	Micrel Inc.
 microchip	Microchip Technology Inc.
 microcrystal	Micro Crystal AG
 micron	Micron Technology Inc.
+mikroe		MikroElektronika d.o.o.
 minix	MINIX Technology Ltd.
 miramems	MiraMEMS Sensing Technology Co., Ltd.
 mitsubishi	Mitsubishi Electric Corporation
-- 
2.19.0.rc1

