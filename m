Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4306C43141
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 19:04:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E84321A72
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 19:04:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E84321A72
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754206AbeFUTEF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 15:04:05 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:39258 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752650AbeFUTED (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 15:04:03 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 3E800805A4; Thu, 21 Jun 2018 21:04:02 +0200 (CEST)
Date:   Thu, 21 Jun 2018 21:04:01 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Chen Yu <yu.c.chen@intel.com>, Ted Ts'o <tytso@mit.edu>,
        Len Brown <len.brown@intel.com>,
        "Lee, Chun-Yi" <jlee@suse.com>, Borislav Petkov <bp@alien8.de>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Stephan Mueller <smueller@chronox.de>,
        Eric Biggers <ebiggers3@gmail.com>,
        Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 3/3][RFC] tools: create power/crypto utility
Message-ID: <20180621190401.GA14623@amd>
References: <cover.1529486870.git.yu.c.chen@intel.com>
 <78af30838d0bac69bdd6e138b659bcbb8464fd13.1529486870.git.yu.c.chen@intel.com>
 <20180621090142.GB21807@amd>
 <CAJZ5v0hDhsxwU4X6_dCqc7P5GaTtpBeMUeJTHo9YJ8QtWinYfg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="ZPt4rx8FFjLCG7dd"
Content-Disposition: inline
In-Reply-To: <CAJZ5v0hDhsxwU4X6_dCqc7P5GaTtpBeMUeJTHo9YJ8QtWinYfg@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ZPt4rx8FFjLCG7dd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu 2018-06-21 14:10:06, Rafael J. Wysocki wrote:
> On Thu, Jun 21, 2018 at 11:01 AM, Pavel Machek <pavel@ucw.cz> wrote:
> >
> >
> > On Wed 2018-06-20 17:40:51, Chen Yu wrote:
> >> crypto_hibernate is a user-space utility to generate
> >> 512bits AES key and pass it to the kernel via ioctl
> >> for hibernation encryption.(We can also add the key
> >> into kernel via keyctl if necessary, but currently
> >> using ioctl seems to be more straightforward as we
> >> need both the key and salt transit).
> >
> > Ah, here you go:
> >
> > https://en.wikipedia.org/wiki/Uswsusp
>=20
> No, not really.
>=20
> > It can already do encryption. If you see problems there, patches will
> > be gladly accepted to fix them.
>=20
> By whom?

By me.

> > If you want to maintain uswsusp in kernel tree, I guess that would be
> > an option, too.
>=20
> No, it isn't an option due to the dependencies on crypto libraries.

Why not?

									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--ZPt4rx8FFjLCG7dd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlsr9qEACgkQMOfwapXb+vLiMgCfTsxaT+klE7ncAIKDZJ94dkAT
ClQAn07ioHsAuzcmn+a1TOL8S6lYDxhY
=XdVo
-----END PGP SIGNATURE-----

--ZPt4rx8FFjLCG7dd--
