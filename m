Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00165C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 15:11:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A25A526CDE
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 15:11:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="V1jSdBk/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A25A526CDE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751989AbeFZPLn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 11:11:43 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:50658 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751958AbeFZPLl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 11:11:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=94rBAfpFGTOHv3Wlc0ER+qUClTVICNEJUdXakHnMct4=; b=V1jSdBk/MADj
        fsWfeAxlBt9fvSuHodHLaL+S/nTCctZxewDuccV2lwi7gBm5qUGMxSCLPrB926NOdiyB6UM+APktH
        AiYHmkI60GsoCRMBIAwLvppB+rK+IC3MfVKvJa4Rlvz25vsuC0+BjFtFAqSy1me5xCCneQI44JubB
        H4Wqs=;
Received: from host109-146-194-33.range109-146.btcentralplus.com ([109.146.194.33] helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fXpcz-0001Kz-R1; Tue, 26 Jun 2018 15:11:33 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id 5E097440070; Tue, 26 Jun 2018 16:11:33 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     Niklas Cassel <niklas.cassel@linaro.org>,
        Mark Brown <broonie@kernel.org>, broonie@kernel.org,
        robh+dt@kernel.org, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, bgoswami@codeaurora.org,
        lgirdwood@gmail.com, linux-arm-msm@vger.kernel.org, tiwai@suse.com,
        linux-arm-kernel@lists.infradead.org, niklas.cassel@linaro.org,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
Subject: Applied "ASoC: q6afe: dt-bindings: add compatible string to dais" to the asoc tree
In-Reply-To:  <20180626092016.9296-4-srinivas.kandagatla@linaro.org>
Message-Id: <20180626151133.5E097440070@finisterre.ee.mobilebroadband>
Date:   Tue, 26 Jun 2018 16:11:33 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: q6afe: dt-bindings: add compatible string to dais

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

From e43792c6e5027ad3f0280f5a2e6952b0d436b19b Mon Sep 17 00:00:00 2001
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Date: Tue, 26 Jun 2018 10:20:07 +0100
Subject: [PATCH] ASoC: q6afe: dt-bindings: add compatible string to dais

Add compatible string to dais so that it can support DT based module
autoloading.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Acked-by: Niklas Cassel <niklas.cassel@linaro.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 Documentation/devicetree/bindings/sound/qcom,q6afe.txt | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/qcom,q6afe.txt b/Documentation/devicetree/bindings/sound/qcom,q6afe.txt
index bdbf87df8c0b..a8179409c194 100644
--- a/Documentation/devicetree/bindings/sound/qcom,q6afe.txt
+++ b/Documentation/devicetree/bindings/sound/qcom,q6afe.txt
@@ -17,6 +17,11 @@ used by all apr services. Must contain the following properties.
 subnode of "dais" representing board specific dai setup.
 "dais" node should have following properties followed by dai children.
 
+- compatible:
+	Usage: required
+	Value type: <stringlist>
+	Definition: must be "qcom,q6afe-dais"
+
 - #sound-dai-cells
 	Usage: required
 	Value type: <u32>
@@ -100,6 +105,7 @@ q6afe@4 {
 	reg = <APR_SVC_AFE>;
 
 	dais {
+		compatible = "qcom,q6afe-dais";
 		#sound-dai-cells = <1>;
 		#address-cells = <1>;
 		#size-cells = <0>;
-- 
2.17.1

