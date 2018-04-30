Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752913AbeD3J2X (ORCPT <rfc822;w@1wt.eu>);
        Mon, 30 Apr 2018 05:28:23 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:52940 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751426AbeD3J2U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Apr 2018 05:28:20 -0400
X-Google-Smtp-Source: AB8JxZqckeV+ZasQ+1gsf+htbnRzrq9GAcppKAbPjoVwzqrxSZRoPwfk0RQgejv28WDc6jTVjttgNg==
Date: Mon, 30 Apr 2018 11:28:17 +0200
From: Thierry Reding <thierry.reding@gmail.com>
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 43/61] pwm: simplify getting .drvdata
Message-ID: <20180430092817.GB2270@ulmo>
References: <20180419140641.27926-1-wsa+renesas@sang-engineering.com>
 <20180419140641.27926-44-wsa+renesas@sang-engineering.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="lEGEL1/lMxI0MVQ2"
Content-Disposition: inline
In-Reply-To: <20180419140641.27926-44-wsa+renesas@sang-engineering.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--lEGEL1/lMxI0MVQ2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 19, 2018 at 04:06:13PM +0200, Wolfram Sang wrote:
> We should get drvdata from struct device directly. Going via
> platform_device is an unneeded step back and forth.
>=20
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---
>=20
> Build tested only. buildbot is happy. Please apply individually.
>=20
>  drivers/pwm/pwm-atmel-tcb.c | 6 ++----
>  drivers/pwm/pwm-rcar.c      | 3 +--
>  2 files changed, 3 insertions(+), 6 deletions(-)

Applied, thanks.

Thierry

--lEGEL1/lMxI0MVQ2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlrm4bEACgkQ3SOs138+
s6Hr0g//XBCtOzuvmEltFaOwqj2kf7ee6IoPhckcA9MCgONUrlwUYpwJPDXjkmNw
ADxKNgEc4IpySGMSdvI9xo/kVPOyX3EHw3RC9RxsZbuOVCTfY007pbsUUtDSJjZT
Z9QljEOcfP0QuCY2AOyU3SkGzMy9vvh/acMLvqdYYtYLbYkZuhxtqDd5rrUw3s/t
SifMTmxY2/Z8TBhFXBSarPFpnXNiGvnutwSZYuqKhMFEiGxWbac6P9tgy+hgSg6t
iA6ACNOrJLmxo60NegWqRNmRof5XUQN/V0Zh52GgsIsVjx/vQTRRKoTqwwLM3xmn
5rqE5uHCfZ6JJNyrB2LlhUdGI7VrOjrqQIkvxjIz79Avj2rC47Oku0FKU+PQ7Nxj
2mI1p1Xye+CXecW+IdtYB/NT0OgRaYHGd+FjH6RjwgwmCRQIrA0wWcA2QNqA4iV8
Z4EAZhYUcMXXShA1t1a8vld1lP1na4FWhUhe32F5GhM//jx5klaGImx2STfy8BQg
lyguqB7Brthsm0Ue1gdZvmqZDulqzxGajR0/c1/eQxYhgRLc13BwggCXBkV4Ugba
q3VrGLbB+2NGP3HnO1k9DPxHjvl+bFaxHF0Q1BvaViqL0bzjl8SYasePtf45UUTn
j4Oxz/nhpzCpHvJ5sgnkO1KSysjeAEXCzSRbCSkLM1D6/UPhkRc=
=YVQV
-----END PGP SIGNATURE-----

--lEGEL1/lMxI0MVQ2--
