Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2D3BC43144
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 11:30:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69342262F6
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 11:30:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="s62zbAur"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69342262F6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934063AbeF0Lad (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 07:30:33 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:34952 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933869AbeF0Lab (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 07:30:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=UC9N4fTeXtg6k4YjY1U3ehlGzvOvTOY4pzTavbZwP9E=; b=s62zbAuriJ5o
        hS0bCjY7MU6dRw6Ka3y7KsO4bwpgfWtOdl6qhrbb5DhIyFEiHdWRhf4GpRr2h+Q+ruIZb9iWB+7rH
        x1LdDeQWScfLsG7G4oTINC6R+M0v+9NR1g2S5X7AIUfuTMxLi6TyJi6RfQlH6hYLuM8y7vpHItf/U
        MGblc=;
Received: from 188.29.164.103.threembb.co.uk ([188.29.164.103] helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fY8ea-0002vl-JU; Wed, 27 Jun 2018 11:30:28 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id 6DABD440070; Wed, 27 Jun 2018 12:30:27 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Jerome Brunet <jbrunet@baylibre.com>
Cc:     Mark Brown <broonie@kernel.org>, Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        =?UTF-8?q?Nicol=C3=B2=20Veronese?= <nicveronese@gmail.com>,
        devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
Subject: Applied "ASoC: simple-amplifier: remame dio2125 documentation" to the asoc tree
In-Reply-To:  <20180626121128.28564-2-jbrunet@baylibre.com>
Message-Id: <20180627113027.6DABD440070@finisterre.ee.mobilebroadband>
Date:   Wed, 27 Jun 2018 12:30:27 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: simple-amplifier: remame dio2125 documentation

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

From 0ed03e6dc288c50b2e7d71523b99df1afd81cea1 Mon Sep 17 00:00:00 2001
From: Jerome Brunet <jbrunet@baylibre.com>
Date: Tue, 26 Jun 2018 14:11:26 +0200
Subject: [PATCH] ASoC: simple-amplifier: remame dio2125 documentation
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The dio2125 is simple enough that we can make it a generic component.
Rename the the dio2125 documentation to simple-amplifier to
prepare this change.

Suggested-by: Nicolò Veronese <nicveronese@gmail.com>
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 .../devicetree/bindings/sound/dioo,dio2125.txt       | 12 ------------
 .../devicetree/bindings/sound/simple-amplifier.txt   | 12 ++++++++++++
 2 files changed, 12 insertions(+), 12 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/sound/dioo,dio2125.txt
 create mode 100644 Documentation/devicetree/bindings/sound/simple-amplifier.txt

diff --git a/Documentation/devicetree/bindings/sound/dioo,dio2125.txt b/Documentation/devicetree/bindings/sound/dioo,dio2125.txt
deleted file mode 100644
index 63dbfe0f11d0..000000000000
--- a/Documentation/devicetree/bindings/sound/dioo,dio2125.txt
+++ /dev/null
@@ -1,12 +0,0 @@
-DIO2125 Audio Driver
-
-Required properties:
-- compatible : "dioo,dio2125"
-- enable-gpios : the gpio connected to the enable pin of the dio2125
-
-Example:
-
-amp: analog-amplifier {
-	compatible = "dioo,dio2125";
-	enable-gpios = <&gpio GPIOH_3 0>;
-};
diff --git a/Documentation/devicetree/bindings/sound/simple-amplifier.txt b/Documentation/devicetree/bindings/sound/simple-amplifier.txt
new file mode 100644
index 000000000000..8647edae7af0
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/simple-amplifier.txt
@@ -0,0 +1,12 @@
+Simple Amplifier Audio Driver
+
+Required properties:
+- compatible : "dioo,dio2125" or "simple-audio-amplifier"
+- enable-gpios : the gpio connected to the enable pin of the simple amplifier
+
+Example:
+
+amp: analog-amplifier {
+	compatible = "simple-audio-amplifier";
+	enable-gpios = <&gpio GPIOH_3 0>;
+};
-- 
2.17.1

