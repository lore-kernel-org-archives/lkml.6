Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C633C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 21:44:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 413172081C
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 21:44:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 413172081C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726438AbeK2Iru (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 03:47:50 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:60262 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726307AbeK2Iru (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 03:47:50 -0500
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 3789980AA3; Wed, 28 Nov 2018 22:44:43 +0100 (CET)
Date:   Wed, 28 Nov 2018 22:44:45 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     lkundrak@v3.sk, arm-soc <arm@kernel.org>,
        Olof Johansson <olof@lixom.net>,
        Eric Miao <eric.y.miao@gmail.com>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Robert Jarzmik <robert.jarzmik@free.fr>, quozl@laptop.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 0/20] MMP platform fixes
Message-ID: <20181128214445.GF20670@amd>
References: <20181128175324.163202-1-lkundrak@v3.sk>
 <CAK8P3a0jN1PBy1oKHrx5abX4OKHVxjgevbUcXbUDPbU+VdvUPg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="AH+kv8CCoFf6qPuz"
Content-Disposition: inline
In-Reply-To: <CAK8P3a0jN1PBy1oKHrx5abX4OKHVxjgevbUcXbUDPbU+VdvUPg@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--AH+kv8CCoFf6qPuz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > this series contains contains a bunch of MMP2 platform fixes.
> >
> > Previous spins of the patch set were sent out over the course of last
> > three months to the MMP platform maintainers, with Arnd and
> > linux-arm-kernel@lists.infradead.org on copy.
> >
> > Unfortunatelly, MMP maintainers (Eric Miao and Haojian Zhuang) don't
> > seem to respond anymore. That's a shame, because the MMP2 support seems=
 to
> > in need for some love. The DT/multiplatform kernels can't even boot wit=
hout
> > 14/20, 15/20 and perhaps more.
> >
> > I'm wondering if this cat gen in via the arm-soc tree? Would it be
> > appropriate if I followed up with a MAINTAINERS update in that case?
>=20
> Yes, sounds good to me. I looked through the series again, and
> found one patch that seems wrong to me. Everything else should
> just go in.

Sounds good to me.

> Patches that are purely bugfixes should probably also get backported
> to stable kernels, so please add a 'Cc: stable@vger.kernel.org' tag
> in the changelog for things that are required to make older kernels
> work correctly (as opposed to adding features that were never supposed
> to work), and describe in the changelog which kernel versions should
> see that backport.

Dunno, I'd be careful there. MMP2 was broken long ago and mainline
never booted on olpc-1.75 AFAICT. Seems like noone cares about
MMP2. I'd just keep it out of stable; stable is for bugs when someone
cares.

									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--AH+kv8CCoFf6qPuz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlv/DE0ACgkQMOfwapXb+vKu2QCgnFkevOapuESw3MpBAP2pRQxx
ehcAn3m05QsZ51wG6yelpTeeIpUpuAX7
=+pEX
-----END PGP SIGNATURE-----

--AH+kv8CCoFf6qPuz--
