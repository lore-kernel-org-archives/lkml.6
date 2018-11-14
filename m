Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CCD8C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 07:13:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C19F1223DD
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 07:13:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=birdec.tech header.i=@birdec.tech header.b="oDOFsso1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C19F1223DD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=birdec.tech
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731384AbeKNRPF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 12:15:05 -0500
Received: from host.euro-space.net ([87.117.239.2]:53436 "EHLO
        host.euro-space.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726927AbeKNRPF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 12:15:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=birdec.tech
        ; s=default; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=8JdkD3vdemO6VK7VLHv7GUg0eF0iysp9FUvOsKhPL0Q=; b=oDOFsso1oulmGF7OCHchtw0sQ4
        r40s1WiTf/h7HVTKcLDhcZaqRZ6XP0tPerCoUygyJXOqT5pMMZZJR+dlUi7F5+qOxQ1+Q8MeRHETq
        36gXQ3WhWLtVkbfPPztjZToBYz8AYGMhCyM2NyK7WW3NAJnWBk+4HqxSjdqGAfat8Y+ucYbAsLar/
        xlvjZUID0TFHiSvNIZJThek/J37rSRWM00pbEmE06v0ekV29jiIgKQKzwFPImfClgpLip4Je49grO
        Mjbo5OGCnzOnZMAUt/PVl+iPrhWbGyaa9Vy5J/5YJ0U2vY29eGqcsI2th2AcCMpPToqDIVhVBtNYu
        3AqdpL5A==;
Received: from x5ce61d81.dyn.telefonica.de ([92.230.29.129]:56166 helo=[192.168.1.3])
        by host.euro-space.net with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.91)
        (envelope-from <kmarinushkin@birdec.tech>)
        id 1gMpMF-0001q0-MD; Wed, 14 Nov 2018 07:13:03 +0000
Subject: Re: Applied "ASoC: pcm3060: Add DT property for single-ended output"
 to the asoc tree
To:     Mark Brown <broonie@kernel.org>
Cc:     alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>,
        Takashi Iwai <tiwai@suse.com>, linux-kernel@vger.kernel.org
References: <20181114003707.4047B440078@finisterre.ee.mobilebroadband>
From:   Kirill Marinushkin <kmarinushkin@birdec.tech>
Message-ID: <56469208-7e28-6804-0a70-998b588a3c6a@birdec.tech>
Date:   Wed, 14 Nov 2018 08:15:11 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <20181114003707.4047B440078@finisterre.ee.mobilebroadband>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - host.euro-space.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - birdec.tech
X-Get-Message-Sender-Via: host.euro-space.net: authenticated_id: kmarinushkin@birdec.tech
X-Authenticated-Sender: host.euro-space.net: kmarinushkin@birdec.tech
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Mark,

Thank you for applying this patch series.

I think you forgot one patch in the series: patch [1] is a documentation for
patch [2]. It has a different naming scheme, because that's how the document [3]
recommends. That's why it was not obvious that they relate to each other.

Document [3] also says:

> The Documentation/ portion of the patch should come in the series before
> the code implementing the binding.

Therefore, could you to apply patch [1] to the same branch as [2]?

Best Regards,
Kirill

[1] [PATCH v2 1/3] dt-bindings: sound: Add documentation for pcm3060 property
    out-single-ended
[2] [PATCH v2 2/3] ASoC: pcm3060: Add DT property for single-ended output
[3] Documentation/devicetree/bindings/submitting-patches.txt

On 11/14/18 01:37, Mark Brown wrote:
> The patch
> 
>    ASoC: pcm3060: Add DT property for single-ended output
> 
> has been applied to the asoc tree at
> 
>    https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 
> 
> All being well this means that it will be integrated into the linux-next
> tree (usually sometime in the next 24 hours) and sent to Linus during
> the next merge window (or sooner if it is a bug fix), however if
> problems are discovered then the patch may be dropped or reverted.  
> 
> You may get further e-mails resulting from automated or manual testing
> and review of the tree, please engage with people reporting problems and
> send followup patches addressing any issues that are reported if needed.
> 
> If any updates are required or you are submitting further changes they
> should be sent as incremental updates against current git, existing
> patches will not be replaced.
> 
> Please add any relevant lists and maintainers to the CCs when replying
> to this mail.
> 
> Thanks,
> Mark
> 
> From b1c0000bde8fb287f4fd3493ca4167efee344c3e Mon Sep 17 00:00:00 2001
> From: Kirill Marinushkin <kmarinushkin@birdec.tech>
> Date: Mon, 12 Nov 2018 08:08:33 +0100
> Subject: [PATCH] ASoC: pcm3060: Add DT property for single-ended output
> 
> DAC output may be differential (default) or single-ended.
> 
> Signed-off-by: Kirill Marinushkin <kmarinushkin@birdec.tech>
> Signed-off-by: Mark Brown <broonie@kernel.org>
> ---
>  sound/soc/codecs/pcm3060.c | 14 ++++++++++++++
>  sound/soc/codecs/pcm3060.h |  1 +
>  2 files changed, 15 insertions(+)
> 
> diff --git a/sound/soc/codecs/pcm3060.c b/sound/soc/codecs/pcm3060.c
> index 771b46e1974b..1dd851a7b43b 100644
> --- a/sound/soc/codecs/pcm3060.c
> +++ b/sound/soc/codecs/pcm3060.c
> @@ -270,9 +270,23 @@ EXPORT_SYMBOL(pcm3060_regmap);
>  
>  /* device */
>  
> +static void pcm3060_parse_dt(const struct device_node *np,
> +			     struct pcm3060_priv *priv)
> +{
> +	priv->out_se = of_property_read_bool(np, "ti,out-single-ended");
> +}
> +
>  int pcm3060_probe(struct device *dev)
>  {
>  	int rc;
> +	struct pcm3060_priv *priv = dev_get_drvdata(dev);
> +
> +	if (dev->of_node)
> +		pcm3060_parse_dt(dev->of_node, priv);
> +
> +	if (priv->out_se)
> +		regmap_update_bits(priv->regmap, PCM3060_REG64,
> +				   PCM3060_REG_SE, PCM3060_REG_SE);
>  
>  	rc = devm_snd_soc_register_component(dev, &pcm3060_soc_comp_driver,
>  					     pcm3060_dai,
> diff --git a/sound/soc/codecs/pcm3060.h b/sound/soc/codecs/pcm3060.h
> index fd89a68aa8a7..c895cf40ee10 100644
> --- a/sound/soc/codecs/pcm3060.h
> +++ b/sound/soc/codecs/pcm3060.h
> @@ -25,6 +25,7 @@ struct pcm3060_priv_dai {
>  struct pcm3060_priv {
>  	struct regmap *regmap;
>  	struct pcm3060_priv_dai dai[PCM3060_DAI_IDS_NUM];
> +	u8 out_se: 1;
>  };
>  
>  int pcm3060_probe(struct device *dev);
> 
