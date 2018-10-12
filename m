Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3518C6787C
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 19:32:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A02F92087D
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 19:32:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A02F92087D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726758AbeJMDGr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 23:06:47 -0400
Received: from mail.bootlin.com ([62.4.15.54]:58158 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725935AbeJMDGq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 23:06:46 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id BE5BF207BB; Fri, 12 Oct 2018 21:32:43 +0200 (CEST)
Received: from qschulz (LFbn-1-10589-128.w90-89.abo.wanadoo.fr [90.89.181.128])
        by mail.bootlin.com (Postfix) with ESMTPSA id 704652072C;
        Fri, 12 Oct 2018 21:32:33 +0200 (CEST)
Date:   Fri, 12 Oct 2018 21:32:32 +0200
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
Subject: Re: [PATCH v3 2/7] ARM: dts: axp81x: add AC power supply subnode
Message-ID: <20181012193232.6qak2xwzean5hgk7@qschulz>
References: <20181008181908.9456-1-oskari@lemmela.net>
 <20181008181908.9456-3-oskari@lemmela.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="itk5j53i7elyqnsr"
Content-Disposition: inline
In-Reply-To: <20181008181908.9456-3-oskari@lemmela.net>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--itk5j53i7elyqnsr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Oskari,

On Mon, Oct 08, 2018 at 09:19:03PM +0300, Oskari Lemmela wrote:
> Add AC power supply subnode for AXP81X PMIC.
>=20

Reviewed-by: Quentin Schulz <quentin.schulz@bootlin.com>

Thanks,
Quentin

--itk5j53i7elyqnsr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEXeEYjDsJh38OoyMzhLiadT7g8aMFAlvA9tAACgkQhLiadT7g
8aOpIA/9HZOGqf/73TrFfVqVJ4tP3l4mNyVT3oFAxyIXUPinI95nimvCR0Jjzo60
O1QWQNbKZFeYJeN/jdsCQWvIGWTPFAHEeUyDLTBPESBMnM9FfEzYj2dsUJEF+Uda
I0bC/Uk6bQFpFsa3+OoWUT+aQxXA7CRhu777knj0Zj0uSex7ZvGrC9BAjzJCzdbD
z7HqgtIoC2ba0OThXNeHjqQEdyQYkaxRfXVBgFLspeJV/rA+Ok/Gf622tXm2dAcy
LyoD7GLc2beRi3lejVHLQjmcleXcgXcSztKq9CInacLUFLOyX6ySVKmPlLVCUOud
G7iJsyBH2ERhVSXHPUqVgzYcgxA2sEyA1ULqFpCFAJEN3I2Z5HT1C2QzUSQLw3U0
vjoDGSenLt07BndDhkRks8WEUsTY2JcgQZZzOcTgqsM/ocKqZDv04W2UPa1/K713
YWMyEyfzI9MhJXKHJV/B+Jlt2kg4TrV19MvnzqRIioTYjhR8JojEn7no0twntulb
kyAO2kdCa905JnLZ95+avFFYXJf0EhMdpIfqOz1ynQ6OfTyjVSqGtr6z0bCrwEs+
kl+oP4sWIEh1Gztr5TUbSFBtIUMPn8pyUZs553D5owwwxC+g4MEDggRLPKQJSe3a
x4Ea0SBVE0ACQtS2OHX2cRIiIbEUbZIc5olMp/lyoxuX7F01Fo4=
=ak0X
-----END PGP SIGNATURE-----

--itk5j53i7elyqnsr--
