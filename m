Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752691AbeBVIKW (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 03:10:22 -0500
Received: from www.zeus03.de ([194.117.254.33]:39028 "EHLO mail.zeus03.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752553AbeBVIKV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 03:10:21 -0500
Date: Thu, 22 Feb 2018 09:10:18 +0100
From: Wolfram Sang <wsa@the-dreams.de>
To: James Hogan <jhogan@kernel.org>
Cc: linux-metag@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-i2c@vger.kernel.org
Subject: Re: [PATCH 13/13] i2c: img-scb: Drop METAG dependency
Message-ID: <20180222081018.tc3jcuwl6yfrxroh@katana>
References: <20180221233825.10024-1-jhogan@kernel.org>
 <20180221233825.10024-14-jhogan@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="n5ojqysm46o3f7dt"
Content-Disposition: inline
In-Reply-To: <20180221233825.10024-14-jhogan@kernel.org>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--n5ojqysm46o3f7dt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 21, 2018 at 11:38:25PM +0000, James Hogan wrote:
> Now that arch/metag/ has been removed, remove the METAG dependency from
> the IMG SCB I2C device driver. The hardware is also present on MIPS SoCs
> so the driver still has value.
>=20
> Signed-off-by: James Hogan <jhogan@kernel.org>

I'd think it should go with the rest of this series? For that:

Acked-by: Wolfram Sang <wsa@the-dreams.de>

Let me know if I should rather pick this up individually.


--n5ojqysm46o3f7dt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlqOeuUACgkQFA3kzBSg
KbYNNw//VozjiVfGaMsSs0jUmsTVvWIAmvkuD59HTdA/N6nMBdcB/axq9PpSHT0J
KXGrGHOf9QtEJeXzydzIRDevKPAePLZjvGjIfZVqrXTOsOqOMngLkE+z8KT6KIN2
UdUCY8kDjoK9CcghAsvIB9FX7hHD2qnZhmm6iWc46PG5zu8LaeCTIw8g7CUE97c/
O7xTtp2wImMWQvizlEAI1GWEvOokPcMYRDH9LVNc6ZlprSPAzXLJaAupdA/cNADv
scD4mHz2ZPjEI4N/H6Z8fuF/7DnNGktMfPhum5NZyYayDJ8oslMTqmyEFQ8vtqDt
Wo113+VG3aWi1J/F7l7NeSnQixsvgUERrKutIxvGHSr4H5WXPQFYVJrcmybxfLzo
5YBpX0DDpJfB+Kwr0SjYBJmJKIeSjjMOvaljjknsWKuCH6RNO5DlUcLt4t5OfoO9
g7ZuoNr9DL+ZoVpl3lWUtE4DkDjqhqwyRxTgr9xQC9bKa8Ya727yCCP6eMV7W94W
tdrvnMjZrgpqDmt1BsC5bqwU1/zgtV5SGv+3hdn7wJsvGlOfV4b9jUhQgvhZUorF
Rq8H0hTAaARId5cC2ChIppjrsjT86FbSGp75qhU0wnzmdwol4X8fg1PmEbO6iwgr
rAV6/2EoqWYw3P54QgWnfhcz3PgCTQBGcZs5mpQW/Mxd8sIMfX4=
=9OYz
-----END PGP SIGNATURE-----

--n5ojqysm46o3f7dt--
