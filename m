Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 1818EC5CFC1
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 08:00:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C24BC208B2
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 08:00:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C24BC208B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755957AbeFOIAT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 04:00:19 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:57463 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755792AbeFOIAS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 04:00:18 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 173F48051C; Fri, 15 Jun 2018 10:00:17 +0200 (CEST)
Date:   Fri, 15 Jun 2018 10:00:14 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     kernel list <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-omap@vger.kernel.org, tony@atomide.com, sre@kernel.org,
        nekit1000@gmail.com, mpartap@gmx.net, merlijn@wizzup.org
Subject: Charge counter on droid 4
Message-ID: <20180615080014.GA29192@amd>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="gKMricLos+KVdGMg"
Content-Disposition: inline
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--gKMricLos+KVdGMg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

Droid 4 has non-removable battery, yet the charge counter is reset to
near zero on each boot of linux.

Unfortunately, that makes charge counter pretty much useless on d4, as
the "battery full" and "battery empty" limits will be different during
each boot.

Is it possible that we reset the cpcap needlessly, or something like
that?

unicsy_demo (github.com:pavelmachek/unicsy_demo.git) was updated to
read the charge counter, and attempt to estimate battery percentages
=66rom that. Use monitor/batmond... warning -- it provides a _lot_ of
information.

Best regards,
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--gKMricLos+KVdGMg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlsjcg4ACgkQMOfwapXb+vIrjQCfTCJf0coRFkCzI7KVkz5WEoxa
zWEAoIBbxbwlP698hqj6EMFzWsO4DkDd
=0ZvM
-----END PGP SIGNATURE-----

--gKMricLos+KVdGMg--
