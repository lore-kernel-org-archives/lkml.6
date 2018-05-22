Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751439AbeEVLyR (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 07:54:17 -0400
Received: from sauhun.de ([88.99.104.3]:58436 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751236AbeEVLyQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 07:54:16 -0400
Date: Tue, 22 May 2018 13:54:14 +0200
From: Wolfram Sang <wsa@the-dreams.de>
To: George Cherian <george.cherian@cavium.com>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org,
        jglauber@cavium.com, kamlakant.patel@cavium.com,
        mchehab+samsung@kernel.org, davem@davemloft.net,
        gregkh@linuxfoundation.org, akpm@linux-foundation.org,
        linus.walleij@linaro.org, rdunlap@infradead.org
Subject: Re: [PATCH 4/4] i2c: xlp9xx: Add MAINTAINERS entry
Message-ID: <20180522115414.473odncwfdpgmcz7@ninjato>
References: <1526454019-32714-1-git-send-email-george.cherian@cavium.com>
 <1526454019-32714-5-git-send-email-george.cherian@cavium.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="z4aciq2vkq75z7wy"
Content-Disposition: inline
In-Reply-To: <1526454019-32714-5-git-send-email-george.cherian@cavium.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--z4aciq2vkq75z7wy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 16, 2018 at 12:00:19AM -0700, George Cherian wrote:
> The i2c XLP9xx driver is maintained by Cavium.
> Add George Cherian and Jan Glauber as the Maintainers.
>=20
> Signed-off-by: George Cherian <george.cherian@cavium.com>
> ---
>  MAINTAINERS | 8 ++++++++
>  1 file changed, 8 insertions(+)
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index df6e9bb..68da265 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -15509,6 +15509,14 @@ L:	linux-kernel@vger.kernel.org
>  S:	Supported
>  F:	drivers/char/xillybus/
> =20
> +XLP9XX I2C DRIVER
> +M:	George Cherian <george.cherian@cavium.com>
> +M:	Jan Glauber <jglauber@cavium.com>

Jan, I need an explicit ACK from you for this change.


--z4aciq2vkq75z7wy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlsEBOYACgkQFA3kzBSg
KbZw8Q/8DkBUb+wq1cl5Cxq/TtxP+qC359yuqNWB94jhvOCSZ0Lug0BBYpJKH6ZI
kF4s4hb8z/RaldItl3MOPal5uEcPuCg3rUS51yGA85go/1XUskP+9e8BU9coaP40
0ZMM2D3wovEFdV+v0GJSxeqxyddTMxPP1BuPzGIfosHY0bvjRPCvGCiWXIGMhs5j
OlhljgUnUzho+bNK+qJHdkPZfyM/qD2hqVwYnlTyLQxddoxCiOCLWI7a96QX20OW
7p0s01/9E31lG0TkUsnwj0d2IDaxXV2O0iENVskCIFWgdWsW98uJqSEwARRUU7c8
cUUeyITzKultT4yVPDANjIVA8RE7Dw3rUSZk6Lic7BJK8Q/Wkls6M0XUCmO6dkXC
39KRDNG9E8b/KwZKu3P2m6q2ml8CB4+WIZXFYW5F8UtumcbUIJ3wswAjOQjIJdWg
c8PXvICkEww6Amv6n6//KCJ3pJjuRx+CdMXs5JhdKxI5uOtNNLeL51LjM3fj+pmA
eDxgEwy8I2odh7/7sRZgLybSxbfpUaije5biaf+Zu5rPwY/UwHC1WZEvJh59xcSL
rkQYD1WrCz1bjQ8RpiJpoDbzCNra/UVbl0lvJXGcpGFAeDAJZQNUM5Ni2RheWuRD
heKwK3R+1V/JP/VPffEpuBjnN+Exgz75UX91pDFJRNO7HpFzXmU=
=IlIB
-----END PGP SIGNATURE-----

--z4aciq2vkq75z7wy--
