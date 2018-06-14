Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id DF697C07D5C
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 19:44:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0CFE208C3
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 19:44:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0CFE208C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755428AbeFNTox (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 15:44:53 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:41959 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754749AbeFNTov (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 15:44:51 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 249408047B; Thu, 14 Jun 2018 21:44:50 +0200 (CEST)
Date:   Thu, 14 Jun 2018 21:44:49 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     pali.rohar@gmail.com, sre@kernel.org,
        kernel list <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-omap@vger.kernel.org, tony@atomide.com, khilman@kernel.org,
        aaro.koskinen@iki.fi, ivo.g.dimitrov.75@gmail.com,
        patrikbachan@gmail.com, serge@hallyn.com, abcloriens@gmail.com,
        clayton@craftyguy.net, martijn@brixit.nl,
        sakari.ailus@linux.intel.com,
        Filip =?utf-8?Q?Matijevi=C4=87?= <filip.matijevic.pz@gmail.com>
Subject: v4.18-rc0: ohci-platform on n900 oops-es on reboot
Message-ID: <20180614194449.GB17808@amd>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="HG+GLK89HZ1zG0kk"
Content-Disposition: inline
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--HG+GLK89HZ1zG0kk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

When I enable

CONFIG_USB_OHCI_HCD=3Dy
CONFIG_USB_OHCI_HCD_OMAP3=3Dy
CONFIG_USB_OHCI_HCD_PLATFORM=3Dy

on n900 (I need it on droid4 and want common config), I get oops when
attempting to reboot the system. I believe problem is there in v4.17,
too.

I'll try to build it as a module and debug, but if you have better
idea, let me know...

Best regards,

									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--HG+GLK89HZ1zG0kk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlsixbEACgkQMOfwapXb+vLVGQCfV+EdRcsPd8afjuvt1DcqvY0i
wSoAn0r3oUHl+l8d9PjqkmB7OTemEh8R
=ABpc
-----END PGP SIGNATURE-----

--HG+GLK89HZ1zG0kk--
