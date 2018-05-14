Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752194AbeENWYO (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 18:24:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:39704 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752009AbeENWYN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 18:24:13 -0400
Date: Mon, 14 May 2018 23:24:09 +0100
From: James Hogan <jhogan@kernel.org>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] mips: xilfpga: stop generating useless dtb.o
Message-ID: <20180514222408.GD29541@jamesdev>
References: <20180425211036.28509-1-alexandre.belloni@bootlin.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ylS2wUBXLOxYXZFQ"
Content-Disposition: inline
In-Reply-To: <20180425211036.28509-1-alexandre.belloni@bootlin.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ylS2wUBXLOxYXZFQ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 25, 2018 at 11:10:35PM +0200, Alexandre Belloni wrote:
> a dtb.o is generated from nexys4ddr.dts but this is never used since it h=
as
> been moved to mips/generic with commit b35565bb16a5 ("MIPS: generic: Add =
support
> for MIPSfpga")
>=20
> Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>

Both applied for 4.17, with fixes and stable tag (4.15+).

Thanks
James

--ylS2wUBXLOxYXZFQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYIAB0WIQS7lRNBWUYtqfDOVL41zuSGKxAj8gUCWvoMhwAKCRA1zuSGKxAj
8o5LAQCx99mPrHSF2UBUh4EWfEwNe3GSj/KUwchBE35anQSupAD/X02T1X+hD3p2
a1svYX02j994T1mH5L2jnjticVbuugI=
=8vL4
-----END PGP SIGNATURE-----

--ylS2wUBXLOxYXZFQ--
