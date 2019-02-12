Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24D13C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 18:11:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6A912190B
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 18:11:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730791AbfBLSLz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 13:11:55 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:47882 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726943AbfBLSLy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 13:11:54 -0500
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 0502380275; Tue, 12 Feb 2019 19:11:45 +0100 (CET)
Date:   Tue, 12 Feb 2019 19:11:52 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     Sasha Levin <sashal@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Lubomir Rintel <lkundrak@v3.sk>,
        Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH 4.9 034/137] ARM: mmp/mmp2: dt: enable the clock
Message-ID: <20190212181151.GB2723@amd>
References: <20190211141811.964925535@linuxfoundation.org>
 <20190211141815.120436242@linuxfoundation.org>
 <20190211205125.GB22473@amd>
 <20190212165036.GE69686@sasha-vm>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="i0/AhcQY5QxfSsSZ"
Content-Disposition: inline
In-Reply-To: <20190212165036.GE69686@sasha-vm>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--i0/AhcQY5QxfSsSZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue 2019-02-12 11:50:36, Sasha Levin wrote:
> On Mon, Feb 11, 2019 at 09:51:25PM +0100, Pavel Machek wrote:
> >Hi!
> >
> >>4.9-stable review patch.  If anyone has any objections, please let me k=
now.
> >>
> >>------------------
> >>
> >>[ Upstream commit f36797ee43802b367e59f0f9a9805304a4ff0c98 ]
> >>
> >>The device-tree booted MMP2 needs to enable the timer clock, otherwise
> >>it would stop ticking when the boot finishes.
> >>
> >>It can also use the clock rate from the clk, the non-DT boards need to
> >>keep using the hardcoded rates.
> >>
> >>Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
> >>Acked-by: Pavel Machek <pavel@ucw.cz>
> >>Signed-off-by: Olof Johansson <olof@lixom.net>
> >>Signed-off-by: Sasha Levin <sashal@kernel.org>
> >
> >While I agree this is good idea for mainline (thus my ack), I don't
> >think it is suitable for stable, as older kernels will not run on OLPC
> >in useful way, anyway.
>=20
> Interesting, so OLPC doesn't run on 4.20?

These are for OLPC-1.75 (arm based). I'd be surprised if it booted
there...
									Pavel

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--i0/AhcQY5QxfSsSZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlxjDGcACgkQMOfwapXb+vIvgwCff4304IDf33YfjsyTuaYfalQM
1iMAoLDedgxctV82oIiIoglPcG1kOHYS
=zlcc
-----END PGP SIGNATURE-----

--i0/AhcQY5QxfSsSZ--
