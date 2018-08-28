Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D01DC433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 20:29:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F09212084D
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 20:29:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="C92/YoZH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F09212084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727294AbeH2AWZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 20:22:25 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:37648 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726998AbeH2AWY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 20:22:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=NduzKOHGg1nzT6KgGKGVYMwK9osddAQ9m5TjK7Obv/Q=; b=C92/YoZHejck
        re/103uYLjqcGi4Kxn8s/+d14qjkgAiNkj2CRJfa9ihAvrCwvckywVcF69O5ApCSg0IL/dhly0nVg
        kD4xt+pnjfbaoFtPdMT2QbMwSLex7mHX71EBpOu+2y7m0K9EZ74Llg406yEhxIagPTRIioGnjAdPT
        tFp0c=;
Received: from 188.29.165.122.threembb.co.uk ([188.29.165.122] helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fukbi-0007ga-FR; Tue, 28 Aug 2018 20:28:58 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id DEDB2440078; Tue, 28 Aug 2018 21:28:56 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Cc:     Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Simon Horman <horms@verge.net.au>,
        linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>,
        Biju Das <biju.das@bp.renesas.com>,
        linux-renesas-soc@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        alsa-devel@alsa-project.org
Subject: Applied "ASoC: rsnd: Add r8a774a1 support" to the asoc tree
In-Reply-To:  <1534869748-26661-1-git-send-email-fabrizio.castro@bp.renesas.com>
Message-Id: <20180828202856.DEDB2440078@finisterre.ee.mobilebroadband>
Date:   Tue, 28 Aug 2018 21:28:56 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: rsnd: Add r8a774a1 support

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

From 6fbf9d8e2793b81dd5f8738999163582ce61dba7 Mon Sep 17 00:00:00 2001
From: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Date: Tue, 21 Aug 2018 17:42:28 +0100
Subject: [PATCH] ASoC: rsnd: Add r8a774a1 support

Document RZ/G2M (R8A774A1) SoC bindings.

Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Reviewed-by: Biju Das <biju.das@bp.renesas.com>
Acked-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 Documentation/devicetree/bindings/sound/renesas,rsnd.txt | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/sound/renesas,rsnd.txt b/Documentation/devicetree/bindings/sound/renesas,rsnd.txt
index 9e764270c36b..8083f0d8f263 100644
--- a/Documentation/devicetree/bindings/sound/renesas,rsnd.txt
+++ b/Documentation/devicetree/bindings/sound/renesas,rsnd.txt
@@ -340,10 +340,11 @@ Required properties:
 - compatible			: "renesas,rcar_sound-<soctype>", fallbacks
 				  "renesas,rcar_sound-gen1" if generation1, and
 				  "renesas,rcar_sound-gen2" if generation2 (or RZ/G1)
-				  "renesas,rcar_sound-gen3" if generation3
+				  "renesas,rcar_sound-gen3" if generation3 (or RZ/G2)
 				  Examples with soctypes are:
 				    - "renesas,rcar_sound-r8a7743" (RZ/G1M)
 				    - "renesas,rcar_sound-r8a7745" (RZ/G1E)
+				    - "renesas,rcar_sound-r8a774a1" (RZ/G2M)
 				    - "renesas,rcar_sound-r8a7778" (R-Car M1A)
 				    - "renesas,rcar_sound-r8a7779" (R-Car H1)
 				    - "renesas,rcar_sound-r8a7790" (R-Car H2)
-- 
2.18.0

