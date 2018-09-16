Return-Path: <SRS0=7f4r=L6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 547ABECE561
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Sep 2018 06:57:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F306B2087B
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Sep 2018 06:57:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F306B2087B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727215AbeIPMTA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Sep 2018 08:19:00 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:32800 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726279AbeIPMTA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Sep 2018 08:19:00 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id C63978074E; Sun, 16 Sep 2018 08:57:03 +0200 (CEST)
Date:   Sun, 16 Sep 2018 08:57:03 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     johannes.berg@intel.com, emmanuel.grumbach@intel.com,
        luciano.coelho@intel.com, linuxwifi@intel.com,
        linux-wireless@vger.kernel.org,
        kernel list <linux-kernel@vger.kernel.org>
Subject: Re: v4.19-rc3 on thinkpad x220: kernel BUG at
 kernel/dma/swiotlb.c:521 when enabling radios
Message-ID: <20180916065703.GA4392@amd>
References: <20180916064702.GA4180@amd>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="fUYQa+Pmc3FrFX/N"
Content-Disposition: inline
In-Reply-To: <20180916064702.GA4180@amd>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--fUYQa+Pmc3FrFX/N
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> I was running X220 with wireless disabled for long long time. Now I
> needed to enable it, and got...

Tried with next-0913, and machine crashed with capslock LED blinking
when I toggled the switch...

Any ideas?
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--fUYQa+Pmc3FrFX/N
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlud/r8ACgkQMOfwapXb+vK1dwCgp5vqvnz6xhArH7xORoGQD68p
5a0AoLGVnkP4L2aOJCO3C4SON4Rl55Te
=Jl4N
-----END PGP SIGNATURE-----

--fUYQa+Pmc3FrFX/N--
