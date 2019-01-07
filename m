Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82DEDC43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 12:59:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B07221736
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 12:59:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546865963;
	bh=qydFa5idYR3fCFs2ddkHxJbsYldhI8XfhIG9+y7U+HY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=S7tjiIHUZm8lwwfwZUzAz/KqOBq3+wd0r+0fFETAMSEUpaeje8Lm9tIri8wyanVu/
	 ArgoEfNWsVL1FK4XvpAwIblpiqUE0j2Hw/VpACUp0PfMxA7qCF4zqRBvpYU3aiSjzC
	 vovon2pZ+sk/imf/pKecsT9x+q2bnjyaQtoG7qL8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730287AbfAGM7W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 07:59:22 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:59008 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730104AbfAGM7K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 07:59:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=1/3disZHKVtOagwiQRwBlJF6cPxgQg9ZIHgnmStqZ7w=; b=c0jgNkukIQtQkPqmh8l09O6Iu
        4Y6IHhLofeRQQYB1xR4BJ0aiAd1a7Mk9UDNwffgfJxtdbL034UN+ddf+/+j1uzM/6Qyqorj2c+Ww3
        mI6M03V9ODMZN3dlz9MGDJ3wT5YUUMCrvZzZWNsELdKJAPt6qKXtwj0aFT3TLgcQpJP1w=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1ggUUm-0006rF-C0; Mon, 07 Jan 2019 12:59:08 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id B988F1127490; Mon,  7 Jan 2019 12:59:07 +0000 (GMT)
Date:   Mon, 7 Jan 2019 12:59:07 +0000
From:   Mark Brown <broonie@kernel.org>
To:     b-ak <anur.bhargav@gmail.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ASoC: tlv320aic32x4: Kernel OOPS while entering DAPM
 standby mode
Message-ID: <20190107125907.GC9570@sirena.org.uk>
References: <20190102170633.GA9724@Ideapad-330S>
 <20190103124554.GS1846@sirena.org.uk>
 <20190103193421.GB18413@Ideapad-330S>
 <20190104164040.GA10873@Ideapad-330S>
 <20190105044622.GA14481@Ideapad-330S>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="/Uq4LBwYP4y1W6pO"
Content-Disposition: inline
In-Reply-To: <20190105044622.GA14481@Ideapad-330S>
X-Cookie: NOBODY EXPECTS THE SPANISH INQUISITION!
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--/Uq4LBwYP4y1W6pO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 05, 2019 at 10:16:22AM +0530, b-ak wrote:

>=20
> Hi Mark,
>=20
> Fixed the build error.
>=20
> Thanks,
> Bhargav
>=20

Please submit patches following the process covered in
submitting-patches.rst, don't send them as attachments to replies in the
middle of threads.  Doing that confuses all the tooling for handling
patches.

--/Uq4LBwYP4y1W6pO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlwzTRoACgkQJNaLcl1U
h9AIjgf/fjBVWmE0ZHSQGFh/tAHqSb+5Hj6lOklK27QkACsJlqM1o+/w+k7Rm1k/
SKTHqQRtHm3yS6m2cZkTu8MOfwzPgyZh5qZN76SBmTQMA23k8eE8DGlVQqSh+L6y
mzL8ZloJ/cBdFijGRYf/WtYYnVj6MID4mWXdCjGM6b1XRwQUc94+j9S3zAy9QfSv
nWVpLFIItHgh1sJhDWWTjmMRwy3Ajv5RQsdWOP/twcNuBSytBNJx7uxQxDXK+1Hn
PL/BvI2/D+/bEhY5bjwxC7FepiwvOGIklcX7lmrRGFdfScLRfD9xuoty34Yb37xl
mB7h0d6MdeYOvRmz5cDW8Qf3BrTMzQ==
=69Ea
-----END PGP SIGNATURE-----

--/Uq4LBwYP4y1W6pO--
