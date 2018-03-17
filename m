Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753003AbeCQUoV (ORCPT <rfc822;w@1wt.eu>);
        Sat, 17 Mar 2018 16:44:21 -0400
Received: from sauhun.de ([88.99.104.3]:38673 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751623AbeCQUoT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Mar 2018 16:44:19 -0400
Date: Sat, 17 Mar 2018 21:44:18 +0100
From: Wolfram Sang <wsa@the-dreams.de>
To: Pierre-Yves MORDRET <pierre-yves.mordret@st.com>
Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>, linux-i2c@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [RESEND PATCH v1] i2c: i2c-stm32f7: fix no check on returned
 setup
Message-ID: <20180317204417.xwfl32lr7zt3dy25@ninjato>
References: <1520859201-30549-1-git-send-email-pierre-yves.mordret@st.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="boro3g3wgwwiedfk"
Content-Disposition: inline
In-Reply-To: <1520859201-30549-1-git-send-email-pierre-yves.mordret@st.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--boro3g3wgwwiedfk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 12, 2018 at 01:53:21PM +0100, Pierre-Yves MORDRET wrote:
> Before assigning returned setup structure check if not null
>=20
> Fixes: 463a9215f3ca7600b5ff ("i2c: stm32f7: fix setup structure")
> Signed-off-by: Pierre-Yves MORDRET <pierre-yves.mordret@st.com>

Maxime? Alexandre?


--boro3g3wgwwiedfk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlqtfhUACgkQFA3kzBSg
KbZ9KxAAgF+tTQhdC/Xp5XrvoN/ChJ//Y8jLjHtHEdjHUeEjMFNsZwkB0GIx/g2k
RhOTtVCHiAwzdMo1fy9Slg1qDayIvTZmpu7pjPZLhE3NJVi3eiXaTYe12fDCI+u9
qUYyFBnTNINB0nSGUO+H4ngCtWqemPRQ+uJLE2ULhhMEQPbRzLaSfoGW5r7wAAuc
aza9vb+4grLItFdZhsJcWNUPwIykNqy8Mpzt722SQ/uEbX4sE54sD29eelb2W5nK
5RjymZPvDw34gPkn2BfidB8JClg+o7v61VzipM4MAOQ5I/zKEZ/fjXQ1FXNnb5Yt
3lfqCzkNQxstw5/s5dzskGxPasB3zcBCcnEKYJW2TGNVQgEJ32SvnGu4gIjFOZvv
yAJXzlGx6z2StPBrqCqXPB9NwMYE7nUosZD1JncIfbJbKYpg+zWkrye1b+ebPIym
ktso021XdIW81rCZByvC0UN/WXxXMF0CbdD0bTilu7veoCGKB1LUDzspNyMTNUdc
Jusn/38RkSYErLOaezBUr5imFMRefHqHrx6wd2g5IhoZqsbPVPAjCXxGvq1N1mb4
X476qDRy7tGjumzHea0E8bzbb/+XGYXenJLmWEUYdWLeBYorrmoXD/GRKP+Nw6nW
l52a0DvICsvhZq7T/XiY4pseWirFPCzANO2pcEZ2MKaxowB2bi8=
=7u4G
-----END PGP SIGNATURE-----

--boro3g3wgwwiedfk--
