Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751461AbeEDPKE (ORCPT <rfc822;w@1wt.eu>);
        Fri, 4 May 2018 11:10:04 -0400
Received: from mail.bootlin.com ([62.4.15.54]:35513 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750707AbeEDPKC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 May 2018 11:10:02 -0400
Date: Fri, 4 May 2018 17:10:00 +0200
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Icenowy Zheng <icenowy@aosc.io>
Cc: Rob Herring <robh+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Linus Walleij <linus.walleij@linaro.org>, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-sunxi@googlegroups.com
Subject: Re: [PATCH 5/7] arm64: allwinner: h6: add R_INTC interrupt controller
Message-ID: <20180504151000.uuvd54nzxe6p7b2f@flea>
References: <20180503183847.11046-1-icenowy@aosc.io>
 <20180503183847.11046-6-icenowy@aosc.io>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="udvzld57c3qc4wzk"
Content-Disposition: inline
In-Reply-To: <20180503183847.11046-6-icenowy@aosc.io>
User-Agent: NeoMutt/20180323
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--udvzld57c3qc4wzk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 04, 2018 at 02:38:45AM +0800, Icenowy Zheng wrote:
> Allwinner H6 SoC has also a R_INTC interrupt controller like Allwinner
> A64 SoC, but has its base address changed due to the memory map change
> in H6.
>=20
> Add it into the device tree.
>=20
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>

Applied, thanks!
Maxime

--=20
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com

--udvzld57c3qc4wzk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAlrsd8cACgkQ0rTAlCFN
r3Sf+A/+KMh1ATndsQ90KuLyl3An7APwcAT1Hv2ZeqQoae34c9TJMEJQ7t1zx2hP
z2zroWAD60eimMS8AqPKhZBN6uETkkA9z1nJOo4J/kGJHKJkN5bcaI1hxJMVuMQ2
s6WYqGzn6lnWc94l/Wi8+22Xh6qaR+OB57ImgKi3lWdZFLAn8gNP3fLBGfgOsVjq
ozUBQm/5lb8YmtXT4s5kYMBpYLYfUVBXVsdiR6o7YixcEeMsHyMwcdVyVlMWWhqi
VwtdUg2W1+Ey1Zo55rcFURVfRKf4tbF/CjFz5avUgeA1+C5DrS8emnQUivC/xeSG
jSBC8uidNRgfkT/evUpKXChejw4xxQu/vr45QNxVUTEfnnR48V7gL1vBt1vnTDkG
WqT67Ls2fULzFVbrUzhj3CkYcgOXMtKhRTADhFdfOfilHhSSwTKec/hvicoYqRxP
HZWuVdktKM3IlEqYKvlVegjSpW6JROoLd+wa3E1eb/z6WTGOrKAxTpRsjO7inW6Y
cmYTTuDETHP3tWTseJgFH9bvd3CJnjSQcpJr0iADMudw7lCSoRx6/NDwaxGrFZtx
HToJ1173kEnQldE3TmqnHafKrawl+qTOD9NGorf5LuN9UuCS3SorQfHc789IHDee
7Uw1BUNptdukt6df1G+iglKsUTtKmUXcwXTVH6m9VmTGOB2SBFo=
=od6U
-----END PGP SIGNATURE-----

--udvzld57c3qc4wzk--
