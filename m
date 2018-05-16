Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753274AbeEPKEH (ORCPT <rfc822;w@1wt.eu>);
        Wed, 16 May 2018 06:04:07 -0400
Received: from esa1.microchip.iphmx.com ([68.232.147.91]:44884 "EHLO
        esa1.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753053AbeEPKEE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 May 2018 06:04:04 -0400
X-IronPort-AV: E=Sophos;i="5.49,404,1520924400";
   d="asc'?scan'208";a="14964745"
Message-ID: <a34429cf43124de623fcaa645d5d7a360c755867.camel@microchip.com>
Subject: Re: [PATCH] mtd: spi-nor: add support for Microchip 25LC256
From: Radu Pirea <radu.pirea@microchip.com>
To: Marek Vasut <marek.vasut@gmail.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>
CC: <linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
        <Zhiqiang.Hou@nxp.com>, <pp@emlix.com>, <richard@nod.at>,
        <computersforpeace@gmail.com>, <dwmw2@infradead.org>
Date: Wed, 16 May 2018 13:05:21 +0300
In-Reply-To: <1db092c8-95fb-5747-f7b9-f6a215b1aa5b@gmail.com>
References: <20180504155404.5285-1-radu.pirea@microchip.com>
         <20180504204013.254d90cf@bbrezillon>
         <e2e23aa21b37754b0c84003e6d87c7cb7d5a17fe.camel@microchip.com>
         <1db092c8-95fb-5747-f7b9-f6a215b1aa5b@gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="=-qBHZrjFqVyIRnkwSuzM0"
X-Mailer: Evolution 3.28.2 
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-qBHZrjFqVyIRnkwSuzM0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2018-05-16 at 00:17 +0200, Marek Vasut wrote:
> On 05/15/2018 06:22 PM, Radu Pirea wrote:
> > On Fri, 2018-05-04 at 20:40 +0200, Boris Brezillon wrote:
> > > On Fri, 4 May 2018 18:54:04 +0300
> > > Radu Pirea <radu.pirea@microchip.com> wrote:
> > >=20
> > > > Added geometry description for Microchip 25LC256 memory.
> > >=20
> > > Same as for the dataflash stuff you posted a few weeks ago: I
> > > don't
> > > think this device belongs in the SPI NOR framework.
> >=20
> > Hi Boris,
> >=20
> > 25lc256 memory is similar with mr25h256, the only difference is the
> > page size(64 vs 256). Because mr25h256 is already in SPI NOR
> > framework
> > I added here 25lc256.
>=20
> I think I must be reading the wrong datasheet, but can you show me
> how
> does it support things like READID opcode ?
>=20
Hi Marek,

I read the datasheet for 25lc256 and for mr25h256 and none of them
supports READID. Is this required for a chip to be included in spi-nor
framework? I just followed the mr25h256 as an example.=20
--=-qBHZrjFqVyIRnkwSuzM0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEdoCq2H4M7urKoB6rrwWfQ+JrPx0FAlr8AmEACgkQrwWfQ+Jr
Px2SEBAAjDFPBtTeDU+oT05eDSU4xKRqNHej7v33Ed3pCWl78KY5FS34xP9dnoZU
GILWIHel95hmOmF4lduZVWXreK4sA30wFG13dJzcXNzmi3AT3KZb4wjWFlEX5rS2
iEsWAYqL0ywjqqzbLwkukNtlRe3m1yEkoGhgunAcGPpy5lZbSP5te7s1+JZm9XZh
7CjOJ4GY0vOLKnQlsIrGFv/ksozR8VtEnARjeRr7Q1edVmhIl5VzR3SskSY6mCbD
jtJKMlEozSCWNizyRiN6PCd3BKraabjc5v5BaQUq6RmQWSF2rqTiGKAMyhoxmYaL
FrTXPmgTc+HaKUWWrrG0fahsWnyYwrBXrVhYFzaCft8PACw8GAj1oZhejXi5QGhK
shViWrgY1Ixq3AHX0Q2IQGgnnsOdYby6KQMAc/CjPkt8RStErTFVwZuhRe3hCswF
ITcKOasH/2NaLtKgyrx4HvhbAYf6j2vgR8y8UKdHe5ynRve1aW1fXt+Qr5yNuLmi
ybNDp8D+SHToolMOgcFzRrbw0+GD8HutNoTIQZbrAhhqKloLyMeI5mapTALvO0M1
tBKtpAXXhAnQMeVfYUJYCq3js1KjNjnLyEhSgZqI7/TUt2wS0kL6MkyIgi0HsgTn
tiWw/U3X/5wX8IpslolF0GN7mFgAGlVVJ+Vs7Owb9TVHO7zBDXY=
=tXue
-----END PGP SIGNATURE-----

--=-qBHZrjFqVyIRnkwSuzM0--
