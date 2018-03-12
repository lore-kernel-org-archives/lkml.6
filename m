Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751458AbeCLNkZ (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 09:40:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:47896 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751242AbeCLNkY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 09:40:24 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 487AA205F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=sre@kernel.org
Date: Mon, 12 Mar 2018 14:40:21 +0100
From: Sebastian Reichel <sre@kernel.org>
To: "Pierre Bourdon (delroth)" <delroth@google.com>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
        Andre Heider <a.heider@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: Signed-off-by missing for commit in the battery tree
Message-ID: <20180312134021.3x5dboqj5wfjhgoq@earth.universe>
References: <20180312124007.61288892@canb.auug.org.au>
 <CANEr7oV8GTU8X1ijUYJKZjF6Pdr1i7+mvUqoDCaaKBCPkvrFgg@mail.gmail.com>
 <CANEr7oWy2ATCnExdoFkCt9Sz3OUEgEQpQQiqmKnOh7iVDekiKg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="wrk2jlvvhhilgn2q"
Content-Disposition: inline
In-Reply-To: <CANEr7oWy2ATCnExdoFkCt9Sz3OUEgEQpQQiqmKnOh7iVDekiKg@mail.gmail.com>
User-Agent: NeoMutt/20180223
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--wrk2jlvvhhilgn2q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Stephen and Pierre,

On Mon, Mar 12, 2018 at 10:46:08AM +0100, Pierre Bourdon (delroth) wrote:
> On Mon, Mar 12, 2018 at 10:35 AM, Pierre Bourdon (delroth)
> <delroth@google.com> wrote:
> > On Mon, 12 Mar 2018 at 02:40, Stephen Rothwell <sfr@canb.auug.org.au> w=
rote:
> >>
> >> Hi Sebastian,
> >>
> >> Commit
> >>
> >>   5e0dfcbb1194 ("max17042: propagate of_node to power supply device")
> >>
> >> is missing a Signed-off-by from its author.

Thanks for the hint!

> > I failed hard :) will resend.
>=20
> So, since I'm very clearly not familiar with the process... is sending
> a v2 with proper s-o-b the Right Way to do it, or are you just fine
> with a correction by email?
>=20
> If the latter:
>=20
> Signed-off-by: Pierre Bourdon <delroth@google.com>
>=20
> Sorry for the screwup, slowly learning (I hope).
> Best,

Thanks for your SoB. I fixed this up in the existing patch.

-- Sebastian

--wrk2jlvvhhilgn2q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlqmgz4ACgkQ2O7X88g7
+prdoxAApwkolmWURlRPJLSBnHm9L5ez2Jwo6ydXGbRVvgIpgBYMaYTfNoxRWOh8
2IXTd8yLteAyHUVVXTOrY31JA/NWPmLVCxWRt2ce91C62VbG2HYwdHm13e/GFVrD
RNJJFTVwZ482BAQF0p7mHnk3VxX7c4URLLJKq9taiq+1owTTOi1FuVj8Cho02h0S
1XZQyqjiXSjO/vBKaGuzpZjvzgoq4hqNh9jl10JqGAiwlXUxdVaefqrCLk0y8tss
GTtpdELz2KR0N4AiDCddEK2wERmcGPuraTIiAZuBFsUSeBeQ6oc4t19kF0b7rs/K
h/Tr6NojOfE7ydI6mZ1LLLzxuEZxLlJL7jv150UMlAi+FPtUEKhy14A87HCsAle5
Xn93BMQM569pRY+5SYbxo8+cb5H8PNP9IiRhquN/p5OtYunxGegV/qVGbPt9+krh
62wcg+QVXPye0bcQU8l+4G3jXfOo7IMRewrx3wuQOxtStYSu6IpdggGcDNUfdLDy
smCUpXYkj/fiK+jAh3VzaYZYkXFUGjGtFZtg0hWGwdEAJW100iRD9IpK56pf1s4c
k5RoSZbxYZ6PWpBmfu2pwSZy567XXmy8bW/y1MRRfKhIHP4OvKaUc+8efMbjqaJT
+9D8AhEW+gIrsiT/mR5AfgZQUD1O7ej+ZQXVPj/iNItqC9Th3Gg=
=xr/6
-----END PGP SIGNATURE-----

--wrk2jlvvhhilgn2q--
