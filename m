Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F04BDC6778A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 15:34:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6C3623EC8
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 15:34:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="gFQ8H4ka"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6C3623EC8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933718AbeGCPeN (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 11:34:13 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:37568 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933695AbeGCPeL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 11:34:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=cZGukGmxv5wYpnZiQfJsBdu9iTHWADCUUUZYyZF8iC0=; b=gFQ8H4kaUlz0
        5cP30u+IRP2fOImq1Lxwvz91Q1JmN6eIQM3vNkWGYn7FJUpTG8mc9psYO2+44jwR6WWY3PbRTt0cf
        NuodgB4eVugaMxMzlJT0fl5GCaPvJ/asTUeDXDProxG8vCw12jLc9/2UavKRVeO/+P/nk+BinZVdQ
        7tEPY=;
Received: from debutante.sirena.org.uk ([2001:470:1f1d:6b5::3] helo=debutante)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1faNJh-0006AM-F6; Tue, 03 Jul 2018 15:34:09 +0000
Received: from broonie by debutante with local (Exim 4.91)
        (envelope-from <broonie@sirena.org.uk>)
        id 1faNJh-0003hp-1Y; Tue, 03 Jul 2018 16:34:09 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Jerome Brunet <jbrunet@baylibre.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
Subject: Applied "ASoC: es7134: update DT binding with new compatible and supplies" to the asoc tree
In-Reply-To:  <20180703150600.17697-2-jbrunet@baylibre.com>
Message-Id: <E1faNJh-0003hp-1Y@debutante>
Date:   Tue, 03 Jul 2018 16:34:09 +0100
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: es7134: update DT binding with new compatible and supplies

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

From c9445d94d7fc60e7b0290df9e109daef85d26bd4 Mon Sep 17 00:00:00 2001
From: Jerome Brunet <jbrunet@baylibre.com>
Date: Tue, 3 Jul 2018 17:05:58 +0200
Subject: [PATCH] ASoC: es7134: update DT binding with new compatible and
 supplies

Update the documentation to add support for the es7154 and
optional power supplies phandles.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 Documentation/devicetree/bindings/sound/everest,es7134.txt | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/sound/everest,es7134.txt b/Documentation/devicetree/bindings/sound/everest,es7134.txt
index 5495a3cb8b7b..091666069bde 100644
--- a/Documentation/devicetree/bindings/sound/everest,es7134.txt
+++ b/Documentation/devicetree/bindings/sound/everest,es7134.txt
@@ -1,10 +1,15 @@
 ES7134 i2s DA converter
 
 Required properties:
-- compatible : "everest,es7134" or "everest,es7144"
+- compatible : "everest,es7134" or
+               "everest,es7144" or
+	       "everest,es7154"
+- VDD-supply : regulator phandle for the VDD supply
+- PVDD-supply: regulator phandle for the PVDD supply for the es7154
 
 Example:
 
 i2s_codec: external-codec {
 	compatible = "everest,es7134";
+	VDD-supply = <&vcc_5v>;
 };
-- 
2.18.0.rc2

