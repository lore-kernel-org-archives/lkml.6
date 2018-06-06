Return-Path: <linux-kernel-owner@vger.kernel.org>
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 8463B60263
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932309AbeFFG6Z (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 02:58:25 -0400
Received: from mail.bootlin.com ([62.4.15.54]:37366 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932239AbeFFG6X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 02:58:23 -0400
Date: Wed, 6 Jun 2018 08:58:11 +0200
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Chen-Yu Tsai <wens@csie.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, arm-soc <arm@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        ionela.voinescu@arm.com,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        chris.redpath@arm.com, devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V2 2/2] arm: dts: sunxi: Add missing cooling device
 properties for CPUs
Message-ID: <20180606065811.moklm4pbrhleasly@flea>
References: <20180601151701.sshwfdbflic6mybv@flea>
 <d894f425b7c32bce4dc4a982db8f4dface2db31d.1528173943.git.viresh.kumar@linaro.org>
 <a313ec0be4104494de319e8318e05614fb97b2fd.1528173943.git.viresh.kumar@linaro.org>
 <20180605071139.osu2pgpg3ychdxln@flea>
 <CAGb2v65EX2RwKjxPw+EK4i6rkfgOJoCU2amuFkF-tHQT40isxw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="yyunednjohhozaln"
Content-Disposition: inline
In-Reply-To: <CAGb2v65EX2RwKjxPw+EK4i6rkfgOJoCU2amuFkF-tHQT40isxw@mail.gmail.com>
User-Agent: NeoMutt/20180512
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--yyunednjohhozaln
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 06, 2018 at 12:02:20AM +0800, Chen-Yu Tsai wrote:
> On Tue, Jun 5, 2018 at 3:11 PM, Maxime Ripard <maxime.ripard@bootlin.com>=
 wrote:
> > On Tue, Jun 05, 2018 at 10:17:49AM +0530, Viresh Kumar wrote:
> >> The cooling device properties, like "#cooling-cells" and
> >> "dynamic-power-coefficient", should either be present for all the CPUs
> >> of a cluster or none. If these are present only for a subset of CPUs of
> >> a cluster then things will start falling apart as soon as the CPUs are
> >> brought online in a different order. For example, this will happen
> >> because the operating system looks for such properties in the CPU node
> >> it is trying to bring up, so that it can register a cooling device.
> >>
> >> Add such missing properties.
> >>
> >> Fix other missing properties (clocks, OPP, clock latency) as well to
> >> make it all work.
> >>
> >> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> >
> > Applied both, thanks!
>=20
> Please fix the "ARM" prefix when applying. :)

Done, thanks for the reminder :)

Maxime

--=20
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com

--yyunednjohhozaln
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAlsXhgIACgkQ0rTAlCFN
r3SpHw//Q0Tq2mev9+RBCUU4pHRg4oFhrh8cuVYbAENhw3Lsld3QjfDM0OlUubg2
cJHQNbpZzKmNg3Of2U2BIR2ZWOncQNItn7tCwZ7p6hGtM3AO72Zv1bzwyHnZUIOm
22biaTtyF5TPO4m4sThbVa0xo2lpYBcNbM4ZZiH5Ss8pObpJeZBysHTAvXb/TKPW
l5rlTO08NfFSF1XfyUNmJtGQAOSoGC+Wb+0vSxVOsMdSfMvuTbRa8Lx18f2xuMNL
kTLsrGUir9RjWE/33M0SUEmFONKAmbZUpyEiazBsmIFQ6HqFq+1/oNPg0AKeV2M5
cJSbRutZl0/hao4Jqu4P4mdsWarTPHyN22Tuh3mORauBcRuM95ro8sNfxCFHRKit
AOEFGn3MarZymmzVVegctwZfQkSprspmWE9WdH867zViKK1d6nNrl9iN8eYhX6De
HVTUeyEgVdxxVIT3XBOfuenBr36mnxus0xgRZxrxuyNfcOE8225vPhnfT/xEhSj0
bPvhLj6oXWPJFkcxd+sXe+LgK7Qogm7Zz55zU6yCzN9zU/LLfiCP2YS3ftl83leY
gHKp6Al5cpNqeegjMGKiKqzZZAYURooyFcLSe6g4xcRFxoRvYwza+UGxcNhwk38x
W3ze64MAfwqCYqDvyKVwKHRlOqqu2Dv3PucN3MMhEIOHbHe+fRE=
=Osr5
-----END PGP SIGNATURE-----

--yyunednjohhozaln--
