Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 573FDC433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 10:51:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07D9E208B4
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 10:51:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07D9E208B4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726972AbeH0Ohc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 10:37:32 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:36336 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726868AbeH0Ohb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 10:37:31 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id C66F18307B; Mon, 27 Aug 2018 12:51:21 +0200 (CEST)
Date:   Mon, 27 Aug 2018 12:51:21 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     kernel list <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-omap@vger.kernel.org, tony@atomide.com, sre@kernel.org,
        nekit1000@gmail.com, mpartap@gmx.net, merlijn@wizzup.org
Cc:     tomi.valkeinen@ti.com, daniel@ffwll.ch,
        dri-devel@lists.freedesktop.org, daniel@fooishbar.org
Subject: 4.19-rc1 on droid 4: screen not updating
Message-ID: <20180827105121.GA8283@amd>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="ZGiS0Q5IWpPtfppv"
Content-Disposition: inline
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ZGiS0Q5IWpPtfppv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

With Sebastian's patches, display works on Droid 4 in v4.18.

I had to do some manual merging, and I see kernel messages in
v4.19-rc1, but they are frozen -- no updates.

a) does someone have it working?

b) is there some way I can help to get it working in mainline? Droid 4
is not exactly new, and this is painful point that makes it hard to
use.

Best regards,
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--ZGiS0Q5IWpPtfppv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAluD16kACgkQMOfwapXb+vJblACdHXOXvPRQ/+viYV8Sr/th4GJ5
fMwAn1iKDSz8ZX/ZMlW2LtrWWEgkLRwg
=1miq
-----END PGP SIGNATURE-----

--ZGiS0Q5IWpPtfppv--
