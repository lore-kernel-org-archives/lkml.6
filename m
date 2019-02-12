Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62B9DC282CA
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 14:22:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3330620838
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 14:22:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549981367;
	bh=pOd1jhl6FKS7kR2rXRroA4f/sDcqvPqerTZNszlsvrA=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=T1TAEonfcuB0noff5FfVZaeV6FpzdQYbGSKO0oQH7FVhOXx5ONMjI5U0XJzAN2S6n
	 npABZGpWaEAtWKw8GYBIgasCVk5XN3g5zlDXvTpp0cJVAQr0MYutX7sOugWnTxcbZ/
	 5wZ66EU88GPCOZHPWofIJsE63ct8G7suibumNKPU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730340AbfBLOWp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 09:22:45 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:56390 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728605AbfBLOWp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 09:22:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=0eWzs6LKUzOLRWcRobRhErpndwGhcBDNN6fh7YprlBU=; b=E+LnDAAxBGLk
        tRuqBp67OKRK5QruXRIlW21ni7dR7x2PncI2i6dtkrQVa4WQ9QTWU9oNcU6JrhVpJ9okTL88QxV6q
        XZy3rvEgyTtpLOVZBsEnn2fjOqxSP4tfQqH95SfolDiDtI3izuzd+sB7aMjM3UY0rst+ATnWxj6j9
        vt3VA=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gtYxG-0004cg-C5; Tue, 12 Feb 2019 14:22:34 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 0AAEB1128113; Tue, 12 Feb 2019 14:22:34 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Mason Yang <masonccyang@mxic.com.tw>
Cc:     Mark Brown <broonie@kernel.org>, broonie@kernel.org,
        marek.vasut@gmail.com, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, bbrezillon@kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        sergei.shtylyov@cogentembedded.com, juliensu@mxic.com.tw,
        Simon Horman <horms@verge.net.au>, zhengxunli@mxic.com.tw,
        linux-spi@vger.kernel.org
Subject: Applied "dt-bindings: spi: Document Renesas R-Car Gen3 RPC-IF controller bindings" to the spi tree
In-Reply-To:  <1548658158-5460-3-git-send-email-masonccyang@mxic.com.tw>
X-Patchwork-Hint: ignore
Message-Id: <20190212142234.0AAEB1128113@debutante.sirena.org.uk>
Date:   Tue, 12 Feb 2019 14:22:34 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   dt-bindings: spi: Document Renesas R-Car Gen3 RPC-IF controller bindings

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

From 06938aef3e9f33760ea384dc74c0f16d6b98b5a0 Mon Sep 17 00:00:00 2001
From: Mason Yang <masonccyang@mxic.com.tw>
Date: Mon, 28 Jan 2019 14:49:18 +0800
Subject: [PATCH] dt-bindings: spi: Document Renesas R-Car Gen3 RPC-IF
 controller bindings

Document the bindings used by the Renesas R-Car Gen3 RPC-IF controller.

Signed-off-by: Mason Yang <masonccyang@mxic.com.tw>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 .../bindings/spi/spi-renesas-rpc.txt          | 40 +++++++++++++++++++
 1 file changed, 40 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/spi/spi-renesas-rpc.txt

diff --git a/Documentation/devicetree/bindings/spi/spi-renesas-rpc.txt b/Documentation/devicetree/bindings/spi/spi-renesas-rpc.txt
new file mode 100644
index 000000000000..7dff7e7bea97
--- /dev/null
+++ b/Documentation/devicetree/bindings/spi/spi-renesas-rpc.txt
@@ -0,0 +1,40 @@
+Renesas R-Car Gen3 RPC-IF controller Device Tree Bindings
+--------------------------------------------------------------------
+
+Required properties:
+- compatible: should be an SoC-specific compatible value, followed by
+		"renesas,rcar-gen3-rpc" as a fallback.
+		supported SoC-specific values are:
+		"renesas,r8a77995-rpc"	(R-Car D3)
+- reg: should contain three register areas:
+	first for the base address of rpc-if registers,
+	second for the direct mapping read mode and
+	third for the write buffer area.
+- reg-names: should contain "regs", "dirmap" and "wbuf"
+- clocks: should contain 1 entries for the module's clock
+- clock-names: should contain "rpc"
+- #address-cells: should be 1
+- #size-cells: should be 0
+
+Example:
+
+	rpc: rpc@ee200000 {
+		compatible = "renesas,r8a77995-rpc", "renesas,rcar-gen3-rpc";
+		reg = <0 0xee200000 0 0x200>, <0 0x08000000 0 0x4000000>,
+		      <0 0xee208000 0 0x100>;
+		reg-names = "regs", "dirmap", "wbuf";
+		clocks = <&cpg CPG_MOD 917>;
+		clock-names = "rpc";
+		power-domains = <&sysc R8A77995_PD_ALWAYS_ON>;
+		resets = <&cpg 917>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		flash@0 {
+			compatible = "jedec,spi-nor";
+			reg = <0>;
+			spi-max-frequency = <40000000>;
+			spi-tx-bus-width = <1>;
+			spi-rx-bus-width = <1>;
+		};
+	};
-- 
2.20.1

