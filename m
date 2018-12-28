Return-Path: <SRS0=Tl5R=PF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FBC2C43444
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 08:06:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1BE12148E
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 08:06:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730919AbeL1IG2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Dec 2018 03:06:28 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:44863 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727989AbeL1IG1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Dec 2018 03:06:27 -0500
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 2923480673; Fri, 28 Dec 2018 09:06:20 +0100 (CET)
Date:   Fri, 28 Dec 2018 09:06:24 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     Thomas Backlund <tmb@mageia.org>
Cc:     Sasha Levin <sashal@kernel.org>,
        Dave Chinner <david@fromorbit.com>,
        Greg KH <gregkh@linuxfoundation.org>, stable@vger.kernel.org,
        linux-kernel@vger.kernel.org, Dave Chinner <dchinner@redhat.com>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH AUTOSEL 4.14 25/35] iomap: sub-block dio needs to zeroout
 beyond EOF
Message-ID: <20181228080624.GA6341@amd>
References: <20181129121458.GK19305@dastard>
 <20181129124756.GA25945@kroah.com>
 <20181129224019.GM19305@dastard>
 <20181130082203.GA26830@kroah.com>
 <20181130101441.GA213156@sasha-vm>
 <20181130215005.GP19305@dastard>
 <20181201074909.GC213156@sasha-vm>
 <20181202232302.GT19305@dastard>
 <20181203092241.GC235790@sasha-vm>
 <2de96c1b-c375-8eed-f934-df5cbcdcd5cc@mageia.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="2fHTh5uZTiUOsy+g"
Content-Disposition: inline
In-Reply-To: <2de96c1b-c375-8eed-f934-df5cbcdcd5cc@mageia.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--2fHTh5uZTiUOsy+g
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon 2018-12-03 23:22:46, Thomas Backlund wrote:
> Den 2018-12-03 kl. 11:22, skrev Sasha Levin:
>=20
> >=20
> > This is a case where theory collides with the real world. Yes, our QA is
> > lacking, but we don't have the option of not doing the current process.
> > If we stop backporting until a future data where our QA problem is
> > solved we'll end up with what we had before: users stuck on ancient
> > kernels without a way to upgrade.
> >=20
>=20
> Sorry, but you seem to be living in a different "real world"...

I have to agree here :-(.

> People stay on "ancient kernels" that "just works" instead of updating
> to a newer one that "hopefully/maybe/... works"

Stable has a rules community agreed on, unfortunately stable team just
simply ignores those and decided to do "whatever they please".

Process went from "serious bugs that bother people only" to "hey, this
looks like a bugfix, lets put it into tree and see what it breaks"...

:-(.
								Pavel

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--2fHTh5uZTiUOsy+g
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlwl2YAACgkQMOfwapXb+vJe+QCghsqA4dMCLDQ7cdQbA8J+SMQn
HOcAn2x58gX5RDvYOE3QccxcmwUhxBtT
=UkbG
-----END PGP SIGNATURE-----

--2fHTh5uZTiUOsy+g--
