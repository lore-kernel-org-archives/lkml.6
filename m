Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752195AbeEQNl0 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 09:41:26 -0400
Received: from sauhun.de ([88.99.104.3]:51324 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750779AbeEQNlZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 09:41:25 -0400
Date: Thu, 17 May 2018 15:41:23 +0200
From: Wolfram Sang <wsa@the-dreams.de>
To: Peter Rosin <peda@axentia.se>
Cc: linux-kernel@vger.kernel.org,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>, linux-i2c@vger.kernel.org
Subject: Re: [PATCH] i2c: synquacer: fix fence-post error in retry loop
Message-ID: <20180517134122.odweeppckmpckk4r@ninjato>
References: <20180509194726.29166-1-peda@axentia.se>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="lq7fi7y74l36e4nv"
Content-Disposition: inline
In-Reply-To: <20180509194726.29166-1-peda@axentia.se>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--lq7fi7y74l36e4nv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 09, 2018 at 09:47:26PM +0200, Peter Rosin wrote:
> There is a difference between attempts and retries.
>=20
> Signed-off-by: Peter Rosin <peda@axentia.se>

Applied to for-next, thanks!


--lq7fi7y74l36e4nv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlr9hoIACgkQFA3kzBSg
KbZKOg//ZFmZcvLw/s44MmWQzjwxXeRqTdI2nBX6oIP2ROL9XoCr1BQyiTO9l7WF
qVrujmaiBsKm9Hr0adbrP9dvurmbukcJSUL51gFSheSgtsYtS9PhwkEB8PCecRjE
cu9lFnqUFQ09F03kG3LNKVckhX52PqgmsDU5tk4NT9QAqoyTJ0ff5ZPb83QTmt8Q
rpaGe2ri8fZhHSBpCJvsbHQrMkG9WiTvRveDcftOg+9XYUs9POTiscQ82gssQqSA
HQBMjFhM9TI/+JvCpzDk81WtZhOyFH50NfEuHnKlpPa4iJWCq742LIrIOPAjKReR
Tp3HsROAtVgPtBU88r27ajbmGL70cgU96TJ5sIF5LPdahWh2EdzlJYkYxiXlu3nu
4B44YI+tK2jn0BgWRpdddPZttNnpz+gpPfsDSNRqVTVbTQm2a3LCt8FtJxpc/vSu
4lXn93KR4qHbiiqOLQUd7q3y2XPTQEALKXF799a5Lv6QjvHFuSKXwKSr9bOSgZyz
g0UA8OuQgdiOBgrgLuTdEkBf0A3+J/Np9JNhoTmutl+kKrflFe7eCUpGyIw2elqK
HVZxQY0I4JkkhbJ6cmgsceQwKnaCRp1rULsv3bkOkCt13+eDjaiFVAlqZ2d3Kq1s
fCMI0nqvlF7lfHck/JM21d06934xTkbXx4ppZAGY6QXHnxjJR7o=
=TnWa
-----END PGP SIGNATURE-----

--lq7fi7y74l36e4nv--
