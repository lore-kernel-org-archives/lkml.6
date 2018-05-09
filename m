Return-Path: <bgoswami@codeaurora.org>
X-Google-Smtp-Source: AB8JxZq66I/PYp4VGEle+HgqvEucdDoR4cEglvUkQs4+Z2LQDygGcNjSAM2ynbf2fuOnUtKN4rxD
ARC-Seal: i=1; a=rsa-sha256; t=1525857323; cv=none;
        d=google.com; s=arc-20160816;
        b=G5JP2YtS+rW4W4XqWB1MH3rkgicQ31SMnbZfLJvSYugV8rtdxzgrIVqRrOW66aMym+
         CuSyJ9dWECPpN/4URhKnQ2ufcxy7wC6Jp5MEb+a3nZUSWvPqsqXhXjbBr5Mn4JXlRwQf
         wEA88kXS7DJvxqnb7f6Q2OURkKp0+IRjb0HaG5JkW92yjWJeRq6D/3xhJfiyKS4iXep3
         mKm52eTwwV2jqSlhEFcpnWLfo0AaxPv5ZakpTl4nwBicfN3395YwIvsHpGPqagpXLhlj
         NqQg8ehBRIUZapQayXvJNezkpjHG/5uO01QnPNIJk5Qb0aeIcHY+ND2QE2ZjfDMoWDnN
         YbSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-language:content-transfer-encoding:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :dmarc-filter:dkim-signature:dkim-signature
         :arc-authentication-results;
        bh=sVtg2XUlVZd84F5ZZGWVp0YTjR3HPQq0sksc0chVWUw=;
        b=a+BNY7B+SXLSM9ElCIpFJuIo/SBXEsDt1/hCFfRkuYnzNCOcYygOL/fA78oUeQaNJF
         aWsQRWQPhBPcvBV/uIriKykVDh0SBFyDEwsGTYi52YnlWC8R+tw1/rhVZ6S+LOeczwSC
         CbEMCOGwsUUMA5iC9kFdU1Mz9y0XsySKRpWuCxzqaqFYj6xQU+57K041q90NYKuSwNBZ
         QEvdDJ0VXP3pceCSOVpWzJ6EDEv0IrNmCYw+M/bFrCHD9XRLYDnoeBxaF8q6f7FnstIO
         f3/9vlWxZskJlsdFGPWho4kWXhrdsXGdfetUf1zwbVYYtzBFmttKy84PPT7TsYtmSIqz
         2T2Q==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=jSznamNn;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=Q/ZZYeZG;
       spf=pass (google.com: domain of bgoswami@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=bgoswami@codeaurora.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=jSznamNn;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=Q/ZZYeZG;
       spf=pass (google.com: domain of bgoswami@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=bgoswami@codeaurora.org
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 08A72606AC
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=bgoswami@codeaurora.org
Subject: Re: [PATCH v7 23/24] ASoC: qcom: apq8096: Add db820c machine driver
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
 andy.gross@linaro.org, broonie@kernel.org, linux-arm-msm@vger.kernel.org,
 alsa-devel@alsa-project.org, robh+dt@kernel.org
Cc: gregkh@linuxfoundation.org, david.brown@linaro.org, mark.rutland@arm.com,
 lgirdwood@gmail.com, plai@codeaurora.org, tiwai@suse.com, perex@perex.cz,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, rohkumar@qti.qualcomm.com,
 spatakok@qti.qualcomm.com
References: <20180501120820.11016-1-srinivas.kandagatla@linaro.org>
 <20180501120820.11016-24-srinivas.kandagatla@linaro.org>
From: Banajit Goswami <bgoswami@codeaurora.org>
Message-ID: <c52fc35d-95a6-6675-6c6e-32a0d5f486d4@codeaurora.org>
Date: Wed, 9 May 2018 02:15:18 -0700
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180501120820.11016-24-srinivas.kandagatla@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599263638421096230?=
X-GMAIL-MSGID: =?utf-8?q?1599977368608530765?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


On 5/1/2018 5:08 AM, Srinivas Kandagatla wrote:
> This patch adds support to DB820c machine driver.
>
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---
>   sound/soc/qcom/Kconfig   |   9 ++
>   sound/soc/qcom/Makefile  |   2 +
>   sound/soc/qcom/apq8096.c | 238 +++++++++++++++++++++++++++++++++++++++++++++++
>   3 files changed, 249 insertions(+)
>   create mode 100644 sound/soc/qcom/apq8096.c
<snip>

> +
> +static int apq8096_sbc_parse_of(struct snd_soc_card *card)
> +{
> +	struct device_node *np, *codec, *platform, *cpu, *node;
> +	struct device *dev = card->dev;
> +	struct snd_soc_dai_link *link;
> +	int ret, num_links;
> +
> +	ret = snd_soc_of_parse_card_name(card, "qcom,model");
> +	if (ret) {
> +		dev_err(dev, "Error parsing card name: %d\n", ret);
> +		return ret;
> +	}
> +
> +	node = dev->of_node;
> +
> +	/* DAPM routes */
> +	if (of_property_read_bool(node, "qcom,audio-routing")) {
> +		ret = snd_soc_of_parse_audio_routing(card,
> +					"qcom,audio-routing");
> +		if (ret)
> +			return ret;
> +	}
> +
> +	/* Populate links */
> +	num_links = of_get_child_count(node);
> +
> +	/* Allocate the DAI link array */
> +	card->dai_link = kcalloc(num_links, sizeof(*link), GFP_KERNEL);
> +	if (!card->dai_link)
> +		return -ENOMEM;
> +
> +	card->num_links	= num_links;
> +	link = card->dai_link;
> +
> +	for_each_child_of_node(node, np) {
> +		cpu = of_get_child_by_name(np, "cpu");
> +		platform = of_get_child_by_name(np, "platform");
> +		codec = of_get_child_by_name(np, "codec");
> +
> +		if (!cpu) {
> +			dev_err(dev, "Can't find cpu DT node\n");
clean up missing to kfree(card->dai_link)?

> +			return -EINVAL;
> +		}
> +
> +		link->cpu_of_node = of_parse_phandle(cpu, "sound-dai", 0);
> +		if (!link->cpu_of_node) {
> +			dev_err(card->dev, "error getting cpu phandle\n");
ditto

> +			return -EINVAL;
> +		}
> +
> +		ret = snd_soc_of_get_dai_name(cpu, &link->cpu_dai_name);
> +		if (ret) {
> +			dev_err(card->dev, "error getting cpu dai name\n");
ditto

> +			return ret;
> +		}
> +
> +		if (codec && platform) {
> +			link->platform_of_node = of_parse_phandle(platform,
> +								  "sound-dai",
> +								   0);
> +			if (!link->platform_of_node) {
> +				dev_err(card->dev, "platform dai not found\n");
ditto

> +				return -EINVAL;
> +			}
> +
> +			ret = snd_soc_of_get_dai_link_codecs(dev, codec, link);
> +			if (ret < 0) {
> +				dev_err(card->dev, "codec dai not found\n");
ditto

> +				return ret;
> +			}
> +			link->no_pcm = 1;
> +			link->ignore_suspend = 1;
ignore_suspend will also need to be set for FE DAIs?

> +			link->ignore_pmdown_time = 1;
> +			link->be_hw_params_fixup = apq8096_be_hw_params_fixup;
> +		} else {
> +			link->platform_of_node = link->cpu_of_node;
> +			link->codec_dai_name = "snd-soc-dummy-dai";
> +			link->codec_name = "snd-soc-dummy";
> +			link->dynamic = 1;
> +		}
> +
> +		ret = of_property_read_string(np, "link-name", &link->name);
> +		if (ret) {
> +			dev_err(card->dev, "error getting codec dai_link name\n");
clean up

> +			return ret;
> +		}
> +
> +		link->dpcm_playback = 1;
> +		link->dpcm_capture = 1;
> +		link->stream_name = link->name;
> +		link++;
> +	}
> +
> +	return ret;
> +}
> +
> +static int apq8096_bind(struct device *dev)
> +{
> +	struct snd_soc_card *card;
> +	int ret;
> +
> +	card = kzalloc(sizeof(*card), GFP_KERNEL);
> +	if (!card)
> +		return -ENOMEM;
> +
> +	component_bind_all(dev, card);
> +	card->dev = dev;
> +	ret = apq8096_sbc_parse_of(card);
> +	if (ret) {
> +		dev_err(dev, "Error parsing OF data\n");
> +		component_unbind_all(dev, card);
> +		return ret;
> +	}
> +
> +	return snd_soc_register_card(card);
> +}
> +
> +static void apq8096_unbind(struct device *dev)
> +{
> +	struct snd_soc_card *card = dev_get_drvdata(dev);
> +
> +	component_unbind_all(dev, card);
> +	snd_soc_unregister_card(card);
Should sound card not be unregistered first, before calling 
component_unbind_all()?

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
