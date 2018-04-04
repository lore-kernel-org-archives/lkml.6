Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751285AbeDDLIA (ORCPT <rfc822;w@1wt.eu>);
        Wed, 4 Apr 2018 07:08:00 -0400
Received: from sauhun.de ([88.99.104.3]:54262 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750827AbeDDLH6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Apr 2018 07:07:58 -0400
Date: Wed, 4 Apr 2018 13:07:56 +0200
From: Wolfram Sang <wsa@the-dreams.de>
To: Pierre Yves MORDRET <pierre-yves.mordret@st.com>
Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>, linux-i2c@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/6] i2c: i2c-stm32f7: Add slave support
Message-ID: <20180404110756.pxrmyjaiasp2c35n@ninjato>
References: <1521650940-11651-1-git-send-email-pierre-yves.mordret@st.com>
 <1521650940-11651-3-git-send-email-pierre-yves.mordret@st.com>
 <20180325181600.vehqe3xcx55qxtd7@katana>
 <94737125-c0b7-08ca-c2f7-feb4e5d0498c@st.com>
 <20180403152604.udgh4v2erpsupgo3@ninjato>
 <a6218454-d44c-7888-2688-d24bf5bc97f4@st.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="keh27gkv2uxr773f"
Content-Disposition: inline
In-Reply-To: <a6218454-d44c-7888-2688-d24bf5bc97f4@st.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--keh27gkv2uxr773f
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> > As far as I understand the code now, both instances can be master /
> > slave simultanously on the same bus?
>=20
> Correct.

Very nice! :)


--keh27gkv2uxr773f
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlrEsggACgkQFA3kzBSg
KbbfuBAAnfzFZGy+3e08dObsETvGRpqa9AUzIxNgU9PmC3SCW2CZG9QYHFnpWTpn
8/Tf+a01z0pwX8wcRXTle6FvCnRRwEmSNzzTy0qmi9BNRXOhnqHzl8/KaAtHzotI
D9X16k8OETWlkfO0eD4mfwM63A2KXkMedR1X9KtUJFaFGr+cT79bIRYP13kRRnca
/Ikpre28zFJtMS8xsPeyWoLo644Fnm0opk1eAXpF5iRVNYMxOx6ElyyyXzZRvrRm
Vb98vGCgftpeFW7YCqnGzFBz6MZXFKFVN7/iz/+KZv4A4GE2fUfpZCtA4C5pUKsR
iwn+hBLUiNHFEBVV7f2HAEtOD/uctdOLsncbASYWcJooiIoOLxSjNCmuV2Hh0uCo
Jc/vHrfxH3XBP+yC0Tc49BpEwirU7A7Bx8G6qmquIXIKlFUQ663mDMo4d4WvvaT4
EBkasujYS7aod6YCOUxdeOkxIsExu/eOnW8FushHbaPRahive9En2sg/Ez2Ft60X
5fwG7FX5D5FKrFffmGwWu6Ft21fV9Ji/Aa00ed+m4EFPlJnD+QLAezYTX63qH1mz
ZWMCV7zhqlAH8wXZTTcGYGkPwqWk4gtbDwFj66dNA7b6HHX/8iw2Rm5KecrQ9GAC
9ajQEF5TZKFlxKYi4kj6HSkOnFk1S4oOp2yBzzF0EnU9UkjlCuU=
=S8CE
-----END PGP SIGNATURE-----

--keh27gkv2uxr773f--
