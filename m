Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 963E5C43142
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 11:54:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 559672585C
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 11:54:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 559672585C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932819AbeFYLyJ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 07:54:09 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:38896 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755240AbeFYLyI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 07:54:08 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id A76A88050E; Mon, 25 Jun 2018 13:54:06 +0200 (CEST)
Date:   Mon, 25 Jun 2018 13:54:05 +0200
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
Message-ID: <20180625115405.GB17001@amd>
References: <cover.1529486870.git.yu.c.chen@intel.com>
 <78af30838d0bac69bdd6e138b659bcbb8464fd13.1529486870.git.yu.c.chen@intel.com>
 <20180621090142.GB21807@amd>
 <CAJZ5v0hDhsxwU4X6_dCqc7P5GaTtpBeMUeJTHo9YJ8QtWinYfg@mail.gmail.com>
 <20180621190401.GA14623@amd>
 <CAJZ5v0jQQ7neWDc_cy5ZJPVJp155BLF7fQFmeNJ3Nn0Jho7AeA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="yNb1oOkm5a9FJOVX"
Content-Disposition: inline
In-Reply-To: <CAJZ5v0jQQ7neWDc_cy5ZJPVJp155BLF7fQFmeNJ3Nn0Jho7AeA@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--yNb1oOkm5a9FJOVX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> >> > It can already do encryption. If you see problems there, patches will
> >> > be gladly accepted to fix them.
> >>
> >> By whom?
> >
> > By me.
>=20
> Well, OK
>=20
> Where's the repository the patches will go to when you accept them?

On sourceforge.

> >> > If you want to maintain uswsusp in kernel tree, I guess that would be
> >> > an option, too.
> >>
> >> No, it isn't an option due to the dependencies on crypto libraries.
> >
> > Why not?
>=20
> You need a specific set of devel libraries for the utilities to build
> and that need not be present on all systems I suppose?
>=20
> Besides, s2disk is currently tangled with s2ram which is obsolete, so
> I'd rather not.

Its not tangled.

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--yNb1oOkm5a9FJOVX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlsw190ACgkQMOfwapXb+vLnjQCfSoeSUVj/C0Bu6y7IEqyCSPxS
vM4AoJp4HWH67iTe/JwDlpsgQ8Nix8VY
=rqQb
-----END PGP SIGNATURE-----

--yNb1oOkm5a9FJOVX--
