Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932079AbeAaHby (ORCPT <rfc822;w@1wt.eu>);
        Wed, 31 Jan 2018 02:31:54 -0500
Received: from mail-lf0-f49.google.com ([209.85.215.49]:46298 "EHLO
        mail-lf0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753139AbeAaHbv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jan 2018 02:31:51 -0500
X-Google-Smtp-Source: AH8x224hCwnYQfxAKvx32J36wV8iQjRcAWulqbA5bKs23KPQAwSPLj8xGpzzit0dSQXEVM29srVYHA==
Date: Wed, 31 Jan 2018 08:31:38 +0100
From: Marcus Folkesson <marcus.folkesson@gmail.com>
To: Andi Shyti <andi.shyti@samsung.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Simon Shields <simon@lineageos.org>, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org, Andi Shyti <andi@etezian.org>,
        jeesw@melfas.com
Subject: Re: [PATCH 7/8] Input: mms114 - add SPDX identifier
Message-ID: <20180131073138.GA1499@gmail.com>
References: <20180129113323.18961-1-andi.shyti@samsung.com>
 <CGME20180129113331epcas2p193a0a99f660793fbfcf2ec825fac0e2c@epcas2p1.samsung.com>
 <20180129113323.18961-8-andi.shyti@samsung.com>
 <20180129194659.df7nlhwx4demk6o6@dtor-ws>
 <20180131060726.GB7575@gangnam.samsung>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ikeVEW9yuYc//A+q"
Content-Disposition: inline
In-Reply-To: <20180131060726.GB7575@gangnam.samsung>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ikeVEW9yuYc//A+q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Andy,

On Wed, Jan 31, 2018 at 03:07:26PM +0900, Andi Shyti wrote:
> Hi Dmitry,
>=20
> > > -/*
> > > - * Copyright (C) 2012 Samsung Electronics Co.Ltd
> > > - * Author: Joonyoung Shim <jy0922.shim@samsung.com>
> > > - *
> > > - * This program is free software; you can redistribute it and/or mod=
ify
> > > - * it under the terms of the GNU General Public License version 2 as
> > > - * published by the Free Software Foundation.
> > > - */
> > > +// SPDX-License-Identifier: GPL-2.0
> > > +// Samsung S6SY761 Touchscreen device driver
>=20
> I'm very sorry, but my distrcation will kill me one day.

More coffee or sleep - your choice ;-)

>=20
> Is it possible to revert this patch or do you want me to send a
> fix?

When you are on it;

Change
MODULE_LICENSE("GPL");

to=20
MODULE_LICENSE("GPL v2");
To match the former license text and SPDX-identifier.

See include/linux/module.h:
 *	"GPL"				[GNU Public License v2 or later]
 *	"GPL v2"			[GNU Public License v2]


Thanks,

>=20
> Sorry,
> Andi

Best regards
Marcus Folkesson

--ikeVEW9yuYc//A+q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEBVGi6LZstU1kwSxliIBOb1ldUjIFAlpxcNQACgkQiIBOb1ld
UjLkiBAAz3axi8vpqDvFexWxr2odDWF/j4YgRZ0dqltXKkPd6CIyb4EoAwxYBZ6S
nro8MdGQp1k/x5Eg23RPrO6iCu+OY30qmRc/X6v+1FCN61S3ftKqYvXmuYCu+NDy
2H1sbXQk1/w5wCNKwUV9BJHytssIPHY3ZCbwaseQTfQriu78X1adn0Bz0G9KMjnQ
bS7kCW8PnTdZsw5kjwVuEG10XYNjTe+/13476FSSsPRwmIFVNcN6oFXASzc5fVs4
UuIDU2SF62ayZbvaZfuDxa5W9gfcT8sS0Hb7rZpvYTzL43wxUvkkQiTTQbd4pWWi
MZaNS3SzIEpWJxzxjWl+l7/tWETy3Qw51FAX6jeLgpLcyW8H8UzkR+pHsfWuufi6
NEXymJxbZNw1POploSQTMnbWeBQUq1D956m8KOOe6gnP3JP4LMJvDXEX3fQFVHl4
GKRdNp7lwVbdaOFCVP34SRPj9gtd49TXJyZnF5UBArzixW91BK9AZA/e/z5x5gFd
K9Dme73mpCgG441wqDa9rYpb0x59ph0pypLBVkUe7g0jBe5Z62U1sdoE1kyB1wnK
2PLPvcxSOrRy4QLVWHjBMZIrgig3Qfwcj/yW4E05boaMfPep2scF+1NaF0/ohh/F
3Tnwz6Tgsp/UQpUgsHeq+0mi8ML3v2ViWFNnVjAUw0XnXb4OTXM=
=kUeJ
-----END PGP SIGNATURE-----

--ikeVEW9yuYc//A+q--
