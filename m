Return-Path: <SRS0=GEt/=PV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D46E2C43612
	for <linux-kernel@archiver.kernel.org>; Sun, 13 Jan 2019 23:10:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A181C20854
	for <linux-kernel@archiver.kernel.org>; Sun, 13 Jan 2019 23:10:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726644AbfAMXKF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 13 Jan 2019 18:10:05 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:46956 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726471AbfAMXKE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Jan 2019 18:10:04 -0500
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 7BB0E809C5; Mon, 14 Jan 2019 00:09:56 +0100 (CET)
Date:   Mon, 14 Jan 2019 00:10:01 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     Tim Chen <tim.c.chen@linux.intel.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jiri Kosina <jikos@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Andi Kleen <ak@linux.intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Asit Mallick <asit.k.mallick@intel.com>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Jon Masters <jcm@redhat.com>,
        Waiman Long <longman9394@gmail.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Borislav Petkov <bp@alien8.de>, linux-kernel@vger.kernel.org,
        x86@kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] x86/speculation: Add document to describe Spectre and
 its mitigations
Message-ID: <20190113231001.GB18710@amd>
References: <64efec3fda40c0758601bf9b1480a35d76d3c487.1545413988.git.tim.c.chen@linux.intel.com>
 <20181228103437.4c03c181@lwn.net>
 <aed62eaa-93b4-8dc5-1920-6a5547e349c8@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="OwLcNYc0lM97+oe1"
Content-Disposition: inline
In-Reply-To: <aed62eaa-93b4-8dc5-1920-6a5547e349c8@linux.intel.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--OwLcNYc0lM97+oe1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> >>
> >> Signed-off-by: Andi Kleen <ak@linux.intel.com>
> >> Signed-off-by: Tim Chen <tim.c.chen@linux.intel.com>
> >> ---
> >>  Documentation/admin-guide/spectre.rst | 502 +++++++++++++++++++++++++=
+++++++++
> >>  1 file changed, 502 insertions(+)
> >>  create mode 100644 Documentation/admin-guide/spectre.rst
> >=20
> > I only saw this now, seems I wasn't copied... I'll take a deeper look, =
but
>=20
> Thanks for taking a look.  I'll make sure you are copied on the updates.
>=20
> > I have a couple of meta comments:
> >=20
> >  - This could arguably go in the security book rather than the admin
> >    guide.  I don't really have a strong opinion on which is right at the
> >    moment, but others might.
>=20
> Since l1tf.rst is already here in admin guide, that's why I keep spectre.=
rst here as well.

I believe l1tf is misplaced. That one really is Intel-specific (not
even all x86s are affectd). Same for Meltdown.
									Pavel

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--OwLcNYc0lM97+oe1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEUEARECAAYFAlw7xUkACgkQMOfwapXb+vLsxgCfSWBDJU6bmYfFCQokxS8T0N6B
oAQAmO4yrw5u7p9CeFQotntnp0J04SY=
=ItKU
-----END PGP SIGNATURE-----

--OwLcNYc0lM97+oe1--
