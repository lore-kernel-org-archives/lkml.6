Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755201AbeDFOOH (ORCPT <rfc822;w@1wt.eu>);
        Fri, 6 Apr 2018 10:14:07 -0400
Received: from relay8-d.mail.gandi.net ([217.70.183.201]:34729 "EHLO
        relay8-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752944AbeDFOOF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Apr 2018 10:14:05 -0400
X-Originating-IP: 2.224.242.101
Date: Fri, 6 Apr 2018 16:13:57 +0200
From: jacopo mondi <jacopo@jmondi.org>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Jacopo Mondi <jacopo+renesas@jmondi.org>, horms@verge.net.au,
        magnus.damm@gmail.com, geert@linux-m68k.org,
        niklas.soderlund@ragnatech.se, sergei.shtylyov@cogentembedded.com,
        dri-devel@lists.freedesktop.org, linux-renesas-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 0/2]  drm: Add Thine THC63LVD1024 LVDS decoder bridge
Message-ID: <20180406141357.GN20945@w540>
References: <1523020092-25540-1-git-send-email-jacopo+renesas@jmondi.org>
 <6903975.GkMFuzh9fq@avalon>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="JB7KW7Ey7eB5HOHs"
Content-Disposition: inline
In-Reply-To: <6903975.GkMFuzh9fq@avalon>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--JB7KW7Ey7eB5HOHs
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Laurent,

On Fri, Apr 06, 2018 at 04:53:43PM +0300, Laurent Pinchart wrote:
> Hi Jacopo,
>
> On Friday, 6 April 2018 16:08:05 EEST Jacopo Mondi wrote:
> > Hello,
> >    this series enables HDMI display on V3M Eagle board.
> >
> > The series is based on Geert's "renesas-drivers-2018-04-03-v4.16" with
> > THC63LVD1024 driver on top (cfr. my in review series:
> > "[PATCH v7 0/2]  drm: Add Thine THC63LVD1024 LVDS decoder bridge")
>
> This isn't a good base for development, as you would pull way too many
> dependencies in. Could you please base v8 on top of v4.17-rc1 (or if you =
get
> to post it before v4.17-rc1 gets merged, you can use Linus' master, as the
> ARM64 DT pull requests for v4.17-rc1 have been merged) ? It will then be =
ready
> for Simon to pull in his v4.18 branch.

I used renesas-drivers as it already contains partial r8a77970 support which
is not there in v4.16 (PFC, GPIO, SCIF...)

I should wait for v4.17-rc1 to come out and re-propose on top of that
probably.

>
> > This series includes some preliminary work from Sergei and Niklas. I ha=
ve
> > reworked the two final patches from Niklas to enable DU first, add the =
LVDS
> > decoder node, and finally add the ADV7511W chip and enable HDMI output.
> >
> > A branch for testing is available at:
> > git://jmondi.org/linux v3m/renesas-drivers-2018-04-03-v4.16/v7-eagle-dts
> >
> > Thanks
> >    j
> >
> > Jacopo Mondi (2):
> >   arm64: dts: renesas: eagle: Enable DU
> >   arm64: dts: renesas: eagle: Add LVDS decoder
> >
> > Niklas S=C3=B6derlund (2):
> >   arm64: dts: renesas: r8a77970: add the LVDS instance
> >   arm64: dts: renesas: eagle: Add ADV7511W and HDMI output
> >
> > Sergei Shtylyov (3):
> >   arm64: dts: renesas: r8a77970: add FCPVD support
> >   arm64: dts: renesas: r8a77970: add VSPD support
> >   arm64: dts: renesas: r8a77970: add DU support
> >
> >  arch/arm64/boot/dts/renesas/r8a77970-eagle.dts | 89 ++++++++++++++++++=
+++++
> >  arch/arm64/boot/dts/renesas/r8a77970.dtsi      | 73 ++++++++++++++++++=
+++
> >  2 files changed, 162 insertions(+)
> >
>
> --
> Regards,
>
> Laurent Pinchart
>
>
>

--JB7KW7Ey7eB5HOHs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJax4ClAAoJEHI0Bo8WoVY8ZqkP/0ImMs0Vp/w8mucupnP0kyYY
uQ4Fb29BGuBM7Ofz67bSbH/EI9y50X+4Z6IG+l0M+y7piSn8JB3ciRJ9uOdGgisl
EYUCMCdM6P8JesJPk1KMUbPDJTrQAdkkT11C+9daXWa2rykzpEt+ACF9ykCxDf4+
4AM0RstwzKQhWE78/z19memKsc20FZAPPkoMx4URuQSRAZ8wT0uVAMEsuKW1qfPE
zl72DJuW8CC7I1mQ7E0xIr+KR7WiQVXIRLtnwfhvTu2j/9EgOtpPy+sqFNJ8Ju3Y
rUs8z1l3Jtu4YYDr35sY7LGtMNplQJczvAgYuB78YaUNVYXvw5Tl/c3+ZRKYyXRd
XB99ppriFK0i5OadmIhqw6tco9Bxf7x1kXO8g+l0lmYptInbSOZJe7aX8FgN2YG9
OZQ/lYK9Zs0uy7IG3CDrHFsuybzfsccad7x00LE62YK2DglquA2u6jQxe1zMYKtN
DSN/Pwd81QB3/IYYkkztgjjj9dYcjmbt9A5iNuvHnUgzCYAB+di2TXVe8xXVv7N4
JU51W1wqBx8aonh1FolaIY2d5Fi7Vs7j8WYuhdB6NfeGVnmKCCi1icnV8uUf92tw
+eKoyfyShmfypOfmrW7SrarYb0TG5tZAf5TQI86E+EEgbFVa4gvHw5ORdvNFqKyL
8FENS+DLpedr573avO0r
=YkYS
-----END PGP SIGNATURE-----

--JB7KW7Ey7eB5HOHs--
