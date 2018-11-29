Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA849C04EB9
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 23:44:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 469F32145D
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 23:44:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 469F32145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727140AbeK3Kvv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 05:51:51 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:51254 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726406AbeK3Kvu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 05:51:50 -0500
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id E58E1809B4; Fri, 30 Nov 2018 00:44:29 +0100 (CET)
Date:   Fri, 30 Nov 2018 00:44:32 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     dmitry.bezrukov@aquantia.com, igor.russkikh@aquantia.com,
        davem@davemloft.net, kernel list <linux-kernel@vger.kernel.org>,
        Netdev list <netdev@vger.kernel.org>
Subject: default-y for Aquantia AQtion USB to 5GbE (in -next)
Message-ID: <20181129234432.GA25059@amd>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="2oS5YaxWCcQjTEyO"
Content-Disposition: inline
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--2oS5YaxWCcQjTEyO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

In -next we have new driver, and it is default-y.

I'm pretty sure that's a no-no.

Can someone please fix it?

Thanks,

								Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--2oS5YaxWCcQjTEyO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlwAeeAACgkQMOfwapXb+vIRAACeJJXuO1+gy2xpe0AK08UMIYQV
VEMAn3kZXLZUdnR4EXOS2g+9sUGE372q
=bP/n
-----END PGP SIGNATURE-----

--2oS5YaxWCcQjTEyO--
