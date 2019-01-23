Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=DATE_IN_PAST_12_24,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10FF5C282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 09:59:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC5CB218A6
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 09:59:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548323948;
	bh=7q0fCv7qaV5KabZDyE7wOITOXU/L+ASfEPQtFvkuL/E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=GjpEBXX/GBFftZPfn4ieEHwqOvn1TPLf5dx+9uwWMphS0PxSTo2bcDjflBSb8MbtF
	 00q3//8N4bHc+aaLouilwyA/kMNoVx9Mks68iazMOzTrWS7vS1jK/Xc5fnaBWVJ9MM
	 XRNMWhUh0GQPKaE23BD1+d1nbILEoEj1bNdr9Xto=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727790AbfAXJ7H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 04:59:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:49484 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726199AbfAXJ6L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 04:58:11 -0500
Received: from earth.universe (dyndsl-037-138-185-084.ewe-ip-backbone.de [37.138.185.84])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 08C88218AC;
        Thu, 24 Jan 2019 09:58:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548323890;
        bh=7q0fCv7qaV5KabZDyE7wOITOXU/L+ASfEPQtFvkuL/E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GJTEREcsf+z3J0Ka8KsGWqb6Fag9WNq5Ggm79osoonsUcgM1yUgVXW4M2w3VZiu9e
         GljPcYxrwppYWmXQOs9PZ2Tra29wkM+VfjOiTadeDMAM4mceKuGVUP+Q88Z97QE/Mh
         pEr/rQJNt+5Vuns4/acABKcSNVz0mMB5V6oW+/44=
Received: by earth.universe (Postfix, from userid 1000)
        id CC8FE3C08EB; Wed, 23 Jan 2019 21:56:27 +0100 (CET)
Date:   Wed, 23 Jan 2019 21:56:27 +0100
From:   Sebastian Reichel <sre@kernel.org>
To:     Lubomir Rintel <lkundrak@v3.sk>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, x86@kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH v5 2/7] x86, olpc: Use a correct version when making up a
 battery node
Message-ID: <20190123205627.nbddtfuy6qdo2bgb@earth.universe>
References: <20190110174005.1202564-1-lkundrak@v3.sk>
 <20190110174005.1202564-3-lkundrak@v3.sk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="lpmyezh6u4iltf3f"
Content-Disposition: inline
In-Reply-To: <20190110174005.1202564-3-lkundrak@v3.sk>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--lpmyezh6u4iltf3f
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Jan 10, 2019 at 06:40:00PM +0100, Lubomir Rintel wrote:
> The XO-1 and XO-1.5 batteries apparently differ in an ability to report
> ambient temperature. Add a different compatible string to the 1.5
> battery.
>=20
> Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
> Acked-by: Pavel Machek <pavel@ucw.cz>
>=20
> ---

I either need an Acked-by from the x86 platform maintainers, that I
can queue this through power-supply or a pull request for an immutable
branch (probably the better idea).

-- Sebastian

--lpmyezh6u4iltf3f
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlxI1PsACgkQ2O7X88g7
+pqrZw/+Md3qBkUZYZAqMNoEDlok7+li3OlE4r+BFb0HQl72BLWRv373gEtloWfK
leEggi0wgJSrx/0vt6ZJxKnFPBKRI26V2LIuWNfM5mj/BqQGykdBENbkcYG6bE3D
uDCIuRqRxSDNJOhIDVr3CFMaLcW470Wc2Q1YAQA01sfmCFTSHuyj/2nmJmL+AcMN
9u7jEb//Y4hhcaLtuAG/UFcqC68Yey5epxHVxoN940XJyIUEx3EScRbbpNf1ZFWy
IcSLJeAQTKY9j6n/OB1E8b6ZJxp5ZVQqeuaGu5+3PBqDpYcVL8+wIGhP4n7CvOGK
7ZJCGLEChqRs2gUJhi17Rg/LgGBGl8myEnEYVKaeyy8Kh6g9a8jb9Q49R6AxISUH
pv9wi9nwL2/EPyqbg4UWNubKYXkSZKA/tFRetAofTvoJvF+FI3t/d3z+G6vv0W6M
OH9IzFZyKu419q6j64g37fBB4NPG3+pZu4FYEzhUfRpRQgYL5cHoH6ZwM+NpKdUM
FUlQvIhmTRsNzZCsfztIz4GOlTTdaZCEyt4jWt8dZcrm6Wle648jQblrjquSLapk
lkg+H1b6r/dzpf7gwoUQvU0tSUaZ+U0hpstSYL6lE/akmkXsuLMMkMA6qRHs+MPX
TgUvS/D9dqPutkHvLBV3HgMuDLu0VK2sDNA6DeLzsC7xP0SK6ak=
=UlIM
-----END PGP SIGNATURE-----

--lpmyezh6u4iltf3f--
