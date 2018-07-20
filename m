Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBF28ECDFBB
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 16:45:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72ECB20647
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 16:45:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="PrDrEYmN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72ECB20647
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388056AbeGTRe2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 13:34:28 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:59854 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387805AbeGTRe2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 13:34:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=JNRZdD/wgx4csnKFF8uz4pAubjwvw6eCVexPTfIOl4Q=; b=PrDrEYmNttlf
        2kMG0/I2QycLguwGWi1PZfFF8FC+tbjpt4qfG/yrtiJLQlmKp5LXAJihbbbIzP7Qsj7lpxOVbNufN
        P1H/hjbPFJD7fVqq4KIDNbIQ5CRayLa7xIkgZOnDk6UDiznd8NVuk2KphocnWbNZD+LoiUxZ7qihe
        Bg3ko=;
Received: from debutante.sirena.org.uk ([2001:470:1f1d:6b5::3] helo=debutante)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fgYWt-00006A-S8; Fri, 20 Jul 2018 16:45:19 +0000
Received: from broonie by debutante with local (Exim 4.91)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fgYWt-00013U-DY; Fri, 20 Jul 2018 17:45:19 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Niklas Cassel <niklas.cassel@linaro.org>
Cc:     Mark Brown <broonie@kernel.org>, broonie@kernel.org,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Applied "regulator: qcom_spmi: Indent with tabs instead of spaces" to the regulator tree
In-Reply-To:  <20180716113525.9335-5-niklas.cassel@linaro.org>
Message-Id: <E1fgYWt-00013U-DY@debutante>
Date:   Fri, 20 Jul 2018 17:45:19 +0100
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: qcom_spmi: Indent with tabs instead of spaces

has been applied to the regulator tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git 

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

From 37164571fb25adef80ae2aaf55840b0105c15b22 Mon Sep 17 00:00:00 2001
From: Niklas Cassel <niklas.cassel@linaro.org>
Date: Mon, 16 Jul 2018 15:32:54 +0200
Subject: [PATCH] regulator: qcom_spmi: Indent with tabs instead of spaces

Fix the following checkpatch error:

ERROR: code indent should use tabs where possible
+        { }$

Fixes: ca5cd8c9400c ("regulator: qcom_spmi: Add support for pmi8994")
Signed-off-by: Niklas Cassel <niklas.cassel@linaro.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/qcom_spmi-regulator.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/regulator/qcom_spmi-regulator.c b/drivers/regulator/qcom_spmi-regulator.c
index 5246f5b870c2..53a61fb65642 100644
--- a/drivers/regulator/qcom_spmi-regulator.c
+++ b/drivers/regulator/qcom_spmi-regulator.c
@@ -1728,7 +1728,7 @@ static const struct spmi_regulator_data pmi8994_regulators[] = {
 	{ "s2", 0x1700, "vdd_s2", },
 	{ "s3", 0x1a00, "vdd_s3", },
 	{ "l1", 0x4000, "vdd_l1", },
-        { }
+	{ }
 };
 
 static const struct of_device_id qcom_spmi_regulator_match[] = {
-- 
2.18.0

