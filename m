Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752009AbeCVW2n (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Mar 2018 18:28:43 -0400
Received: from muru.com ([72.249.23.125]:33310 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751937AbeCVW2l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Mar 2018 18:28:41 -0400
Date: Thu, 22 Mar 2018 15:28:37 -0700
From: Tony Lindgren <tony@atomide.com>
To: Pavel Machek <pavel@ucw.cz>
Cc: kernel list <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-omap@vger.kernel.org, sre@kernel.org, nekit1000@gmail.com,
        mpartap@gmx.net, merlijn@wizzup.org
Subject: Re: v4.16-rc5 on Motorola Droid 4
Message-ID: <20180322222837.GG5799@atomide.com>
References: <20180322123518.GA27004@amd>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="mSxgbZZZvrAyzONB"
Content-Disposition: inline
In-Reply-To: <20180322123518.GA27004@amd>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--mSxgbZZZvrAyzONB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

* Pavel Machek <pavel@ucw.cz> [180322 12:36]:
> What does _not_ yet work is battery charging, and I'm not sure if the
> phone will actually shut down itself or if it will drain & damage the
> battery.

Hmm you have IIO and CPCAP related options enabled, right?

Maybe define DEBUG in cpcap-charger.c, cpcap-battery.c
and cpcap-adc.c and see what output you get?

Regards,

Tony

--mSxgbZZZvrAyzONB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEkgNvrZJU/QSQYIcQG9Q+yVyrpXMFAlq0LhUACgkQG9Q+yVyr
pXP2oxAAtdPvIf1daQ58//aOa125yS/bZVOS4twFhkuJ/BIaTYemp1eWyfwScMa2
fi3eiRTYKA4KYZ8zzsy+x3Cw3SLT0xbJzThKXOESaf28l3PV+ACYkET5WyF2vB5h
6F+eE2j9JgsJWukVlNefANpQLUy0phHOgntGhsMtri8odVNWhv6Lngr4Zu9KXKNY
whQyXPXeAbwM+MQRBvlIAvZjQbhrVUt1QBIdgisEaQQ35Y7BqvBpw8jj4U2zm9N0
1UfLmUx1TUXAglGi9nrNLSeiHEIzY+dW7kKz6eY52k9vtCCkh0fk8mQks2c+6yi1
YV/5emEfOGibBpLTijf6qkDGxXa4ch8MFVM6RAH4sZ/QCHugvn9Wdl8f2Bq4dxi1
yYFC0K0jA9BqQTI94MpTAmhLWTTZwwpZU7wrLvFUGvgohFTI2gF0loUgBffL7vfV
pYk71zae3qTr/OpcRkOEKV4FQE4RsQQRDkk+S7xN54UZvkq4DHTXlfgg854Ihk1l
e3yMA+84Jx/F8lrreIOKGWWIIC9MibKwTaPAQlICMl3A0JnoOtdv6JIv4L4UIK4j
KoLDjK2FWG7iYXZ3diG1imQgvDlnqxx7TxaBhol2fakjSFvEHZRU019VrKBjJvC8
QfZSO9m8sMepK5zK9gSUAI9FXrXvjRX5DCAprXSQD+jLCHX6ctk=
=vUFB
-----END PGP SIGNATURE-----

--mSxgbZZZvrAyzONB--
