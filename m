Return-Path: <SRS0=4jry=KT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9AFFC4646D
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 21:04:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98C23217B7
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 21:04:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98C23217B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=the-dreams.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729718AbeHDXGJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Aug 2018 19:06:09 -0400
Received: from sauhun.de ([88.99.104.3]:58878 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728309AbeHDXGJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Aug 2018 19:06:09 -0400
Received: from localhost (p54B337AD.dip0.t-ipconnect.de [84.179.55.173])
        by pokefinder.org (Postfix) with ESMTPSA id B8950684DB5;
        Sat,  4 Aug 2018 23:04:10 +0200 (CEST)
Date:   Sat, 4 Aug 2018 23:04:10 +0200
From:   Wolfram Sang <wsa@the-dreams.de>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     robh+dt@kernel.org, afaerber@suse.de, linus.walleij@linaro.org,
        linux-i2c@vger.kernel.org, liuwei@actions-semi.com,
        mp-cs@actions-semi.com, 96boards@ucrobotics.com,
        devicetree@vger.kernel.org, andy.shevchenko@gmail.com,
        daniel.thompson@linaro.org, amit.kucheria@linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, hzhang@ucrobotics.com,
        bdong@ucrobotics.com, manivannanece23@gmail.com,
        thomas.liau@actions-semi.com, jeff.chen@actions-semi.com
Subject: Re: [PATCH v8 6/6] MAINTAINERS: Add entry for Actions Semiconductor
 Owl I2C driver
Message-ID: <20180804210410.okdjmwlqtjtarzmo@ninjato>
References: <20180801180232.23680-1-manivannan.sadhasivam@linaro.org>
 <20180801180232.23680-7-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="fxix552pc65a3rfg"
Content-Disposition: inline
In-Reply-To: <20180801180232.23680-7-manivannan.sadhasivam@linaro.org>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--fxix552pc65a3rfg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 01, 2018 at 11:32:32PM +0530, Manivannan Sadhasivam wrote:
> Add entry for Actions Semiconductor Owl I2C driver under ARM/ACTIONS

So, it goes upstream via arm-soc?

>=20
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Acked-by: Wolfram Sang <wsa@the-dreams.de>


--fxix552pc65a3rfg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAltmFMoACgkQFA3kzBSg
Kbbz+g//f+smcxURu7eKin0PrmusPul2GE5dfw9TX+C8oZ+/6/hW/SL0QLL8do2j
9bSqQsR4N2vfs/KrZ4IUx95l3WLfwFljS8oFMlmEqhZEcd3Rgu/lp2m7Afq6aTFA
TtvVEs/7bkIh8BXBQnFRhYtfFyBQxmTTsQluS7TViCUoDvbE0+WIpmse60dLHGMR
hMpg/s6Na3cQztsk0lbwjLS2Xj0znMEKH94Tha734DnzNpYGY5nrBvEC7puEqWDW
XDd06hnTDJrnqZxUAaXe+rHgJZ9ATG0Wty3OQtgsGuGEIxcRs7O4/J5t0jdPy0YE
VhydSQUCv5jcLUQC/AyTppAKDaY0NDfyFaAQQzsKzkUHXtGPeonzkPR/1PUiMDE7
NgPU5AM3FqbpGwUeFH3hzQPIHUTkV/u0SZp+LVhH8gJ0zpbWaclGtzeMhmyO692Z
tQNSJwiY7bUZBB0I9YDMHKvxO24XuNOwPUiDyL3RHSbAn+4U6ppAuUIUFdOyXEsU
Z5tPvczTed3B1kX6tPFWggbUer0X88y5fA5f73v1GFKu/26ySlOmBhUqdi23efkf
697IyHN0rIiAsDJLDR/MutMA/4ftFhX86//QMn26GtpNlPk7RwJGCA1Xm5aqBc3V
M0pfQxVX9SAVB+gKVVEUPBJtoTWvXUyd4FwbtpV8Ms3XzhaDW68=
=QKJe
-----END PGP SIGNATURE-----

--fxix552pc65a3rfg--
