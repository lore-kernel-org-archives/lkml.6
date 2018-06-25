Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CDF1C43142
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 13:18:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CAFAF25A3F
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 13:18:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="bOGtUz7+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CAFAF25A3F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933512AbeFYNPe (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 09:15:34 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:36502 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752930AbeFYNPc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 09:15:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=xj1VRLiN0oeZWHaN6cRlrfD/LPVl1POuMH6QLBQDFYc=; b=bOGtUz7+TETp
        74g5RsDUtopKkEOLuebsgV/rTWtVOlHghXORO/HyK9naJUXRUPoRFFtWHlaEn5yIU3mPk4MwxigpC
        WwG5u+m5ysCau/pYfpWWsJlRte81413pbcgvyuw8f3pcbpa0MHFYloC/qU4TtH8MAXtU/1jTL77Ni
        Hxer4=;
Received: from debutante.sirena.org.uk ([2001:470:1f1d:6b5::3] helo=debutante)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fXRKy-0007rb-Nt; Mon, 25 Jun 2018 13:15:20 +0000
Received: from broonie by debutante with local (Exim 4.91)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fXRKy-0008Lb-A6; Mon, 25 Jun 2018 14:15:20 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Robert Jarzmik <robert.jarzmik@free.fr>
Cc:     Vinod Koul <vkoul@kernel.org>, Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Ezequiel Garcia <ezequiel.garcia@free-electrons.com>,
        Boris Brezillon <boris.brezillon@free-electrons.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        alsa-devel@alsa-project.org, netdev@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-ide@vger.kernel.org, linux-mtd@lists.infradead.org,
        dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-media@vger.kernel.org, alsa-devel@alsa-project.org
Subject: Applied "dmaengine: pxa: document pxad_param" to the asoc tree
In-Reply-To:  <20180524070703.11901-11-robert.jarzmik@free.fr>
Message-Id: <E1fXRKy-0008Lb-A6@debutante>
Date:   Mon, 25 Jun 2018 14:15:20 +0100
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   dmaengine: pxa: document pxad_param

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

From b6d1a17f4729e4fda5740a855da91d202db2c118 Mon Sep 17 00:00:00 2001
From: Robert Jarzmik <robert.jarzmik@free.fr>
Date: Sun, 17 Jun 2018 19:02:14 +0200
Subject: [PATCH] dmaengine: pxa: document pxad_param

Add some documentation for the pxad_param structure, and describe the
contract behind the minimal required priority of a DMA channel.

Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
Acked-by: Vinod Koul <vkoul@kernel.org>
---
 include/linux/dma/pxa-dma.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/include/linux/dma/pxa-dma.h b/include/linux/dma/pxa-dma.h
index e56ec7af4fd7..9fc594f69eff 100644
--- a/include/linux/dma/pxa-dma.h
+++ b/include/linux/dma/pxa-dma.h
@@ -9,6 +9,15 @@ enum pxad_chan_prio {
 	PXAD_PRIO_LOWEST,
 };
 
+/**
+ * struct pxad_param - dma channel request parameters
+ * @drcmr: requestor line number
+ * @prio: minimal mandatory priority of the channel
+ *
+ * If a requested channel is granted, its priority will be at least @prio,
+ * ie. if PXAD_PRIO_LOW is required, the requested channel will be either
+ * PXAD_PRIO_LOW, PXAD_PRIO_NORMAL or PXAD_PRIO_HIGHEST.
+ */
 struct pxad_param {
 	unsigned int drcmr;
 	enum pxad_chan_prio prio;
-- 
2.18.0.rc2

