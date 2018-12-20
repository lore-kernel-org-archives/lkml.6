Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FBD6C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 15:07:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECC1C21720
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 15:07:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545318446;
	bh=xnlPTArTKkuoQaKLeIhrXo6BiYmCU8pF/VZkPDOteQs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=AS7lq1Q0JsHAuC7ugAsX5XuPhWtvWVnWLxwI72v7jNoQSDvZfgAp+NMxezM/O+/iG
	 +OY3Ho1x+B+mrEY4JhuvO+q9wlphreWfkIS8Kb5IDv0ucvUJ+LwneOja0KuhQ5vCLQ
	 D6jU4jSNekgKAUp9bRkcLqWLLFWtgGtJU2Nyc4RA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731023AbeLTPHZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 10:07:25 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:42174 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730536AbeLTPHY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 10:07:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=FTBfCPsDaptKpOmyncTF35ttM7t0jibRMEu63FLnH9I=; b=hWR5FSCHsZnF3tIM++WMIKA8S
        /35E2UOUIeTnJ6g1saZYUrVlhDH6XHVWO5Sbs1+MO0ktb7jBSjkAKLSMR2bx0FZhsSEW6tB6W5ZCv
        b48MAl/d+H7ZWL/rlVZrEkSM0hEYrekXiT+k7AtcYIp88fT7RBw+w6sp5ZU/42necafDw=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gZzub-0003ix-BD; Thu, 20 Dec 2018 15:06:57 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id E074A1121B93; Thu, 20 Dec 2018 15:06:56 +0000 (GMT)
Date:   Thu, 20 Dec 2018 15:06:56 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Maruthi Srinivas Bayyavarapu 
        <maruthi.srinivas.bayyavarapu@xilinx.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Vishal Sagar <vsagar@xilinx.com>,
        Michal Simek <michal.simek@xilinx.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 2/3] ASoC: xlnx: add pcm formatter platform driver
Message-ID: <20181220150656.GB9325@sirena.org.uk>
References: <1545239949-112845-1-git-send-email-maruthi.srinivas.bayyavarapu@xilinx.com>
 <1545239949-112845-3-git-send-email-maruthi.srinivas.bayyavarapu@xilinx.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="E39vaYmALEf/7YXx"
Content-Disposition: inline
In-Reply-To: <1545239949-112845-3-git-send-email-maruthi.srinivas.bayyavarapu@xilinx.com>
X-Cookie: Truth is free, but information costs.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--E39vaYmALEf/7YXx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Dec 19, 2018 at 10:49:08PM +0530, Maruthi Srinivas Bayyavarapu wrote:

This looks mostly good, a few small things but all pretty trivial:

> +	switch (bits_per_sample) {
> +	case 8:
> +		val |= (BIT_DEPTH_8 << AUD_CTRL_DATA_WIDTH_SHIFT);
> +		break;
> +	case 16:
> +		val |= (BIT_DEPTH_16 << AUD_CTRL_DATA_WIDTH_SHIFT);
> +		break;
> +	case 20:
> +		val |= (BIT_DEPTH_20 << AUD_CTRL_DATA_WIDTH_SHIFT);
> +		break;
> +	case 24:
> +		val |= (BIT_DEPTH_24 << AUD_CTRL_DATA_WIDTH_SHIFT);
> +		break;
> +	case 32:
> +		val |= (BIT_DEPTH_32 << AUD_CTRL_DATA_WIDTH_SHIFT);
> +		break;
> +	}

It'd be better to have a default case returning an error for unsupported
sample sizes.

> +		ret = devm_request_irq(dev, aud_drv_data->mm2s_irq,
> +				       xlnx_mm2s_irq_handler, 0,
> +				       "xlnx_formatter_pcm_mm2s_irq", dev);
> +		if (ret) {
> +			dev_err(dev, "xlnx audio mm2s irq request failed\n");
> +			goto clk_err;
> +		}
> +		ret = xlnx_formatter_pcm_reset(aud_drv_data->mmio +
> +					       XLNX_MM2S_OFFSET);
> +		if (ret) {
> +			dev_err(dev, "audio formatter reset failed\n");
> +			goto clk_err;
> +		}
> +		xlnx_formatter_disable_irqs(aud_drv_data->mmio +
> +					    XLNX_MM2S_OFFSET,
> +					    SNDRV_PCM_STREAM_PLAYBACK);

This requests the interrupt before we've reset and quiesced the hardware
meaning the interrupt could fire immediately on request with the
hardware in an unknown state; it'd be better to reset the hardware first
then request the interrupt to minimize the risk that something goes
wrong with the handler.

> +	dev_info(dev, "pcm platform device registered\n");
> +	return 0;

This is just adding noise to the log.

--E39vaYmALEf/7YXx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlwbsBAACgkQJNaLcl1U
h9Cpegf/WpTeT0YeDGH0yu/OmjEIpOjD5J8UooYjuzyLJCdKXLgfQy+I8gCQhe2M
Y+gOMrV1HtL2EayxfPee5P00+H/4RfTZ63nDEJY/SAQTRS7CA93lmYVqMAwPSm6/
mzeQmaawJJMPSK2dZFDwU9mafYaJzEiItW/eKFpUPbQSdqhCLHu41yaLGdxouvNv
ZaUOeOkI/y0w//PUWnJFlO2ddPjhC6PcdtkOstzxKzSTVu6tYrHZE0R4nBiAh4+S
SEdqbixMoAnuq9g2MfKzs1jopzMOpNjmcBpEE858EbZyOzG9b1gcHyxu21ldu2VQ
cPdurnYOp1tr986M/Y9yTc8PhxJoAg==
=sW2Y
-----END PGP SIGNATURE-----

--E39vaYmALEf/7YXx--
