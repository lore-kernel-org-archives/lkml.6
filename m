Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19897C282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 11:56:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D622A222B2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 11:56:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550059012;
	bh=lEHTEwx8LjfWPDnCIJL0kg24n/DJWgYAHayPimS1RpY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=s+eGxzhKNRvz2h92ZSslJcaWQBDVUNeNTRLWrIhkAFkBnbgXTHPNV6gsU4uCqvW95
	 lMQz+FOAZY9tHrjCUtnf04uXnuC8S5emrhmz+JLpX9Y7jtiE2inBaI/GIhQ0VGSdmN
	 DIicVTf1nz9hFaWAZ+pi1FiysWE8zkzl1aFm0h1c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391986AbfBML4v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 06:56:51 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:54994 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726882AbfBML4u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 06:56:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=lEHTEwx8LjfWPDnCIJL0kg24n/DJWgYAHayPimS1RpY=; b=O2mhGTXvRGaeKnIhhWjz6Q2Ei
        ZnFCMA+lfXzS4CpcmZTBs+OlzokDFkesffafPVoF29vVBvRb+o4U1fqakfyJkCCxqG4k5Qp+qdAEp
        eGAZaKa6y+5Cs40w9Hz+YIohGw4pCLqHPXf47mJelNv6/Ck5eM1N6/t+JnGSpN7grN+GI=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gtt9e-00048c-RE; Wed, 13 Feb 2019 11:56:42 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 338E21128158; Wed, 13 Feb 2019 11:56:42 +0000 (GMT)
Date:   Wed, 13 Feb 2019 11:56:42 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Stefan Agner <stefan@agner.ch>
Cc:     Shawn Guo <shawnguo@kernel.org>, s.hauer@pengutronix.de,
        Trent Piepho <tpiepho@impinj.com>, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        devicetree@vger.kernel.org, fabio.estevam@nxp.com,
        mark.rutland@arm.com, linux-arm-kernel@lists.infradead.org,
        kernel@pengutronix.de
Subject: Re: [PATCH 2/2] ARM: dts: imx7: add DMA properties for ECSPI
Message-ID: <20190213115642.GC7540@sirena.org.uk>
References: <20190107132226.16216-1-stefan@agner.ch>
 <20190107132226.16216-2-stefan@agner.ch>
 <1549573243.3075.72.camel@impinj.com>
 <20190211012305.GA21496@dragon>
 <c8677ded56c2fc7c1d375816f1dd8d66@agner.ch>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="R+My9LyyhiUvIEro"
Content-Disposition: inline
In-Reply-To: <c8677ded56c2fc7c1d375816f1dd8d66@agner.ch>
X-Cookie: Nothing is but what is not.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--R+My9LyyhiUvIEro
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Feb 12, 2019 at 08:20:46PM +0100, Stefan Agner wrote:

> > I dropped both patches from my tree.

> I think this is the wrong approach to disable DMA on those devices. The
> device tree is supposed to describe the complete hardware. If the driver
> is not ready to support DMA for that particular variant, we should add
> this information in the driver. We have compatible strings for i.MX
> 6UL/i.MX 7 to disable DMA accordingly.

Yes, that seems sensible - it's vanishingly unlikely that there's any
problem in the hardware here, it's software bugs and quirking in the
driver seems better than changing the DT.

--R+My9LyyhiUvIEro
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlxkBfkACgkQJNaLcl1U
h9AVqwf+JOiZLu406UOLhIQJf6RMKFfrh1E7dVOI4A8MUZhEkZ4t3RHBOPpFJILe
xRdXkUyv12y6dk81ztTLFnZH1eK6jN4J7j9ETei5mfJ6KrJc93PzyHZhD/pQvBk0
Q64HFEg0uE6b4hK0OhEjMl/02xVgRWhEQkENwWoX7JLKL3Zo0ZYOVIg+LJyk3jux
tCgZBq5OPlANasZ6PYXg3iqlVOPyhnPRjggu4ILoUhB83ukKTOIp5ZoKJq7f/kwT
JpS15NDnUVYVp8NDwwqBGXpoZEdTPaHCYxX2Uetm8jPF/6KYlYWvKqjSOqs+Nu5j
iEoDyWU56KtZZ4OhQYdGkuBxYWhDcg==
=bamr
-----END PGP SIGNATURE-----

--R+My9LyyhiUvIEro--
