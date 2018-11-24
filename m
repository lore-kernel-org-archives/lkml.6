Return-Path: <SRS0=c/ts=OD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1787FC43441
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Nov 2018 15:23:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D030320663
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Nov 2018 15:23:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D030320663
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726708AbeKYCMe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 24 Nov 2018 21:12:34 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:33776 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726011AbeKYCMe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Nov 2018 21:12:34 -0500
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 04E5C80985; Sat, 24 Nov 2018 16:23:49 +0100 (CET)
Date:   Sat, 24 Nov 2018 16:23:52 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Cc:     bp@alien8.de, hpa@zytor.com,
        kernel list <linux-kernel@vger.kernel.org>, mingo@redhat.com,
        tglx@linutronix.de, x86@kernel.org, jani.nikula@linux.intel.com,
        rodrigo.vivi@intel.com, intel-gfx@lists.freedesktop.org,
        chris@chris-wilson.co.uk
Subject: Re: v4.20-rc1: list_del corruption on thinkpad x220
Message-ID: <20181124152352.GA9548@amd>
References: <20181108175803.GA10785@amd>
 <154279919462.20217.14259089584802660420@jlahtine-desk.ger.corp.intel.com>
 <20181121115449.GA32455@amd>
 <154296105546.7930.1457928786446716358@jlahtine-desk.ger.corp.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="YiEDa0DAkWCtVeE4"
Content-Disposition: inline
In-Reply-To: <154296105546.7930.1457928786446716358@jlahtine-desk.ger.corp.intel.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--YiEDa0DAkWCtVeE4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > > There's one similar for nouveau in Bugzilla, but it seems like a genu=
ine
> > > memory corruption (1 bit flipped):
> > >=20
> > > https://bugs.freedesktop.org/show_bug.cgi?id=3D84880
> > >=20
> > > Any extra information would be of use :)
> > >=20
> > > Regards, Joonas
> > >=20
> > > PS. Could you open a bug to Bugzilla, it'll help to collect the
> > > information in one consolidated place:
> > >=20
> > > https://01.org/linuxgraphics/documentation/how-report-bugs
> >=20
> > I prefer email... certainly for bugs that can't be reproduced.
>=20
> By adding it to the Bugzilla it may be recognized by somebody else
> who is experiencing a similar issue. Internet points are not deducted
> for submitting bugs in good faith, even if they get closed as
> NOTABUG.

Feel free to copy from email to bugzilla :-).

> It sounds like you've hit the same signature twice, so it may very well
> be reproducible. Does flightgear have some demo mode where you could
> leave it running a heavy scene overnight?

I'm not sure if it was same signature twice. I had two lockups, but
IIRC only investigated one.

Not really a demo mode. I can put plane on autopilot, but eventually
gas runs out. (And I guess window needs to be visible for test to be
effective.) I tried today, but it did not crash.

Do you have something else I could run to do the testing?

> Were you running 4.19 kernel previously, distro one or vanilla? A full
> dmesg from a boot would be appreciated (from kernel where you didn't
> experience issues, and from one where you do).

Recent kernels I'm running are self-compiled.

> We actually have a well defined process and personnel to look into the
> Bugzilla entries, so it'd still be helpful to have this logged to
> Bugzilla.

If I can reproduce it, it makes sense to create bugzilla entry.

Best regards,
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--YiEDa0DAkWCtVeE4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlv5bQgACgkQMOfwapXb+vJ2LwCfc8KyBVkCfE84DoaqSiwngr23
SuUAoL3e2X4/sePjGvTHhEiGWyFgLUzp
=fZs7
-----END PGP SIGNATURE-----

--YiEDa0DAkWCtVeE4--
