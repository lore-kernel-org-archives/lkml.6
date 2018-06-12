Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 86BDFC5CFF1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 12:42:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 376AC2089C
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 12:42:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 376AC2089C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754337AbeFLMmb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 08:42:31 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:48219 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754270AbeFLMma (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 08:42:30 -0400
Received: from soja.hi.pengutronix.de ([2001:67c:670:100:3ad5:47ff:feaf:13da])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <o.rempel@pengutronix.de>)
        id 1fSicu-0007XP-8P; Tue, 12 Jun 2018 14:42:20 +0200
Subject: Re: [PATCH v7 3/6] kernel/reboot.c: export pm_power_off_prepare
To:     Shawn Guo <shawnguo@kernel.org>, Mark Brown <broonie@kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc:     kernel@pengutronix.de, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Russell King <linux@armlinux.org.uk>
References: <20180517055014.6607-1-o.rempel@pengutronix.de>
 <20180517055014.6607-4-o.rempel@pengutronix.de>
From:   Oleksij Rempel <o.rempel@pengutronix.de>
Message-ID: <daba73df-037c-2583-3a08-f3f27c4129d1@pengutronix.de>
Date:   Tue, 12 Jun 2018 14:42:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180517055014.6607-4-o.rempel@pengutronix.de>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="Sj2PRcQlY7eZybdA0sq9wWzJEO8fKS924"
X-SA-Exim-Connect-IP: 2001:67c:670:100:3ad5:47ff:feaf:13da
X-SA-Exim-Mail-From: o.rempel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Sj2PRcQlY7eZybdA0sq9wWzJEO8fKS924
Content-Type: multipart/mixed; boundary="d6BZYFRi4L3iCmOh3nm6wjii3dWC9QFDg";
 protected-headers="v1"
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Shawn Guo <shawnguo@kernel.org>, Mark Brown <broonie@kernel.org>,
 "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc: kernel@pengutronix.de, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
 linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
 Liam Girdwood <lgirdwood@gmail.com>,
 Leonard Crestez <leonard.crestez@nxp.com>, Rob Herring <robh+dt@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Michael Turquette <mturquette@baylibre.com>,
 Stephen Boyd <sboyd@codeaurora.org>, Fabio Estevam <fabio.estevam@nxp.com>,
 Russell King <linux@armlinux.org.uk>
Message-ID: <daba73df-037c-2583-3a08-f3f27c4129d1@pengutronix.de>
Subject: Re: [PATCH v7 3/6] kernel/reboot.c: export pm_power_off_prepare
References: <20180517055014.6607-1-o.rempel@pengutronix.de>
 <20180517055014.6607-4-o.rempel@pengutronix.de>
In-Reply-To: <20180517055014.6607-4-o.rempel@pengutronix.de>

--d6BZYFRi4L3iCmOh3nm6wjii3dWC9QFDg
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Hi Rafael,

Last version of this patch was send at 17.05.2018. No other comment was
provided and this patch is a blocker for other patches in this serie.
Can you please give some feedback on it.

On 17.05.2018 07:50, Oleksij Rempel wrote:
> Export pm_power_off_prepare. It is needed to implement power off on
> Freescale/NXP iMX6 based boards with external power management
> integrated circuit (PMIC).
>=20
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> ---
>  kernel/reboot.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/kernel/reboot.c b/kernel/reboot.c
> index e4ced883d8de..83810d726f3e 100644
> --- a/kernel/reboot.c
> +++ b/kernel/reboot.c
> @@ -49,6 +49,7 @@ int reboot_force;
>   */
> =20
>  void (*pm_power_off_prepare)(void);
> +EXPORT_SYMBOL_GPL(pm_power_off_prepare);
> =20
>  /**
>   *	emergency_restart - reboot the system
>=20


--d6BZYFRi4L3iCmOh3nm6wjii3dWC9QFDg--

--Sj2PRcQlY7eZybdA0sq9wWzJEO8fKS924
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEpENFL0P3hvQ7p0DDdQOiSHVI77QFAlsfv6QACgkQdQOiSHVI
77Qdywf/T0Izrw+e0Li53mUZBC1xxmYwoUcLfZawU2SQsO4BWC3bRpOycrT5AOIZ
lrCTbNjBWl9a1AVF4FhiWj+u7WaOwo4QWQTFPUwHJ4mBii/IWfEcz+l6Ivu0SSlZ
FrZ//lJlaG67yUWG23ZiGNVTpNrdIoy2Awe5fBCy27IBdRf0INY3mB+VxqdCOwUu
Ch2emdFFSNOQSOEWQJDz9EObHLqf/7adzNgXuIUpSO33rXO9LJPxdY4VOdzhbfy7
Vq6x+Zl54rwyW4stbtklrBnkjjbgbvzqOSIutUEMOMwheohpIcUa6r8jDZXpHnCE
CVRJI4cEfYuMFRFR+SAhEDFuYEYwyQ==
=0P0j
-----END PGP SIGNATURE-----

--Sj2PRcQlY7eZybdA0sq9wWzJEO8fKS924--
