Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C500EC64EB1
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 20:26:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8612420868
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 20:26:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544128007;
	bh=VilFGvysd91LarBbw6kiqAYETJf9N8686cnPwEdmY3I=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=AQDJUySytDf5ZZQS29O0BJHJHHNsfXfYmDjMr1l5hjLvsYpjtu5QbJu64nzfm/xS9
	 0lJD+aucwx4dAe+i8bSXewMo+deLOsTnxs3uhJNenJ53U3nOos6/fWiGgk5+xBLR5N
	 pUI81Yfy6NF9AtQUF38xho62lK8oxC/Xh3zfVbgI=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8612420868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726198AbeLFU0q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 15:26:46 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:37664 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726152AbeLFU0c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 15:26:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=t8KFbJ2NXZ0FGG+ttZKp3CG22kWVDCaNGg/o746SS1M=; b=DUyk9zKXOOsV
        i5WT3WblmUtTngOlDvXi8qdqBPwY1Wz6KOTMc/mOg4o7MutOoWMZlG9zpSpZBfvvQEPO/c+WJQgXJ
        D5IK4JagGH8s9X7uIWsgaC6l6zUebMRbigmKIk+VM71y/kMsf9+2eJOeG4VSA1v6qWSokHL2j/NBW
        9wt2Q=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gV0E1-0001iH-On; Thu, 06 Dec 2018 20:26:21 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 6D6ED11252F7; Thu,  6 Dec 2018 20:26:21 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Tomer Maimon <tmaimon77@gmail.com>
Cc:     Mark Brown <broonie@kernel.org>, broonie@kernel.org,
        robh+dt@kernel.org, mark.rutland@arm.com, yuenn@google.com,
        venture@google.com, brendanhiggins@google.com,
        avifishman70@gmail.com, joel@jms.id.au, linux-spi@vger.kernel.org,
        openbmc@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-spi@vger.kernel.org
Subject: Applied "spi: Update NPCM PSPI controller documentation" to the spi tree
In-Reply-To:  <20181204135442.125269-1-tmaimon77@gmail.com>
X-Patchwork-Hint: ignore
Message-Id: <20181206202621.6D6ED11252F7@debutante.sirena.org.uk>
Date:   Thu,  6 Dec 2018 20:26:21 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   spi: Update NPCM PSPI controller documentation

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

From 6ab4a3502923c20c5a6921868e787e5fd033409b Mon Sep 17 00:00:00 2001
From: Tomer Maimon <tmaimon77@gmail.com>
Date: Tue, 4 Dec 2018 15:54:42 +0200
Subject: [PATCH] spi: Update NPCM PSPI controller documentation

Update the PSPI NPCM binding document of the spi aliases use
to define the spi ID number.

Signed-off-by: Tomer Maimon <tmaimon77@gmail.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 .../devicetree/bindings/spi/nuvoton,npcm-pspi.txt         | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/spi/nuvoton,npcm-pspi.txt b/Documentation/devicetree/bindings/spi/nuvoton,npcm-pspi.txt
index 99606b22e5c2..1fd9a4406a1d 100644
--- a/Documentation/devicetree/bindings/spi/nuvoton,npcm-pspi.txt
+++ b/Documentation/devicetree/bindings/spi/nuvoton,npcm-pspi.txt
@@ -19,8 +19,16 @@ Optional properties:
 - clock-frequency : Input clock frequency to the PSPI block in Hz.
 		    Default is 25000000 Hz.
 
+Aliases:
+- All the SPI controller nodes should be represented in the aliases node using
+  the following format 'spi{n}' withe the correct numbered in "aliases" node.
+
 Example:
 
+aliases {
+	spi0 = &spi0;
+};
+
 spi0: spi@f0200000 {
 	compatible = "nuvoton,npcm750-pspi";
 	reg = <0xf0200000 0x1000>;
-- 
2.19.0.rc2

