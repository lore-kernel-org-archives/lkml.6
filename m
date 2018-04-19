Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753202AbeDSOzc (ORCPT <rfc822;w@1wt.eu>);
        Thu, 19 Apr 2018 10:55:32 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:41700 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752144AbeDSOza (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Apr 2018 10:55:30 -0400
Date: Thu, 19 Apr 2018 15:55:23 +0100
From: Mark Brown <broonie@kernel.org>
To: Radu Pirea <radu.pirea@microchip.com>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>, robh+dt@kernel.org,
        mark.rutland@arm.com, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 2/3] dt-bindings: add binding for at91-usart in spi mode
Message-ID: <20180419145523.GH27188@sirena.org.uk>
References: <20180413161117.20274-1-radu.pirea@microchip.com>
 <20180413161117.20274-3-radu.pirea@microchip.com>
 <20180413162327.GE22187@piout.net>
 <8e6c447d-dce5-f9af-e5b2-8d1d863159d6@microchip.com>
 <20180413181251.GG22187@piout.net>
 <20180417110358.GD8973@sirena.org.uk>
 <68cdbb8b60c32980caa7b130409d05d28788edd9.camel@microchip.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="PW0Eas8rCkcu1VkF"
Content-Disposition: inline
In-Reply-To: <68cdbb8b60c32980caa7b130409d05d28788edd9.camel@microchip.com>
X-Cookie: We've upped our standards, so up yours!
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--PW0Eas8rCkcu1VkF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Apr 19, 2018 at 01:04:16PM +0300, Radu Pirea wrote:

> Thank you for suggestions. I followed your advice and looked at PXA SSP
> driver. In my opinion it is a layer that avoids collsions and
> unfortunately complicates things a bit. My ideea is to keep the things
> as simple as possible. For example, I can enhance usart-serial and
> usart-spi drivers to print detailed messages if probe fails because one
> driver tries to request a memory region already used by another driver.
> What do you think? Is this approach a good way to move forward?

Alexandre's suggestion using a MFD with a property to select the mode
seems more solid TBH.

--PW0Eas8rCkcu1VkF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlrYrdsACgkQJNaLcl1U
h9CMZAf9GecsYu4xXaOVqUz0a0cx6h608umvha/JVWSZkxiQ/wfRaegqAE/FLR7t
InctEm95jQ0cTn07XxLwOCEUrW2KzacBq4Ivv+5vbFQU7mDBSRDHhKZwlOPzPGfG
ebSQ/pFduE9Uhxs73RbY5F5xa3nLDPa6almsZeqv5T3C80TEdtxPk6uJhKDqDt44
CEqiNJVtfXoFlFsNJjS/qnLPTou63bOVRkcY0VBlycNBb2AR0qPN7SUQKvVNrQwo
aT3v4xlOJQv3UCScITTw9G5/mVcgETvbhlJpufyNCd5zv1ocFVpQy3Em9HdG1T4o
hftd8yd9tQPMIX7bt12eonRCWE2Zeg==
=p/IG
-----END PGP SIGNATURE-----

--PW0Eas8rCkcu1VkF--
