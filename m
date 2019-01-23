Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31198C282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 15:58:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F245F2184C
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 15:58:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726289AbfAWP6v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 10:58:51 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:41715 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725930AbfAWP6v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 10:58:51 -0500
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id D20D18074E; Wed, 23 Jan 2019 16:58:41 +0100 (CET)
Date:   Wed, 23 Jan 2019 16:58:50 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Lukas Wunner <lukas@wunner.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        "Hutter, Tony" <hutter2@llnl.gov>,
        Marc Dionne <marc.c.dionne@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>, Kash Pande <kash@tripleback.net>
Subject: Re: x86/fpu: Don't export __kernel_fpu_{begin,end}()
Message-ID: <20190123155850.GB8721@amd>
References: <CAB9dFdsZb-sZixeOzrt8F50h1pnUK2W2Cxx8+xjhgd0=6xs7iw@mail.gmail.com>
 <20190109111951.5zvnj7ls6jv56p2u@linutronix.de>
 <20190109165235.GA8151@kroah.com>
 <20190109170935.e6b6rwzpk6dlruu4@linutronix.de>
 <20190110131132.GC20217@kroah.com>
 <ba74ed88-06d0-5063-799f-c9c6ddbc7da0@llnl.gov>
 <20190110180752.f4cnunadzzkev24m@linutronix.de>
 <20190110182413.GA6932@kroah.com>
 <20190111050407.4k7pkir3jqtyn22o@wunner.de>
 <20190111054058.GA27966@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="aM3YZ0Iwxop3KEKx"
Content-Disposition: inline
In-Reply-To: <20190111054058.GA27966@kroah.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--aM3YZ0Iwxop3KEKx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri 2019-01-11 06:40:58, Greg Kroah-Hartman wrote:
> On Fri, Jan 11, 2019 at 06:04:07AM +0100, Lukas Wunner wrote:
> > On Thu, Jan 10, 2019 at 07:24:13PM +0100, Greg Kroah-Hartman wrote:
> > > My tolerance for ZFS is pretty non-existant.  Sun explicitly did not
> > > want their code to work on Linux, so why would we do extra work to get
> > > their code to work properly?
> >=20
> > ZoL facilitates seamless r/w cross-mounting with macOS, something no
> > other filesystem allows, and that feature is critical for me to work
> > on Linux drivers for Mac hardware.  Please don't make life harder than
> > necessary for developers like me.  Your "extra work" argument seems
> > disingenuous to me, Sebastian's patch is causing extra work for
> > ZFS developers, not the kernel community.  The maintenance burden
> > for the kernel community to retain the export is zero.
>=20
> Sorry, no, we do not keep symbols exported for no in-kernel users.

Killing ZFS is _not_ nice. Its not like ZFS is closed source...=20
=20
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--aM3YZ0Iwxop3KEKx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlxIjzoACgkQMOfwapXb+vKnyQCfWS6aw9br4w0yFh+P3021ahMQ
EBcAoKhg16FWGPC8DaXcVtYOgyQ00tC8
=JjK+
-----END PGP SIGNATURE-----

--aM3YZ0Iwxop3KEKx--
