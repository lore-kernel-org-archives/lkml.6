Return-Path: <SRS0=7f4r=L6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E7B0ECE560
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Sep 2018 11:06:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42742208AE
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Sep 2018 11:06:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42742208AE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728219AbeIPQ24 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Sep 2018 12:28:56 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:37963 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728129AbeIPQ24 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Sep 2018 12:28:56 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 6DA9280753; Sun, 16 Sep 2018 13:06:20 +0200 (CEST)
Date:   Sun, 16 Sep 2018 13:06:19 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     "Grumbach, Emmanuel" <emmanuel.grumbach@intel.com>
Cc:     Johannes Berg <johannes@sipsolutions.net>,
        Randy Dunlap <rdunlap@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        linuxwifi <linuxwifi@intel.com>
Subject: Re: [linuxwifi] [PATCH] fix iwlwifi on old cards in v4.19 was Re:
 4.19-rc[23] iwlwifi: BUG in swiotlb
Message-ID: <20180916110619.GB4854@amd>
References: <0c5e53e5-2afa-8d38-0b48-272c670c4bc5@infradead.org>
 <1536651177.3224.106.camel@sipsolutions.net>
 <20180916093414.GA4299@amd>
 <20180916094142.GB4299@amd>
 <20180916095535.GA4245@amd>
 <20180916095935.GA4388@amd>
 <0BA3FCBA62E2DC44AF3030971E174FB301336B20F4@HASMSX111.ger.corp.intel.com>
 <0BA3FCBA62E2DC44AF3030971E174FB301336B2111@HASMSX111.ger.corp.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="O5XBE6gyVG5Rl6Rj"
Content-Disposition: inline
In-Reply-To: <0BA3FCBA62E2DC44AF3030971E174FB301336B2111@HASMSX111.ger.corp.intel.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--O5XBE6gyVG5Rl6Rj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun 2018-09-16 10:14:22, Grumbach, Emmanuel wrote:
> >=20
> > >
> > >
> > > .max_tfd_queue_size was ommited for old cards, leading to oops in
> > swiotlb.
> > >
> > > Signed-off-by: Pavel Machek <pavel@ucw.cz>
> > >
> >=20
> > I picked it up in our tree with minor commit message fixes.
> > I also added the Fixes tag for stable.
>=20
> Ah, of course... not needed... Sorry...

That was quick, thanks!

Ouch, and I should mention... I'm not sure 256 is right value to
use. I just... guessed so based on the other files :-).

									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--O5XBE6gyVG5Rl6Rj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlueOSsACgkQMOfwapXb+vL1CQCfSMumoGaeL/BS6wHn4G5EFRCl
NtwAniA+eI4XammwM9qjoB05/d7+54+M
=IfCT
-----END PGP SIGNATURE-----

--O5XBE6gyVG5Rl6Rj--
