Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C633C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 15:12:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0E7D26CE2
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 15:11:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="ANVA9jIt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0E7D26CE2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752009AbeFZPL6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 11:11:58 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:50598 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751253AbeFZPLi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 11:11:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=vK3QWXn50j9wGdDAjupEEC/8UUi8wMEy11sq87MzCIY=; b=ANVA9jItX1WK
        y6LLVneaLvBKjhZFCMAdWaaeRZ9brP3A1hKwbXrWvqO4M42oq7XgUoemaq9ERvLMK4Kud+jkHxO5k
        YDz0+9iOu7Th3DB7iygLKAbAfIPMXgY9P3ywZ9Y2OCltJQPICFFrDmkVvPb3nYfwNZiR9R12//V7G
        BXLXg=;
Received: from host109-146-194-33.range109-146.btcentralplus.com ([109.146.194.33] helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fXpcx-0001Ks-MH; Tue, 26 Jun 2018 15:11:31 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id 337B6440070; Tue, 26 Jun 2018 16:11:31 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     Niklas Cassel <niklas.cassel@linaro.org>,
        Mark Brown <broonie@kernel.org>, broonie@kernel.org,
        robh+dt@kernel.org, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, bgoswami@codeaurora.org,
        lgirdwood@gmail.com, linux-arm-msm@vger.kernel.org, tiwai@suse.com,
        linux-arm-kernel@lists.infradead.org, niklas.cassel@linaro.org,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
Subject: Applied "ASoC: qdsp6: q6adm: use of_platform_populate/depopulate()" to the asoc tree
In-Reply-To:  <20180626092016.9296-5-srinivas.kandagatla@linaro.org>
Message-Id: <20180626151131.337B6440070@finisterre.ee.mobilebroadband>
Date:   Tue, 26 Jun 2018 16:11:31 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: qdsp6: q6adm: use of_platform_populate/depopulate()

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

From f614c9b070ed149bbaac4edefb2b5fcb7755c4b0 Mon Sep 17 00:00:00 2001
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Date: Tue, 26 Jun 2018 10:20:08 +0100
Subject: [PATCH] ASoC: qdsp6: q6adm: use of_platform_populate/depopulate()

Now that the child nodes have there own compatible strings,
Use of_platform_populate/depopulate() instead of less common
of_platform_device_create()/destroy().

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Acked-by: Niklas Cassel <niklas.cassel@linaro.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/qcom/qdsp6/q6adm.c | 16 ++--------------
 1 file changed, 2 insertions(+), 14 deletions(-)

diff --git a/sound/soc/qcom/qdsp6/q6adm.c b/sound/soc/qcom/qdsp6/q6adm.c
index 9983c665a941..932c3ebfd252 100644
--- a/sound/soc/qcom/qdsp6/q6adm.c
+++ b/sound/soc/qcom/qdsp6/q6adm.c
@@ -64,7 +64,6 @@ struct q6adm {
 	struct aprv2_ibasic_rsp_result_t result;
 	struct mutex lock;
 	wait_queue_head_t matrix_map_wait;
-	struct platform_device *pdev_routing;
 };
 
 struct q6adm_cmd_device_open_v5 {
@@ -588,7 +587,6 @@ EXPORT_SYMBOL_GPL(q6adm_close);
 static int q6adm_probe(struct apr_device *adev)
 {
 	struct device *dev = &adev->dev;
-	struct device_node *dais_np;
 	struct q6adm *adm;
 
 	adm = devm_kzalloc(&adev->dev, sizeof(*adm), GFP_KERNEL);
@@ -605,22 +603,12 @@ static int q6adm_probe(struct apr_device *adev)
 	INIT_LIST_HEAD(&adm->copps_list);
 	spin_lock_init(&adm->copps_list_lock);
 
-	dais_np = of_get_child_by_name(dev->of_node, "routing");
-	if (dais_np) {
-		adm->pdev_routing = of_platform_device_create(dais_np,
-							   "q6routing", dev);
-		of_node_put(dais_np);
-	}
-
-	return 0;
+	return of_platform_populate(dev->of_node, NULL, NULL, dev);
 }
 
 static int q6adm_remove(struct apr_device *adev)
 {
-	struct q6adm *adm = dev_get_drvdata(&adev->dev);
-
-	if (adm->pdev_routing)
-		of_platform_device_destroy(&adm->pdev_routing->dev, NULL);
+	of_platform_depopulate(&adev->dev);
 
 	return 0;
 }
-- 
2.17.1

