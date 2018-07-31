Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8041C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 13:40:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77A33208A2
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 13:40:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77A33208A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732283AbeGaPVL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 11:21:11 -0400
Received: from mail.bootlin.com ([62.4.15.54]:38306 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732160AbeGaPVL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 11:21:11 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 5AE5E20765; Tue, 31 Jul 2018 15:40:46 +0200 (CEST)
Received: from localhost (AAubervilliers-681-1-89-120.w90-88.abo.wanadoo.fr [90.88.30.120])
        by mail.bootlin.com (Postfix) with ESMTPSA id 201E920799;
        Tue, 31 Jul 2018 15:40:36 +0200 (CEST)
Date:   Tue, 31 Jul 2018 15:40:37 +0200
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Jagan Teki <jagan@amarulasolutions.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Chen-Yu Tsai <wens@csie.org>, Icenowy Zheng <icenowy@aosc.io>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com
Subject: Re: [PATCH] arm64: defconfig: Enable MFD_AXP20X_I2C
Message-ID: <20180731134036.mzgntiv6fwxg2vja@flea>
References: <20180731133828.2582-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="o57shyus2qwbsshg"
Content-Disposition: inline
In-Reply-To: <20180731133828.2582-1-jagan@amarulasolutions.com>
User-Agent: NeoMutt/20180622
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--o57shyus2qwbsshg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 31, 2018 at 07:08:28PM +0530, Jagan Teki wrote:
> The Allwinner H6 SoC is paired with the X-Powers AXP805 PMIC
> connected via I2C.
>=20
> Enable the driver for this PMIC.
>=20
> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>

Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>

Maxime

--=20
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com

--o57shyus2qwbsshg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAltgZtQACgkQ0rTAlCFN
r3QO1w//VHJaNCHimZdtgbrmtEFAzjgZLQEJaLVQ5M5NJHyzen+i0cLkMPg8nIWp
l+JzB5PGvOPJPIIh6QnDRHTX2z0snlRZLld6biGtEX/pl5XWR++J1gKfsAVnnyDn
eA75UiDyNvZ7HqrqFlYbyeYUIsuVgcobq+0lSpZkV3+5hn7vAqM6GdlAdT79Jmpn
3ZK8EbGxsZUjc3kOsscOTUOE+k6aiii+0CXb5iLj+moBuA953+qHBeMcqf5e/iax
kHGT8NTQqLi453JeIbd9HtHcGHWgo36QJk3Xq4O30hnbKbK12KzZu02G+gG2qBsA
6sQWtU8s6BBrDfY+C6jj33SljbiojtDY8Kgzef9GqEd94HIa/gKKh+7VQlZDuX04
oQ+ts7AwKp3RzMSJqIDczzawfXzLvdUd8ZlAG3ucqN0h5dpD6WdhyckdT8EnP0pW
jzxqdxxqWuue8IQjFtK/NNBUA/MIlnWwnQumSUwvdHoOSpvrPfPvtbdh2y2zYjhY
SqAK0KPj83o//fmHw0lXJCu2dEexOagTaVqe4n8cOiMGE7MPrByCFcjhXY8czJjS
J7BcYkZgP8P+sAtR5MaPFPixFpT4w3KtEYfZS789iIhsWzEEbvL+KW5k3uM3SeJf
AO5Njp7s/732DmllMlDtzmERbR8bkAl8iUR8AvXPrFW5A+9h1YM=
=cxUo
-----END PGP SIGNATURE-----

--o57shyus2qwbsshg--
