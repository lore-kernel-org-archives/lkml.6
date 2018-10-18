Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC537ECDE43
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 22:15:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79ECE21476
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 22:15:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79ECE21476
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727008AbeJSGS4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 02:18:56 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:56569 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725906AbeJSGS4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 02:18:56 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 68E84808D4; Fri, 19 Oct 2018 00:15:49 +0200 (CEST)
Date:   Fri, 19 Oct 2018 00:15:49 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Tony Lindgren <tony@atomide.com>
Cc:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-omap@vger.kernel.org, sre@kernel.org, nekit1000@gmail.com,
        mpartap@gmx.net, merlijn@wizzup.org
Subject: Re: omap4: support for manually updated display
Message-ID: <20181018221549.GB6364@amd>
References: <20180830090456.GA17277@amd>
 <797c13fa-7a5b-a809-7dd0-14b01a3046be@ti.com>
 <3205865.8O8aibZXye@avalon>
 <20180910174453.GV5662@atomide.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="ADZbWkCsHQ7r3kzd"
Content-Disposition: inline
In-Reply-To: <20180910174453.GV5662@atomide.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ADZbWkCsHQ7r3kzd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > I want to make it clear that I don't want to claim any privilege in get=
ting=20
> > patches merged first. I am however worried that, without an easy way to=
 test=20
> > DSI support, and without enough time to focus on it, I would break what=
ever=20
> > would be merged now in future reworks. I would thus like to find out ho=
w to=20
> > collaborate on this task, hopefully to move towards usage of drm_bridge=
 and=20
> > drm_panel for DSI-based pipelines.
>=20
> Real users with mainline kernel with a real product should
> always have priority over any ongoing clean-up.
>=20
> And for testing, a bunch of real users is something you can't
> beat for proper testing of code on ongoing basis!
>=20
> Naturally the burden of getting the patches ready is on the people
> using them for rebase and fixing comments. And Sebastian has
> already agreed help with maintaining it.
>=20
> I've been actually using DSI command mode support and testing
> Linux next several times a week to prevent regressions from
> sneaking into -rc1 in general. So now I can't test omapdrm with
> next until Sebastian is done with rebasing.. Back to headless
> testing then.
>=20
> Anyways, I'd say let's add the DSI command mode support ASAP after
> rebasing, there are at least Sebastian, Pavel and I then testing
> and helping with further ongoing panel conversion work.

Are there any news here? Does someone have a patch set that actually
works?

Are there any in-progress patches I could help with?

Thanks,
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--ADZbWkCsHQ7r3kzd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlvJBhUACgkQMOfwapXb+vLzawCdG8ZYberJWdLXkdZbyd3UTMNq
aX4An1RuEy9r7/b0HIM7pcNWIuNJADVy
=j4wK
-----END PGP SIGNATURE-----

--ADZbWkCsHQ7r3kzd--
