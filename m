Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78E83C433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 22:42:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 257F12087A
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 22:42:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 257F12087A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727626AbeH2Cfs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 22:35:48 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:52295 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727067AbeH2Cfs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 22:35:48 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 58FC980268; Wed, 29 Aug 2018 00:41:59 +0200 (CEST)
Date:   Wed, 29 Aug 2018 00:41:58 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Tony Lindgren <tony@atomide.com>
Cc:     kernel list <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-omap@vger.kernel.org, sre@kernel.org, nekit1000@gmail.com,
        mpartap@gmx.net, merlijn@wizzup.org, tomi.valkeinen@ti.com,
        daniel@ffwll.ch, dri-devel@lists.freedesktop.org,
        daniel@fooishbar.org
Subject: Re: 4.19-rc1 on droid 4: screen not updating
Message-ID: <20180828224158.GA12978@amd>
References: <20180827105121.GA8283@amd>
 <20180828023722.GK7523@atomide.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="7AUc2qLy4jB3hD7Z"
Content-Disposition: inline
In-Reply-To: <20180828023722.GK7523@atomide.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--7AUc2qLy4jB3hD7Z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > With Sebastian's patches, display works on Droid 4 in v4.18.
>=20
> Hmm care to post your v4.18 patches somewhere too for people?
> I'd have to look around for them since I've been using Linux
> next for past few months.

I don't have patches separated at the moment. I pushed the branch to

git@gitolite.kernel.org:pub/scm/linux/kernel/git/pavel/linux-n900.git

all-v4.18

> Also, do you have v4.19-rc1 versions of your pending audio
> patches somewhere? I'd like to play with voice calls again
> now with my WIP pending n_gsm serdev patches..

I pushed that to all-v4.19 .

> > I had to do some manual merging, and I see kernel messages in
> > v4.19-rc1, but they are frozen -- no updates.
> >=20
> > a) does someone have it working?
>=20
> I have had it working for few weeks since I'm following
> Linux next. I just pushed Sebastian's patches I rebased
> earlier today against v4.19-rc1 to [0][1].

Thanks, will take a look tommorow.

> > b) is there some way I can help to get it working in mainline? Droid 4
> > is not exactly new, and this is painful point that makes it hard to
> > use.
>=20
> Well since Sebastian is busy according to [2], maybe try to update
> Sebastian's mfd-ti-lmu backlight patches so they can get merged?
> Please check with Sebastian, but that would cut down the pending
> pile by quite a few patches.

Ok, let me take a look.

I currently don't have the patches separated, and yes, the audio ones
work, but no, they are not designed right :-(.=20

Best regards,
									Pavel

> [0] git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap droid=
4-pending-v4.19
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap.git=
/log/?h=3Ddroid4-pending-v4.19
> [2] https://lists.freedesktop.org/archives/dri-devel/2018-August/186226.h=
tml

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--7AUc2qLy4jB3hD7Z
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAluFz7YACgkQMOfwapXb+vJRFwCeOMVjRK3QYSn+0vy/PTAhpSOL
W9MAn3WO+DDpXIpceIy+U0dSpM8d9e+a
=XVDh
-----END PGP SIGNATURE-----

--7AUc2qLy4jB3hD7Z--
