Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 167D9C282D0
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 12:14:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0C1F2177E
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 12:14:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548764056;
	bh=puyz1jsFt3vEDQXU+nHOGLoBQbj1WCTTbwg0zJtBNaU=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=dUCO+1h7ruQ1gw60n/GZKvSskIIys/6CBo79I8YjNFLw2uEFSGbjvmY3tGlS9aYwW
	 C3lwSkFa27ReSOSGbNAVAmEDKccTmQl1nPqBjEcIjtmitbtmkR+8OZAyWcReoaR/si
	 gh9pXCcfYwoJXslL47MwNm9vIy20uZ51aZaCurr8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728694AbfA2MOP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 07:14:15 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:51614 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727264AbfA2MOP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 07:14:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=L9NrviBzZNISiu7A7sd2MzTcXsXUFzlBzN9H06B6iOo=; b=sctkE6BTGZkK
        s+5RZG7jaLoFRKABj7F0eRYxBOcWENsBQwHnEFHMKZQL1j3yAOHtY4k03CAkijtAygrjBQMg0jxH6
        0LeJVaPehlmz7w/+fGuWbu063Akv8eZaK1PEaJUEzLto1JNoQwrLjELm4OVAzTbjWuT/kXXRwsTJz
        EKdZg=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1goSHK-0008AT-2H; Tue, 29 Jan 2019 12:14:10 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id B8B441127D50; Tue, 29 Jan 2019 12:14:09 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Cheng-Yi Chiang <cychiang@chromium.org>
Cc:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org, tzungbi@chromium.org,
        Mark Brown <broonie@kernel.org>,
        Rohit kumar <rohitkr@codeaurora.org>,
        Guenter Roeck <groeck@chromium.org>, dgreid@chromium.org,
        alsa-devel@alsa-project.org
Subject: Applied "ASoC: Documentation: Add google, cros-ec-codec" to the asoc tree
In-Reply-To:  <20190119113332.249720-1-cychiang@chromium.org>
X-Patchwork-Hint: ignore
Message-Id: <20190129121409.B8B441127D50@debutante.sirena.org.uk>
Date:   Tue, 29 Jan 2019 12:14:09 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: Documentation: Add google, cros-ec-codec

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

From 494a3503d684b6fc497623bc01e3e16f8def0499 Mon Sep 17 00:00:00 2001
From: Cheng-Yi Chiang <cychiang@chromium.org>
Date: Sat, 19 Jan 2019 19:33:31 +0800
Subject: [PATCH] ASoC: Documentation: Add google, cros-ec-codec

Add documentation for Chrome EC codec driver.

Signed-off-by: Cheng-Yi Chiang <cychiang@chromium.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 .../bindings/sound/google,cros-ec-codec.txt   | 26 +++++++++++++++++++
 MAINTAINERS                                   |  7 +++++
 2 files changed, 33 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/google,cros-ec-codec.txt

diff --git a/Documentation/devicetree/bindings/sound/google,cros-ec-codec.txt b/Documentation/devicetree/bindings/sound/google,cros-ec-codec.txt
new file mode 100644
index 000000000000..1084f7f22eea
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/google,cros-ec-codec.txt
@@ -0,0 +1,26 @@
+* Audio codec controlled by ChromeOS EC
+
+Google's ChromeOS EC codec is a digital mic codec provided by the
+Embedded Controller (EC) and is controlled via a host-command interface.
+
+An EC codec node should only be found as a sub-node of the EC node (see
+Documentation/devicetree/bindings/mfd/cros-ec.txt).
+
+Required properties:
+- compatible: Must contain "google,cros-ec-codec"
+- #sound-dai-cells: Should be 1. The cell specifies number of DAIs.
+- max-dmic-gain: A number for maximum gain in dB on digital microphone.
+
+Example:
+
+cros-ec@0 {
+	compatible = "google,cros-ec-spi";
+
+	...
+
+	cros_ec_codec: ec-codec {
+		compatible = "google,cros-ec-codec";
+		#sound-dai-cells = <1>;
+		max-dmic-gain = <43>;
+	};
+};
diff --git a/MAINTAINERS b/MAINTAINERS
index 9f64f8d3740e..3bcc5465e460 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3687,6 +3687,13 @@ N:	cros_ec
 N:	cros-ec
 F:	drivers/power/supply/cros_usbpd-charger.c
 
+CHROMEOS EC CODEC DRIVER
+M:	Cheng-Yi Chiang <cychiang@chromium.org>
+S:	Maintained
+R:	Enric Balletbo i Serra <enric.balletbo@collabora.com>
+R:	Guenter Roeck <groeck@chromium.org>
+F:	Documentation/devicetree/bindings/sound/google,cros-ec-codec.txt
+
 CIRRUS LOGIC AUDIO CODEC DRIVERS
 M:	Brian Austin <brian.austin@cirrus.com>
 M:	Paul Handrigan <Paul.Handrigan@cirrus.com>
-- 
2.20.1

