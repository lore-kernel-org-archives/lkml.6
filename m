Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934085AbeCGP4S (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 10:56:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:47462 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934094AbeCGP4N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 10:56:13 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4FBC2204EE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=jhogan@kernel.org
Date: Wed, 7 Mar 2018 15:56:07 +0000
From: James Hogan <jhogan@kernel.org>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: Ralf Baechle <ralf@linux-mips.org>,
        Allan Nielsen <Allan.Nielsen@microsemi.com>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v5 2/5] MIPS: mscc: add ocelot dtsi
Message-ID: <20180307155605.GS4197@saruman>
References: <20180306121607.1567-1-alexandre.belloni@bootlin.com>
 <20180306121607.1567-3-alexandre.belloni@bootlin.com>
 <20180307151753.GQ4197@saruman>
 <20180307152751.GM3035@piout.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="PhxIMoEr374zxJm2"
Content-Disposition: inline
In-Reply-To: <20180307152751.GM3035@piout.net>
User-Agent: Mutt/1.7.2 (2016-11-26)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--PhxIMoEr374zxJm2
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 07, 2018 at 04:27:51PM +0100, Alexandre Belloni wrote:
> On 07/03/2018 at 15:17:56 +0000, James Hogan wrote:
> > On Tue, Mar 06, 2018 at 01:16:04PM +0100, Alexandre Belloni wrote:
> > > diff --git a/arch/mips/boot/dts/mscc/ocelot.dtsi b/arch/mips/boot/dts=
/mscc/ocelot.dtsi
> > > new file mode 100644
> > > index 000000000000..8c3210577410
> > > --- /dev/null
> > > +++ b/arch/mips/boot/dts/mscc/ocelot.dtsi
> > > @@ -0,0 +1,117 @@
> > > +//SPDX-License-Identifier: (GPL-2.0 OR MIT)
> >=20
> > Niggle: there should be a space after // for consistency with other
> > files. Same in patch 3.
> >=20
>=20
> Ah, yes...
>=20
> If that is the only thing left, I can resend right away

There are a couple of irqchip patches from v2 which have gone from the
latest versions:
https://patchwork.linux-mips.org/project/linux-mips/list/?series=3D568

and the vendor prefix too from v4:
https://patchwork.linux-mips.org/project/linux-mips/list/?series=3D856

I presume they're all still relevant. Were you expecting the irqchip
ones to go through MIPS too? We'd need an ack from the irqchip folk if
so.

Cheers
James

--PhxIMoEr374zxJm2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEd80NauSabkiESfLYbAtpk944dnoFAlqgC5UACgkQbAtpk944
dnqpZxAAhdOHk4mQz5uDlvDsxv02A9Zn0D04DY5dAfGqYa6PoqNNrx7+Mj0rxo5s
G0LweMNaHETxNlIae1bbOEF0FqT3jlRw4t6QQE4cdBYKq+v02rcmCCKlSPBLACSy
gVpvSvl9QU3bJjMFErUTtboS3Ohn0SAC5TmSyVnUFxNGTCfZfT14/xLVE+nZLhBv
R79kLdKwwWm/Cmk8yfSFAWEDygkSAPWoZ2VYgeE9DHbRMWTNUPNujF5HMug3j4rx
suHmOpI1Hr/aP0eD5iY5YW5wXCeDqSCAQN8U6QVjttE9O1MZrWW3iKzSkuFc0f8h
dgfDIj8sNazAO7rrvgwEMG8L4KiAD3fdwKazIxtkH941lJVJlOYPnXsG+i5agadw
VpNJR/WvkQdXsUIOp5F9ETwSTwXbTti2DaoPqtOC7eC9fXFIx5Ie+5IaeZF3/uEv
RKRkHcOrc2jxxQzF9SX9CM+n/ZDsr8zbfLSlsuDfZQEsDbLQr2ul69IqY7h5WOWH
6coqoXWJESUG1mZwoLn62uschdbcALLFRoJ8Thm+u5moFkcXxaTRwPqerb9IqXLP
X6eTgIyUvMIxCJNpMAv/W1dBZ3FRdL8IYzGbdHnRxfED+pF4T4IKpe4K6PRiJAK9
gSfYeKJ3NCjAGMldOjtkzGkJ27o2wwpgXnpL2CcZKxXbSfoAXcg=
=vF5I
-----END PGP SIGNATURE-----

--PhxIMoEr374zxJm2--
