Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4377C282CA
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 01:19:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 716722148E
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 01:19:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="jRwGQKRN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726714AbfA1BS7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 27 Jan 2019 20:18:59 -0500
Received: from ozlabs.org ([203.11.71.1]:41055 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726511AbfA1BS7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Jan 2019 20:18:59 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 43nsGS11Tvz9s7h;
        Mon, 28 Jan 2019 12:18:55 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1548638336;
        bh=o972wViH7oKwD9aW738rysPAnjQX405iQwywhfyKDlw=;
        h=Date:From:To:Cc:Subject:From;
        b=jRwGQKRNbMk8Qyu8sXdGy2hmTWh/fA2Y6I0+tbhRsGV7RQPLANRyMnIrsD986ei3/
         q6Bi6faa2TUnw6NpegzH/SJOFA+RW1nnYrW5l5OZBsHxhSA6cABt0qrVxYSpf2muJg
         jYwHyZRBcJbsyA7jwhWmGadKKqt39FMiX7Ve0LICRbBQNqrLNP1FHGEJgzx9F6pBNx
         1LwEbwEUlO9qKRjKyBURN1K4HWyLDqJQigoCbogEr9cVFdzgwlpo0NyvEHhzAy+XBK
         sKaTj9fSEG4nyd6j4uPhMvJGMdW/5aAznsMG85lmVDYgIgu7zxF39+SgzCOWfpxe4i
         Vvb6OabAwgJAg==
Date:   Mon, 28 Jan 2019 12:18:55 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: Fixes tag needs some work in the hwmon-fixes tree
Message-ID: <20190128121855.55ef0b9c@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/5.SzisS3xg0ya0Y=1hBFfo."; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/5.SzisS3xg0ya0Y=1hBFfo.
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Guenter,

In commit

  315fd42cc1f8 ("hwmon: (nct6775) Fix fan6 detection for NCT6793D")

Fixes tag

  Fixes: 2d99925a15b6 ("hwmon: (nct6775) Separate fan/pwm configuration

has these problem(s):

  - Subject has leading but no trailing quotes

Pleas do not split the subject over more than 1 line.

--=20
Cheers,
Stephen Rothwell

--Sig_/5.SzisS3xg0ya0Y=1hBFfo.
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlxOWH8ACgkQAVBC80lX
0Gx0fgf/eZxT5Es2cZhjd6jEDsBGQgTH5lAecKkuRyG1KFj8uZ7YF5qsQ8e0j7Qo
7TZ8r0tz876sPHwiJ+W6O1ebnziN5RIEksfbaCunokdsYWY3zQrdphVhQoRT0ubY
m7AausqVBChNH4MAj/MRPuiZDLPd+UPHoUHNZNGjlnltnd7GwyeacClOeLlDkzQb
ALzcWJD1ETaEh7g7YE8gZehBD/gb5xC6IRVDL0stI5BsvZ2SDmPvnSM1/37Us7BY
6oQCFFHAsojT7DSN054Rbo1Lw4CExRAbC4vnx/HnWUdHQuSbJ44OGHJhRCtagAkQ
oukto2F2uU/vrOnAAL1LzvbouOtVXg==
=TQIr
-----END PGP SIGNATURE-----

--Sig_/5.SzisS3xg0ya0Y=1hBFfo.--
