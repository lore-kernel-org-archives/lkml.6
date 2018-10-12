Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78353C6787C
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 19:34:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3EE812087D
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 19:34:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3EE812087D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727088AbeJMDH6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 23:07:58 -0400
Received: from mail.bootlin.com ([62.4.15.54]:58277 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726689AbeJMDH6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 23:07:58 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id B52BA2073D; Fri, 12 Oct 2018 21:33:54 +0200 (CEST)
Received: from qschulz (LFbn-1-10589-128.w90-89.abo.wanadoo.fr [90.89.181.128])
        by mail.bootlin.com (Postfix) with ESMTPSA id 6EF5820DDF;
        Fri, 12 Oct 2018 21:33:43 +0200 (CEST)
Date:   Fri, 12 Oct 2018 21:33:42 +0200
From:   Quentin Schulz <quentin.schulz@bootlin.com>
To:     Oskari Lemmela <oskari@lemmela.net>
Cc:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Lee Jones <lee.jones@linaro.org>,
        Quentin Schulz <quentin.schulz@free-electrons.com>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 4/7] arm64: dts: allwinner: a64: sopine: enable power
 supplies
Message-ID: <20181012193342.qddlsxkxgn4cgmvg@qschulz>
References: <20181008181908.9456-1-oskari@lemmela.net>
 <20181008181908.9456-5-oskari@lemmela.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="gah5pmp3avjfpsxl"
Content-Disposition: inline
In-Reply-To: <20181008181908.9456-5-oskari@lemmela.net>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--gah5pmp3avjfpsxl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Oskari,

On Mon, Oct 08, 2018 at 09:19:05PM +0300, Oskari Lemmela wrote:
> Sopine baseboard have ACIN and battery connectors.
>=20

Reviewed-by: Quentin Schulz <quentin.schulz@bootlin.com>

Thanks,
Quentin

--gah5pmp3avjfpsxl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEXeEYjDsJh38OoyMzhLiadT7g8aMFAlvA9xYACgkQhLiadT7g
8aOyBRAAn3Ae+qz+Z6Z3jrZHpJPCWFPnLrTcTHdn3MTTcN4RTi4NBB1fw9QJJqL7
rm6ArNL/SJO28zj5YMSktecrAyaLrRASJM00r4jSx/SRB1CZIoyn1vV07e+Lwijv
hjkgacdR3QFPa4jh0aPR73TYanKcgEI5ULafPyqmGdTe1slO6lQFZtNa96LzDSSU
Sy7e04VTmDSZ0P6E0ZgK1e2wWgc7H5Z8hOKpkPgNxiup+akfCQYOMkuZtDfJZ7Vg
ksLVUmgQzuPwTmTYRiCS3iY2B09tGqo9W5ahZpQ7t31AOJHSqpF6u3mDRiZ4dOdE
8IEUFBYei0gL2YP/z5ldXvklS4pPHBmOMI9biVWPyV+WNT4i5mY83ufDrcgmWvGV
va9NQEgd7fuP2tW4Du3kV9vTH/E1TdHR+nu5LTipQQS29nnKmLyeo6sXWW2573v9
JyHqhjRMKQw6Vczhl/VL8v6s+21QdmVH4zLD/AfWHgWcLR8yAUsvQhEK1pnDbtQ9
rT8x2+eEN9pOx/HkLxVU/j6E+Y+ehO1LkM0eABZHjCwdIk2TX23pONRKyIncFZTH
JwXndJOlh95+WgeqQi2o+goFG7AmDf/8rwyF94b2qvIJJvcTHC5j6/fXvJhwVXK+
pKvF5XtN5K2c7phcoS6qYn8KxE1FNbNNbW4NqQP1UT94FnFyifc=
=W2kz
-----END PGP SIGNATURE-----

--gah5pmp3avjfpsxl--
