Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1033212AbeBNRAt (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 12:00:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:46028 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1032961AbeBNRAr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 12:00:47 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F5AB2177D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=jhogan@kernel.org
Date: Wed, 14 Feb 2018 17:00:42 +0000
From: James Hogan <jhogan@kernel.org>
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 6/8] MIPS: mscc: add ocelot PCB123 device tree
Message-ID: <20180214170042.GE3986@saruman>
References: <20180116101240.5393-1-alexandre.belloni@free-electrons.com>
 <20180116101240.5393-7-alexandre.belloni@free-electrons.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="hwvH6HDNit2nSK4j"
Content-Disposition: inline
In-Reply-To: <20180116101240.5393-7-alexandre.belloni@free-electrons.com>
User-Agent: Mutt/1.7.2 (2016-11-26)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--hwvH6HDNit2nSK4j
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 16, 2018 at 11:12:38AM +0100, Alexandre Belloni wrote:
> Add a device tree for the Microsemi Ocelot PCB123 evaluation board.
>=20
> Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>

Please Cc DT folk.

> diff --git a/arch/mips/boot/dts/mscc/ocelot_pcb123.dts b/arch/mips/boot/d=
ts/mscc/ocelot_pcb123.dts
> new file mode 100644
> index 000000000000..42bd404471f6
> --- /dev/null
> +++ b/arch/mips/boot/dts/mscc/ocelot_pcb123.dts
> @@ -0,0 +1,27 @@
> +/* SPDX-License-Identifier: (GPL-2.0 OR MIT) */
> +/* Copyright (c) 2017 Microsemi Corporation */
> +
> +/dts-v1/;
> +
> +#include "ocelot.dtsi"
> +
> +/ {
> +	compatible =3D "mscc,ocelot-pcb123", "mscc,ocelot";

Should mscc,ocelot-pcb123 be added to the mscc DT binding documentation
in the other patch?

Cheers
James

--hwvH6HDNit2nSK4j
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEd80NauSabkiESfLYbAtpk944dnoFAlqEazoACgkQbAtpk944
dnocQw//fpcnqfZS66x7TEp9LKICny/fGLn9eDLZt5hCK51w8AIdSbGdLQ4V6pB5
ps7LiLJ83HQ6+6FmITB8YIXPNQo4k2Ay8WCQbx2ONXEED2G4dcfJlTZq0n6Kc2Iz
WZto+AxV3f8bQstfxXJ1bXGsnUZ4XxpXLm2oebW319YZJWDJgeamCNxnCcQfOkvP
1chpa9covZToaGKeZkt/PiwVn8kXvUt8YtNq1DuyjlxRkYZw0dpVyrcTUjz3c8Qg
DwrIJgv4Xos2IjW1PNlvcEodx6PneXxrITyLsY4K/ojwo32QLTFpsAIOprrgnY0G
YEUsPe/nGXO1YiZc9uaugpoeZ9Z7uRTqMkJ1isQtTCE4QSws2ys0a23XvbkVX4k9
v/QuI4fhoFm2vzvXi1itctpPg6s16HhZbEy15bSjWwDHe+iB17dIUiHDVp0UyT5/
bi4rEw5yjS4Q/lXxWoIw4mC0NSzuxYzVn6hqp0bKdp4mXwkVKngDj6BF3U7MOKO/
hxHQqaW4tuIkQIzzRLwBvsR3XHRupIs5G5HTrLWT807Ot2WeQ6l3+2KSfScnozqx
F/Vduu6ygFJIhdK5sNNIJKe7bHNp2AgF0ggxA8Mw9rN/SrjtKhSsEoyXFhXp404a
uwHhISjmNZdYzsVzvy8TuBy0HqUSwOhZV2o2KQ69tYIXO929j0Q=
=DpII
-----END PGP SIGNATURE-----

--hwvH6HDNit2nSK4j--
