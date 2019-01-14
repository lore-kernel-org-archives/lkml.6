Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 655DBC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 22:10:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29A72205F4
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 22:10:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547503803;
	bh=SV0/QMYk+sKHgFwE2WXIgntB3EaqKvZNRb+3hDFrjh8=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=ek3s8sBi5+h+jWDsw4VhMN1OTIa9kvyeo4UmbkeHefzG2DOK+wIak+6HbDYZGo1BY
	 P2dpqVYIoNSzbERxQcLc91JO3UxAjol1KO5cfNfzvcD0lUAXvWZx7UAm6pTPsOQQRM
	 NPTPkQ0h2RkBJg3yJ3R3b/FB01wlzC9m3WYU5tQE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727085AbfANWKB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 17:10:01 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:33752 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726592AbfANWKB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 17:10:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=Jibu305MxvbFEi+SyUbJ6S4gPyhpb+7LaLU2rRsdfwM=; b=Q/Ax7OIdapQd
        9oBdLiyLQhsmCvurSYcw3azEwx8H8Qhpk4RdyqnyE5/Mgk3WYl9CeGuM60I8aVnr+wj091Ah4L9J8
        PdaiZhEeHC5xAi7Dvwe4IVhfnww9Wg+155VXKwP990rvFpUdXBG1X0fsw0s7FbQyUyaxE1ktnPP85
        5i67Y=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gjAQf-0008Go-7b; Mon, 14 Jan 2019 22:09:57 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id D5D971127AD0; Mon, 14 Jan 2019 22:09:56 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Douglas Anderson <dianders@chromium.org>,
        Mark Brown <broonie@kernel.org>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Girish Mahadevan <girishm@codeaurora.org>,
        Dilip Kota <dkota@codeaurora.org>,
        Alok Chauhan <alokc@codeaurora.org>,
        Douglas Anderson <dianders@chromium.org>,
        linux-spi@vger.kernel.org
Subject: Applied "spi: spi-geni-qcom: Get rid of forward declaration" to the spi tree
In-Reply-To:  <20190110210253.23219-2-swboyd@chromium.org>
X-Patchwork-Hint: ignore
Message-Id: <20190114220956.D5D971127AD0@debutante.sirena.org.uk>
Date:   Mon, 14 Jan 2019 22:09:56 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   spi: spi-geni-qcom: Get rid of forward declaration

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

From de43affed77b1bd9f246235dbd94eb23b07ab657 Mon Sep 17 00:00:00 2001
From: Stephen Boyd <swboyd@chromium.org>
Date: Thu, 10 Jan 2019 13:02:53 -0800
Subject: [PATCH] spi: spi-geni-qcom: Get rid of forward declaration

We don't need this forward declaration. Move the function to where it
needed so we can drop it and shave some lines of code.

CC: Girish Mahadevan <girishm@codeaurora.org>
CC: Dilip Kota <dkota@codeaurora.org>
CC: Alok Chauhan <alokc@codeaurora.org>
Cc: Douglas Anderson <dianders@chromium.org>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-geni-qcom.c | 55 ++++++++++++++++++-------------------
 1 file changed, 26 insertions(+), 29 deletions(-)

diff --git a/drivers/spi/spi-geni-qcom.c b/drivers/spi/spi-geni-qcom.c
index c3e9464027d4..5f0b0d5bfef4 100644
--- a/drivers/spi/spi-geni-qcom.c
+++ b/drivers/spi/spi-geni-qcom.c
@@ -89,9 +89,6 @@ struct spi_geni_master {
 	int irq;
 };
 
-static void handle_fifo_timeout(struct spi_master *spi,
-				struct spi_message *msg);
-
 static int get_spi_clk_cfg(unsigned int speed_hz,
 			struct spi_geni_master *mas,
 			unsigned int *clk_idx,
@@ -122,6 +119,32 @@ static int get_spi_clk_cfg(unsigned int speed_hz,
 	return ret;
 }
 
+static void handle_fifo_timeout(struct spi_master *spi,
+				struct spi_message *msg)
+{
+	struct spi_geni_master *mas = spi_master_get_devdata(spi);
+	unsigned long time_left, flags;
+	struct geni_se *se = &mas->se;
+
+	spin_lock_irqsave(&mas->lock, flags);
+	reinit_completion(&mas->xfer_done);
+	mas->cur_mcmd = CMD_CANCEL;
+	geni_se_cancel_m_cmd(se);
+	writel(0, se->base + SE_GENI_TX_WATERMARK_REG);
+	spin_unlock_irqrestore(&mas->lock, flags);
+	time_left = wait_for_completion_timeout(&mas->xfer_done, HZ);
+	if (time_left)
+		return;
+
+	spin_lock_irqsave(&mas->lock, flags);
+	reinit_completion(&mas->xfer_done);
+	geni_se_abort_m_cmd(se);
+	spin_unlock_irqrestore(&mas->lock, flags);
+	time_left = wait_for_completion_timeout(&mas->xfer_done, HZ);
+	if (!time_left)
+		dev_err(mas->dev, "Failed to cancel/abort m_cmd\n");
+}
+
 static void spi_geni_set_cs(struct spi_device *slv, bool set_flag)
 {
 	struct spi_geni_master *mas = spi_master_get_devdata(slv->master);
@@ -356,32 +379,6 @@ static void setup_fifo_xfer(struct spi_transfer *xfer,
 		writel(mas->tx_wm, se->base + SE_GENI_TX_WATERMARK_REG);
 }
 
-static void handle_fifo_timeout(struct spi_master *spi,
-				struct spi_message *msg)
-{
-	struct spi_geni_master *mas = spi_master_get_devdata(spi);
-	unsigned long time_left, flags;
-	struct geni_se *se = &mas->se;
-
-	spin_lock_irqsave(&mas->lock, flags);
-	reinit_completion(&mas->xfer_done);
-	mas->cur_mcmd = CMD_CANCEL;
-	geni_se_cancel_m_cmd(se);
-	writel(0, se->base + SE_GENI_TX_WATERMARK_REG);
-	spin_unlock_irqrestore(&mas->lock, flags);
-	time_left = wait_for_completion_timeout(&mas->xfer_done, HZ);
-	if (time_left)
-		return;
-
-	spin_lock_irqsave(&mas->lock, flags);
-	reinit_completion(&mas->xfer_done);
-	geni_se_abort_m_cmd(se);
-	spin_unlock_irqrestore(&mas->lock, flags);
-	time_left = wait_for_completion_timeout(&mas->xfer_done, HZ);
-	if (!time_left)
-		dev_err(mas->dev, "Failed to cancel/abort m_cmd\n");
-}
-
 static int spi_geni_transfer_one(struct spi_master *spi,
 				struct spi_device *slv,
 				struct spi_transfer *xfer)
-- 
2.20.1

