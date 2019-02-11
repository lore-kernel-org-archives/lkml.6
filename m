Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 502C1C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 13:02:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DC16218D8
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 13:02:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549890129;
	bh=rrNFtBlNJNUJkT8yM6Dz01tGCHsAHN8Ue9pLoJM+yKo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=o+DCGrjhuki+sLRvCZyr++KK//y2A+k4iTSV8/gBrw0+cMhKpwNk3vlOLKj3LfbMl
	 YkNRq3iFfsUvY1NMCTmFw7g6iyHIB2Cyy1xrgf5/d/LPpIDUv7LYDOxrFqijeb55gK
	 lVmK3tk1lvqw3q4DP60NEHCN+2OokAH52homaNfU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727735AbfBKNCH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 08:02:07 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:45508 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727106AbfBKNCG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 08:02:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=/6/LV1g/4PvANDpUzkKHrGOV+A+8ltW5SRahKEBI2rA=; b=NxIGDC4DkXNJGhLi65zkcWEOM
        aLHRgAJDYqKlL0Gyql0W997GGnHt6g1AdEg8Y05wITqM0C36yiBPDtAjPobNek/7stQo1CiaZDSi/
        PnUpPs4u1F77zGEqwgvkHWq69n7GA7F1iGzZMRoGAKrVXw/PwWNYR7DxZq2V49oW5uyzk=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gtBDm-00039F-Ol; Mon, 11 Feb 2019 13:02:02 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 1055911280BD; Mon, 11 Feb 2019 13:02:02 +0000 (GMT)
Date:   Mon, 11 Feb 2019 13:02:02 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Shuah Khan <shuah@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@amacapital.net>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 1/2] selftests/x86/fsgsbase: Indirect output through a
 wrapper function
Message-ID: <20190211130202.GB22391@sirena.org.uk>
References: <20190203134017.9375-1-broonie@kernel.org>
 <20190203134017.9375-2-broonie@kernel.org>
 <20190211084543.GA62722@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Y7xTucakfITjPcLV"
Content-Disposition: inline
In-Reply-To: <20190211084543.GA62722@gmail.com>
X-Cookie: Tell me what to think!!!
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Y7xTucakfITjPcLV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 11, 2019 at 09:45:43AM +0100, Ingo Molnar wrote:
> * Mark Brown <broonie@kernel.org> wrote:

> > In preparation for a change to make this test run repeatedly which
> > would generate huge amounts of output as is indirect all the printf()
> > calls in the program through a wrapper and add a quiet flag which can
> > be used to suppress the output.  This is fairly quick and dirty, I'm not
> > 100% sure what would be idiomatic here.

> So this really loses useful output when there is a failure. After this=20
> patch I get:

>   dagon:~/tip/tools/testing/selftests/x86> ./fsgsbase_64 -vv
>   [FAIL] 24 errors detected in 1 tries

> Not very helpful, and no real command-line way to see the failures.

For clarity it's the second patch that breaks this, though you're right
this isn't helpful and this patch needs a log level adding to really fix
that.

--Y7xTucakfITjPcLV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlxhckkACgkQJNaLcl1U
h9AVggf9HTPsj2bt0CiUxdUGSsC4Y1qHC9wmO9yPS+Rd7nlaDX9LKzStBhaYDGvE
7OWjEWrRmdz+8gJSx1n3D0CqkdIx+4Ab4QpD2z1hxJ881s8ZSzhgaRYUAa0krqfo
bsCGj65/WNUnx0igulioWp1kMhptb9roJerKZcQbZ1mACbypFXld0rtqJLycTotu
tzlcP5UfaayOrjUlQmcRAvngRPj691Ao5BtW+BmBWmOd6YScGemRcLMw1YvUhJno
ThjA+8765SadI27nUormfrNb4Up/hFI1lncH2JVT8xiEwhiCkmdmYxTRpRRv14IO
CyO663YVmGYyPalGJwTipgmpvhRQJA==
=kzGX
-----END PGP SIGNATURE-----

--Y7xTucakfITjPcLV--
