Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DATE_IN_PAST_12_24,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C61C0C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 11:13:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 950072146E
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 11:13:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550661229;
	bh=96LMg4TzWLSZVdHTvW4WrLJJp5uxPRw6D5MCVxyfumY=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=KUGaih2s775yVHGf989Z2CpaoC27cngd06bJrYtmmszrULYBWLd0ZuwsYRbbqths5
	 N7UV/OVPgmlAWbv888uvACwjdFcjdydH+b8cilIYry8cAhh68thjshOAFa8fOM2S8m
	 zYhVNG4Z7M4NR4I8emlEOvw5ecgv0imL0wj4ljv8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727979AbfBTLNs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 06:13:48 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:45094 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727924AbfBTLNp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 06:13:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=6BZ7sydURhTQtY3rpfXg+bUYm3hrRA4zd7SOKO4qu6o=; b=L6fElBGaVn/J
        6wi74Me+VbEdvaqiTriff0szjTKpdZPqo0cjvSNJg5s6AWEE4jsjRVwfGcFjEHrJpOWyoVqcSxwuK
        l6zzM6vb4INCfxk5vH4thkSljE1JxFZGjMHpAUaRXIgYC7JALoN3GDYriQzEDrHw8SukWnFrVrL8u
        ifjVY=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gwPom-00011l-D9; Wed, 20 Feb 2019 11:13:36 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 7E59C11284C0; Tue, 19 Feb 2019 15:50:20 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Bogdan Togorean <bogdan.togorean@gmail.com>
Cc:     Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, lars@metafoo.de,
        linux-kernel@vger.kernel.org, lgirdwood@gmail.com,
        robh+dt@kernel.org, tiwai@suse.com, broonie@kernel.org,
        alsa-devel@alsa-project.org
Subject: Applied "ASoC: adau1977: Add MICBIAS example in DT bindings" to the asoc tree
In-Reply-To:  <20190219141139.24216-2-bogdan.togorean@gmail.com>
X-Patchwork-Hint: ignore
Message-Id: <20190219155020.7E59C11284C0@debutante.sirena.org.uk>
Date:   Tue, 19 Feb 2019 15:50:20 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: adau1977: Add MICBIAS example in DT bindings

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

From fb7a97456e324b4ac13044db17a4f5b974e49e33 Mon Sep 17 00:00:00 2001
From: Bogdan Togorean <bogdan.togorean@gmail.com>
Date: Tue, 19 Feb 2019 16:11:38 +0200
Subject: [PATCH] ASoC: adau1977: Add MICBIAS example in DT bindings

Add MICBIAS property to the optional devicetree bindings.

Signed-off-by: Bogdan Togorean <bogdan.togorean@gmail.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 Documentation/devicetree/bindings/sound/adi,adau1977.txt | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/adi,adau1977.txt b/Documentation/devicetree/bindings/sound/adi,adau1977.txt
index e79aeef73f28..87c16e6f2e7c 100644
--- a/Documentation/devicetree/bindings/sound/adi,adau1977.txt
+++ b/Documentation/devicetree/bindings/sound/adi,adau1977.txt
@@ -23,6 +23,12 @@ Optional properties:
  - DVDD-supply: supply voltage for the digital core, please consult
                 Documentation/devicetree/bindings/regulator/regulator.txt
 
+- adi,micbias: configures the voltage setting for the MICBIAS pin.
+		Select 0/1/2/3/4/5/6/7/8 to specify MICBIAS voltage
+		5V/5.5V/6V/6.5V/7V/7.5V/8V/8.5V/9V
+		If not specified the default value will be "7" meaning 8.5 Volts.
+		This property is only valid for the ADAU1977
+
 For required properties on SPI, please consult
 Documentation/devicetree/bindings/spi/spi-bus.txt
 
@@ -40,6 +46,7 @@ Examples:
 		AVDD-supply = <&regulator>;
 		DVDD-supply = <&regulator_digital>;
 
+		adi,micbias = <3>;
 		reset_gpio = <&gpio 10 GPIO_ACTIVE_LOW>;
 	};
 
-- 
2.20.1

