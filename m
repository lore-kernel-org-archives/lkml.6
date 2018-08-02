Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12A82C43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 10:47:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5ACF21501
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 10:47:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5ACF21501
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732078AbeHBMiT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 08:38:19 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:52345 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726862AbeHBMiS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 08:38:18 -0400
Received: from soja.hi.pengutronix.de ([2001:67c:670:100:3ad5:47ff:feaf:13da])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <o.rempel@pengutronix.de>)
        id 1flB8o-0006P7-KE; Thu, 02 Aug 2018 12:47:34 +0200
Subject: Re: [PATCH v9 3/6] kernel/reboot.c: export pm_power_off_prepare
To:     Mark Brown <broonie@kernel.org>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        kernel@pengutronix.de, devicetree@vger.kernel.org,
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
        Russell King <linux@armlinux.org.uk>, linux-imx@nxp.com,
        yibin.gong@nxp.com, "A.s. Dong" <aisheng.dong@nxp.com>
References: <20180802103425.3053-1-o.rempel@pengutronix.de>
 <20180802103425.3053-4-o.rempel@pengutronix.de>
 <20180802104443.GH9117@sirena.org.uk>
From:   Oleksij Rempel <o.rempel@pengutronix.de>
Message-ID: <94d48ecb-7302-c7ed-e815-730be0426a04@pengutronix.de>
Date:   Thu, 2 Aug 2018 12:47:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180802104443.GH9117@sirena.org.uk>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="5AJLEBPFi8zhQJWYRI3WJOFLDJr5ahJGy"
X-SA-Exim-Connect-IP: 2001:67c:670:100:3ad5:47ff:feaf:13da
X-SA-Exim-Mail-From: o.rempel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--5AJLEBPFi8zhQJWYRI3WJOFLDJr5ahJGy
Content-Type: multipart/mixed; boundary="AXOb8o839w5QurrTYeEqtVxfDzvKm5doU";
 protected-headers="v1"
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Mark Brown <broonie@kernel.org>
Cc: Shawn Guo <shawnguo@kernel.org>,
 "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, kernel@pengutronix.de,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
 Andrew Morton <akpm@linux-foundation.org>,
 Liam Girdwood <lgirdwood@gmail.com>,
 Leonard Crestez <leonard.crestez@nxp.com>, Rob Herring <robh+dt@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Michael Turquette <mturquette@baylibre.com>,
 Stephen Boyd <sboyd@codeaurora.org>, Fabio Estevam <fabio.estevam@nxp.com>,
 Russell King <linux@armlinux.org.uk>, linux-imx@nxp.com, yibin.gong@nxp.com,
 "A.s. Dong" <aisheng.dong@nxp.com>
Message-ID: <94d48ecb-7302-c7ed-e815-730be0426a04@pengutronix.de>
Subject: Re: [PATCH v9 3/6] kernel/reboot.c: export pm_power_off_prepare
References: <20180802103425.3053-1-o.rempel@pengutronix.de>
 <20180802103425.3053-4-o.rempel@pengutronix.de>
 <20180802104443.GH9117@sirena.org.uk>
In-Reply-To: <20180802104443.GH9117@sirena.org.uk>

--AXOb8o839w5QurrTYeEqtVxfDzvKm5doU
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 02.08.2018 12:44, Mark Brown wrote:
> On Thu, Aug 02, 2018 at 12:34:22PM +0200, Oleksij Rempel wrote:
>> Export pm_power_off_prepare. It is needed to implement power off on
>> Freescale/NXP iMX6 based boards with external power management
>> integrated circuit (PMIC).
>=20
> I thought we'd got an ack for this from Raphael on a previous version o=
r
> am I mistaken?
>=20

No, we got an:
"Anyway, I have no particular problems with exporting
pm_power_off_prepare via EXPORT_SYMBOL_GPL()."

Should i see it as ACK?


--AXOb8o839w5QurrTYeEqtVxfDzvKm5doU--

--5AJLEBPFi8zhQJWYRI3WJOFLDJr5ahJGy
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEpENFL0P3hvQ7p0DDdQOiSHVI77QFAlti4T8ACgkQdQOiSHVI
77SA7Qf+PEBdxj2UynzNMWWjoQrpHpM98iIoXeKecu2cWw70ew2hGM6x07P+RcGH
R3JNhb7OioigTyxAEKf99TB4sRnoQwZKnaf2sBIUaT4w58rCIPNQV3zZJAmGef/U
o2n21ct8+G3DNgQ0HaK32XWVvtq0s0D0Jog60AH9gqTmBpC+jR+v1kVZ1CqI4Djm
urDDQjN4TusrUVlMCCWoVMhb1F8pddCrb6NAgBQQmK90wJJ+2eZzutvvEQMJMsUz
GFdQolaj/lOeuKzK1hZT6wRMh4OGRTln3jBuHYCdWJ5jLsuu+CMXww7mCZcfo8U3
v9w4e25L8O1m88nWMH5SA1ZwvHLGPw==
=YY42
-----END PGP SIGNATURE-----

--5AJLEBPFi8zhQJWYRI3WJOFLDJr5ahJGy--
