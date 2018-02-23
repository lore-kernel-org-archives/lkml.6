Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751771AbeBWJw2 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Feb 2018 04:52:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:50564 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751591AbeBWJw0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Feb 2018 04:52:26 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 495C3217A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=jhogan@kernel.org
Date: Fri, 23 Feb 2018 09:52:21 +0000
From: James Hogan <jhogan@kernel.org>
To: Colin King <colin.king@canonical.com>
Cc: Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MIPS: ath25: check for kzalloc allocation failure
Message-ID: <20180223095220.GK6245@saruman>
References: <20180222175012.11076-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="mPOSj6iWmtyhwOMz"
Content-Disposition: inline
In-Reply-To: <20180222175012.11076-1-colin.king@canonical.com>
User-Agent: Mutt/1.7.2 (2016-11-26)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--mPOSj6iWmtyhwOMz
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 22, 2018 at 05:50:12PM +0000, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
>=20
> Currently there is no null check on a failed allocation of board_data,
> and hence a null pointer dereference will occurr.  Fix this by checking
> for the out of memory null pointer.
>=20
> Fixes: a7473717483e ("MIPS: ath25: add board configuration detection")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Applied to my fixes branch with 3.19+ stable tag.

Thanks
James

--mPOSj6iWmtyhwOMz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEd80NauSabkiESfLYbAtpk944dnoFAlqP5FQACgkQbAtpk944
dno/kg/+OdLgQEiQPu+8he69/Y2ZIDSfdIn9mblJXoYxnbpS5YaSMK/fPvSizNQ6
8x+n0VkGC5FgNLd7dTfQOFiP18Z5jv0f0nPzrBKMhK7PF7Zm1+KS8nLspvWjxdbE
NzDs8xnNF5tu9LCT/WTh/PeSJUCqMG/nbCbZ9XSZ0wM4F9A989kG4AgHQkCiHdsA
U0Sw7vOouFUboMWYzv+jWBjOGYVU7LvtyGcBkhsbKfhuKJmhqKV4NCasEmrGUMFB
rjMYvUa5orbGkGX93WbuuFFybDV2Z8HOW+QidvPi7GezbyhI4nq+iM0/wEPe2FZe
KS8zwnS6Pdqm8H/YtA37onKOl39mlAyOh2tFbjBZ6PusAKnPh5SPBpLCDzXwKoGD
Nb0kfhT4zbEEbu8MvIOFMnTkfD7sxzE9+h+ZK5LfQiK+csOOIVYJ3F+UMm8I7pJD
jRS9BnqO4MGea9Fkn5VIgXZ1hyRQ+DSqt/42BsrtgGSuiqRoB//+4T1y9aPLOpHj
1Q3yXaqYoG5GznU38ioHGPzQAlA9Ho5zK0xetkUXjwIx8y3a4Fhy7TTEkUzUkz1v
j8fX41yNlkSB6NdVlYv8yMS98qLVYGGbFOqLvT+tUcbpZoa6Dtxl/UD6CpwtpTD3
Gqj3p+bsxcTSbJS0gXHSl3lbdRtOWbsjXwM0TUmKUzqAaJOoY6k=
=R+XB
-----END PGP SIGNATURE-----

--mPOSj6iWmtyhwOMz--
