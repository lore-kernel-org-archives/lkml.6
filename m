Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751827AbeCVR7J (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Mar 2018 13:59:09 -0400
Received: from mail.bootlin.com ([62.4.15.54]:52488 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751611AbeCVR7H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Mar 2018 13:59:07 -0400
Date: Thu, 22 Mar 2018 18:59:04 +0100
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Andre Przywara <andre.przywara@arm.com>
Cc: Harald Geyer <harald@ccbib.org>, Chen-Yu Tsai <wens@csie.org>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Icenowy Zheng <icenowy@aosc.io>,
        info@olimex.com
Subject: Re: [PATCHv2 5/5] arm64: allwinner: a64: Add support for TERES-I
 laptop
Message-ID: <20180322175904.j2aho4tglifezzhq@flea>
References: <20180315162510.11669-1-harald@ccbib.org>
 <20180315162510.11669-6-harald@ccbib.org>
 <20180318202251.5gpv6sblfr4edxmj@flea>
 <E1exwhF-0000Qw-4g@stardust.g4.wien.funkfeuer.at>
 <20180320141353.zmzq4e5652rsp4ye@flea>
 <0288a32a-bbbf-20ca-2ebf-6fc8e82168df@arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="2ttze3nocb22ulyv"
Content-Disposition: inline
In-Reply-To: <0288a32a-bbbf-20ca-2ebf-6fc8e82168df@arm.com>
User-Agent: NeoMutt/20180223
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--2ttze3nocb22ulyv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 20, 2018 at 05:09:47PM +0000, Andre Przywara wrote:
> Hi,
>=20
> On 20/03/18 14:13, Maxime Ripard wrote:
> > On Mon, Mar 19, 2018 at 04:27:36PM +0100, Harald Geyer wrote:
> >>> together with all the patches but the
> >>> PWM (so I had to drop the backlight node as well).
> >>>
> >>> Please coordinate with Andre about who should send the PWM support.
> >>
> >> Seems the patch got broken because only the backlight node but not the
> >> pwm node was removed. Anyway, since Andre has already sent an updated
> >> version of his series, maybe just revert the broken patch, merge his
> >> series and then apply the original teres-i patch again?
> >=20
> > Unfortunately, there's dependencies on the PWM driver itself, and the
> > maintainer hasn't replied yet.
>=20
> But those dependencies are purely "administrative", not technical,
> aren't they? As the existing driver worked already with the DT changes,
> it's just the listing of the compatible strings in the binding doc that
> is missing? IIRC we added those later on in the past already.
>=20
> So I think it's safe to merge them independently:
> "[PATCH v2 1/4] pwm: sun4i: drop unused .has_rdy member" and
> "[PATCH v2 2/4] pwm: sun4i: simplify controller mapping" are
> PWM fixes and go via Thierry, I guess.
>=20
> "[PATCH v2 3/4] dt-bindings: pwm: sunxi: add new compatible strings" is
> just Documentation of existing behaviour, and independent from 1/4 and 2/=
4.
>=20
> "[PATCH v2 4/4] dts: sunxi: A64: Add PWM controllers" just "softly"
> depends on the introduction of the compatible strings in 3/4, but has no
> real technical dependency. It can go in any time on its own without
> breaking the build or functionality.
>=20
> Or am I too sloppy here?

As far as I know, Thierry never commented on any version of these
patches, so I'd still like to get his review first.

Maxime

--=20
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com

--2ttze3nocb22ulyv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAlqz7ucACgkQ0rTAlCFN
r3RHFA//V0g5uZDSnhCoGV/8KoEeEeA/MfWgk0NRCUPYDEtZboEj151nf8o0+9Cb
TCtE9vGuUzB2QqIR/nZJTFN9vju5XLGx+t5WG3DEIUzYIMniJQCOUMeOTedjg9lX
kBsnlC5AxkKtTcbRXLvrChGHIrt575g1Jv1GmazD6XJXOtJxAHNomEzwXDBIhh6K
46nsgD+cfmwmRWz5/IOR5sDVlAUySWbI9DMTF3BIk1QQBqno4+kM9l15DXt+2MIR
/Si8fOd3BMddt8P524i4qp58Euer3ogz3ejAi+G0L+L5vH6amTgOmpKU060y8hZo
VzAZEWwdTdiPP/G5ZpI4Dqg4WUHRm2vZjU+xlgZejhS7CzbyrIiP6x89xoFJ5wR6
9KHqn1YPTK1ZJFukcsX6rFp2rpR8HfzPyZzlA73vhMWgEkifP7zCjXq/66bXrV7p
Ms21a8L6ysa0all7R85NVy4IzsbFV3Qqz7T2ePjiBzqXKHdiYiVVoih5IOY7sBWb
fgOXRMOTVyMXB7LBG6as63nsZmRkjRuXYBSmYuX51Cqev+tdStFhdtvJ7OapUZrj
Rv074TlqlhzmXmTyCYcKVNqFuT/ukkI4OnOJCIp203n8yQK5t04y0FgVrG/K7ABT
IoYnicbBvkKVs5RVBJYLjskQS0N3G/yF1BJrm+PrdSdFMvfatDA=
=0QYc
-----END PGP SIGNATURE-----

--2ttze3nocb22ulyv--
