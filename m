Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40C05C43142
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 22:16:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA9B4261C0
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 22:16:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA9B4261C0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754678AbeFYWQT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 18:16:19 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:55748 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752639AbeFYWQR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 18:16:17 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 1B5608051B; Tue, 26 Jun 2018 00:16:16 +0200 (CEST)
Date:   Tue, 26 Jun 2018 00:16:15 +0200
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
Message-ID: <20180625221615.GA15249@amd>
References: <cover.1529486870.git.yu.c.chen@intel.com>
 <78af30838d0bac69bdd6e138b659bcbb8464fd13.1529486870.git.yu.c.chen@intel.com>
 <20180621090142.GB21807@amd>
 <CAJZ5v0hDhsxwU4X6_dCqc7P5GaTtpBeMUeJTHo9YJ8QtWinYfg@mail.gmail.com>
 <20180621190401.GA14623@amd>
 <CAJZ5v0jQQ7neWDc_cy5ZJPVJp155BLF7fQFmeNJ3Nn0Jho7AeA@mail.gmail.com>
 <20180625115405.GB17001@amd>
 <CAJZ5v0jBh_0Uz54-Y2-qwdJNeD+KMpGEsH7q0XOdbCq5VCP1Ng@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="ReaqsoxgOBHFXBhH"
Content-Disposition: inline
In-Reply-To: <CAJZ5v0jBh_0Uz54-Y2-qwdJNeD+KMpGEsH7q0XOdbCq5VCP1Ng@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ReaqsoxgOBHFXBhH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> >> >> > If you want to maintain uswsusp in kernel tree, I guess that woul=
d be
> >> >> > an option, too.
> >> >>
> >> >> No, it isn't an option due to the dependencies on crypto libraries.
> >> >
> >> > Why not?
> >>
> >> You need a specific set of devel libraries for the utilities to build
> >> and that need not be present on all systems I suppose?
> >>
> >> Besides, s2disk is currently tangled with s2ram which is obsolete, so
> >> I'd rather not.
> >
> > Its not tangled.
>=20
> Yes, it is.

I checked the Makefile, and it builds from separate sources. Yes, it
is in one repository, but s2disk does not depend on s2ram (s2both does).

Anyway... that's really besides a point.

Interested parties can easily fix up the userland parts of uswsusp,
change crypto, add or remove dependencies, move it to other hosting,
or drop it and start again. Kernel interface is flexible enough. If
Chen wants to move the s2disk encryption into kernel, it is his task
to explain why that is neccessary.

								Pavel

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--ReaqsoxgOBHFXBhH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlsxaa8ACgkQMOfwapXb+vJyFwCfWUccgGfheRduGC2ZOul4mXrL
40oAoI1WWJXf10/e9kxVdLKXp09QFciq
=NQCN
-----END PGP SIGNATURE-----

--ReaqsoxgOBHFXBhH--
