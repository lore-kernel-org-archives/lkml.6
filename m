Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DATE_IN_PAST_12_24,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73EEBC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 11:14:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 438B6205F4
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 11:14:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550661281;
	bh=kShe7pWfEu+OtvsaTgEHEeajt8Z4uD0Tv8Yuba0vaY8=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=vSnTLdk+ed02BX/qciA/7l0dq0c7E4NwT2FlT7kHMG068g55XMOBogtSklIcyGiOO
	 OuWO41aYCsiv5zD0Aoo4Q3i49YEDs3m6wUqO8Ly6KAiPlrZ08PDmFSaWPw3RnhPgji
	 qRbiAenx8I9ueZbumlE8/0oT1DNAcpzeoBKTBusg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728088AbfBTLOj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 06:14:39 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:45002 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727894AbfBTLNo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 06:13:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=VJ3XJyKV6pW+totso5EaK5ACZF2q/kNBQEXD36AHUPw=; b=wOuZz8JnZERP
        JHvLKeEpAu8EIzzlDuEQE6zV3NH8OP7cFhKenMz39tXmILayzdYR/o8jBk9lBFfSX6PbWqVwSuXSb
        dhK1knSjKI+ZQTw76L+5n4lxSJRoRxXiVH2EI041nAGLAuzyVdQ6aoNQHEik+ih3Eqq/e0fpLUZYS
        dMQHY=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gwPol-00011V-Qo; Wed, 20 Feb 2019 11:13:35 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 8FD3711284D7; Tue, 19 Feb 2019 15:50:48 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Yash Shah <yash.shah@sifive.com>
Cc:     Palmer Dabbelt <palmer@sifive.com>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Mark Brown <broonie@kernel.org>, palmer@sifive.com,
        linux-spi@vger.kernel.org, linux-riscv@lists.infradead.org,
        broonie@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        sachin.ghadi@sifive.com, paul.walmsley@sifive.com,
        linux-spi@vger.kernel.org
Subject: Applied "spi: sifive: Add DT documentation for SiFive SPI controller" to the spi tree
In-Reply-To:  <1550576407-17778-2-git-send-email-yash.shah@sifive.com>
X-Patchwork-Hint: ignore
Message-Id: <20190219155048.8FD3711284D7@debutante.sirena.org.uk>
Date:   Tue, 19 Feb 2019 15:50:48 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   spi: sifive: Add DT documentation for SiFive SPI controller

has been applied to the spi tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git 

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

From 3b155e873a38c3b28e419da759cfe86c74b1c870 Mon Sep 17 00:00:00 2001
From: Yash Shah <yash.shah@sifive.com>
Date: Tue, 19 Feb 2019 17:10:06 +0530
Subject: [PATCH] spi: sifive: Add DT documentation for SiFive SPI controller

DT documentation for SPI controller added.

Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
Signed-off-by: Emil Renner Berthing <kernel@esmil.dk>
Signed-off-by: Yash Shah <yash.shah@sifive.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 .../devicetree/bindings/spi/spi-sifive.txt    | 37 +++++++++++++++++++
 1 file changed, 37 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/spi/spi-sifive.txt

diff --git a/Documentation/devicetree/bindings/spi/spi-sifive.txt b/Documentation/devicetree/bindings/spi/spi-sifive.txt
new file mode 100644
index 000000000000..3f5c6e438972
--- /dev/null
+++ b/Documentation/devicetree/bindings/spi/spi-sifive.txt
@@ -0,0 +1,37 @@
+SiFive SPI controller Device Tree Bindings
+------------------------------------------
+
+Required properties:
+- compatible		: Should be "sifive,<chip>-spi" and "sifive,spi<version>".
+			  Supported compatible strings are:
+			  "sifive,fu540-c000-spi" for the SiFive SPI v0 as integrated
+			  onto the SiFive FU540 chip, and "sifive,spi0" for the SiFive
+			  SPI v0 IP block with no chip integration tweaks.
+			  Please refer to sifive-blocks-ip-versioning.txt for details
+- reg			: Physical base address and size of SPI registers map
+			  A second (optional) range can indicate memory mapped flash
+- interrupts		: Must contain one entry
+- interrupt-parent	: Must be core interrupt controller
+- clocks		: Must reference the frequency given to the controller
+- #address-cells	: Must be '1', indicating which CS to use
+- #size-cells		: Must be '0'
+
+Optional properties:
+- sifive,fifo-depth		: Depth of hardware queues; defaults to 8
+- sifive,max-bits-per-word	: Maximum bits per word; defaults to 8
+
+SPI RTL that corresponds to the IP block version numbers can be found here:
+https://github.com/sifive/sifive-blocks/tree/master/src/main/scala/devices/spi
+
+Example:
+	spi: spi@10040000 {
+		compatible = "sifive,fu540-c000-spi", "sifive,spi0";
+		reg = <0x0 0x10040000 0x0 0x1000 0x0 0x20000000 0x0 0x10000000>;
+		interrupt-parent = <&plic>;
+		interrupts = <51>;
+		clocks = <&tlclk>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		sifive,fifo-depth = <8>;
+		sifive,max-bits-per-word = <8>;
+	};
-- 
2.20.1

