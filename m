Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2765EC65BAE
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 12:09:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E030320851
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 12:09:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544702965;
	bh=ZPV99ruivtBpiiPby1x6oX54cQYe65dlXzKtjhQi5b0=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=vLrHHW83NbOsWTSqfBYxrAmiVlutc+Q38jneRrzvXKCL+gJXEV4j2KqalUvHQgnNg
	 s5ykBqTSaA8/zoCYtSsppc8dL3rncqUh09RsA5tLNfdJsezsyV3BMGL4uxb9OQP+lZ
	 K2Vza5I5XJyqyjeLowWLhkZMR8Qx/Y4e9PhKJfV4=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E030320851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729057AbeLMMJY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 07:09:24 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:50496 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729030AbeLMMJU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 07:09:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=47b6UFW9JssHYmyaxpcTmf1PEZG11RjDQTensH3WEt0=; b=CTKZVoui2LhN
        BaWBYQbeVuTJ49pouYxsk0LOoV2rxFFvAQwyF0PytXzJrMiKBYyg2cNoElbgNdqr9Nr2Pt3QbkaCJ
        tuid+jVEIieC834m2lRKEUldu9xSsIpJxPOo/TKn/NB5C2I9xNveJlb7ocdmLkFDBP7uPSpy/1deh
        D1xZU=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gXPno-0000ze-E0; Thu, 13 Dec 2018 12:09:16 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 1C82111254D1; Thu, 13 Dec 2018 12:09:16 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Clark Wang <xiaoning.wang@nxp.com>
Cc:     Mark Brown <broonie@kernel.org>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-spi@vger.kernel.org
Subject: Applied "doc: lpspi: Document DT bindings for LPSPI slave mode" to the spi tree
In-Reply-To:  <20181207024924.6315-5-xiaoning.wang@nxp.com>
X-Patchwork-Hint: ignore
Message-Id: <20181213120916.1C82111254D1@debutante.sirena.org.uk>
Date:   Thu, 13 Dec 2018 12:09:16 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   doc: lpspi: Document DT bindings for LPSPI slave mode

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

From 62f82df488ce16f7068c7285820b2b7f7dcd7597 Mon Sep 17 00:00:00 2001
From: Clark Wang <xiaoning.wang@nxp.com>
Date: Fri, 7 Dec 2018 02:50:41 +0000
Subject: [PATCH] doc: lpspi: Document DT bindings for LPSPI slave mode

Add introductions of interrupt-parent and spi-slave.

Signed-off-by: Clark Wang <xiaoning.wang@nxp.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 Documentation/devicetree/bindings/spi/spi-fsl-lpspi.txt | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/spi/spi-fsl-lpspi.txt b/Documentation/devicetree/bindings/spi/spi-fsl-lpspi.txt
index 8d178a4503cf..6cc3c6fe25a3 100644
--- a/Documentation/devicetree/bindings/spi/spi-fsl-lpspi.txt
+++ b/Documentation/devicetree/bindings/spi/spi-fsl-lpspi.txt
@@ -5,8 +5,11 @@ Required properties:
   - "fsl,imx7ulp-spi" for LPSPI compatible with the one integrated on i.MX7ULP soc
   - "fsl,imx8qxp-spi" for LPSPI compatible with the one integrated on i.MX8QXP soc
 - reg : address and length of the lpspi master registers
+- interrupt-parent : core interrupt controller
 - interrupts : lpspi interrupt
 - clocks : lpspi clock specifier
+- spi-slave : spi slave mode support. In slave mode, add this attribute without
+	      value. In master mode, remove it.
 
 Examples:
 
@@ -16,4 +19,5 @@ lpspi2: lpspi@40290000 {
 	interrupt-parent = <&intc>;
 	interrupts = <GIC_SPI 28 IRQ_TYPE_LEVEL_HIGH>;
 	clocks = <&clks IMX7ULP_CLK_LPSPI2>;
+	spi-slave;
 };
-- 
2.19.0.rc2

