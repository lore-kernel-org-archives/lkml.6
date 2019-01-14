Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EFF1C43612
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 13:01:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFC8F20657
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 13:01:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726623AbfANNB5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 08:01:57 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:39367 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726449AbfANNB4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 08:01:56 -0500
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id CD5C8809FC; Mon, 14 Jan 2019 14:01:48 +0100 (CET)
Date:   Mon, 14 Jan 2019 14:01:54 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     Jiri Kosina <jikos@kernel.org>
Cc:     Tim Chen <tim.c.chen@linux.intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Thomas Gleixner <tglx@linutronix.de>,
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
Message-ID: <20190114130153.GC21544@amd>
References: <64efec3fda40c0758601bf9b1480a35d76d3c487.1545413988.git.tim.c.chen@linux.intel.com>
 <20181228103437.4c03c181@lwn.net>
 <aed62eaa-93b4-8dc5-1920-6a5547e349c8@linux.intel.com>
 <20190113231001.GB18710@amd>
 <nycvar.YFH.7.76.1901140012110.6626@cbobk.fhfr.pm>
 <20190114120157.GB21544@amd>
 <nycvar.YFH.7.76.1901141305220.6626@cbobk.fhfr.pm>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="uXxzq0nDebZQVNAZ"
Content-Disposition: inline
In-Reply-To: <nycvar.YFH.7.76.1901141305220.6626@cbobk.fhfr.pm>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--uXxzq0nDebZQVNAZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon 2019-01-14 13:06:24, Jiri Kosina wrote:
> On Mon, 14 Jan 2019, Pavel Machek wrote:
>=20
> > > > That one really is Intel-specific (not even all x86s are affectd). =
Same=20
> > > > for Meltdown.
> > >=20
> > > At least for Meltdown, your claim is simply not correct.
> >=20
> > You are right, there may be few ARM chips affected by meltdown.
>=20
> And some of the powerpc64s as well.

Do you mean this?

https://lkml.org/lkml/2018/1/8/649

Frankly I'd not call it Meltdown, as it works only on data in the
cache, so the defense is completely different. Seems more like a l1tf
:-).

									Pavel

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--uXxzq0nDebZQVNAZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlw8iEEACgkQMOfwapXb+vJqgACgmZsTauJosHl/t1XgYZPA2ajV
p3UAmgMnZydkKqUgWv16yx1gr9rZQgiP
=S6Lg
-----END PGP SIGNATURE-----

--uXxzq0nDebZQVNAZ--
