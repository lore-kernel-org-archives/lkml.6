Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08D0DC67839
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 12:09:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C10EC20989
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 12:09:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544702944;
	bh=c/tMroSw4dioCY0t+lvEB1yCU78hOl+es1crMDbR6NQ=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=ekDCxDQmnDEDIUtQbBBAxIYEZbDafknpmo5U8a0yHjR8XmRyJeOvZKOq4Tfo8dHU0
	 Mwc1j/fFjhxpCU5WaKm7rduYnGURZg4d+FNdiNVH87R85lHxOzrHHKuU4HXeXf0eay
	 FjxuHpPcTpw1GKuArEKj4HwUsYyWLJNleoVa7Ey8=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C10EC20989
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728918AbeLMMJD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 07:09:03 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:49962 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728897AbeLMMJD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 07:09:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=qSnOTg8j+VEvEt+D1/RqJc0fjRRAZFyN/0tnQ6fL8wY=; b=UNDSohCc4+cH
        eOPPy7Rno0/A5q0Z1KeB3JZ9p17YD1GV56FRTTyxD06N61OS+daaY0bG55wztQFGNJyaIX92o6cfb
        LQSSnj+EWNOFLXfZeeeaLiHr+G96HVnIq89gAjHuw/H73bc2K0YB7oyT3ILzr+wNLYXbsXVUURFva
        tPFcI=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gXPnE-0000xs-9E; Thu, 13 Dec 2018 12:08:40 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id D576C11254D1; Thu, 13 Dec 2018 12:08:39 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Jerome Brunet <jbrunet@baylibre.com>
Cc:     Mark Brown <broonie@kernel.org>, Mark Brown <broonie@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Carlo Caione <carlo@caione.org>, devicetree@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-amlogic@lists.infradead.org,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
Subject: Applied "MAINTAINERS: Add Amlogic sound drivers entry" to the asoc tree
In-Reply-To:  <20181211134713.4908-5-jbrunet@baylibre.com>
X-Patchwork-Hint: ignore
Message-Id: <20181213120839.D576C11254D1@debutante.sirena.org.uk>
Date:   Thu, 13 Dec 2018 12:08:39 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   MAINTAINERS: Add Amlogic sound drivers entry

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

From 1b46ed96961db1a826b3e5cadac18c7c4857f054 Mon Sep 17 00:00:00 2001
From: Jerome Brunet <jbrunet@baylibre.com>
Date: Tue, 11 Dec 2018 14:47:13 +0100
Subject: [PATCH] MAINTAINERS: Add Amlogic sound drivers entry

Add sound/soc/meson drivers entry for Amlogic audio drivers.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index f4855974f325..637f6ce22626 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1309,6 +1309,13 @@ F:	drivers/pinctrl/meson/
 F:	drivers/mmc/host/meson*
 N:	meson
 
+ARM/Amlogic Meson SoC Sound Drivers
+M:	Jerome Brunet <jbrunet@baylibre.com>
+L:	alsa-devel@alsa-project.org (moderated for non-subscribers)
+S:	Maintained
+F:	sound/soc/meson/
+F:	Documentation/devicetree/bindings/sound/amlogic*
+
 ARM/Annapurna Labs ALPINE ARCHITECTURE
 M:	Tsahee Zidenberg <tsahee@annapurnalabs.com>
 M:	Antoine Tenart <antoine.tenart@bootlin.com>
-- 
2.19.0.rc2

