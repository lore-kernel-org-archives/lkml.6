Return-Path: <SRS0=94iy=MT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 058D0C65C1B
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Oct 2018 17:48:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4ED992087D
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Oct 2018 17:48:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4ED992087D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727365AbeJHA4r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Oct 2018 20:56:47 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:35660 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726178AbeJHA4q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Oct 2018 20:56:46 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 1F6288081E; Sun,  7 Oct 2018 19:48:43 +0200 (CEST)
Date:   Sun, 7 Oct 2018 19:48:42 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     "Theodore Y. Ts'o" <tytso@mit.edu>,
        =?utf-8?B?0JTQvNC40YLRgNC40Lkg0JvQtdC+0L3RgtGM0LXQsg==?= 
        <dm.leontiev7@gmail.com>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: Maybe a copyright attack on linux
Message-ID: <20181007174842.GA10888@amd>
References: <CA+JonM0_4GSeQ5veX3aDjJ_RBoL065YLNFMuyVftQBn-pCcA=A@mail.gmail.com>
 <20180926153029.GF3321@thunk.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="jRHKVT23PllUwdXP"
Content-Disposition: inline
In-Reply-To: <20180926153029.GF3321@thunk.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--jRHKVT23PllUwdXP
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed 2018-09-26 11:30:29, Theodore Y. Ts'o wrote:
> On Wed, Sep 26, 2018 at 05:55:18PM +0300, =D0=94=D0=BC=D0=B8=D1=82=D1=80=
=D0=B8=D0=B9 =D0=9B=D0=B5=D0=BE=D0=BD=D1=82=D1=8C=D0=B5=D0=B2 wrote:
> > Or: "Why you should not use "kill switch" option proposed by smdy to
> > protest against CoC"
> >=20
> > Hello.
> >=20
> > I'm neither a great software developer nor a lawyer, but I'm not a
> > novice and I'm very annoyed whan I see this:
> >=20
> > https://woww.reddit.com/r/programming/comments/9iqr3u/linux_developers_=
threaten_to_pull_kill_switch/
>=20
> Dmitry,
>=20
> Before you worry overmuch, I suggest you take a look at the people who
> are the claimed "linux developers" who are so "threatening" and see
> how many commits (if any at all) they actually have contributed to he
> Linux sources.
>=20
> There are a lot of people who are not members of the Linux kernel
> development community that have been contributing a huge amount of
> noise on both sides of the controversy, both pro- and anti- CoC.
>=20
> My view is that this noise is not at all helpful, and they have their
> own agenda which they are trying to promote.  A handy-dandy command if
> you have the git tree for the kernel downloaded is:

Agreed that that noise is not helpful.

But there are still people who don't like CoC "improvements", and find
it very, very strange that such change was merged without any
discussion.

And yes, some of those people pass "git author" test.

> 	git log --author=3Duser@example.com

									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--jRHKVT23PllUwdXP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlu6RvoACgkQMOfwapXb+vLL4ACgi5wuno/7ai4Vk7XO9GhA+0fW
h/sAoIAIXYNkGLHUswqri6OQ5fzx+xh6
=6mvf
-----END PGP SIGNATURE-----

--jRHKVT23PllUwdXP--
