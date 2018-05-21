Return-Path: <broonie@sirena.org.uk>
X-Google-Smtp-Source: AB8JxZre7m4h1ZxzTkmG0gK1xJkv7Lvd6uk7ZUzdJeSx6I3lY3MzTqdoFF/1r3hw/ARrti+PFsis
ARC-Seal: i=1; a=rsa-sha256; t=1526917628; cv=none;
        d=google.com; s=arc-20160816;
        b=y8mwxv+3G5UXrRNqd+da5jlY+HO4LuQw0KosfW7c4zQi6y8d97xRSazez21est4R+R
         NfuURSBLdIaEPxrqvW9d12dcOkEttNuoua2Ug+DIK25ydZ+9v30W9oDiZCHqesGy1ibw
         EWxvOwbyBF5WVoaYYzP8sKlLAc5I9aJUMYBG2CRBnDDkfvcZi7NcQtj68CEw4xaozB65
         fcCTTC+96cJuqLnhKlvPHUTTJTKSpG75JxnulElJRRltc040EPoSJ5ht4/Y3WQXALDIQ
         qfHgNVCcg3DmdgloFxa9VcfX8IH4Hf862VBQ67wfwjQyT0UVO9b9BOCn1OxxxOhcz2cu
         L5mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=date:message-id:in-reply-to:subject:cc:to:from:dkim-signature
         :arc-authentication-results;
        bh=w0pA+pUt3DlNnmEuRdqxepJjP6MNmokUI1/wzTfa698=;
        b=aFx+YLAcYzWxxgwPsP9GWbdmflnmxuZWhJFOdcvlB1cnXjejwORHi5D+BBF5ZniwEz
         iTZlzvCGFxojU5No9AofIRac+EUvdDYEBiXMq+wKk1FD7nn2IpqL9jrtDGnz3R/DQU/X
         /nHGbcX0xeRbltvYQ/H5wZb1hgLuZZz6T9gZIy3cxx9HMo/kPQg4ZxcgOSc5jMe/yFOI
         Es2/anhx4NJFdaJgBWHTZ8oI1ErpmVSDDZAqhuMadOhusPF7SWradT1nRSDhmECrngcJ
         X5Imi/ZWQVie8hKNNN/XtahWySX4u+JaKrBybTplZwaeY4pHTArr1rLKQjyy3SPMIOrx
         LuUA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@sirena.org.uk header.s=20170815-heliosphere header.b=I4i7SIHW;
       spf=pass (google.com: domain of broonie@sirena.org.uk designates 2a01:7e01::f03c:91ff:fed4:a3b6 as permitted sender) smtp.mailfrom=broonie@sirena.org.uk;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@sirena.org.uk header.s=20170815-heliosphere header.b=I4i7SIHW;
       spf=pass (google.com: domain of broonie@sirena.org.uk designates 2a01:7e01::f03c:91ff:fed4:a3b6 as permitted sender) smtp.mailfrom=broonie@sirena.org.uk;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=kernel.org
From: Mark Brown <broonie@kernel.org>
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: Mark Brown <broonie@kernel.org>, andy.gross@linaro.org, broonie@kernel.org, linux-arm-msm@vger.kernel.org, alsa-devel@alsa-project.org, robh+dt@kernel.org, bgoswami@codeaurora.org, mark.rutland@arm.com, devicetree@vger.kernel.org, rohkumar@qti.qualcomm.com, gregkh@linuxfoundation.org, plai@codeaurora.org, tiwai@suse.com, lgirdwood@gmail.com, david.brown@linaro.org, linux-arm-kernel@lists.infradead.org, spatakok@qti.qualcomm.com, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
Subject: Applied "ASoC: qcom: apq8096: Add db820c machine driver" to the asoc tree
In-Reply-To: <20180509125635.5653-24-srinivas.kandagatla@linaro.org>
Message-Id: <E1fKn1a-0006zQ-5l@debutante>
Date: Mon, 21 May 2018 16:47:02 +0100
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1601089179484309695?=
X-GMAIL-MSGID: =?utf-8?q?1601089179484309695?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The patch

   ASoC: qcom: apq8096: Add db820c machine driver

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

>From a6f933f63f2ffdb211dbf203dd9750449af000d3 Mon Sep 17 00:00:00 2001
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Date: Fri, 18 May 2018 13:56:10 +0100
Subject: [PATCH] ASoC: qcom: apq8096: Add db820c machine driver

This patch adds support to DB820c machine driver.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Reviewed-by: Banajit Goswami <bgoswami@codeaurora.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/qcom/Kconfig   |   9 ++
 sound/soc/qcom/Makefile  |   2 +
 sound/soc/qcom/apq8096.c | 255 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 266 insertions(+)
 create mode 100644 sound/soc/qcom/apq8096.c

diff --git a/sound/soc/qcom/Kconfig b/sound/soc/qcom/Kconfig
index 85bb7dd11fd9..87838fa27997 100644
--- a/sound/soc/qcom/Kconfig
+++ b/sound/soc/qcom/Kconfig
@@ -81,3 +81,12 @@ config SND_SOC_QDSP6
 	 This will enable sound soc platform specific
 	 audio drivers. This includes q6asm, q6adm,
 	 q6afe interfaces to DSP using apr.
+
+config SND_SOC_MSM8996
+	tristate "SoC Machine driver for MSM8996 and APQ8096 boards"
+	depends on QCOM_APR
+	select SND_SOC_QDSP6
+	help
+          Support for Qualcomm Technologies LPASS audio block in
+          APQ8096 SoC-based systems.
+          Say Y if you want to use audio device on this SoCs
diff --git a/sound/soc/qcom/Makefile b/sound/soc/qcom/Makefile
index 0276717917c0..206945bb9ba1 100644
--- a/sound/soc/qcom/Makefile
+++ b/sound/soc/qcom/Makefile
@@ -13,9 +13,11 @@ obj-$(CONFIG_SND_SOC_LPASS_APQ8016) += snd-soc-lpass-apq8016.o
 # Machine
 snd-soc-storm-objs := storm.o
 snd-soc-apq8016-sbc-objs := apq8016_sbc.o
+snd-soc-apq8096-objs := apq8096.o
 
 obj-$(CONFIG_SND_SOC_STORM) += snd-soc-storm.o
 obj-$(CONFIG_SND_SOC_APQ8016_SBC) += snd-soc-apq8016-sbc.o
+obj-$(CONFIG_SND_SOC_MSM8996) += snd-soc-apq8096.o
 
 #DSP lib
 obj-$(CONFIG_SND_SOC_QDSP6) += qdsp6/
diff --git a/sound/soc/qcom/apq8096.c b/sound/soc/qcom/apq8096.c
new file mode 100644
index 000000000000..561cd429e6f2
--- /dev/null
+++ b/sound/soc/qcom/apq8096.c
@@ -0,0 +1,255 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (c) 2018, Linaro Limited
+
+#include <linux/soc/qcom/apr.h>
+#include <linux/module.h>
+#include <linux/component.h>
+#include <linux/platform_device.h>
+#include <linux/of_device.h>
+#include <sound/soc.h>
+#include <sound/soc-dapm.h>
+#include <sound/pcm.h>
+
+static int apq8096_be_hw_params_fixup(struct snd_soc_pcm_runtime *rtd,
+				      struct snd_pcm_hw_params *params)
+{
+	struct snd_interval *rate = hw_param_interval(params,
+					SNDRV_PCM_HW_PARAM_RATE);
+	struct snd_interval *channels = hw_param_interval(params,
+					SNDRV_PCM_HW_PARAM_CHANNELS);
+
+	rate->min = rate->max = 48000;
+	channels->min = channels->max = 2;
+
+	return 0;
+}
+
+static int apq8096_sbc_parse_of(struct snd_soc_card *card)
+{
+	struct device_node *np;
+	struct device_node *codec = NULL;
+	struct device_node *platform = NULL;
+	struct device_node *cpu = NULL;
+	struct device *dev = card->dev;
+	struct snd_soc_dai_link *link;
+	int ret, num_links;
+
+	ret = snd_soc_of_parse_card_name(card, "qcom,model");
+	if (ret) {
+		dev_err(dev, "Error parsing card name: %d\n", ret);
+		return ret;
+	}
+
+	/* DAPM routes */
+	if (of_property_read_bool(dev->of_node, "qcom,audio-routing")) {
+		ret = snd_soc_of_parse_audio_routing(card,
+					"qcom,audio-routing");
+		if (ret)
+			return ret;
+	}
+
+	/* Populate links */
+	num_links = of_get_child_count(dev->of_node);
+
+	/* Allocate the DAI link array */
+	card->dai_link = kcalloc(num_links, sizeof(*link), GFP_KERNEL);
+	if (!card->dai_link)
+		return -ENOMEM;
+
+	card->num_links	= num_links;
+	link = card->dai_link;
+
+	for_each_child_of_node(dev->of_node, np) {
+		cpu = of_get_child_by_name(np, "cpu");
+		if (!cpu) {
+			dev_err(dev, "Can't find cpu DT node\n");
+			ret = -EINVAL;
+			goto err;
+		}
+
+		link->cpu_of_node = of_parse_phandle(cpu, "sound-dai", 0);
+		if (!link->cpu_of_node) {
+			dev_err(card->dev, "error getting cpu phandle\n");
+			ret = -EINVAL;
+			goto err;
+		}
+
+		ret = snd_soc_of_get_dai_name(cpu, &link->cpu_dai_name);
+		if (ret) {
+			dev_err(card->dev, "error getting cpu dai name\n");
+			goto err;
+		}
+
+		platform = of_get_child_by_name(np, "platform");
+		codec = of_get_child_by_name(np, "codec");
+		if (codec && platform) {
+			link->platform_of_node = of_parse_phandle(platform,
+								  "sound-dai",
+								   0);
+			if (!link->platform_of_node) {
+				dev_err(card->dev, "platform dai not found\n");
+				ret = -EINVAL;
+				goto err;
+			}
+
+			ret = snd_soc_of_get_dai_link_codecs(dev, codec, link);
+			if (ret < 0) {
+				dev_err(card->dev, "codec dai not found\n");
+				goto err;
+			}
+			link->no_pcm = 1;
+			link->ignore_pmdown_time = 1;
+			link->be_hw_params_fixup = apq8096_be_hw_params_fixup;
+		} else {
+			link->platform_of_node = link->cpu_of_node;
+			link->codec_dai_name = "snd-soc-dummy-dai";
+			link->codec_name = "snd-soc-dummy";
+			link->dynamic = 1;
+		}
+
+		link->ignore_suspend = 1;
+		ret = of_property_read_string(np, "link-name", &link->name);
+		if (ret) {
+			dev_err(card->dev, "error getting codec dai_link name\n");
+			goto err;
+		}
+
+		link->dpcm_playback = 1;
+		link->dpcm_capture = 1;
+		link->stream_name = link->name;
+		link++;
+	}
+
+	return 0;
+err:
+	of_node_put(cpu);
+	of_node_put(codec);
+	of_node_put(platform);
+	kfree(card->dai_link);
+	return ret;
+}
+
+static int apq8096_bind(struct device *dev)
+{
+	struct snd_soc_card *card;
+	int ret;
+
+	card = kzalloc(sizeof(*card), GFP_KERNEL);
+	if (!card)
+		return -ENOMEM;
+
+	component_bind_all(dev, card);
+	card->dev = dev;
+	ret = apq8096_sbc_parse_of(card);
+	if (ret) {
+		dev_err(dev, "Error parsing OF data\n");
+		goto err;
+	}
+
+	ret = snd_soc_register_card(card);
+	if (ret)
+		goto err;
+
+	return 0;
+
+err:
+	component_unbind_all(dev, card);
+	kfree(card);
+	return ret;
+}
+
+static void apq8096_unbind(struct device *dev)
+{
+	struct snd_soc_card *card = dev_get_drvdata(dev);
+
+	snd_soc_unregister_card(card);
+	component_unbind_all(dev, card);
+	kfree(card->dai_link);
+	kfree(card);
+}
+
+static const struct component_master_ops apq8096_ops = {
+	.bind = apq8096_bind,
+	.unbind = apq8096_unbind,
+};
+
+static int apq8016_compare_of(struct device *dev, void *data)
+{
+	return dev->of_node == data;
+}
+
+static void apq8016_release_of(struct device *dev, void *data)
+{
+	of_node_put(data);
+}
+
+static int add_audio_components(struct device *dev,
+				struct component_match **matchptr)
+{
+	struct device_node *np, *platform, *cpu, *node, *dai_node;
+
+	node = dev->of_node;
+
+	for_each_child_of_node(node, np) {
+		cpu = of_get_child_by_name(np, "cpu");
+		if (cpu) {
+			dai_node = of_parse_phandle(cpu, "sound-dai", 0);
+			of_node_get(dai_node);
+			component_match_add_release(dev, matchptr,
+						    apq8016_release_of,
+						    apq8016_compare_of,
+						    dai_node);
+		}
+
+		platform = of_get_child_by_name(np, "platform");
+		if (platform) {
+			dai_node = of_parse_phandle(platform, "sound-dai", 0);
+			component_match_add_release(dev, matchptr,
+						    apq8016_release_of,
+						    apq8016_compare_of,
+						    dai_node);
+		}
+	}
+
+	return 0;
+}
+
+static int apq8096_platform_probe(struct platform_device *pdev)
+{
+	struct component_match *match = NULL;
+	int ret;
+
+	ret = add_audio_components(&pdev->dev, &match);
+	if (ret)
+		return ret;
+
+	return component_master_add_with_match(&pdev->dev, &apq8096_ops, match);
+}
+
+static int apq8096_platform_remove(struct platform_device *pdev)
+{
+	component_master_del(&pdev->dev, &apq8096_ops);
+
+	return 0;
+}
+
+static const struct of_device_id msm_snd_apq8096_dt_match[] = {
+	{.compatible = "qcom,apq8096-sndcard"},
+	{}
+};
+
+MODULE_DEVICE_TABLE(of, msm_snd_apq8096_dt_match);
+
+static struct platform_driver msm_snd_apq8096_driver = {
+	.probe  = apq8096_platform_probe,
+	.remove = apq8096_platform_remove,
+	.driver = {
+		.name = "msm-snd-apq8096",
+		.owner = THIS_MODULE,
+		.of_match_table = msm_snd_apq8096_dt_match,
+	},
+};
+module_platform_driver(msm_snd_apq8096_driver);
+MODULE_AUTHOR("Srinivas Kandagatla <srinivas.kandagatla@linaro.org");
+MODULE_DESCRIPTION("APQ8096 ASoC Machine Driver");
+MODULE_LICENSE("GPL v2");
-- 
2.17.0
