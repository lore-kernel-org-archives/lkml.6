Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA4A9C67790
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 17:30:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 622FB20843
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 17:30:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="gxZetrbu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 622FB20843
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729418AbeGYSna (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 14:43:30 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:55904 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728573AbeGYSna (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 14:43:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=vVlkOGmqN+isN7YEKS//R0qE7APW7MsivWUQ459hrCo=; b=gxZetrbua6nx
        29oXJt9jaJOORPBq9HwZs43HxbzL2jrcjgPympNolMO3OaFN0+8mO104iSy15oL8yiKPItQmULwVX
        54f/+QM2lMe53Y4JbdU/HO8GCa/WpzsF23wt1c1vk7iShxB6ASSwOf1CA1CUSUMoSuNbGRtkizy/8
        ICgfg=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fiNcT-0006nq-NP; Wed, 25 Jul 2018 17:30:37 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 5C87D1123B08; Wed, 25 Jul 2018 18:30:37 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Akshu Agrawal <akshu.agrawal@amd.com>
Cc:     Adam Thomson <Adam.Thomson.Opensource@diasemi.com>,
        Mark Brown <broonie@kernel.org>,
        "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." 
        <alsa-devel@alsa-project.org>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        open list <linux-kernel@vger.kernel.org>,
        Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>, djkurtz@chromium.org,
        akshu.agrawal@amd.com, Mark Brown <broonie@kernel.org>,
        Wei Yongjun <weiyongjun1@huawei.com>,
        "Mukunda,, Vijendar" <Vijendar.Mukunda@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Adam Thomson <Adam.Thomson.Opensource@diasemi.com>,
        alsa-devel@alsa-project.org
Subject: Applied "ASoC: AMD: Add a fix voltage regulator for DA7219 and ADAU7002" to the asoc tree
In-Reply-To:  <1532509274-8280-1-git-send-email-akshu.agrawal@amd.com>
Message-Id: <20180725173037.5C87D1123B08@debutante.sirena.org.uk>
Date:   Wed, 25 Jul 2018 18:30:37 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: AMD: Add a fix voltage regulator for DA7219 and ADAU7002

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

From 7b5317aa809f833d017196ad4a34e3b3b7dae101 Mon Sep 17 00:00:00 2001
From: Akshu Agrawal <akshu.agrawal@amd.com>
Date: Wed, 25 Jul 2018 17:00:59 +0800
Subject: [PATCH] ASoC: AMD: Add a fix voltage regulator for DA7219 and
 ADAU7002

DA7219 for our platform need to be configured for 1.8V.
Hence, we add a volatge regulator with supplies
of 1.8V in the machine driver.

Signed-off-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Signed-off-by: Akshu Agrawal <akshu.agrawal@amd.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/amd/Kconfig                |  1 +
 sound/soc/amd/acp-da7219-max98357a.c | 43 ++++++++++++++++++++++++++++
 2 files changed, 44 insertions(+)

diff --git a/sound/soc/amd/Kconfig b/sound/soc/amd/Kconfig
index 6cbf9cf4d1a4..58c1dcb4d255 100644
--- a/sound/soc/amd/Kconfig
+++ b/sound/soc/amd/Kconfig
@@ -8,6 +8,7 @@ config SND_SOC_AMD_CZ_DA7219MX98357_MACH
 	select SND_SOC_DA7219
 	select SND_SOC_MAX98357A
 	select SND_SOC_ADAU7002
+	select REGULATOR
 	depends on SND_SOC_AMD_ACP && I2C
 	help
 	 This option enables machine driver for DA7219 and MAX9835.
diff --git a/sound/soc/amd/acp-da7219-max98357a.c b/sound/soc/amd/acp-da7219-max98357a.c
index ccddc6650b9c..dfd520206013 100644
--- a/sound/soc/amd/acp-da7219-max98357a.c
+++ b/sound/soc/amd/acp-da7219-max98357a.c
@@ -32,6 +32,8 @@
 #include <linux/clk.h>
 #include <linux/gpio.h>
 #include <linux/module.h>
+#include <linux/regulator/machine.h>
+#include <linux/regulator/driver.h>
 #include <linux/i2c.h>
 #include <linux/input.h>
 #include <linux/acpi.h>
@@ -278,11 +280,52 @@ static struct snd_soc_card cz_card = {
 	.num_controls = ARRAY_SIZE(cz_mc_controls),
 };
 
+static struct regulator_consumer_supply acp_da7219_supplies[] = {
+	REGULATOR_SUPPLY("VDD", "i2c-DLGS7219:00"),
+	REGULATOR_SUPPLY("VDDMIC", "i2c-DLGS7219:00"),
+	REGULATOR_SUPPLY("VDDIO", "i2c-DLGS7219:00"),
+	REGULATOR_SUPPLY("IOVDD", "ADAU7002:00"),
+};
+
+static struct regulator_init_data acp_da7219_data = {
+	.constraints = {
+		.always_on = 1,
+	},
+	.num_consumer_supplies = ARRAY_SIZE(acp_da7219_supplies),
+	.consumer_supplies = acp_da7219_supplies,
+};
+
+static struct regulator_config acp_da7219_cfg = {
+	.init_data = &acp_da7219_data,
+};
+
+static struct regulator_ops acp_da7219_ops = {
+};
+
+static struct regulator_desc acp_da7219_desc = {
+	.name = "reg-fixed-1.8V",
+	.type = REGULATOR_VOLTAGE,
+	.owner = THIS_MODULE,
+	.ops = &acp_da7219_ops,
+	.fixed_uV = 1800000, /* 1.8V */
+	.n_voltages = 1,
+};
+
 static int cz_probe(struct platform_device *pdev)
 {
 	int ret;
 	struct snd_soc_card *card;
 	struct acp_platform_info *machine;
+	struct regulator_dev *rdev;
+
+	acp_da7219_cfg.dev = &pdev->dev;
+	rdev = devm_regulator_register(&pdev->dev, &acp_da7219_desc,
+				       &acp_da7219_cfg);
+	if (IS_ERR(rdev)) {
+		dev_err(&pdev->dev, "Failed to register regulator: %d\n",
+			ret);
+		return -EINVAL;
+	}
 
 	machine = devm_kzalloc(&pdev->dev, sizeof(struct acp_platform_info),
 			       GFP_KERNEL);
-- 
2.18.0

