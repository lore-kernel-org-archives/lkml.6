Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB233C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 16:57:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC55B222DA
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 16:57:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502840AbfBNQ5T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 11:57:19 -0500
Received: from sauhun.de ([88.99.104.3]:54140 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2502823AbfBNQ5T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 11:57:19 -0500
Received: from localhost (unknown [83.221.228.209])
        by pokefinder.org (Postfix) with ESMTPSA id 8FBAD2C2817;
        Thu, 14 Feb 2019 17:57:17 +0100 (CET)
Date:   Thu, 14 Feb 2019 17:57:17 +0100
From:   Wolfram Sang <wsa@the-dreams.de>
To:     Federico Vaga <federico.vaga@cern.ch>
Cc:     Peter Korsgaard <peter@korsgaard.com>,
        Andrew Lunn <andrew@lunn.ch>, Peter Rosin <peda@axentia.se>,
        linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 0/5] i2c: ocores: improvements
Message-ID: <20190214165717.gr2ujb26x5papwep@ninjato>
References: <20190214085134.12900-1-federico.vaga@cern.ch>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="q7zkhe3ilfb4wtbd"
Content-Disposition: inline
In-Reply-To: <20190214085134.12900-1-federico.vaga@cern.ch>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--q7zkhe3ilfb4wtbd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 14, 2019 at 09:51:29AM +0100, Federico Vaga wrote:
>=20
> This patch set provides improvements to the i2c-ocore driver.
>=20
> [V6 -> V7]
> - restore accidentally removed 'reviewed-by' tags in changelog

Series applied to for-next, thanks!


--q7zkhe3ilfb4wtbd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlxlnewACgkQFA3kzBSg
KbatDw/9ErjD838FhrEXP6pC3yWuz6ZJ40mPOV2lY6uFwQVsruoHLsLTg4B0uB3K
W/CG/kRdPABB7ExWn7hr9OvIv1+Jpa4YeliO1hgXILC3VPEQSd6BbPx6W4wBgAQu
q9TKXzYGUncG+l+/eBpBKF79EttEODb+kMLCsWafm0rmR32ToBIwRLvWgUp7w5uA
iP50HRbC5Npxc9hnGfRlmNFCilmEijCYPHchSqRaEQ7D7okHPdxtYRT7bGaVooLe
NToCZHwIUf6K5o+Mx0diP2d2PEDhrBAiNiyH21ouXCu1l0iki6LdA4mRSL/5luSW
zpSTwY7ZeBZbfQgwNAAsb/tBJ1ugVRYRCu99TqyJl16+KIeLosJcRz5NO+8v8TOb
wR0ZuLiDDkTR/yzUSootfTpsrIM/ecYQbVW37kQ2RsLXBPcqdi61z/3lM9i+eFCN
T84vyYmspKCt2iMNeEgDPWgFrd2TG3kbZRwhdu/JVqNwSKkGPqFJi6ejTk5PN6xD
vTICvWEoM1ngtigJkNQp14G6Y1D1yNGBYJMNyq3xbb/dVJ8DJQxLWUaJFNtbnN01
CYeIRlO1CfOZseOYvP5celsMaXqLM9gKhVZPurtHxwLfIZe4dlV2xt+uDTBJhWxV
BLnfi71+OWACMYixsZ3VDnqVpAg9K+y/3W0l1uAQFUB73a4kvDo=
=iroc
-----END PGP SIGNATURE-----

--q7zkhe3ilfb4wtbd--
