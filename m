Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FD58C6786F
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 12:06:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6734B2081B
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 12:06:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="ZRlTiqbC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6734B2081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728490AbeKAVJN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 17:09:13 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:46402 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728085AbeKAVJN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 17:09:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=pMDQAeklvgbByodv3ha4umpLX8gnPDDDdDG/WwjOvZI=; b=ZRlTiqbCOvFPscsfZvAY334uW
        bV6omm7UQ5J/VBSdMJBWqblAtj/n5icvJHlTSvBvEPGs4FiDGaFtZ3QCaXToSMEeL/ZSaE9nUxmB6
        RtueWCXDXwXh026uBoU2eeCrWnSsNQsUBmHmGS3W5CuuhzLpoAWzHbVdZqcfTHzVXFx/8=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gIBk6-0005TP-MU; Thu, 01 Nov 2018 12:06:30 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 5E029112260E; Thu,  1 Nov 2018 12:06:30 +0000 (GMT)
Date:   Thu, 1 Nov 2018 12:06:30 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Sasha Levin <sashal@kernel.org>
Cc:     stable@vger.kernel.org, linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH AUTOSEL 4.14 22/73] regulator: fixed: Default enable high
 on DT regulators
Message-ID: <20181101120630.GD6425@sirena.org.uk>
References: <20181031230948.29203-1-sashal@kernel.org>
 <20181031230948.29203-22-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="zbGR4y+acU1DwHSi"
Content-Disposition: inline
In-Reply-To: <20181031230948.29203-22-sashal@kernel.org>
X-Cookie: Excellent day to have a rotten day.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--zbGR4y+acU1DwHSi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 31, 2018 at 07:08:57PM -0400, Sasha Levin wrote:
> From: Linus Walleij <linus.walleij@linaro.org>
>=20
> [ Upstream commit 28be5f15df2ee6882b0a122693159c96a28203c7 ]
>=20
> commit efdfeb079cc3
> ("regulator: fixed: Convert to use GPIO descriptor only")
> switched to use gpiod_get() to look up the regulator from the
> gpiolib core whether that is device tree or boardfile.

This patch is only introduced in v4.19...

--zbGR4y+acU1DwHSi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlva7EUACgkQJNaLcl1U
h9ASnwf+JKSPfJeC5Xqg9msOA7vXlnQwQCcYBHAsdDy8/n0TAmuaGqEUsZnPIBvW
w7jEW3N8zNm7ly6djc1bozkhlf0SHuGP36oCZYim4o5uWaG7xgTkK6G3j0LAgEbn
ysrwBUIX8tILGX+zrf8tn724IU3r9+wtbkEBsyL2astUXU9/xPBXh5WwBt3HE7IV
nRlVg0H3e39DD2du+pvXatXjoldzLfU75x7XsYgVAQO2JmpKp2K95TarqpEZv2IP
8yi6HHw+FZMdqQxbUsdZaUjJhy76woUu1kRpCMbcmtA1iM4UyJRbdMZlaC/O+/GM
5AZ3HYQNg2O/r90s6ZleP5C8Ly4zeA==
=tEBz
-----END PGP SIGNATURE-----

--zbGR4y+acU1DwHSi--
