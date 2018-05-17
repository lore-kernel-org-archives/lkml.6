Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752328AbeEQNwh (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 09:52:37 -0400
Received: from sauhun.de ([88.99.104.3]:51408 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750924AbeEQNwg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 09:52:36 -0400
Date: Thu, 17 May 2018 15:52:33 +0200
From: Wolfram Sang <wsa@the-dreams.de>
To: Colin King <colin.king@canonical.com>
Cc: Moritz Fischer <mdf@kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-i2c@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] i2c: xiic: fix spelling mistake: "unexpexted" ->
 "unexpected"
Message-ID: <20180517135233.ebimh6keikt7isz5@ninjato>
References: <20180514171552.25094-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="3fumasckvskl3tas"
Content-Disposition: inline
In-Reply-To: <20180514171552.25094-1-colin.king@canonical.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--3fumasckvskl3tas
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 14, 2018 at 06:15:52PM +0100, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
>=20
> Trivial fix to spelling mistakes in dev_dbg messages
>=20
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Applied to for-next, thanks!


--3fumasckvskl3tas
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlr9iSEACgkQFA3kzBSg
KbYYyxAAkIBYKLpw/pGKHoNq0p90HVTFBhILc5rJdlmo9JBQ9HNM5Mj+WlujbTrE
Bnu1+3AjS6bGmUTIuqn8uD8oC1cJfYORtypW1++O7L5R7l7HxIdHylLpg4xmYMcV
EAMktFKHq/Jxp6fImUFapKudKkT/F4HUuYsbRVk/g9TVIEpdzdN8iDba4GUrLPz7
q0QG/bRuVzuLLjOGiH/PaJ6dN60sJeppSxOcUb2OlCEavsuW+UArB0NXo8UuRYd/
NX4aCVAvMAXC6wp8q1FuWW4o1lUDYUXko5WwGwuK/f5nZeKBqKE89jEEsY2onNRH
G3oZPw9M2ouv2kj4y6G/giqbO+RzJE0h2Y5htGBdwdb9AeIt8jrya8NcBOY4zeuc
U2XuBOzpmpvw+DfGJT06RW7x22LlJ8DHfYC57BFOqrMS7ycyOcWeWTFiS71icGrL
Y13LfiI8+7+QQ8XLPO4oMEMhSpK6eX+6NQmX9yFbjxr8T+5Df4jxdiOSn5M74k9/
Y9na+swyeMDtPvyzIiMuw18dsEiIg+BUjzZzSfkGlrW+Sh8NOjVYdq1cDfJTDd6Z
5g1YFS8mNyKG0nyq56+fvHMM8VVcntF0oULNcmWBdBDEsh9pqlgcdoY6GdDwhASB
EpQMR9IHy9kc9/hbdl/eTqqvYC7ko7iC2ldOQSfmxrioZa6aoiA=
=NZMQ
-----END PGP SIGNATURE-----

--3fumasckvskl3tas--
