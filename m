Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753616AbeDSOHZ (ORCPT <rfc822;w@1wt.eu>);
        Thu, 19 Apr 2018 10:07:25 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:45570 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753228AbeDSOHV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Apr 2018 10:07:21 -0400
Date: Thu, 19 Apr 2018 15:07:14 +0100
From: Mark Brown <broonie@kernel.org>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: Nicolas Ferre <nicolas.ferre@microchip.com>,
        Radu Pirea <radu.pirea@microchip.com>, robh+dt@kernel.org,
        mark.rutland@arm.com, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 2/3] dt-bindings: add binding for at91-usart in spi mode
Message-ID: <20180419140714.GF27188@sirena.org.uk>
References: <20180413161117.20274-1-radu.pirea@microchip.com>
 <20180413161117.20274-3-radu.pirea@microchip.com>
 <20180413162327.GE22187@piout.net>
 <8e6c447d-dce5-f9af-e5b2-8d1d863159d6@microchip.com>
 <20180413181251.GG22187@piout.net>
 <20180417110358.GD8973@sirena.org.uk>
 <20180419133233.GE7369@piout.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="NQTVMVnDVuULnIzU"
Content-Disposition: inline
In-Reply-To: <20180419133233.GE7369@piout.net>
X-Cookie: We've upped our standards, so up yours!
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--NQTVMVnDVuULnIzU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Apr 19, 2018 at 03:32:33PM +0200, Alexandre Belloni wrote:

> My suggestion was to add an MFD driver that would match the current
> compatible and either have an atmel,usart-mode property or maybe more
> risky, check whether there are children nodes. Based on that, the
> correct platform device can be added, either an usart or an spi master
> device can be registered.

Yeah, that's another approach which could work and is a bit easier from
the DT point of view - the PXA stuff predated DT and was adapted into
it.

--NQTVMVnDVuULnIzU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlrYopEACgkQJNaLcl1U
h9B0iwf8DJAbNZ57AaIWFWCNwfrF/crGozXn98JaRznV9iFV3ikqGyDH+Yk8JdH/
lWGLneeoz7HTOgSLAaQn3bRcH/K6ZDjXCQQMV9ckGHpbFdkTzbPPXWLmUTn20Hw2
X314CE8FCvD4dUmTOJYHAzexxisLd9GJ5qnEIoyzKMN7ju8i3G2kqFhFudfZhMEe
tlqqAf+FxU8eDwBw+usszBivKsKz3wpV1/GDOK0MQTlqF6elrehlL5HgOufTwMWZ
zVg6ddRxl3bwt2oS7czToe91E1yAvXRDQiqeRAyoIMdxKt8N9soH1x3PaC+vbEMt
a2W+2YsaTZyawtHffcVNmrKQwu59QQ==
=54d/
-----END PGP SIGNATURE-----

--NQTVMVnDVuULnIzU--
