Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC178C43612
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 16:17:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B07DB20883
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 16:17:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546964243;
	bh=EvQ+/fYdjnESPmdsCc/Mpy3neMiK2IQe7rnD9c5lrOU=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=i3esIQwIAsJXo73GbS747k9TjQxW8N+m3Y1eYrpG+g8Hn1wszrQCJZkqTwb9oc1zZ
	 CqtHc3c4mGuDc9dSSX8DpvLmWkdIvOJ2kbFTv6MEdU4bWyaCrEcZlPJE6WTeLIm1IQ
	 bTCIt+XzpajKZ5meEh7nnptg+KXfNf00qKz4RRP8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729278AbfAHQRW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 11:17:22 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:42890 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729200AbfAHQRW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 11:17:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=zOd3qz1OnpQ3ls4xKSUiIaKz/D+TnsJReOukCFs+99Q=; b=lhvwxO5B4MxA
        zhiRC9xG7mFOqW6CDxgX/pQwkatDIlSneND+MoMQII/nwzDAO1f2zO6u365y/H7c7oDAoB9nM0+t4
        SBZpQB/dMO6pJ6RM4KEgboEv9lI3y/4AVYcYutOb4ZWz3bgilvBFIReuwO8k0VSyB+8hsfelLbpvO
        1kh8o=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1ggu3y-0003QL-MX; Tue, 08 Jan 2019 16:17:10 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 49B0C112778C; Tue,  8 Jan 2019 16:17:10 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Agrawal@sirena.org.uk, Akshu <Akshu.Agrawal@amd.com>
Cc:     Akshu Agrawal <akshu.agrawal@amd.com>,
        Mark Brown <broonie@kernel.org>,
        "moderated list:ANALOG DEVICES INC ASOC CODEC DRIVERS" 
        <alsa-devel@alsa-project.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        open list <linux-kernel@vger.kernel.org>,
        Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        "djkurtz@chromium.org" <djkurtz@chromium.org>,
        "Agrawal,, Akshu" <Akshu.Agrawal@amd.com>,
        Mark Brown <broonie@kernel.org>,
        "Deucher,, Alexander" <Alexander.Deucher@amd.com>,
        alsa-devel@alsa-project.org
Subject: Applied "ASoC: ADAU7002: Add optional delay before start of capture" to the asoc tree
In-Reply-To:  <1546942924-9428-1-git-send-email-akshu.agrawal@amd.com>
X-Patchwork-Hint: ignore
Message-Id: <20190108161710.49B0C112778C@debutante.sirena.org.uk>
Date:   Tue,  8 Jan 2019 16:17:10 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: ADAU7002: Add optional delay before start of capture

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

From 7b57085a33ce55e28616f04fd9877ba2ca7e79de Mon Sep 17 00:00:00 2001
From: "Agrawal, Akshu" <Akshu.Agrawal@amd.com>
Date: Tue, 8 Jan 2019 10:24:40 +0000
Subject: [PATCH] ASoC: ADAU7002: Add optional delay before start of capture

On capture through some of dmic we observe a glitch at the
start of record. This is because we start capturing even before
dmic is ready to send out data.
The optional delay will be applied after enabling the mic.

Signed-off-by: Akshu Agrawal <akshu.agrawal@amd.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/adau7002.c | 45 +++++++++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/sound/soc/codecs/adau7002.c b/sound/soc/codecs/adau7002.c
index fdff86878287..a8deb37fc78a 100644
--- a/sound/soc/codecs/adau7002.c
+++ b/sound/soc/codecs/adau7002.c
@@ -8,6 +8,7 @@
  */
 
 #include <linux/acpi.h>
+#include <linux/delay.h>
 #include <linux/init.h>
 #include <linux/module.h>
 #include <linux/of.h>
@@ -15,12 +16,55 @@
 
 #include <sound/soc.h>
 
+struct adau7002_priv {
+	int wakeup_delay;
+};
+
+static int adau7002_aif_event(struct snd_soc_dapm_widget *w,
+			      struct snd_kcontrol *kcontrol, int event)
+{
+	struct snd_soc_component *component =
+			snd_soc_dapm_to_component(w->dapm);
+	struct adau7002_priv *adau7002 =
+			snd_soc_component_get_drvdata(component);
+
+	switch (event) {
+	case SND_SOC_DAPM_POST_PMU:
+		if (adau7002->wakeup_delay)
+			msleep(adau7002->wakeup_delay);
+		break;
+	}
+
+	return 0;
+}
+
+static int adau7002_component_probe(struct snd_soc_component *component)
+{
+	struct adau7002_priv *adau7002;
+
+	adau7002 = devm_kzalloc(component->dev, sizeof(*adau7002),
+				GFP_KERNEL);
+	if (!adau7002)
+		return -ENOMEM;
+
+	device_property_read_u32(component->dev, "wakeup-delay-ms",
+				 &adau7002->wakeup_delay);
+
+	snd_soc_component_set_drvdata(component, adau7002);
+
+	return 0;
+}
+
 static const struct snd_soc_dapm_widget adau7002_widgets[] = {
+	SND_SOC_DAPM_AIF_OUT_E("ADAU AIF", "Capture", 0,
+			       SND_SOC_NOPM, 0, 0, adau7002_aif_event,
+			       SND_SOC_DAPM_POST_PMU | SND_SOC_DAPM_POST_PMD),
 	SND_SOC_DAPM_INPUT("PDM_DAT"),
 	SND_SOC_DAPM_REGULATOR_SUPPLY("IOVDD", 0, 0),
 };
 
 static const struct snd_soc_dapm_route adau7002_routes[] = {
+	{ "ADAU AIF", NULL, "PDM_DAT"},
 	{ "Capture", NULL, "PDM_DAT" },
 	{ "Capture", NULL, "IOVDD" },
 };
@@ -40,6 +84,7 @@ static struct snd_soc_dai_driver adau7002_dai = {
 };
 
 static const struct snd_soc_component_driver adau7002_component_driver = {
+	.probe			= adau7002_component_probe,
 	.dapm_widgets		= adau7002_widgets,
 	.num_dapm_widgets	= ARRAY_SIZE(adau7002_widgets),
 	.dapm_routes		= adau7002_routes,
-- 
2.20.1

