Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751262AbeDDKQE (ORCPT <rfc822;w@1wt.eu>);
        Wed, 4 Apr 2018 06:16:04 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:59058 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751095AbeDDKQD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Apr 2018 06:16:03 -0400
Date: Wed, 4 Apr 2018 11:16:00 +0100
From: Mark Brown <broonie@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>
Subject: Re: [GIT PULL] regulator updates for v4.17
Message-ID: <20180404101600.GA7691@sirena.org.uk>
References: <20180402163413.GV29239@sirena.org.uk>
 <CA+55aFwXUh6AkFoYN4DihjaYwNjD-ti=hw5jz6f-bhjXYS+dNQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="sdtB3X0nJg68CQEu"
Content-Disposition: inline
In-Reply-To: <CA+55aFwXUh6AkFoYN4DihjaYwNjD-ti=hw5jz6f-bhjXYS+dNQ@mail.gmail.com>
X-Cookie: An idle mind is worth two in the bush.
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--sdtB3X0nJg68CQEu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 03, 2018 at 12:00:24PM -0700, Linus Torvalds wrote:
> On Mon, Apr 2, 2018 at 9:34 AM, Mark Brown <broonie@kernel.org> wrote:

> > A very small set of updates for the regulator API this time around,
> > there's a few bug fixes and also:

> Heh. This one was "very small", and the regmap update was "fairly large".

> I think the regmap one was smaller. This one actually has a new
> driver, the regmap one looked like mostly cleanups.

> But I've used your words for the commit logs.

Yeah, I know - I'm not so much measuring it by the absolute volume of
changes as I am by how many changes I expect to see in the subsystem and
where they are (core vs drivers). =20

--sdtB3X0nJg68CQEu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlrEpd0ACgkQJNaLcl1U
h9AUVQf+PTX31Dra49s5ZtcKmlMfO3CYrvRNtmPowjKBSRn6T3XWlgBh2nnScXs1
bS50F5TbVC7bD3GOcux8v1kbKJ9jx3aAsHUrukeBWcdE9OLBKOKe4f6vtfl55YAZ
PvKk5FkSt3YyUD81VJ3daJrLmBRocM9xDlmWuJ2I7Y37YW5JHnJQRUnEPXZArxKJ
S5BVqTcnDOK29skJLGra+Of6SJHnOcR1eH05iwWea3b8nx1HTxrHr9jq387xjdiK
HUndTmFHqhAG1vqi56U+WJe3yF8AvZhMU6aY98SXlaIDneHe1KxJJS/FRR0k2ktD
JQ7xnljNzYny5lgG5jqyGYtuKAnV5A==
=OsQ8
-----END PGP SIGNATURE-----

--sdtB3X0nJg68CQEu--
