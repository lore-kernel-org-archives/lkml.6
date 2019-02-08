Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74BA4C169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 13:11:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4131B218AC
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 13:11:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549631473;
	bh=Mo5RwKPeFQupXDKrXFc1Ahkfm5TKQT8gxyRHapjGh+8=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=l1vmG06aDUnUwN7Al0XpP01a/yvqc398oKQ8LhuDCmDoXU6OdYxPwsQMdjo13mU3o
	 6Sj6Xu8q6PxFhXgndiIDxH2dBGnAqnCJJvGaCYLnWiZ6bYEW5oUKJdlcgoidEXp7/q
	 3a56vvqN80SAipLgsc0py5luzz5XSBnFXdxfPsTo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727567AbfBHNLL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 08:11:11 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:37814 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726600AbfBHNLL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 08:11:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=7hfsyRifw4S3C/OKvZF9n7+rcSsdtnAF6uLl31JeAeA=; b=gJs8yKVfXLVa
        6y800mcT7yId5UkCyqMFht1zymZeRYQm8LYwtFP/8FvpfPU5ioNZsqGiKiFfvvCUIUXrUaGq1J+fi
        gTcvwY+HOzHoXFLy7IwC+msmlvxF7ZqbMbcDc7L2FImpNBfK9gxRlqzwZzzy5FKc1qtk4n6xAnDOH
        XC+KQ=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gs5vt-0001JL-PE; Fri, 08 Feb 2019 13:11:05 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 5FAE01127F30; Fri,  8 Feb 2019 13:11:05 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Johan Hovold <johan@kernel.org>
Cc:     Mark Brown <broonie@kernel.org>, Mark Brown <broonie@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        alsa-devel@alsa-project.org
Subject: Applied "dt-bindings: sound: msm8916-wcd-analog: fix example regulator names" to the asoc tree
In-Reply-To:  <20190207165755.1548-4-johan@kernel.org>
X-Patchwork-Hint: ignore
Message-Id: <20190208131105.5FAE01127F30@debutante.sirena.org.uk>
Date:   Fri,  8 Feb 2019 13:11:05 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   dt-bindings: sound: msm8916-wcd-analog: fix example regulator names

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

From 510135535382db7f5ee8727818172e42c9c9cbd5 Mon Sep 17 00:00:00 2001
From: Johan Hovold <johan@kernel.org>
Date: Thu, 7 Feb 2019 17:57:55 +0100
Subject: [PATCH] dt-bindings: sound: msm8916-wcd-analog: fix example regulator
 names

Fix upper-case regulator names in the binding example which do not match
the corresponding required properties.

While at it, add a blank line after the required-properties section to
improve readability.

Signed-off-by: Johan Hovold <johan@kernel.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 .../devicetree/bindings/sound/qcom,msm8916-wcd-analog.txt  | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/qcom,msm8916-wcd-analog.txt b/Documentation/devicetree/bindings/sound/qcom,msm8916-wcd-analog.txt
index fdcea3d12ee5..e7d17dda55db 100644
--- a/Documentation/devicetree/bindings/sound/qcom,msm8916-wcd-analog.txt
+++ b/Documentation/devicetree/bindings/sound/qcom,msm8916-wcd-analog.txt
@@ -30,6 +30,7 @@ Required properties
  - vdd-cdc-io-supply: phandle to VDD_CDC_IO regulator DT node.
  - vdd-cdc-tx-rx-cx-supply: phandle to VDD_CDC_TX/RX/CX regulator DT node.
  - vdd-micbias-supply: phandle of VDD_MICBIAS supply's regulator DT node.
+
 Optional Properties:
  - qcom,mbhc-vthreshold-low: Array of 5 threshold voltages in mV for 5 buttons
 			     detection on headset when the mbhc is powered up
@@ -92,9 +93,9 @@ spmi_bus {
 				  "cdc_ear_cnp_int",
 				  "cdc_hphr_cnp_int",
 				  "cdc_hphl_cnp_int";
-	               VDD-CDC-IO-supply = <&pm8916_l5>;
-	               VDD-CDC-TX-RX-CX-supply = <&pm8916_l5>;
-	               VDD-MICBIAS-supply = <&pm8916_l13>;
+	               vdd-cdc-io-supply = <&pm8916_l5>;
+	               vdd-cdc-tx-rx-cx-supply = <&pm8916_l5>;
+	               vdd-micbias-supply = <&pm8916_l13>;
 	               #sound-dai-cells = <1>;
 	};
 };
-- 
2.20.1

