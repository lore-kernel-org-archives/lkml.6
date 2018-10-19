Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DA85ECDE43
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 12:26:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8E542087A
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 12:26:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="w0khUXej"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8E542087A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727404AbeJSUcf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 16:32:35 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:38870 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726609AbeJSUce (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 16:32:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=iSVSD4UqzdaVJQYjif86HPRztS0sE98o03+gpKRbI7o=; b=w0khUXejzdVv
        aR0am+9kGVFZrjAZcQxpVIGG+o5eFXF0wiZyybKWwvIW7mjCVJhdBfa+29hjRDd1gLmsEIsXWqxUb
        //xw3x3/LesuY8MrkcFxU/f+DcOgb5QfUArSAc5LfoexRSQDMUDn7wSya9E+s4kNbUhhI/Y5UuDbJ
        e3tTQ=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gDTrG-0008Ub-5P; Fri, 19 Oct 2018 12:26:26 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id DD8F91122548; Fri, 19 Oct 2018 13:26:25 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Olivier Moysan <olivier.moysan@st.com>
Cc:     Mark Brown <broonie@kernel.org>, lgirdwood@gmail.com,
        broonie@kernel.org, perex@perex.cz, tiwai@suse.com,
        mcoquelin.stm32@gmail.com, alexandre.torgue@st.com,
        alsa-devel@alsa-project.org, robh@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-kernel@vger.kernel.org, olivier.moysan@st.com,
        arnaud.pouliquen@st.com, benjamin.gaignard@st.com,
        alsa-devel@alsa-project.org
Subject: Applied "ASoC: dt-bindings: add mclk provider support to stm32 sai" to the asoc tree
In-Reply-To:  <1539612216-12602-2-git-send-email-olivier.moysan@st.com>
Message-Id: <20181019122625.DD8F91122548@debutante.sirena.org.uk>
Date:   Fri, 19 Oct 2018 13:26:25 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: dt-bindings: add mclk provider support to stm32 sai

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

From af16112457d8175b444baa9aac02558a1e1154b5 Mon Sep 17 00:00:00 2001
From: Olivier Moysan <olivier.moysan@st.com>
Date: Mon, 15 Oct 2018 16:03:33 +0200
Subject: [PATCH] ASoC: dt-bindings: add mclk provider support to stm32 sai

add mclk provider support to stm32 sai

Signed-off-by: Olivier Moysan <olivier.moysan@st.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 Documentation/devicetree/bindings/sound/st,stm32-sai.txt | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/st,stm32-sai.txt b/Documentation/devicetree/bindings/sound/st,stm32-sai.txt
index 3a3fc506e43a..3f4467ff0aa2 100644
--- a/Documentation/devicetree/bindings/sound/st,stm32-sai.txt
+++ b/Documentation/devicetree/bindings/sound/st,stm32-sai.txt
@@ -31,7 +31,11 @@ SAI subnodes required properties:
   - reg: Base address and size of SAI sub-block register set.
   - clocks: Must contain one phandle and clock specifier pair
 	for sai_ck which feeds the internal clock generator.
+	If the SAI shares a master clock, with another SAI set as MCLK
+	clock provider, SAI provider phandle must be specified here.
   - clock-names: Must contain "sai_ck".
+	Must also contain "MCLK", if SAI shares a master clock,
+	with a SAI set as MCLK clock provider.
   - dmas: see Documentation/devicetree/bindings/dma/stm32-dma.txt
   - dma-names: identifier string for each DMA request line
 	"tx": if sai sub-block is configured as playback DAI
@@ -51,6 +55,9 @@ SAI subnodes Optional properties:
 	configured according to protocol defined in related DAI link node,
 	such as i2s, left justified, right justified, dsp and pdm protocols.
 	Note: ac97 protocol is not supported by SAI driver
+   - #clock-cells: should be 0. This property must be present if the SAI device
+	is a master clock provider, according to clocks bindings, described in
+	Documentation/devicetree/bindings/clock/clock-bindings.txt.
 
 The device node should contain one 'port' child node with one child 'endpoint'
 node, according to the bindings defined in Documentation/devicetree/bindings/
-- 
2.19.0.rc2

