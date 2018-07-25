Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C7A6C6778F
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 20:02:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1647820852
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 20:02:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1647820852
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730563AbeGYVPV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 17:15:21 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:44744 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729923AbeGYVPU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 17:15:20 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 27A9B805A4; Wed, 25 Jul 2018 22:02:06 +0200 (CEST)
Date:   Wed, 25 Jul 2018 22:02:05 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     kernel list <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-omap@vger.kernel.org, tony@atomide.com, sre@kernel.org,
        nekit1000@gmail.com, mpartap@gmx.net, merlijn@wizzup.org
Subject: Droid 4: suspend to RAM?
Message-ID: <20180725200205.GA29594@amd>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="Dxnq1zWXvFF0Q93v"
Content-Disposition: inline
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Dxnq1zWXvFF0Q93v
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

I have two big problems with droid 4. #1 is that it lost 2 SMS.. and I
have no idea why. Second is power consumption -- it seems to be rather
high even before modem (and thus USB) is enabled.

Interestingly, CyanogenMod and Jolla seem to have higher power
consumption than stock operating system.

(My Linux can survive for 10 hours, stock system could survive for 4
days if I'm not mistaken).

I thought I would experiment with suspend to RAM.. and it indeed
seemed to suspend ok, but I could not wake it up. Do I need to set up
wakeup with button somehow? Is suspend to RAM required for good power
consumption?

Best regards,								Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--Dxnq1zWXvFF0Q93v
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAltY1z0ACgkQMOfwapXb+vKsdQCfXWEMTjEB61nbc4AfE4BXvBmI
DQgAoKVMRru93oblVP5zv8M7sMjTe6hX
=yGlm
-----END PGP SIGNATURE-----

--Dxnq1zWXvFF0Q93v--
