Return-Path: <SRS0=1bfu=OR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21035C04EB8
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 11:24:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1F6B2146D
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 11:24:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1F6B2146D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726156AbeLHLYu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Dec 2018 06:24:50 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:50703 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726111AbeLHLYu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Dec 2018 06:24:50 -0500
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 3213580A0B; Sat,  8 Dec 2018 12:24:44 +0100 (CET)
Date:   Sat, 8 Dec 2018 12:24:47 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Cc:     bp@alien8.de, hpa@zytor.com,
        kernel list <linux-kernel@vger.kernel.org>, mingo@redhat.com,
        tglx@linutronix.de, x86@kernel.org, jani.nikula@linux.intel.com,
        rodrigo.vivi@intel.com, intel-gfx@lists.freedesktop.org,
        chris@chris-wilson.co.uk
Subject: Re: v4.20-rc1: list_del corruption on thinkpad x220, graphics
 related?
Message-ID: <20181208112447.GA9663@amd>
References: <20181108175803.GA10785@amd>
 <154279919462.20217.14259089584802660420@jlahtine-desk.ger.corp.intel.com>
 <20181121115449.GA32455@amd>
 <154296105546.7930.1457928786446716358@jlahtine-desk.ger.corp.intel.com>
 <20181124152352.GA9548@amd>
 <20181208111346.GA5535@amd>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="UlVJffcvxoiEqYs2"
Content-Disposition: inline
In-Reply-To: <20181208111346.GA5535@amd>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--UlVJffcvxoiEqYs2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat 2018-12-08 12:13:46, Pavel Machek wrote:
> Hi!
>=20
> > > > > There's one similar for nouveau in Bugzilla, but it seems like a =
genuine
> > > > > memory corruption (1 bit flipped):
> > > > >=20
> > > > > https://bugs.freedesktop.org/show_bug.cgi?id=3D84880
> > > > >=20
> > > > > Any extra information would be of use :)
> > > > >=20
> > > > > Regards, Joonas
> > > > >=20
> > > > > PS. Could you open a bug to Bugzilla, it'll help to collect the
> > > > > information in one consolidated place:
> > > > >=20
> > > > > https://01.org/linuxgraphics/documentation/how-report-bugs
> > > >=20
> > > > I prefer email... certainly for bugs that can't be reproduced.
> > >=20
> > > By adding it to the Bugzilla it may be recognized by somebody else
> > > who is experiencing a similar issue. Internet points are not deducted
> > > for submitting bugs in good faith, even if they get closed as
> > > NOTABUG.
>=20
> Well, your documentation suggests you'll deduce my internet points:
>=20
> 	Before filing the bug, please try to reproduce your issue with the
> 	latest kernel. Use the latest drm-tip branch from
> 	http://cgit.freedesktop.org/drm-tip and build as instructed on our
> 	Build Guide.
>=20
> :-)

I'd prefer not to run drm-tip. I'll update to 2.6.20-rc5+ and see if
it re-appears (but it takes long time to reproduce :-().

If you think it is useful, I can try to update my machine to
linux-next.

Best regards,
									Pavel

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--UlVJffcvxoiEqYs2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlwLqf8ACgkQMOfwapXb+vKwUQCgkfvrUb3l2kZFeBNeyZ3Khz8h
qsEAoIxZHW8WDt0EU6l1AMXymRya7plv
=H++O
-----END PGP SIGNATURE-----

--UlVJffcvxoiEqYs2--
