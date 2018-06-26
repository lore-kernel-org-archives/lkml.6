Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DF62C43144
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 11:12:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11C70269B9
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 11:12:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11C70269B9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934094AbeFZLMw (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 07:12:52 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:42083 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932888AbeFZLMu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 07:12:50 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 25BF380384; Tue, 26 Jun 2018 13:12:48 +0200 (CEST)
Date:   Tue, 26 Jun 2018 13:12:45 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Oliver Neukum <oneukum@suse.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Chen Yu <yu.c.chen@intel.com>, Ted Ts'o <tytso@mit.edu>,
        Len Brown <len.brown@intel.com>,
        "Lee, Chun-Yi" <jlee@suse.com>, Borislav Petkov <bp@alien8.de>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Stephan Mueller <smueller@chronox.de>,
        Eric Biggers <ebiggers3@gmail.com>,
        Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 3/3][RFC] tools: create power/crypto utility
Message-ID: <20180626111245.GA25323@amd>
References: <cover.1529486870.git.yu.c.chen@intel.com>
 <78af30838d0bac69bdd6e138b659bcbb8464fd13.1529486870.git.yu.c.chen@intel.com>
 <20180621090142.GB21807@amd>
 <CAJZ5v0hDhsxwU4X6_dCqc7P5GaTtpBeMUeJTHo9YJ8QtWinYfg@mail.gmail.com>
 <20180621190401.GA14623@amd>
 <CAJZ5v0jQQ7neWDc_cy5ZJPVJp155BLF7fQFmeNJ3Nn0Jho7AeA@mail.gmail.com>
 <20180625115405.GB17001@amd>
 <CAJZ5v0jBh_0Uz54-Y2-qwdJNeD+KMpGEsH7q0XOdbCq5VCP1Ng@mail.gmail.com>
 <20180625221615.GA15249@amd>
 <1530009024.20417.5.camel@suse.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="fdj2RfSjLxBAspz7"
Content-Disposition: inline
In-Reply-To: <1530009024.20417.5.camel@suse.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--fdj2RfSjLxBAspz7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue 2018-06-26 12:30:24, Oliver Neukum wrote:
> On Di, 2018-06-26 at 00:16 +0200, Pavel Machek wrote:
> > Interested parties can easily fix up the userland parts of uswsusp,
> >=20
> > change crypto, add or remove dependencies, move it to other hosting,
> >=20
> > or drop it and start again. Kernel interface is flexible enough. If
> >=20
> > Chen wants to move the s2disk encryption into kernel, it is his task
> >=20
> > to explain why that is neccessary.
>=20
> We would have to assume that the kernel is on a higher level of trust.
> To a certain extent it is.You cannot drop support for /dev/kmem conceptio=
nally
> if there is an ioctl to snapshot it.

If I understood the description, proposed patches give userspace encryption
key + image encrypted with that key. So... that's not really an
improvement.

Anyway, I guess it makes sense to wait for v2 of patches with better
description of security goals of this.

									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--fdj2RfSjLxBAspz7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlsyH60ACgkQMOfwapXb+vKehgCffChO2ruu+N5DchYHAWeASRY2
SdwAnRV3WMx9+4VZYNEGdcksH56NWYmO
=7OFp
-----END PGP SIGNATURE-----

--fdj2RfSjLxBAspz7--
