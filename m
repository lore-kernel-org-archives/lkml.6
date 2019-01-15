Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D181C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 14:25:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D08FD20866
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 14:25:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547562305;
	bh=AS8fPZx09u9Memo4DjJSKMzTNFOWHoATd2o8KbLVHl8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ntdslysuSEg9sbkBfH8whEenb7Ct0JesFWLntSu9MKLaYI/UXaD+ujUdtnt6HtCDC
	 21fPO5gYxhUQTTmTKIUV76XzDxWaSna3mqFveGklhvfJC/KUogkn9M2nxwpxt9iWEL
	 gki3skjHsLStXQvxqOAfvfTkGjGxOyIv8uXUlcvQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730342AbfAOOZF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 09:25:05 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:32846 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727574AbfAOOZD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 09:25:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=DrWM2TYp01Hb/9SMq6G1LGGAVaQ0o4kL5/Rut7tJG4o=; b=eD5CqffcHSv5SK1z6qOtRE8cn
        ttmd8oNu8FcVjCw3fieaBapIp0n4eUC8rhh7ydUGFJrdqVSa3eN8DxNDpvmliPkGqMobn1XLZ+9yi
        8T4VHpSRxQDSoLGzcZMOr0A5QiZtdxhHzzi1rwXv+OzjFOpf4Kf2oDY0vZrK0suzYPWvs=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gjPe8-000843-Se; Tue, 15 Jan 2019 14:24:52 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 44B9A1127848; Tue, 15 Jan 2019 14:24:52 +0000 (GMT)
Date:   Tue, 15 Jan 2019 14:24:52 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Baolin Wang <baolin.wang@linaro.org>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, orsonzhai@gmail.com,
        zhang.lyra@gmail.com, lanqing.liu@unisoc.com,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] spi: sprd: Add the SPI irq function for the SPI DMA
 mode
Message-ID: <20190115142452.GA5522@sirena.org.uk>
References: <ab49bb74e921474aa9390f81cdf65f32c3d9d898.1547559542.git.baolin.wang@linaro.org>
 <ec1741f29c44c436c1086877ff5b208e6b8af45d.1547559542.git.baolin.wang@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="oyUTqETQ0mS9luUI"
Content-Disposition: inline
In-Reply-To: <ec1741f29c44c436c1086877ff5b208e6b8af45d.1547559542.git.baolin.wang@linaro.org>
X-Cookie: Violence is molding.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--oyUTqETQ0mS9luUI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jan 15, 2019 at 09:46:51PM +0800, Baolin Wang wrote:

This looks good, just one small issue and a thing to check:

> +static irqreturn_t sprd_spi_handle_irq(int irq, void *data)
> +{
> +	struct sprd_spi *ss = (struct sprd_spi *)data;
> +	u32 val = readl_relaxed(ss->base + SPRD_SPI_INT_MASK_STS);
> +
> +	if (val & SPRD_SPI_MASK_TX_END) {
> +		writel_relaxed(SPRD_SPI_TX_END_CLR, ss->base + SPRD_SPI_INT_CLR);
> +		if (!(ss->trans_mode & SPRD_SPI_RX_MODE))
> +			complete(&ss->xfer_completion);
> +		return IRQ_HANDLED;
> +	}
> +
> +	if (val & SPRD_SPI_MASK_RX_END) {
> +		writel_relaxed(SPRD_SPI_RX_END_CLR, ss->base + SPRD_SPI_INT_CLR);
> +		complete(&ss->xfer_completion);
> +	}
> +
> +	return IRQ_HANDLED;
> +}

This will return IRQ_HANDLED no matter if there was an interrupt
actually handled.  That means that if something goes wrong due to some
bug or a hardware change (eg, a new version of the IP) and there's
another interrupt fired we won't clear it and the interrupt core won't
be able to detect that it's a spurious interrupt and use its own error
handling.  It's better to return IRQ_NONE in that case.

> +	ret = devm_request_irq(&pdev->dev, ss->irq, sprd_spi_handle_irq,
> +				0, pdev->name, ss);
> +	if (ret)
> +		dev_err(&pdev->dev, "failed to request spi irq %d, ret = %d\n",
> +			ss->irq, ret);

Are you sure it's safe to use devm_request_irq(), especially when
unloading the driver?  Using it means that we will only disable the
interrupt after the driver's remove function has finished so there's a
danger of an interrupt firing when some of the resources the hander has
used are still in use.  I didn't spot any issues, just something to
check especially with the later patches building on top of this.

--oyUTqETQ0mS9luUI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlw97TMACgkQJNaLcl1U
h9BFNwf9HP3Z+bpkgsUNL5XdG5PvKTnwIdDpVQSXq4JNtppq2ITkJ7VxbDbJ3+1l
8dK4dnT6wX3+/dib9ky626PIovD+WkchDpQYKud/tb4ZsKwmhJ5OhfxLd/2rQOOF
eeYdFPiKHai0NzIdZpOga6orkDvjgM860VSh7Ylfl2iJ13cZGoR8Jnxo+Sa+huPg
lxphZAUJWUjFVeU0fetbyVb8iY89ovgBUMtzJ5xcWzdLXiLi3yT2s8NGrTtDxS2u
QVhJulPTxjxJ694mGH2mPz8hda+7uw/IT8sjk8bd3MmK/efl6CEZ5B1frzIm85Jg
pDm8Fno1/aJOZ339cLVOo5pjwxtJ2g==
=cuso
-----END PGP SIGNATURE-----

--oyUTqETQ0mS9luUI--
