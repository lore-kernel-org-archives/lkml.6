Return-Path: <bgoswami@codeaurora.org>
X-Google-Smtp-Source: AB8JxZoCGRD1nKHxKZSH256iJ6uw4u06GiCF+JU53kowYu7tqbXFEWaHcRAHLkOtjB6WlUCobO2P
ARC-Seal: i=1; a=rsa-sha256; t=1525858957; cv=none;
        d=google.com; s=arc-20160816;
        b=TDmYjosCm37OFdBFQpvlE1ttzsKUKxYamEzmsz582l5eh+1FYuwR7FjrtmPd69He8C
         z0VP+eWogy+sOtHBESCjAjtzBPQjJhzraScrCPkS/lYAniA5TA9nOs5lNPxUt6sgNpS1
         CIiHtxhHOc75OjAzWKVV30iYTEEdixU7DqEUqRBYWfTrHOTz4NorPwBG3jObq3kAfskb
         ZgLKIJHm+wl7G8TZqdZiss6jqyB2HvKIMSnIf4t3JTswASTdKVfLTk/LTBAdsE4j9SKO
         DI6ZxCjPzsvUgd9aK0c75z+0oldbBqdIA5dKde84ba4ymHCa9HcH58Akk3qpv2J41+aE
         eJxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-language:content-transfer-encoding:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :dmarc-filter:dkim-signature:dkim-signature
         :arc-authentication-results;
        bh=Zs2579HYP3IAjDkfJO0BT5KmLPENlvse1E5/VJ0l3iw=;
        b=j7S7A86ZLBa/rjMXl8sCg5/oy51Mf3UK9id76u348VqyAbOYOwwO+Uai7Hn0iRpupR
         Xxlohs958w4lK1LX1ClLrZfJ27rW9EJKC4QPmxVNhiGzq1GrjqRy3ZJJ/lqIgdYrgtnM
         9egz7N9oWXJQkrZ0kJ1TBQF2wdniugkkodRMUCqF1zOMOzzhVx91ht9PvVhufP3q5JPX
         KmNaHezs4Gh1qrXius4n4boaAg4iauAipprsFTwINOMI3DjI9H8+Ec5ZHagovbVuIBWd
         OUCUrEtqGURtM4yuHs1ey7K+2w7I1nqf5y3MS7nsd5yjfeadqdeRgzs6yvm2njaLUH5N
         74OQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=Ls/NKiVF;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=hth581u8;
       spf=pass (google.com: domain of bgoswami@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=bgoswami@codeaurora.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=Ls/NKiVF;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=hth581u8;
       spf=pass (google.com: domain of bgoswami@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=bgoswami@codeaurora.org
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 2792C601A0
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=bgoswami@codeaurora.org
Subject: Re: [PATCH v7 20/24] ASoC: qdsp6: q6afe: Add q6afe dai driver
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
 andy.gross@linaro.org, broonie@kernel.org, linux-arm-msm@vger.kernel.org,
 alsa-devel@alsa-project.org, robh+dt@kernel.org
Cc: gregkh@linuxfoundation.org, david.brown@linaro.org, mark.rutland@arm.com,
 lgirdwood@gmail.com, plai@codeaurora.org, tiwai@suse.com, perex@perex.cz,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, rohkumar@qti.qualcomm.com,
 spatakok@qti.qualcomm.com
References: <20180501120820.11016-1-srinivas.kandagatla@linaro.org>
 <20180501120820.11016-21-srinivas.kandagatla@linaro.org>
From: Banajit Goswami <bgoswami@codeaurora.org>
Message-ID: <22a39a17-36ef-3e94-e91b-11d303559ae4@codeaurora.org>
Date: Wed, 9 May 2018 02:42:34 -0700
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180501120820.11016-21-srinivas.kandagatla@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599263634618005779?=
X-GMAIL-MSGID: =?utf-8?q?1599979082349849750?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 5/1/2018 5:08 AM, Srinivas Kandagatla wrote:
> This patch adds support to q6afe backend dais driver.
>
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> Reviewed-and-tested-by: Rohit kumar <rohitkr@codeaurora.org>
> ---
>   sound/soc/qcom/Kconfig           |   4 +
>   sound/soc/qcom/qdsp6/Makefile    |   1 +
>   sound/soc/qcom/qdsp6/q6afe-dai.c | 752 +++++++++++++++++++++++++++++++++++++++
>   3 files changed, 757 insertions(+)
>   create mode 100644 sound/soc/qcom/qdsp6/q6afe-dai.c
>
> diff --git a/sound/soc/qcom/Kconfig b/sound/soc/qcom/Kconfig
> index 43f9ed85efa8..d3523a30d942 100644
> --- a/sound/soc/qcom/Kconfig
<snip>
> +};
> +
> +static int msm_dai_q6_dai_probe(struct snd_soc_dai *dai)
> +{
> +	struct q6afe_dai_data *dai_data = dev_get_drvdata(dai->dev);
> +	struct snd_soc_dapm_context *dapm;
> +	struct q6afe_port *port;
> +
> +	dapm = snd_soc_component_get_dapm(dai->component);
dapm unused here?

LGTM otherwise.
Acked-by: Banajit Goswami <bgoswami@codeaurora.org>

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
