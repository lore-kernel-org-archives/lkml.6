Return-Path: <SRS0=7f4r=L6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.6 required=3.0 tests=DATE_IN_PAST_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 317D3ECE560
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Sep 2018 20:03:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6D7B2087E
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Sep 2018 20:03:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6D7B2087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=collabora.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728583AbeIQB0n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Sep 2018 21:26:43 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:47032 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728547AbeIQB0m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Sep 2018 21:26:42 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 791A727DAE4
Received: by earth.universe (Postfix, from userid 1000)
        id 3FBE93C0C4B; Sun, 16 Sep 2018 13:45:20 +0200 (CEST)
Date:   Sun, 16 Sep 2018 13:45:20 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Matheus Castello <matheus@castello.eng.br>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/4] power: supply: MAX17040: Add IRQ for low level and
 alert SOC changes
Message-ID: <20180916114520.4375nr2gv3y4ghzv@earth.universe>
References: <20180723040816.19455-1-matheus@castello.eng.br>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="k533wzevwisygjeg"
Content-Disposition: inline
In-Reply-To: <20180723040816.19455-1-matheus@castello.eng.br>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--k533wzevwisygjeg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Matheus,

Did I miss a v2 of this patchset, that solves the issues
found by Krzysztof?

-- Sebastian

On Mon, Jul 23, 2018 at 12:08:12AM -0400, Matheus Castello wrote:
> This series add IRQ handler for low level SOC alert, define a devicetree=
=20
> binding attribute to configure the alert level threshold and check for ch=
anges
> in SOC for send uevents.
>=20
> Max17040 have a pin for alert host about low level state of charge and th=
is=20
> alert can be configured in a threshold from 1% up to 32% of SOC.
>=20
> Tested on Raspberry Pi Zero W, with a SparkFun Lipo Fuel Gauge module bas=
ed on
> MAXIM MAX17043.
>=20
> Matheus Castello (4):
>   power: supply: max17040: Add IRQ handler for low SOC alert
>   power: supply: max17040: Config alert SOC low level threshold from FDT
>   dt-bindings: power: supply: Max17040: Add low level SOC alert threshold
>   power: supply: max17040: Send uevent in SOC changes
>=20
>  .../bindings/power/supply/max17040_battery.txt     | 24 ++++++
>  drivers/power/supply/max17040_battery.c            | 95 ++++++++++++++++=
++++++
>  2 files changed, 119 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/power/supply/max170=
40_battery.txt
>=20
> --=20
> 2.13.3
>=20

--k533wzevwisygjeg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlueQlAACgkQ2O7X88g7
+ppLrg/7BYjg6/pKDHyZ+vtYMvAJDd4hrJpRJ93dyzVNteZscXRWhaRj1JjQB2SY
pJi0IzL62/RwGT0Irtv5yetlYVtOv651sXa4ICY07OInLFMW3StSFGbR5NlnF2QF
YLhg4KUkGM08KbwIwPkVLWjKCyloUYIeRKAJnODhWuIH5FX3EH/sLUQCMvFHc1M2
wtnPPiOdGHOEZmzB0zEwJku6Ts0CkuYh4+UL95C3NkFQNJ1TPo9XVj18ovpGFIgF
LLpQY51Iz4EZeLvGmQvUt2u6tI45g93+LU7RBOyqFc9pSwhx0PDS8ZYz5ajPLL58
9GEeO79kD23T8ys6RJiBSUL3YLkMGuyukQJsTCO2eI8D7iX/L/yFjXkLTSmb7+a1
g0zQwDFtwiFypdJgvMR78h4hZdTK07SlDF3rUUcKxUONkJeekx26HE6Xjtv348e5
vtjLp9u6rrfvANPujIw2QF0VFWqaA/1TIwPtUgDivbHZo/BKHvAu3tUezIzfGUUM
XZTf7D6441KHHnM2/PnaPMjCvjxBnxatnCBiCX7n7oCRDiEzGkMG+YiYWp+ADLVy
lJ1ZSCboQbwPSnpW7ckcccyRLjExu78YVgVK+KaVC5YOxwp306bhRU1aApGNwLHN
YHeWVeK7s3rQJWSywQ6ObhI3jxylekC4FuHkggjDTWrTdgAiSVs=
=IHXf
-----END PGP SIGNATURE-----

--k533wzevwisygjeg--
