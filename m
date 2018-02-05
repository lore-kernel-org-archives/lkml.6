Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753385AbeBEPqU (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Feb 2018 10:46:20 -0500
Received: from mailout4.samsung.com ([203.254.224.34]:35735 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752925AbeBEPp1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Feb 2018 10:45:27 -0500
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20180205154525epoutp048766261d220f0921c5fa707e729b667b~QeHbHvuJZ3163331633epoutp04B
X-AuditID: b6c32a35-891ff70000001031-94-5a787c15f073
From: Sylwester Nawrocki <s.nawrocki@samsung.com>
To: broonie@kernel.org
Cc: lgirdwood@gmail.com, alsa-devel@alsa-project.org, robh+dt@kernel.org,
        devicetree@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        krzk@kernel.org, jcsing.lee@samsung.com, sbkim73@samsung.com,
        linux-kernel@vger.kernel.org, b.zolnierkie@samsung.com,
        m.szyprowski@samsung.com, Sylwester Nawrocki <s.nawrocki@samsung.com>
Subject: [PATCH 5/8] ASoC: samsung: Add support for HDMI audio on TM2 board
Date: Mon, 05 Feb 2018 16:44:00 +0100
Message-id: <20180205154403.13520-6-s.nawrocki@samsung.com>
X-Mailer: git-send-email 2.14.2
In-reply-to: <20180205154403.13520-1-s.nawrocki@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrEIsWRmVeSWpSXmKPExsWy7bCmnq5oTUWUwYPHAhZXLh5istg4Yz2r
        xdSHT9gs5h85x2rxdn83s8X58xvYLb5d6WCyuLxrDpvFjPP7mCzWHrnLbtG69wi7xeE37awW
        F1d8YXLg9djwuYnNY+esu+wem1Z1snn0bVnF6PF5k1wAaxSXTUpqTmZZapG+XQJXxsaFv1kK
        rlpXNK3cwtLA+Fq/i5GDQ0LAROLog+guRi4OIYEdjBJdS94zQTjfGSVO7upm7WLkBCta3X+c
        GSKxm1Hi4Z05LBDOL0aJT523mUCq2AQMJXqP9jGC2CICYhK353SCdTALnGGSmL5vDViRsIC3
        xP0Z65hBbBYBVYnHWx6B2bwC1hLrf92FWicv8X7BfbBBnAI2EnvuLWMEGSQhsINNYvWpY4wQ
        RS4SPzddhLKFJV4d38IO8ZC0xKWjthD1/YwSJ9Y0QzXPYJS40z6BCaLBWuLw8Ytg25gF+CTe
        fe1hhWjmlehoE4Io8ZBYe/EBM0TYUaKvLxDiY6CZWzv62ScwSi1gZFjFKJZaUJybnlpsWGCo
        V5yYW1yal66XnJ+7iREc01qmOxinnPM5xCjAwajEwyuQURElxJpYVlyZe4hRgoNZSYTX6Xp5
        lBBvSmJlVWpRfnxRaU5q8SFGaQ4WJXHegACXKCGB9MSS1OzU1ILUIpgsEwenVANjoIFLhYr1
        jPRfKo++ZVnNXHXRkPOHuSJfcKl9hka2TZpN2bHr+Rr2XFd1/0lkRPAuM221+aG3MbfMwnmX
        Lu9Ol/U6qV4skwLbNZ3ElJs0SnRUsr0PLlzYksBd39HRdffWZJ2bBXPUf7RvmZJbXTZnnn6W
        BNMNs5ZgsfbObjmpg3O+3fY/rMRSnJFoqMVcVJwIAEM+yhHlAgAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrFLMWRmVeSWpSXmKPExsVy+t9jAV2Rmooog0+TdC2uXDzEZLFxxnpW
        i6kPn7BZzD9yjtXi7f5uZovz5zewW3y70sFkcXnXHDaLGef3MVmsPXKX3aJ17xF2i8Nv2lkt
        Lq74wuTA67HhcxObx85Zd9k9Nq3qZPPo27KK0ePzJrkA1igum5TUnMyy1CJ9uwSujI0Lf7MU
        XLWuaFq5haWB8bV+FyMnh4SAicTq/uPMXYxcHEICOxklXndvYIJwfjFKHDqynh2kik3AUKL3
        aB8jiC0iICZxe04nWAezwBkmiS8TL4EVCQt4S9yfsY4ZxGYRUJV4vOURmM0rYC2x/tddVoh1
        8hLvF9wHG8QpYCOx594yIJsDaJu1RNNNgQmMPAsYGVYxSqYWFOem5xYbFRjmpZbrFSfmFpfm
        pesl5+duYgSG4LbDWn07GO8viT/EKMDBqMTDm5FVESXEmlhWXJl7iFGCg1lJhNfpenmUEG9K
        YmVValF+fFFpTmrxIUZpDhYlcd7beccihQTSE0tSs1NTC1KLYLJMHJxSDYwqQdWRnmFapUcn
        Lt2qWVrbtdrbL3jxlWOnq16zSPyZPbendMNH51ifjfIKcU4RATI6B+0tDzUk7E4yiw9M0Zo1
        Z0n11NU6ansdy+7O7Pr0pyhIr1BoydziaVO36NqqGWVsXqq5J3HJ1CZFqZ9tky3u1ny9svNw
        zbqcor2RWTPn53T5yH9m8lViKc5INNRiLipOBADAQNE7PQIAAA==
X-CMS-MailID: 20180205154524epcas1p35874552d9056837a162dc59d847d1930
X-Msg-Generator: CA
CMS-TYPE: 101P
X-CMS-RootMailID: 20180205154524epcas1p35874552d9056837a162dc59d847d1930
X-RootMTR: 20180205154524epcas1p35874552d9056837a162dc59d847d1930
References: <20180205154403.13520-1-s.nawrocki@samsung.com>
        <CGME20180205154524epcas1p35874552d9056837a162dc59d847d1930@epcas1p3.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch defines I2S1 - HDMI DAI link and implements related
hw_params callback. The AUD PLL frequency is configured through
the CLK_SCLK_I2S1 leaf clock, the exynos5433 clock tree
definitions are updated in a separate patch.

The device tree parsing part is changed is a way it supports older
DTBs with just a single CPU DAI specified, without the HDMI link.

Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
---
 sound/soc/samsung/tm2_wm5110.c | 180 +++++++++++++++++++++++++++++++++++------
 1 file changed, 157 insertions(+), 23 deletions(-)

diff --git a/sound/soc/samsung/tm2_wm5110.c b/sound/soc/samsung/tm2_wm5110.c
index a55d18703fe7..eafa14a97c61 100644
--- a/sound/soc/samsung/tm2_wm5110.c
+++ b/sound/soc/samsung/tm2_wm5110.c
@@ -34,6 +34,7 @@ struct tm2_machine_priv {
 	struct snd_soc_codec *codec;
 	unsigned int sysclk_rate;
 	struct gpio_desc *gpio_mic_bias;
+	struct clk *sclk_i2s1;
 };
 
 static int tm2_start_sysclk(struct snd_soc_card *card)
@@ -210,6 +211,76 @@ static struct snd_soc_ops tm2_aif2_ops = {
 	.hw_free = tm2_aif2_hw_free,
 };
 
+static int tm2_hdmi_hw_params(struct snd_pcm_substream *substream,
+			      struct snd_pcm_hw_params *params)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct tm2_machine_priv *priv = snd_soc_card_get_drvdata(rtd->card);
+	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
+	unsigned long fpll;
+	unsigned int bfs;
+	int bitwidth, ret;
+
+	bitwidth = snd_pcm_format_width(params_format(params));
+	if (bitwidth < 0) {
+		dev_err(rtd->card->dev, "Invalid bit-width: %d\n", bitwidth);
+		return bitwidth;
+	}
+
+	switch (bitwidth) {
+	case 48:
+		bfs = 64;
+		break;
+	case 16:
+		bfs = 32;
+		break;
+	default:
+		dev_err(rtd->card->dev, "Unsupported bit-width: %d\n", bitwidth);
+		return -EINVAL;
+	}
+
+	switch (params_rate(params)) {
+	case 32000:
+	case 64000:
+		fpll = 131072006U;
+		break;
+	case 44100:
+	case 88200:
+	case 176400:
+		fpll = 180633609U;
+		break;
+	case 48000:
+	case 96000:
+	case 192000:
+		fpll = 196608001U;
+		break;
+	default:
+		dev_err(rtd->card->dev, "Unsupported sample rate: %d\n",
+			params_rate(params));
+		return -EINVAL;
+	}
+
+	/* Set AUD PLL frequency at least fs * bfs * 8 */
+	ret = clk_set_rate(priv->sclk_i2s1, (fpll + 1) / 2);
+	if (ret < 0)
+		return ret;
+
+	ret = snd_soc_dai_set_sysclk(cpu_dai, SAMSUNG_I2S_OPCLK,
+					0, SAMSUNG_I2S_OPCLK_PCLK);
+	if (ret < 0)
+		return ret;
+
+	ret = snd_soc_dai_set_clkdiv(cpu_dai, SAMSUNG_I2S_DIV_BCLK, bfs);
+	if (ret < 0)
+		return ret;
+
+	return 0;
+}
+
+static struct snd_soc_ops tm2_hdmi_ops = {
+	.hw_params = tm2_hdmi_hw_params,
+};
+
 static int tm2_mic_bias(struct snd_soc_dapm_widget *w,
 				struct snd_kcontrol *kcontrol, int event)
 {
@@ -405,6 +476,12 @@ static struct snd_soc_dai_link tm2_dai_links[] = {
 		.dai_fmt	= SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF |
 				  SND_SOC_DAIFMT_CBM_CFM,
 		.ignore_suspend = 1,
+	}, {
+		.name		= "HDMI",
+		.stream_name	= "i2s1",
+		.ops		= &tm2_hdmi_ops,
+		.dai_fmt	= SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF |
+				  SND_SOC_DAIFMT_CBS_CFS,
 	}
 };
 
@@ -412,7 +489,6 @@ static struct snd_soc_card tm2_card = {
 	.owner			= THIS_MODULE,
 
 	.dai_link		= tm2_dai_links,
-	.num_links		= ARRAY_SIZE(tm2_dai_links),
 	.controls		= tm2_controls,
 	.num_controls		= ARRAY_SIZE(tm2_controls),
 	.dapm_widgets		= tm2_dapm_widgets,
@@ -426,11 +502,14 @@ static struct snd_soc_card tm2_card = {
 
 static int tm2_probe(struct platform_device *pdev)
 {
+	struct device_node *cpu_dai_node[2] = {};
+	struct device_node *codec_dai_node[2] = {};
+	const char *cells_name = NULL;
 	struct device *dev = &pdev->dev;
 	struct snd_soc_card *card = &tm2_card;
 	struct tm2_machine_priv *priv;
-	struct device_node *cpu_dai_node, *codec_dai_node;
-	int ret, i;
+	struct of_phandle_args args;
+	int num_codecs, ret, i;
 
 	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
 	if (!priv)
@@ -464,47 +543,102 @@ static int tm2_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
-	cpu_dai_node = of_parse_phandle(dev->of_node, "i2s-controller", 0);
-	if (!cpu_dai_node) {
-		dev_err(dev, "i2s-controllers property invalid or missing\n");
-		ret = -EINVAL;
-		goto amp_node_put;
+	num_codecs = of_count_phandle_with_args(dev->of_node, "audio-codec",
+						 NULL);
+
+	/* Skip the HDMI link if not specified in DT */
+	if (num_codecs > 1) {
+		card->num_links = ARRAY_SIZE(tm2_dai_links);
+		cells_name = "#sound-dai-cells";
+	} else {
+		card->num_links = ARRAY_SIZE(tm2_dai_links) - 1;
 	}
 
-	codec_dai_node = of_parse_phandle(dev->of_node, "audio-codec", 0);
-	if (!codec_dai_node) {
-		dev_err(dev, "audio-codec property invalid or missing\n");
-		ret = -EINVAL;
-		goto cpu_dai_node_put;
+	for (i = 0; i < num_codecs; i++) {
+		struct of_phandle_args args;
+
+		ret = of_parse_phandle_with_args(dev->of_node, "i2s-controller",
+						 cells_name, i, &args);
+		if (!args.np) {
+			dev_err(dev, "i2s-controller property parse error: %d\n", i);
+			ret = -EINVAL;
+			goto dai_node_put;
+		}
+		cpu_dai_node[i] = args.np;
+
+		codec_dai_node[i] = of_parse_phandle(dev->of_node,
+						     "audio-codec", i);
+		if (!codec_dai_node[i]) {
+			dev_err(dev, "audio-codec property parse error\n");
+			ret = -EINVAL;
+			goto dai_node_put;
+		}
 	}
 
+	/* Initialize WM5110 - I2S and HDMI - I2S1 DAI links */
 	for (i = 0; i < card->num_links; i++) {
+		unsigned int dai_index = 0; /* WM5110 */
+
 		card->dai_link[i].cpu_name = NULL;
 		card->dai_link[i].platform_name = NULL;
-		card->dai_link[i].codec_of_node = codec_dai_node;
-		card->dai_link[i].cpu_of_node = cpu_dai_node;
-		card->dai_link[i].platform_of_node = cpu_dai_node;
+
+		if (num_codecs > 1 && i == card->num_links - 1)
+			dai_index = 1; /* HDMI */
+
+		card->dai_link[i].codec_of_node = codec_dai_node[dai_index];
+		card->dai_link[i].cpu_of_node = cpu_dai_node[dai_index];
+		card->dai_link[i].platform_of_node = cpu_dai_node[dai_index];
+	}
+
+	if (num_codecs > 1) {
+		/* HDMI DAI link (I2S1) */
+		i = card->num_links - 1;
+
+		ret = of_parse_phandle_with_fixed_args(dev->of_node,
+						"audio-codec", 0, 1, &args);
+		if (ret) {
+			dev_err(dev, "audio-codec property parse error\n");
+			goto dai_node_put;
+		}
+
+		ret = snd_soc_get_dai_name(&args, &card->dai_link[i].codec_dai_name);
+		if (ret) {
+			dev_err(dev, "Unable to get codec_dai_name\n");
+			goto dai_node_put;
+		}
+
+		priv->sclk_i2s1 = of_clk_get_by_name(cpu_dai_node[1], "i2s_opclk1");
+		if (IS_ERR(priv->sclk_i2s1)) {
+			ret = PTR_ERR(priv->sclk_i2s1);
+			goto dai_node_put;
+		}
 	}
 
 	ret = devm_snd_soc_register_component(dev, &tm2_component,
 				tm2_ext_dai, ARRAY_SIZE(tm2_ext_dai));
 	if (ret < 0) {
 		dev_err(dev, "Failed to register component: %d\n", ret);
-		goto codec_dai_node_put;
+		goto err_put_sclk;
 	}
 
 	ret = devm_snd_soc_register_card(dev, card);
 	if (ret < 0) {
 		dev_err(dev, "Failed to register card: %d\n", ret);
-		goto codec_dai_node_put;
+		goto err_put_sclk;
+	}
+
+	goto dai_node_put;
+
+err_put_sclk:
+	clk_put(priv->sclk_i2s1);
+dai_node_put:
+	for (i = 0; i < num_codecs; i++) {
+		of_node_put(codec_dai_node[i]);
+		of_node_put(cpu_dai_node[i]);
 	}
 
-codec_dai_node_put:
-	of_node_put(codec_dai_node);
-cpu_dai_node_put:
-	of_node_put(cpu_dai_node);
-amp_node_put:
 	of_node_put(card->aux_dev[0].codec_of_node);
+
 	return ret;
 }
 
-- 
2.14.2
