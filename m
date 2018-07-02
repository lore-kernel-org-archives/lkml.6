Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F169FC3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 05:04:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9D012555B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 05:04:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9D012555B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752893AbeGBFEq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 01:04:46 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:37845 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751419AbeGBFEm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 01:04:42 -0400
Received: from soja.hi.pengutronix.de ([2001:67c:670:100:3ad5:47ff:feaf:13da])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <o.rempel@pengutronix.de>)
        id 1fZr0n-0000zT-TB; Mon, 02 Jul 2018 07:04:29 +0200
Subject: Re: [PATCH v7 3/6] kernel/reboot.c: export pm_power_off_prepare
To:     Shawn Guo <shawnguo@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Mark Brown <broonie@kernel.org>, kernel@pengutronix.de,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Russell King <linux@armlinux.org.uk>, linux-pm@vger.kernel.org
References: <20180517055014.6607-1-o.rempel@pengutronix.de>
 <20180517055014.6607-4-o.rempel@pengutronix.de>
 <daba73df-037c-2583-3a08-f3f27c4129d1@pengutronix.de>
 <2307533.g32PyNi9fl@aspire.rjw.lan> <20180617070527.GL16091@dragon>
From:   Oleksij Rempel <o.rempel@pengutronix.de>
Message-ID: <20738ca3-4289-9e44-ff74-9099b5b8c2b6@pengutronix.de>
Date:   Mon, 2 Jul 2018 07:04:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180617070527.GL16091@dragon>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="HiPCWAM0hvhY06dQMa7Wk95ToC7Gl2hlf"
X-SA-Exim-Connect-IP: 2001:67c:670:100:3ad5:47ff:feaf:13da
X-SA-Exim-Mail-From: o.rempel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--HiPCWAM0hvhY06dQMa7Wk95ToC7Gl2hlf
Content-Type: multipart/mixed; boundary="otFWDJEXySuV7qS8y6T1ZFssVlkaKfQop";
 protected-headers="v1"
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Shawn Guo <shawnguo@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Mark Brown <broonie@kernel.org>, kernel@pengutronix.de,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
 Andrew Morton <akpm@linux-foundation.org>,
 Liam Girdwood <lgirdwood@gmail.com>,
 Leonard Crestez <leonard.crestez@nxp.com>, Rob Herring <robh+dt@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Michael Turquette <mturquette@baylibre.com>,
 Stephen Boyd <sboyd@codeaurora.org>, Fabio Estevam <fabio.estevam@nxp.com>,
 Russell King <linux@armlinux.org.uk>, linux-pm@vger.kernel.org
Message-ID: <20738ca3-4289-9e44-ff74-9099b5b8c2b6@pengutronix.de>
Subject: Re: [PATCH v7 3/6] kernel/reboot.c: export pm_power_off_prepare
References: <20180517055014.6607-1-o.rempel@pengutronix.de>
 <20180517055014.6607-4-o.rempel@pengutronix.de>
 <daba73df-037c-2583-3a08-f3f27c4129d1@pengutronix.de>
 <2307533.g32PyNi9fl@aspire.rjw.lan> <20180617070527.GL16091@dragon>
In-Reply-To: <20180617070527.GL16091@dragon>

--otFWDJEXySuV7qS8y6T1ZFssVlkaKfQop
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Hi Rafael,

it is two weeks since this email. Probably it was lost some where in the
space time continuum.
Can you please respond to it :)

On 17.06.2018 09:05, Shawn Guo wrote:
> On Tue, Jun 12, 2018 at 04:33:05PM +0200, Rafael J. Wysocki wrote:
>> On Tuesday, June 12, 2018 2:42:12 PM CEST Oleksij Rempel wrote:
>>>  This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
>>> --Sj2PRcQlY7eZybdA0sq9wWzJEO8fKS924
>>> Content-Type: multipart/mixed; boundary=3D"d6BZYFRi4L3iCmOh3nm6wjii3d=
WC9QFDg";
>>>  protected-headers=3D"v1"
>>> From: Oleksij Rempel <o.rempel@pengutronix.de>
>>> To: Shawn Guo <shawnguo@kernel.org>, Mark Brown <broonie@kernel.org>,=

>>>  "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
>>> Cc: kernel@pengutronix.de, devicetree@vger.kernel.org,
>>>  linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
>>>  linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.o=
rg>,
>>>  Liam Girdwood <lgirdwood@gmail.com>,
>>>  Leonard Crestez <leonard.crestez@nxp.com>, Rob Herring <robh+dt@kern=
el.org>,
>>>  Mark Rutland <mark.rutland@arm.com>,
>>>  Michael Turquette <mturquette@baylibre.com>,
>>>  Stephen Boyd <sboyd@codeaurora.org>, Fabio Estevam <fabio.estevam@nx=
p.com>,
>>>  Russell King <linux@armlinux.org.uk>
>>> Message-ID: <daba73df-037c-2583-3a08-f3f27c4129d1@pengutronix.de>
>>> Subject: Re: [PATCH v7 3/6] kernel/reboot.c: export pm_power_off_prep=
are
>>> References: <20180517055014.6607-1-o.rempel@pengutronix.de>
>>>  <20180517055014.6607-4-o.rempel@pengutronix.de>
>>> In-Reply-To: <20180517055014.6607-4-o.rempel@pengutronix.de>
>>>
>>> --d6BZYFRi4L3iCmOh3nm6wjii3dWC9QFDg
>>> Content-Type: text/plain; charset=3Dutf-8
>>> Content-Language: en-US
>>> Content-Transfer-Encoding: quoted-printable
>>>
>>> Hi Rafael,
>>>
>>> Last version of this patch was send at 17.05.2018. No other comment w=
as
>>> provided and this patch is a blocker for other patches in this serie.=

>>> Can you please give some feedback on it.
>>
>> I would have done that had I not missed the patch.
>>
>> Which probably wouldn't have happened had you CCed it to linux-pm.
>>
>> Anyway, I have no particular problems with exporting pm_power_off_prep=
are via
>> EXPORT_SYMBOL_GPL().
>=20
> Rafael,
>=20
> Can we have your explicit Acked-by tag on this patch?  Thanks.
>=20
> Shawn
>=20


--otFWDJEXySuV7qS8y6T1ZFssVlkaKfQop--

--HiPCWAM0hvhY06dQMa7Wk95ToC7Gl2hlf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEpENFL0P3hvQ7p0DDdQOiSHVI77QFAls5slYACgkQdQOiSHVI
77R2sAf/X9mHyHBxUk8NRvP4/mSj0ZBzaD6H/acG8rx5PgaoeiCETAdfU1+PRb55
KwMwyreI14fsuYpZch45Kteub768zhZfc3J8uhZTGECZ/be+AOid3XzgjvZ4Rma7
rut3U7XgXHMHY41m9Q9y6H6OXvwlJjsyUUPYYN2e4d1fPNYcAc7PMK2570bPRAxh
nv5n/TpiDorfh83c6mApCQtrMmHUPY5m71k/DtnnbdtulO3E6PHC/qiQzFywQPB6
YpZHNW/G9DjgFgA4purXQz1ql4W/fPWAe7N9QeTpe7Dbm24+6cywJKpEs70impOo
hs0gsMlodRhWgpLvKV3/jFVY651u1w==
=7pZD
-----END PGP SIGNATURE-----

--HiPCWAM0hvhY06dQMa7Wk95ToC7Gl2hlf--
