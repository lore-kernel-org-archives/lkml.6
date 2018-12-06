Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF1C3C04EB9
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 00:10:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8AB582146D
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 00:10:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8AB582146D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=collabora.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728886AbeLFAKw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 19:10:52 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:51914 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727575AbeLFAKw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 19:10:52 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 6C9D6260CCA
Received: by earth.universe (Postfix, from userid 1000)
        id 1243B3C08D6; Thu,  6 Dec 2018 01:10:48 +0100 (CET)
Date:   Thu, 6 Dec 2018 01:10:48 +0100
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Baolin Wang <baolin.wang@linaro.org>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        yuanjiang.yu@unisoc.com, broonie@kernel.org
Subject: Re: [PATCH 0/5] Add new features for SC27XX fuel gauge driver
Message-ID: <20181206001048.awfhmigouztqs6td@earth.universe>
References: <cover.1542185618.git.baolin.wang@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="6fkbibezpeowkax5"
Content-Disposition: inline
In-Reply-To: <cover.1542185618.git.baolin.wang@linaro.org>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--6fkbibezpeowkax5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Nov 14, 2018 at 05:07:03PM +0800, Baolin Wang wrote:
> This patch set adds some new features for SC27XX fuel gauge driver.
>=20
> 1. Read calibration data from eFuse device to calibrate fuel gauge.
> 2. Add low voltage alarm to adjust the battery capacity in lower
> voltage stage.
> 3. Add power management interfaces
> 4. Save last optimized battery capacity to be used as the initial
> battery capacity if system is not first power-on.
>=20
> Baolin Wang (2):
>   dt-bindings: power: supply: Add nvmem properties to calibrate FGU
>   power: supply: sc27xx: Add fuel gauge calibration
>=20
> Yuanjiang Yu (3):
>   power: supply: sc27xx: Add fuel gauge low voltage alarm
>   power: supply: sc27xx: Add suspend/resume interfaces
>   power: supply: sc27xx: Save last battery capacity
>=20
>  .../devicetree/bindings/power/supply/sc27xx-fg.txt |    4 +
>  drivers/power/supply/sc27xx_fuel_gauge.c           |  453 ++++++++++++++=
+++++-
>  2 files changed, 444 insertions(+), 13 deletions(-)

I applied patches 1-4 and skipped patch 5 due to pending changes.

-- Sebastian

--6fkbibezpeowkax5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlwIaQUACgkQ2O7X88g7
+pqLKw/+IlpcbeCdt+0onz8HK1cf8vvuwgBApnTWGQftNy46FEcy+pmQQSUCs05N
CEG6FAyhp/d2BmHhpeGvAXgDGtKWzW2kRl4J8anQH/tiiE0lep8Mmjtjr2iuYzgr
5nEYPQgj/hGDlJPt4T6KDq+dpvtbrSYsxW9+r2USzfpH3xfvus+Ka9E/psX84oAV
xb8iB4qPTqGKbsGeJZs1Mmuo+Ml1QacQ6KFE8MnfiOLMaE1ynpjOhvYgzdLTqvwW
MaUbsLz4zk3mQIgqi7MCcNRngOBsDmtmKAOlOMuwQL0G5X65u9jbVPDi9PgyrSKf
OSwFfcWI42qXv6eL94xkfjiWdXjl5hTkfdlbtuRmLGZbvKNICREtd4R0cVNne9lv
IgouR2D8W2gdkSgx/euisA5xRpLlSaU8tt3WFMnvZ4+SCatDVKGiUbtXvZIDKI7G
ABrGcduf9tO8UUPNEAyypBuC+DX6DeAUt3VmvudRwNnS3iWRbapMNW3D3f/l8c3a
QsNx+bsGf5HCN2kKdhh804mWFgDC9nBUWntANwUiLbexyluSH9LrBYBDiIlFNbkW
6Mk/wqwNw7Hxcy5U5RR1aesN4WCpupglAWeuB3MQPFwgRFBBP6oK8AG2Pudwkefx
i/Q2SjpD6GUKK5g6Foo548qv3SnhtLbq/jImgViQdDesdrqNkq8=
=/pqc
-----END PGP SIGNATURE-----

--6fkbibezpeowkax5--
