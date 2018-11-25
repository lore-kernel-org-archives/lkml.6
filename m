Return-Path: <SRS0=bZNE=OE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8B6DC43441
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 10:59:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A86FD20867
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 10:59:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A86FD20867
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727612AbeKYVsr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 25 Nov 2018 16:48:47 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:60578 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727182AbeKYVsq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Nov 2018 16:48:46 -0500
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id C4E5E80954; Sun, 25 Nov 2018 11:57:52 +0100 (CET)
Date:   Sun, 25 Nov 2018 11:57:54 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     linux-kernel@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Dave Jiang <dave.jiang@intel.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ross Zwisler <zwisler@kernel.org>,
        Joe Perches <joe@perches.com>,
        "Tobin C. Harding" <me@tobin.cc>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Steve French <stfrench@microsoft.com>,
        Olof Johansson <olof@lixom.net>, linux-nvdimm@lists.01.org,
        ksummit-discuss@lists.linuxfoundation.org
Subject: Re: [RFC PATCH 0/3] Maintainer Handbook: Subsystem Profile
Message-ID: <20181125105754.GB25471@amd>
References: <154225759358.2499188.15268218778137905050.stgit@dwillia2-desk3.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="QKdGvSO+nmPlgiQ/"
Content-Disposition: inline
In-Reply-To: <154225759358.2499188.15268218778137905050.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--QKdGvSO+nmPlgiQ/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed 2018-11-14 20:53:13, Dan Williams wrote:
> At a recently concluded session at the Linux Plumbers Conference I
> proposed a "Subsystem Profile" as a document that a maintainer can
> provide to set contributor expectations and provide fodder for a
> discussion between maintainers about the merits of different maintainer
> policies.
>=20
> For those that did not attend, the goal of the Subsystem Profile, and the
> Maintainer Handbook more generally, is to provide a desk reference for
> maintainers both new and experienced. The session introduction was:
>=20
>     The first rule of kernel maintenance is that there are no hard and
>     fast rules. That state of affairs is both a blessing and a curse. It
>     has served the community well to be adaptable to the different
>     people and different problem spaces that inhabit the kernel
>     community. However, that variability also leads to inconsistent
>     experiences for contributors, little to no guidance for new
>     contributors, and unnecessary stress on current maintainers. There
>     are quite a few of people who have been around long enough to make
>     enough mistakes that they have gained some hard earned proficiency.
>     However if the kernel community expects to keep growing it needs to
>     be able both scale the maintainers it has and ramp new ones without
>     necessarily let them make a decades worth of mistakes to learn the
>     ropes.=20
>=20
> To be clear, the proposed document does not impose or suggest new
> rules. Instead it provides an outlet to document the unwritten rules
> and policies in effect for each subsystem, and that each subsystem
> might decide differently for whatever reason.

Sounds like a new rules to me :-(, making submitting simple patches
harder.

It would be good if the rules were similar / same accross the
subsystems, documenting "it is okay to be different" is not really helpful.


									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--QKdGvSO+nmPlgiQ/
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlv6gDIACgkQMOfwapXb+vIHpACeMr/5ZBBOd8P13v1FJdbu09st
8jwAoLVfTBCtCF/7C+p9+kZKxV4DKggb
=utEq
-----END PGP SIGNATURE-----

--QKdGvSO+nmPlgiQ/--
