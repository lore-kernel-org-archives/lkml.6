Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751914AbeDJQth (ORCPT <rfc822;w@1wt.eu>);
        Tue, 10 Apr 2018 12:49:37 -0400
Received: from www.zeus03.de ([194.117.254.33]:37882 "EHLO mail.zeus03.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751367AbeDJQtf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Apr 2018 12:49:35 -0400
X-UD-Smtp-Session: l3s3148p1@1WGhToFpZJYgAwDPW8txAAId4P/+oMhl
Date: Tue, 10 Apr 2018 18:49:34 +0200
From: Wolfram Sang <wsa@the-dreams.de>
To: Joe Perches <joe@perches.com>
Cc: Peter Rosin <peda@axentia.se>, linux-i2c@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: remove me as maintainer for I2C host drivers
Message-ID: <20180410164934.putqtz2duvboyvnk@katana>
References: <20180410141125.4477-1-wsa@the-dreams.de>
 <68529743-2df6-f07f-b3db-720e09b765c3@axentia.se>
 <20180410155250.rjrfd6v5unqlf25m@ninjato>
 <29ab4b56-f857-a2d6-0b28-833896e9f47c@axentia.se>
 <695c3bd58a41b1f902c0deabf7552fcd5a89b53f.camel@perches.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="uzg5xcmtup7s5h7p"
Content-Disposition: inline
In-Reply-To: <695c3bd58a41b1f902c0deabf7552fcd5a89b53f.camel@perches.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--uzg5xcmtup7s5h7p
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> > No no, you don't need to add yourself there. I understand the mux drive=
rs,
> > and it's pretty quiet, so no need for that. What I was worrying about w=
as
> > this "Odd Fixes" fallback entry needlessly covering the muxes when they
> > are covered elsewhere.
>=20
> If you want to exclude drivers/i2c/muxes from the
> subsystem drivers block then you could add
>=20
> X:	drivers/i2c/muxes/

I'll do that, thanks all!


--uzg5xcmtup7s5h7p
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlrM6xkACgkQFA3kzBSg
Kbavow/+JcMR9RXAa7D7+2RC29cXor+iNoMKBZ8I+6kZlHpsuGZWtxcpJCHIATqh
VDNanSmzio7zxW0rWSUi3uWvVsQp9sHbYQz2YWF03JXtOC03j0UV8YhUfie+YhvM
InKLQIAzU4qFUE19DdzHAVU5bb7cUS3y1TAeD1cFKKEur4GFvJtAb/5lSx+CO1yn
Jk06jmA40UsfoGYpFIzovAe+wYo8gsQ0FPTpvTLD7Gtz/W1moNjJgBLPVopCf1zp
1MGizyS57VGE13cEajXsV1hgHbGnYSksCrdquCxvhFnJMFpYHtj3YnDMnt0YILny
pb+IWsMO7LDZL5vXHnnkZxAw86/zVWsiHrl+7lJuPl2OhgyQO7sRNEIeyZki5Aya
Yireymzj2/gZ/zER+LrJKNfULgDJfTGghNbiiIJs00iXrdFkY1ungq29sVGWsSbM
15Cla7nbM351Q8lVRnqCXlzUpYoCxIKfiv7ixpCeY+Jx02QUf7YSat0u8g5GLQMT
+RriTIavl3klpYJhJmiSBBgODKzLX25BnBYxgMXxi4C5QOPalyApNEebVl6Lz7q7
MDsXqC9nm/3GYC4yTjIEkGNNDakqD+nUTeKsOkB8NrH6oZBXxgrJvJqleitdUCLy
M58iLmoP0QibtInI3e66dzHNo3zUR878it1pddQ2S2PxZqyhZk4=
=2I3Y
-----END PGP SIGNATURE-----

--uzg5xcmtup7s5h7p--
