Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4322FC4646E
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 21:48:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0568F217A2
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 21:48:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0568F217A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732136AbeHCXqD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 19:46:03 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:34856 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729828AbeHCXqD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 19:46:03 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 74E9080611; Fri,  3 Aug 2018 23:47:55 +0200 (CEST)
Date:   Fri, 3 Aug 2018 23:47:55 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     kernel list <linux-kernel@vger.kernel.org>
Cc:     gnomes@lxorguk.ukuu.org.uk, x86@kernel.org, hpa@zytor.com,
        mingo@redhat.com, tglx@linutronix.de
Subject: v4.18-rc6 on thinkpad x60: 72000 bogomips?
Message-ID: <20180803214754.GA9063@amd>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="bp/iNruPH9dso1Pn"
Content-Disposition: inline
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--bp/iNruPH9dso1Pn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

I know bogomips are supposed to be bogus, but 72000 of them? On
Genuine Intel(R) CPU           T2400  @ 1.83GHz ? I could live with
1830 bogomips, or maybe 500, or maybe 6000, but 72k is a bit
much. 32-bit kernel.

(And no, it does not break anything AFAICT, but it looks weird.)

4.18.0-rc5 on Intel(R) Core(TM)2 Duo CPU     E7400  @ 2.80GHz shows
5599.82 bogomips. 64-bit kernel.

Any ideas?
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--bp/iNruPH9dso1Pn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAltkzYoACgkQMOfwapXb+vI6/ACgs9DW00aqwy/xl/nsLRk+z232
KykAniwW+ZTkpADoqv2v0JxgkQqDRVqA
=/Bs7
-----END PGP SIGNATURE-----

--bp/iNruPH9dso1Pn--
