Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752359AbeCQUiA (ORCPT <rfc822;w@1wt.eu>);
        Sat, 17 Mar 2018 16:38:00 -0400
Received: from sauhun.de ([88.99.104.3]:38641 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751236AbeCQUh6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Mar 2018 16:37:58 -0400
Date: Sat, 17 Mar 2018 21:37:56 +0100
From: Wolfram Sang <wsa@the-dreams.de>
To: "Christ, Austin" <austinwc@codeaurora.org>
Cc: Abhishek Sahu <absahu@codeaurora.org>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Sricharan R <sricharan@codeaurora.org>, linux-arm-msm@vger.kernel.org,
        linux-soc@vger.kernel.org, linux-i2c@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 00/13] Major code reorganization to make all i2c
 transfers working
Message-ID: <20180317203756.akqctdkhxelfs7in@ninjato>
References: <1520860502-14886-1-git-send-email-absahu@codeaurora.org>
 <2a092d8f-6d1a-27e4-01f6-49790f767ae6@codeaurora.org>
 <20180313211758.kv5voneg4akm3rqo@ninjato>
 <cf4b43fc-8051-77d1-c4f0-e46cb209fa49@codeaurora.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="a4jbbs57u5skqfvc"
Content-Disposition: inline
In-Reply-To: <cf4b43fc-8051-77d1-c4f0-e46cb209fa49@codeaurora.org>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--a4jbbs57u5skqfvc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 13, 2018 at 04:12:19PM -0600, Christ, Austin wrote:
> Sorry for the miscommunication. I reviewed the patches and tested them on
> the Centriq 2400 platform.
>=20
> Perhaps the following is the most appropriate.
>=20
> Acked-by: Austin Christ <austinwc@codeaurora.org>

If you are okay with that, I'll just read it as "Tested-by" for the
whole series.

Thanks!


--a4jbbs57u5skqfvc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlqtfKQACgkQFA3kzBSg
KbYNZw/+MGzwiowhr+ZAxN2k78JoukH58b6ttVpbXCm2MgA7BfE77mczawlDQWhP
Sae3oCirWbuinO72JOkPF/mJTpJReRNJGcwlaUt32BhA/ifFfgO0bXxBOVpeadbZ
qXFz6GwTu1l4Ka+f5fZlVDbREBVy2M16A3C3OIkpzWonVj+RMZf3ow8yMomjl5i8
QvBDrTZ7yXt2JMEE81ZZygfhab2N57IaTxCdCp8xVrXqS0MQ65KKJEHws3dmJywc
Kl/p5/OK83hihPw28diycYpINXBeSwRmFHB/9gvMrtQI3BShSptvMMERoH267KAH
VjqCSOV0/NJpNggkl0sb0vRoF0MZ4FXN2g3GbBJ0a8Yv5AyZrBwUL2n0x5ECo5R3
iINwHtPwK2ch/tJ5MpRM7WNx5FwMEq25C8H/Oc8cgxJ+ZKrwS6tPb1mNX+qiHmTv
EUvCdsZS7rjclwO97l5m33v2xw5938412NgO4rC7Gm+SYmhUeJnMavluYXntfA6r
MfjTFkJeyZhacbPJ+uiCx/y+6mYxg5GTcCEdlU075m33g30Q+5YJJEQhIOz1ilPB
zxWzNp5VmGQs7hgqpj7aFu/ToUiXAcYppE9VbTKlBT3tzTLy93DpOamJumAcHd7m
jui2Tkip5//66xgPCjG8OvxvSj90GbshCEH9Jf+7Wp1V58/POWY=
=k6Ew
-----END PGP SIGNATURE-----

--a4jbbs57u5skqfvc--
