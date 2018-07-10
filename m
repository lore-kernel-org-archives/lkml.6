Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 089B6C3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 12:05:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6DB520843
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 12:05:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6DB520843
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933258AbeGJMFJ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 08:05:09 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:53982 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932710AbeGJMFI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 08:05:08 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 1BC6980498; Tue, 10 Jul 2018 14:05:06 +0200 (CEST)
Date:   Tue, 10 Jul 2018 14:05:04 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     =?utf-8?B?UGF3ZcWC?= Chmiel <pawel.mikolaj.chmiel@gmail.com>
Cc:     kgene@kernel.org, krzk@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, linux@armlinux.org.uk,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, xc-racer2@live.ca
Subject: Re: [PATCH v4 0/5] Initial support for Samsung Galaxy S and Galaxy S
 4G
Message-ID: <20180710120504.GB6884@amd>
References: <1530958183-10956-1-git-send-email-pawel.mikolaj.chmiel@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="WhfpMioaduB5tiZL"
Content-Disposition: inline
In-Reply-To: <1530958183-10956-1-git-send-email-pawel.mikolaj.chmiel@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--WhfpMioaduB5tiZL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> This patch series adds support for Samsung Galaxy S and Galaxy S 4G.
> Both are commercial phone based on Aries family.

Thanks for doing this. What kind of userspace are your running?

(I do have N900 here running Debian and PostmarketOS, and Droid 4
running Maemo Leste)

Best regards,
							Pavel
						=09
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--WhfpMioaduB5tiZL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAltEoPAACgkQMOfwapXb+vLwOgCgl0jgMCercNULc9DErx+XC+09
LR4AnRyBJGPrh3+2AK+jMo8V5Mh2yNd6
=GQTU
-----END PGP SIGNATURE-----

--WhfpMioaduB5tiZL--
