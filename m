Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752235AbeEOH2K (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 03:28:10 -0400
Received: from sauhun.de ([88.99.104.3]:60774 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752102AbeEOH2J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 03:28:09 -0400
Date: Tue, 15 May 2018 09:28:07 +0200
From: Wolfram Sang <wsa@the-dreams.de>
To: Peter Rosin <peda@axentia.se>
Cc: linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "Gustavo A. R. Silva" <garsilva@embeddedor.com>,
        linux-i2c@vger.kernel.org
Subject: Re: [PATCH 1/2] i2c: pmcmsp: return message count on master_xfer
 success
Message-ID: <20180515072806.twsuirbmx2xs5rge@ninjato>
References: <20180509194630.29047-1-peda@axentia.se>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="6klqfydcvsqnnam2"
Content-Disposition: inline
In-Reply-To: <20180509194630.29047-1-peda@axentia.se>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--6klqfydcvsqnnam2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 09, 2018 at 09:46:29PM +0200, Peter Rosin wrote:
> Returning zero is wrong in this case.
>=20
> Signed-off-by: Peter Rosin <peda@axentia.se>

Applied to for-current, thanks!


--6klqfydcvsqnnam2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlr6jAYACgkQFA3kzBSg
Kbaciw//RnwWTyfCtwEIwaiR6lRkdAQUGEVT98Jo96ID5qGIQUFuWkIo3G33BuR4
1kPXOVjcTAWO7ZtHjwqKczSKov/k2WmpyllO4oiSc9sUOxC3kk2nE6Kq0IEiL3uv
oE4b3LTRbmXxgcdAw2QeOziBi6QaCp/NXdSvW4PmyoiRikQEFv7Z5ez+rGbGbwX5
8t3zpdz+hDKh5vXaTtWcmyU3oDT30/5RcwFMiTA/AGbYK64cnFH277DpJnAeGtLe
AbXGC0DIZWzCOcO8mhJPtGVhvNF7zJQs6SITjrrDMeFRrPgP4AN9hif2od+IZRxL
ClC3bQMcdJjU/PK+sLlB9tmoiIPED90uMk0vC8uov5lVMerAUv137zA/btxLyuY6
EmasH2Z/zAlVtorymnnVDh5/8auSl7eCE3kRrNhilA+WBz/kNq7vnrnBKWs6LSSw
XJRoJ+ReJN8C4T8LOD3pp3DLPSkXU15YeQoshF9nw85oiEZWQfDOympWtKCAANZm
5G/uSRgXxLOtDYaaZVdUdQzIT2bBBTBrZ+Z3ja/VGPcuQ/sm8DHkNnWYV3fCQuoF
lG/emZ4rU3qduBCQGXCChL0jlSvEQXve3E1up12MTpJOKAQhSYEBg8KY5LlL8GX/
a+H4oMloRNPxNMpvnY9DdnC4ZLSAtIn+z7CLl6FnN1KbwLmykmw=
=0yAl
-----END PGP SIGNATURE-----

--6klqfydcvsqnnam2--
