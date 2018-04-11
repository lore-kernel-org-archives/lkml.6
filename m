Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753267AbeDKQCG (ORCPT <rfc822;w@1wt.eu>);
        Wed, 11 Apr 2018 12:02:06 -0400
Received: from anholt.net ([50.246.234.109]:44688 "EHLO anholt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752664AbeDKQCE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Apr 2018 12:02:04 -0400
From: Eric Anholt <eric@anholt.net>
To: Matheus Castello <matheus@castello.eng.br>, robh@kernel.org,
        stefan.wahren@i2se.com
Cc: linus.walleij@linaro.org, mark.rutland@arm.com, robh+dt@kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Matheus Castello <matheus@castello.eng.br>
Subject: Re: [PATCH v5 1/3] dt-bindings: pinctrl: bcm2835-gpio: Add generic pinctrl support
In-Reply-To: <1523422726-7910-2-git-send-email-matheus@castello.eng.br>
References: <f500b25c-eea0-9f01-7d7b-5a9dd90c50fa@castello.eng.br> <1523422726-7910-1-git-send-email-matheus@castello.eng.br> <1523422726-7910-2-git-send-email-matheus@castello.eng.br>
User-Agent: Notmuch/0.22.2+1~gb0bcfaa (http://notmuchmail.org) Emacs/25.2.2 (x86_64-pc-linux-gnu)
Date: Wed, 11 Apr 2018 09:02:02 -0700
Message-ID: <87bmeppw91.fsf@anholt.net>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha512; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain

Matheus Castello <matheus@castello.eng.br> writes:

> Added generic pin configuration and multiplexing support,
> and should be preferred than brcm legacy one.
>
> Signed-off-by: Matheus Castello <matheus@castello.eng.br>
> ---
>  .../devicetree/bindings/pinctrl/brcm,bcm2835-gpio.txt  | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)

All 3 patches are:

Reviewed-by: Eric Anholt <eric@anholt.net>

Thanks for doing this!

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE/JuuFDWp9/ZkuCBXtdYpNtH8nugFAlrOMXoACgkQtdYpNtH8
nuj/1g//fxXVtZo3a5iog1ZPJ+ZHt2TI1AKXnCcQ6dF1gdsHD4FOF3UqnK1I87Aj
V38Fv3b3l3vMNvrRZp4y6evU/+1Xa7AbAbKTE+TCqmAPsLM06ECFtjax9gqIf5tI
gDa46IO63fLNmAEFVy3bi0UyjmHka6zvOycXnOihpuwXjErrcf0UOuFflyBHIEFR
b2SQcPAPf6+Q9GhGOAZF1kO7JpTkBxfSptXKYajkCTfUfgVYrOUFtjn6I8BYEvp6
hxVFjwimABfhhhAE5hRj6lyCFq90z/y0pwu2LpYA9moR0Pxw04Ht95pGtrs/MQYc
UBzQ6e+gU7dNfwA9vtr7kRwqR7PT/QCuASUvTOFAigypXDACjLbjQHYxnZJQl3El
lRdgMvdW23t8/LQb+/sgsJLAprBYp3RE72EJ/mtxZUYhqqHYGB+Wuav3mSo1ZVvV
xksZCMNGzm7vHgp32c1T/SWKTJ3tpDNfu8mVJw2yJY6uE8ahfgxbQGINf4CAfNhh
9W2YAHyL6Mipz5JfFVZmMn/WKKgPn+gA17QVpFdLJOr/M/nOVODiYI31krvfNFlP
3y9XfGMyHoF3bDMO962u3kmDAe8yJRVRVO2T/354AVmL4Is9IR2er88DkFa7MjBn
yT4DMkILqgkGOfk9xwJ306QNF4mHZ4AuR+Tlh46fPkQXGa+yu/A=
=UWDk
-----END PGP SIGNATURE-----
--=-=-=--
