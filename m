Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1AD8C46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 08:06:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A25D92082E
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 08:06:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A25D92082E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727199AbeJYQhs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 12:37:48 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:56058 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726471AbeJYQhr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 12:37:47 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id D3DEC80845; Thu, 25 Oct 2018 10:06:06 +0200 (CEST)
Date:   Thu, 25 Oct 2018 10:06:07 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     NeilBrown <neil@brown.name>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        ksummit-discuss@lists.linuxfoundation.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Olof Johansson <olof@lixom.net>, Chris Mason <clm@fb.com>,
        Mishi Choudhary <mishi@linux.com>
Subject: Re: Call to Action Re: [PATCH 0/7] Code of Conduct: Fix some
 wording, and add an interpretation document
Message-ID: <20181025080607.GB9323@amd>
References: <20181020134908.GA32218@kroah.com>
 <87y3ar80ac.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="1UWUbFP1cBYEclgG"
Content-Disposition: inline
In-Reply-To: <87y3ar80ac.fsf@notabene.neil.brown.name>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--1UWUbFP1cBYEclgG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon 2018-10-22 08:20:11, NeilBrown wrote:
> On Sat, Oct 20 2018, Greg Kroah-Hartman wrote:
>=20
> > Hi all,
> >
> > As everyone knows by now, we added a new Code of Conduct to the kernel
> > tree a few weeks ago.
>=20
> I wanted to stay detached from all this, but as remaining (publicly)
> silent might be seen (publicly) as acquiescing, I hereby declare that:
>    I reject, as illegitimate, this Code and the process by
>    which it is being "developed".
>=20
> It is clear from the surrounding discussions that this is well outside our
> core competencies.  It will be flawed, it isn't what we need.

Agreed.

> I call on you, Greg:
>  - to abandon this divisive attempt to impose a "Code of Conduct"
>  - to revert 8a104f8b5867c68

Agreed.

Plus I actually wish more people would gpg-sign their emails. It is
not that hard, and I actually thought original Linus' rc4 announcement
was fake.

It was not, and it does not look like there are spoofed mails here,
either, but hey, there are few I'd like to verify.

Best regards,

									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--1UWUbFP1cBYEclgG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlvReW8ACgkQMOfwapXb+vJNJgCcDT8g+fbbz4EliEaK07NNnLCP
nD4AoKPWgjXfuiZrc6aVRWdM96JOsx+z
=pg52
-----END PGP SIGNATURE-----

--1UWUbFP1cBYEclgG--
