Return-Path: <SRS0=T5ek=J6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=DATE_IN_PAST_24_48,
	DKIM_SIGNED,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1DF6ECDFB0
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Jul 2018 22:44:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E0832089F
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Jul 2018 22:44:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="bPH6dfyi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E0832089F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731898AbeGNXFC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 14 Jul 2018 19:05:02 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:58060 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731583AbeGNXFB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Jul 2018 19:05:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=9x1M5WQv3SyAHzK7h2NknWEhK5RucskrhUB6iXnsxeA=; b=bPH6dfyixRnX
        /ckUGL54znTtlG/YBQOz7uDx5Vpuu44PY70SD1wFgp1U4UEV3hX0/5Pzgu3VlOHI9PgEe6as3yclG
        va0YWknRDFLSiU/l1UiccD14qwmQgRudp8U4/7XlRvsqecMCvlFSdQYaEYBBM8THDtiba3WT/N7rS
        SM6mQ=;
Received: from host86-174-189-173.range86-174.btcentralplus.com ([86.174.189.173] helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1feTH5-0006hq-7Y; Sat, 14 Jul 2018 22:44:23 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id D9E5444007E; Fri, 13 Jul 2018 16:10:14 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Jerome Brunet <jbrunet@baylibre.com>
Cc:     Mark Brown <broonie@kernel.org>, Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
Subject: Applied "ASoC: add DT documentation for the sound-name-prefix property" to the asoc tree
In-Reply-To:  <20180713125043.13242-2-jbrunet@baylibre.com>
Message-Id: <20180713151014.D9E5444007E@finisterre.ee.mobilebroadband>
Date:   Fri, 13 Jul 2018 16:10:14 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: add DT documentation for the sound-name-prefix property

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

From d5418ae3f9443f911d4324c0cade988ced39cfbe Mon Sep 17 00:00:00 2001
From: Jerome Brunet <jbrunet@baylibre.com>
Date: Fri, 13 Jul 2018 14:50:42 +0200
Subject: [PATCH] ASoC: add DT documentation for the sound-name-prefix property

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 .../devicetree/bindings/sound/name-prefix.txt | 24 +++++++++++++++++++
 1 file changed, 24 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/name-prefix.txt

diff --git a/Documentation/devicetree/bindings/sound/name-prefix.txt b/Documentation/devicetree/bindings/sound/name-prefix.txt
new file mode 100644
index 000000000000..645775908657
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/name-prefix.txt
@@ -0,0 +1,24 @@
+Name prefix:
+
+Card implementing the routing property define the connection between
+audio components as list of string pair. Component using the same
+sink/source names may use the name prefix property to prepend the
+name of their sinks/sources with the provided string.
+
+Optional name prefix property:
+- sound-name-prefix : string using as prefix for the sink/source names of
+		      the component.
+
+Example: Two instances of the same component.
+
+amp0: analog-amplifier@0 {
+	compatible = "simple-audio-amplifier";
+	enable-gpios = <&gpio GPIOH_3 0>;
+	sound-name-prefix = "FRONT";
+};
+
+amp1: analog-amplifier@1 {
+	compatible = "simple-audio-amplifier";
+	enable-gpios = <&gpio GPIOH_4 0>;
+	sound-name-prefix = "BACK";
+};
-- 
2.18.0

