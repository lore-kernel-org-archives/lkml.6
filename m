Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EE18C4646D
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 10:58:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0E952240A
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 10:58:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0E952240A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=the-dreams.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727806AbeHJN2O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 09:28:14 -0400
Received: from sauhun.de ([88.99.104.3]:53974 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727236AbeHJN2N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 09:28:13 -0400
Received: from localhost (p54B337F1.dip0.t-ipconnect.de [84.179.55.241])
        by pokefinder.org (Postfix) with ESMTPSA id 2940F7230D5;
        Fri, 10 Aug 2018 12:58:47 +0200 (CEST)
Date:   Fri, 10 Aug 2018 12:58:43 +0200
From:   Wolfram Sang <wsa@the-dreams.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org,
        Peter Rosin <peda@axentia.se>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [PULL REQUEST] i2c for 4.18
Message-ID: <20180810105840.bajsbm3dx3myusji@ninjato>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="dlf7ammxupzzcrry"
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--dlf7ammxupzzcrry
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Linus,

here is a driver bugfix for I2C. The bug was found by systematically
stress testing the driver, so I am confident to merge it that late in
the cycle although it is probably unusually large.

Please pull.

Thanks,

   Wolfram


The following changes since commit 1ffaddd029c867d134a1dde39f540dcc8c52e274:

  Linux 4.18-rc8 (2018-08-05 12:37:41 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git i2c/for-current

for you to fetch changes up to 5eb173f5c8f3a3cdc47b3952c368f10a28c81ab8:

  i2c: xlp9xx: Fix case where SSIF read transaction completes early (2018-08-09 17:41:13 +0200)

----------------------------------------------------------------
George Cherian (1):
      i2c: xlp9xx: Fix case where SSIF read transaction completes early

 drivers/i2c/busses/i2c-xlp9xx.c | 41 ++++++++++++++++++++++++++++-------------
 1 file changed, 28 insertions(+), 13 deletions(-)

--dlf7ammxupzzcrry
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlttb9wACgkQFA3kzBSg
KbZqNw//VWzQgiTdQZ/J45OLBtjW7ZLkeGqT3s9eiHmYf5FNl/itUk1GO4E7BGyw
L6YUqcAjTFAcH6DoHa23lMGbY9ZIlUCHA8YZZ80E9LAkKNMLe3NDk48URuPME3FG
ns9M2mzehl9eQGHkOM0mOsZ7IjnEp/cbGg6zlMs7Dm+ZlJgWgPI1IuhdVWf+nP/2
cy2YNAyBKZLDnQdC9r4Rdvkqb3XH1hPXCxnYQKY7dl1pPvm4bc8935OgHsoGuWzr
uuEuOTfvo/HyMWEjDgPDW6HACxBqFJHCwiTf/+Jun92QYYO8mfTy4z2v3HOCkvKT
dsQXkBBE+K1Km1Si/4ElFQ8+/vPXx7m7OeYRCfs8AcLHf4mqFvrcVZJkIW8qmrnb
Tg+IO3TL0040Kz5XB4JciP0A5AINwJMt22ewNlm5uNLwZ/KS7JEmjreQjMkctT6o
EhmTatLhcTmTev04/G3w75Rz72imUvZaMzIxWS/iwKM149lQ6viQj9cO8ao1TqhC
Ti9+096Vu+Ac2G4YtLlr03+18+jCS9dS5TW1Jmtd41MMjLDm4f+QSDQWd713Bnb0
rxA9lhfLfcQznwGbQz6IB0TdVKwPO4kVTOVWj90uIFtzWXDoMu2l3h0dRKlgpOK+
KdBb6AfCfNQsaRRQGLwW+se6xoDoVhtVp6N7+Gn6002todmyRlU=
=Uzat
-----END PGP SIGNATURE-----

--dlf7ammxupzzcrry--
