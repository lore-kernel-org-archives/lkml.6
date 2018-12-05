Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1C09C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 11:49:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 807A6206B7
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 11:49:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="O3A0o9iU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 807A6206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727677AbeLELtC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 06:49:02 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:56720 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726918AbeLELtB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 06:49:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=WrUdGCH3HH5tHsjC6Vu680aUbSUsAUkeo47fbnKhiZE=; b=O3A0o9iUv9b0PYxqmUQvsQp2G
        7A8VZmBDLOhIleqeG2PwQXFhvLNdRDOUB55bhrVRePqxSLxvHuEwz6527q+xYWXbY6nf3ieOK/1tS
        cn2kf7RbMhCQJwqJ7Yd3u3punW/9HIMTzZ0VCd6zU90ebIG2VuIWarvGAXYz3V3uDf9Z0=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gUVff-0003L7-PK; Wed, 05 Dec 2018 11:48:51 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 4F57B112533E; Wed,  5 Dec 2018 11:48:51 +0000 (GMT)
Date:   Wed, 5 Dec 2018 11:48:51 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Sasha Levin <sashal@kernel.org>
Cc:     stable@vger.kernel.org, linux-kernel@vger.kernel.org,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Sriram Periyasamy <sriramx.periyasamy@intel.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>
Subject: Re: [PATCH AUTOSEL 4.19 031/123] ASoC: Intel: Power down links
 before turning off display audio power
Message-ID: <20181205114851.GC6205@sirena.org.uk>
References: <20181205093555.5386-1-sashal@kernel.org>
 <20181205093555.5386-31-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="GPJrCs/72TxItFYR"
Content-Disposition: inline
In-Reply-To: <20181205093555.5386-31-sashal@kernel.org>
X-Cookie: Real Users never use the Help key.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--GPJrCs/72TxItFYR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 05, 2018 at 04:34:23AM -0500, Sasha Levin wrote:
> From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
>=20
> [ Upstream commit 4c10473d6ddf12ec124c9ff71a5d23bb5388478b ]
>=20
> On certain platforms, Display HDMI HDA codec was not going to sleep state
> after the use when links are powered down after turning off the display
> power. As per the HW recommendation, links are powered down before turning
> off the display power to ensure that the codec goes to sleep state.

Are we sure there's no dependencies here?

--GPJrCs/72TxItFYR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlwHuyIACgkQJNaLcl1U
h9Cswgf9E2dJbsL/3j7vHTNDq4/dPa6TCumaPjEa79+c5lJjHXQbnKQ5RNHq7TFx
OGrFLEoJirWh4cbTu12Bp74GPhyQSe7iba/cQ79dwomHA0RMhVzbdS4oghwOcliR
tM5VDKG9V5IFfDMmWlAHMMQ7J1T4rKqshEHZE8FWQFvhW6Zjm5ka+FWDrcGjzh+f
WmmcMVqot71AKIUM1B/TI89/t1pii3LIpnsl57s4MHsMazqfzPItX9VE+h8YuoM6
lUt1S5yMtV8uQSp+6OUdTXyJ2jrR4Pfucl+jWlSfht5GXN6FY5jrhZYozPJ/dZTP
BfLSYjo9m7L/9W9hOMQN1JAaxyRf5g==
=4sO+
-----END PGP SIGNATURE-----

--GPJrCs/72TxItFYR--
