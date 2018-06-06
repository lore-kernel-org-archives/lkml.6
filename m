Return-Path: <linux-kernel-owner@vger.kernel.org>
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jCPEEg9J"
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 024EB601D2
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932695AbeFFKp5 (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 06:45:57 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:53502 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932630AbeFFKpy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 06:45:54 -0400
X-Google-Smtp-Source: ADUXVKLNIcN7d5iQAJN6gl86MEXxoYJLrxjpREg03Wyn4WXcoi8arJ/vL38UFtue/RbngGem/21oOA==
Date: Wed, 6 Jun 2018 12:45:50 +0200
From: Thierry Reding <thierry.reding@gmail.com>
To: Dmitry Osipenko <digetx@gmail.com>
Cc: Peter De Schrijver <pdeschrijver@nvidia.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Prashant Gaikwad <pgaikwad@nvidia.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-tegra@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/5] Tegra20 External Memory Controller driver
Message-ID: <20180606104550.GK11810@ulmo>
References: <20180603223654.23324-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="RVlUGXxwBj5SDcM9"
Content-Disposition: inline
In-Reply-To: <20180603223654.23324-1-digetx@gmail.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--RVlUGXxwBj5SDcM9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 04, 2018 at 01:36:49AM +0300, Dmitry Osipenko wrote:
> Hello,
>=20
> Couple years ago the Tegra20 EMC driver was removed from the kernel
> due to incompatible changes in the Tegra's clock driver. This patchset
> introduces a modernized EMC driver. Currently the sole purpose of the
> driver is to initialize DRAM frequency to maximum rate during of the
> kernels boot-up. Later we may consider implementing dynamic memory
> frequency scaling, utilizing functionality provided by this driver.
>=20
> Changelog:
>=20
> v2:
> 	- Minor code cleanups like consistent use of writel_relaxed instead
> 	  of non-relaxed version, reworded error messages, etc.
>=20
> 	- Factored out use_pllm_ud bit checking into a standalone patch for
> 	  consistency.
>=20
> Dmitry Osipenko (5):
>   dt: bindings: tegra20-emc: Document interrupt property
>   ARM: dts: tegra20: Add interrupt to External Memory Controller
>   clk: tegra20: Turn EMC clock gate into divider
>   clk: tegra20: Check whether direct PLLM sourcing is turned off for EMC
>   memory: tegra: Introduce Tegra20 EMC driver

I took a brief look and didn't spot any dependencies between the clk and
memory patches. Is it correct that these can be applied separately?

Thierry

--RVlUGXxwBj5SDcM9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlsXu14ACgkQ3SOs138+
s6ESmRAAgk7ByRH8GWRq1Ksk7cukW8gtj4BjXdmxXTZ3g3WpV48CSdZ96NemAfqw
yZU3YzV/sb1D32i8hbCwrDWU5C1SmuKSkjnrBePyA+brHtzzuWI9KY149DjTi2Y3
qzoh+5/hgQ0lAxbh18RqpyTzfUSFOdBAUhhDyhdWO7pirdB59tMuNidiPNmZFFKB
9hDLaIjHWUOLDGFR3G48AgQDhwnN8xxgmNCpoCNUBsO5kkiQb/xDvOgzsQ+I8rjs
m+x1iY6LxqfrB/oxyh1uUj/m5Gd0vJTnIqJ981bUhPSUezeQQ/6Up9mP/v6lPOzw
dqIbIA7BG5vkOJ0mgi0CFeV6kdwmx8M6I3ZAAzvD1+FpcqgTqNpHSNNKTz1ro9iU
Nr6KStV2Dhu/enRqDuhtcE/OanPV90Q8/R/W5+wkIaG3bMVYMhgcjJTiPZCObXiD
pqQI+34TZj4M4EGQkRov/ZzBlSiknXGewsFdf0FD3sZIhLmDQfhm+9urApB8qmGt
vcwff3HkejKtpe4RwT1gbiL/log9um3+U5/Jdua0AOer/cs4hH/i9qiV8LSmCKeg
PKEBqnDkpNwuuHTgJEHR639jiqhnDCoR8kYDZOZYjv4Af9sfqmugQ4PpaiZXWyeU
rNGIaIrmOBO+RPDKrEaBWx4aQqAElQp8Z30TQvBW6cWTSIlzRb0=
=k4kO
-----END PGP SIGNATURE-----

--RVlUGXxwBj5SDcM9--
