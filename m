Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752417AbeENVrm (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 17:47:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:60942 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752011AbeENVrk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 17:47:40 -0400
Date: Mon, 14 May 2018 22:47:35 +0100
From: James Hogan <jhogan@kernel.org>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>,
        "David S . Miller" <davem@davemloft.net>,
        Allan Nielsen <Allan.Nielsen@microsemi.com>, razvan.stefanescu@nxp.com,
        po.liu@nxp.com, Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Florian Fainelli <f.fainelli@gmail.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mips@linux-mips.org
Subject: Re: [PATCH net-next v3 0/7] Microsemi Ocelot Ethernet switch support
Message-ID: <20180514214734.GB29541@jamesdev>
References: <20180514200500.2953-1-alexandre.belloni@bootlin.com>
 <20180514205844.GG1057@lunn.ch>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="bCsyhTFzCvuiizWE"
Content-Disposition: inline
In-Reply-To: <20180514205844.GG1057@lunn.ch>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--bCsyhTFzCvuiizWE
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 14, 2018 at 10:58:44PM +0200, Andrew Lunn wrote:
> Hi Alexandre
> >=20
> > The ocelot dts changes are here for reference and should probably go
> > through the MIPS tree once the bindings are accepted.
>=20
> For your next version, you probably want to drop those patches, so
> that David can apply the network patches to net-next.

Since it sounds like the net patches are ready now, I'll apply the MIPS
DTS ones for 4.18.

Thanks
James

--bCsyhTFzCvuiizWE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYIAB0WIQS7lRNBWUYtqfDOVL41zuSGKxAj8gUCWvoD9QAKCRA1zuSGKxAj
8l6fAQCuGpJjEOto9b3UOmR7TvOLsGFlm/DBKjHz5NONozRKmAEAkyvOnQnccFsc
xJ4i2tuIwAqXO+rCOHn6V8wHKzKZjAw=
=bOdD
-----END PGP SIGNATURE-----

--bCsyhTFzCvuiizWE--
