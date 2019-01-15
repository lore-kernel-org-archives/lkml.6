Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F5F8C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 14:30:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 315B320866
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 14:30:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547562650;
	bh=1K+Gu58jKOu/0chqLgN4jEWhkizK7RPhc8P4b51gqdo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=WS3WZlpssn9OggfAsWMeyl9F3L3YSlr/NzQi0yWJROeSUZSVvNJ6hxyuS6qDzgF/q
	 tYfmil8o4HHCemUG6B2imhWV7shXOBPZ/uC2G1KWq5OFMD1MyAUG5Cy9pCmNqoDzjW
	 4ebpWhqHg3WSG0/udRKPAEAj63nOA/eNom+n+Gns=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730425AbfAOOas (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 09:30:48 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:42462 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726863AbfAOOas (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 09:30:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=MuPLHtZH7rlUgDXHBK3E6VgT2jKi13wCatC85bEvl7Q=; b=RnfAwpkb7TYNF3zKqsN72e9Wb
        tNsOPghxVd1aL78c65yputD4QGbkwmj9+/tJzR/3nrugSXIAswd8WRd9ATxqdP4qgm6H2/n+aCn0t
        x8elSJ+xTd0kFM5FLky69i/qPeEgqSSLXmw08kG0CUv7XWHGc4bRMgKXRccFxjnZMiXN0=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gjPjm-00085q-Th; Tue, 15 Jan 2019 14:30:42 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 67A661127848; Tue, 15 Jan 2019 14:30:42 +0000 (GMT)
Date:   Tue, 15 Jan 2019 14:30:42 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Baolin Wang <baolin.wang@linaro.org>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, orsonzhai@gmail.com,
        zhang.lyra@gmail.com, lanqing.liu@unisoc.com,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] spi: sprd: Add DMA mode support
Message-ID: <20190115143042.GB5522@sirena.org.uk>
References: <ab49bb74e921474aa9390f81cdf65f32c3d9d898.1547559542.git.baolin.wang@linaro.org>
 <324f3106dbff2f28baae098b05219f1384fda97a.1547559542.git.baolin.wang@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="9zSXsLTf0vkW971A"
Content-Disposition: inline
In-Reply-To: <324f3106dbff2f28baae098b05219f1384fda97a.1547559542.git.baolin.wang@linaro.org>
X-Cookie: Violence is molding.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--9zSXsLTf0vkW971A
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 15, 2019 at 09:46:53PM +0800, Baolin Wang wrote:
> From: Lanqing Liu <lanqing.liu@spreadtrum.com>
>=20
> Add DMA mode support for the Spreadtrum SPI controller, and we will enable
> SPI interrupt to help to complete the SPI transfer work in DMA mode.

Again this looks good, one thing to check though:

> +static bool sprd_spi_can_dma(struct spi_controller *sctlr,
> +			     struct spi_device *spi, struct spi_transfer *t)
> +{
> +	struct sprd_spi *ss =3D spi_controller_get_devdata(sctlr);
> +
> +	return ss->dma.enable;
> +}

Is it always a benefit to use DMA?  One reason this is a function rather
than just a property is that even if the device can DMA any size of
transfer often for short transfers the performance is better if you use
PIO since the overhead of setting up the DMA controller, waiting and
then taking the interrupt when it finishes ends up being more than the
cost of just reading and writing directly to the FIFOs for PIO.

--9zSXsLTf0vkW971A
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlw97pEACgkQJNaLcl1U
h9A9nAf+P9t2LyV+tEMCXlBQkjp0a/mBHna6R0+O2ldyqMIHvFWCYcTrED5sYgFq
ijPCK+i2c5VdbhxEtOfSgyijaElF1E4GT5rqHMGpcBOsnGHvx0CbLYniyg1WE1xB
nary/yQzFekPVbGunZnSQNcrIsgiKxBl5RuWhvzJH24X4uXNywQy0nr/ul3xgOcA
jIOvRfmPOz3M7Rus9RdD+f7pJpIfsgskY58QTR8xid+DyIUH7f2PttbcsAKwSHfB
Mq2EcAc9nDLP87ubjLGVc/E0JlSxeh5vunO5F/pmnJ1+2RPOvOBRXzYuexWG+uKN
B0jSxQRAynE4YApO1KR6NUFk3DU/JQ==
=1wSg
-----END PGP SIGNATURE-----

--9zSXsLTf0vkW971A--
