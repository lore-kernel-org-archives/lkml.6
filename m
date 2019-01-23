Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E53CC282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 17:58:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4540D218A1
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 17:58:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548266292;
	bh=XLJkTRgB+vsc8ZVxmnhx05j6vqzHV8y31C6F6NnoPE8=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=EOJ8LEZG5WZkku5oh242PBHfL7Z23YqAWPToPj2U1LS+bQti/ysCvE0sC13bYsJ4J
	 uLgWk+ZqOIkKdGYS1BTJAJVYRfsXzj8B/u7QPJhzb9aHWnyMO0URhEBWw8IXxRUxtv
	 QAtKTYMTNdtJSSilPaXENXrtJUW1o3s4Ciu9yKRo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726887AbfAWR6K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 12:58:10 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:46204 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726002AbfAWR6F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 12:58:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=aWKeCy1Ru8ZJvduNpOVtiC3AjjMHSSmdlnRkX+bZMxI=; b=pnkXKvbBOXBQ
        YqPUhugWc8YpmXakLOPBIUhd00s+noDdxXjQeYeklw24a8660AMzX2O7HTFgvY0zDhfsbjgNjkBkz
        4eJDggGStQpWQsWTcyClPfOzt3MmV0D2p1PPG0d7kOV6+COEyxYy7JEE+N5zJbsucjV2WtHDnmvII
        OWzwE=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gmMmi-0006qc-CO; Wed, 23 Jan 2019 17:57:56 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 08ACD1127ABA; Wed, 23 Jan 2019 17:57:55 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     Mark Brown <broonie@kernel.org>, broonie@kernel.org,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-spi@vger.kernel.org
Subject: Applied "spi/topcliff_pch: Fix potential NULL dereference on allocation error" to the spi tree
In-Reply-To:  <20190123120022.14008-1-yuehaibing@huawei.com>
X-Patchwork-Hint: ignore
Message-Id: <20190123175755.08ACD1127ABA@debutante.sirena.org.uk>
Date:   Wed, 23 Jan 2019 17:57:55 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   spi/topcliff_pch: Fix potential NULL dereference on allocation error

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

From e902cdcb5112b89ee445588147964723fd69ffb4 Mon Sep 17 00:00:00 2001
From: YueHaibing <yuehaibing@huawei.com>
Date: Wed, 23 Jan 2019 20:00:22 +0800
Subject: [PATCH] spi/topcliff_pch: Fix potential NULL dereference on
 allocation error

In pch_spi_handle_dma, it doesn't check for NULL returns of kcalloc
so it would result in an Oops.

Fixes: c37f3c2749b5 ("spi/topcliff_pch: DMA support")
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-topcliff-pch.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/spi/spi-topcliff-pch.c b/drivers/spi/spi-topcliff-pch.c
index 97d137591b18..e7e8ea1edcce 100644
--- a/drivers/spi/spi-topcliff-pch.c
+++ b/drivers/spi/spi-topcliff-pch.c
@@ -1008,6 +1008,9 @@ static void pch_spi_handle_dma(struct pch_spi_data *data, int *bpw)
 
 	/* RX */
 	dma->sg_rx_p = kcalloc(num, sizeof(*dma->sg_rx_p), GFP_ATOMIC);
+	if (!dma->sg_rx_p)
+		return;
+
 	sg_init_table(dma->sg_rx_p, num); /* Initialize SG table */
 	/* offset, length setting */
 	sg = dma->sg_rx_p;
@@ -1068,6 +1071,9 @@ static void pch_spi_handle_dma(struct pch_spi_data *data, int *bpw)
 	}
 
 	dma->sg_tx_p = kcalloc(num, sizeof(*dma->sg_tx_p), GFP_ATOMIC);
+	if (!dma->sg_tx_p)
+		return;
+
 	sg_init_table(dma->sg_tx_p, num); /* Initialize SG table */
 	/* offset, length setting */
 	sg = dma->sg_tx_p;
-- 
2.20.1

