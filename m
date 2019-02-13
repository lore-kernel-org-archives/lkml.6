Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CA57C282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 12:20:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BEDB5222B1
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 12:20:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550060429;
	bh=Joj+7VQ5RCUEzFPTSYvT6xlJ5etrpth6uhAuKIcZb2k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=H6jYSt3Zs8edh0Kzd0H16qxij+J4E90p4a4tTfMRSzOH5J3NoAzLKITnO/1u5VT5w
	 SjIUeI/5PjlGkO/d7NaJCi9Rcu1C0tms7JOerfM2K9IyTZGQA+dGYxsLTUsSuiJpUV
	 30DbtnuX20klfHquH2scFAN3Q4PgFRbC/5yRecTE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404042AbfBMMU2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 07:20:28 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:38180 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730329AbfBMMU1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 07:20:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=n8CCJEE5qJrEvvsUxRv+p43JH3L72pQLMLiqZ0Ye+Eg=; b=EX1d/sv4SQuuSFiLSAvsPEHLF
        Pi+0IYbWcsvUMelC1fVfmO5ZrqD1tLAgPpGabfS3XXjOUndT3kvt32VezfSXwgFUbUsoKOxjeEcBM
        Wmzh2lVuqlPvHPhB3psqQarT8hmqIf6zc3mw1TfnyOvLWznb5FA/bBLJY8gsbnlsRBSak=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gttWO-0004GI-LW; Wed, 13 Feb 2019 12:20:12 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 328301128159; Wed, 13 Feb 2019 12:20:12 +0000 (GMT)
Date:   Wed, 13 Feb 2019 12:20:12 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Baolin Wang <baolin.wang@linaro.org>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, orsonzhai@gmail.com,
        zhang.lyra@gmail.com, lanqing.liu@unisoc.com,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/3] spi: sprd: spi: sprd: Add DMA mode support
Message-ID: <20190213122012.GE7540@sirena.org.uk>
References: <11e55b5f9b0d83649a5b81c7e3fdb667cd3ddc5b.1550043082.git.baolin.wang@linaro.org>
 <3f9d23d4b250c5046f8c3411606aa9ffe807edd8.1550043082.git.baolin.wang@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="gMR3gsNFwZpnI/Ts"
Content-Disposition: inline
In-Reply-To: <3f9d23d4b250c5046f8c3411606aa9ffe807edd8.1550043082.git.baolin.wang@linaro.org>
X-Cookie: Nothing is but what is not.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--gMR3gsNFwZpnI/Ts
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Feb 13, 2019 at 03:36:11PM +0800, Baolin Wang wrote:

> +enum sprd_spi_dma_channel {
> +	SPI_RX,
> +	SPI_TX,
> +	SPI_MAX,
> +};

It'd have been better to namespace these (SPRD_SPI_ or something) in
case of conflicts.  That's really minor though and everything else looks
good so I'll go ahead and apply, thanks!

--gMR3gsNFwZpnI/Ts
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlxkC3sACgkQJNaLcl1U
h9CuBAf/dxGjyh/qcii3tgS/K0gNwj7+wo5ZZcI1DGGxewwd6fBiFLO0RRjy2Twz
M/+PxIm4IZyYuCRDhhgSym5gE5LpJQZCPtIKaEladCecjWcYiOTNPwpvZwTxI/jy
QgyfOn3qfQllW/xnUrvKffxxBFX30a3qwui9glhJmpmsxvMHau49wEAgOEDql+KO
TiFNAckqKlBrLQagonHd36kfp2zncx1Pp4drhk0SaKJ03wu7R5Gl0LpheQDt97Ae
Hs+6XbjKYjDZZmiTV1PmHUxzrHp9AHv+mgW36SDh0b4rd0JJTsaMf7Tsny3MWU0t
tTZYrk5YCvvzQOcTAR4FYykSY/GrkQ==
=x+WH
-----END PGP SIGNATURE-----

--gMR3gsNFwZpnI/Ts--
