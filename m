Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF142C43140
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 08:53:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88FD120883
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 08:53:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88FD120883
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754264AbeFUIxh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 04:53:37 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:48827 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754178AbeFUIxf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 04:53:35 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 8B47680554; Thu, 21 Jun 2018 10:53:33 +0200 (CEST)
Date:   Thu, 21 Jun 2018 10:53:33 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Chen Yu <yu.c.chen@intel.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <len.brown@intel.com>,
        "Lee, Chun-Yi" <jlee@suse.com>, Borislav Petkov <bp@alien8.de>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3][RFC] Introduce the in-kernel hibernation encryption
Message-ID: <20180621085332.GA21807@amd>
References: <cover.1529486870.git.yu.c.chen@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="X1bOJ3K7DJ5YkBrT"
Content-Disposition: inline
In-Reply-To: <cover.1529486870.git.yu.c.chen@intel.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--X1bOJ3K7DJ5YkBrT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> As security becomes more and more important, we add the in-kernel
> encryption support for hibernation.
=2E..
> There was a discussion on the mailing list on whether this key should
> be derived in kernel or in user space. And it turns out to be generating
> the key by user space is more acceptable[1]. So this patch set is divided
> into two parts:
> 1. The hibernation snapshot encryption in kernel space,
> 2. the key derivation implementation in user space.

uswsusp was created so that this kind of stuff could be kept in
userspace. You get graphical progress bar (etc) too. As you already
have userspace component for key derivation, I see no advantages to
uswsusp.

If you have some, please explain.

Best regards,
								Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--X1bOJ3K7DJ5YkBrT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlsrZ4wACgkQMOfwapXb+vJZqQCgkly9SD276j3k5iMXoRJ79poD
UusAoKGQUGD1m96jkOVVxTiFwHuFCNYe
=iseQ
-----END PGP SIGNATURE-----

--X1bOJ3K7DJ5YkBrT--
