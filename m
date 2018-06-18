Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AE76C5AE59
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 22:49:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1AB4720693
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 22:49:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1AB4720693
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937001AbeFRWtM (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 18:49:12 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:56238 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S936977AbeFRWtK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 18:49:10 -0400
Received: from [2a02:8011:400e:2:cbab:f00:c93f:614] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1fV2xQ-0005jc-8v; Mon, 18 Jun 2018 23:49:08 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1fV2xH-0001GC-GP; Mon, 18 Jun 2018 23:48:59 +0100
Message-ID: <4512507e46a150638432084f9404a2da55979cce.camel@decadent.org.uk>
Subject: Re: [PATCH] firmware: Update Kconfig help text for Google firmware
From:   Ben Hutchings <ben@decadent.org.uk>
To:     Julius Werner <jwerner@chromium.org>
Cc:     Thierry Escande <thierry.escande@collabora.com>,
        LKML <linux-kernel@vger.kernel.org>, pm.debian@googlemail.com
Date:   Mon, 18 Jun 2018 23:48:59 +0100
In-Reply-To: <CAODwPW8aPTACtWcQAFCdAkjT3jHNCu1rKxCh4uYJfj_QnBrTdA@mail.gmail.com>
References: <20180616220531.GB14131@decadent.org.uk>
         <CAODwPW8aPTACtWcQAFCdAkjT3jHNCu1rKxCh4uYJfj_QnBrTdA@mail.gmail.com>
Content-Type: multipart/signed; micalg="pgp-sha512";
        protocol="application/pgp-signature"; boundary="=-fFXjFIaIBuZk/XnNhcM/"
X-Mailer: Evolution 3.28.2-1 
Mime-Version: 1.0
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:cbab:f00:c93f:614
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-fFXjFIaIBuZk/XnNhcM/
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2018-06-18 at 13:04 -0700, Julius Werner wrote:
[...]
> nit: Technically, most of the stuff is useful on all coreboot devices,
> not just Chromebooks. (Ideally we'd want to factor that out into a
> separate drivers/firmware/coreboot, but it's a bit tricky because the
> same memconsole frontend is used for both coreboot and a proprietary
> Google server BIOS, so it's a little tricky to decide where everything
> should go. Nobody had the time to go untangle it yet.)
[...]
> GSMI is also used by Chromebooks AFAIK. (I think it's sort of become a
> general coreboot interface by now as well, although the name still
> says Google.)

OK, I'll send a v2 to fix these.

Ben.

--=20
Ben Hutchings
I'm not a reverse psychological virus.
Please don't copy me into your signature.


--=-fFXjFIaIBuZk/XnNhcM/
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEErCspvTSmr92z9o8157/I7JWGEQkFAlsoNtsACgkQ57/I7JWG
EQntyQ/8CNYwxqQcQr5r8O7eZVbISU/I7rwlIP1fw8JYLcCqZNJ7PC7QeL6wadam
TGgHkj6niyo6dyS40GAwtCzJbAMHi6eooA8nVfq737Md7bUr27Z06QZ3HAzhe4Fr
W+GsxP981CQ3ym7BuiqViSbdMFw4YGYEmw6G1MkZaa/cojUNY/aaB1MVkvRkNWfl
gluJZ+Xo2EERgULq5BAS+LyO9c9xhRrCsx5fM1ZaQxMHg1CjR1dPb+/8drcMjff9
uvDl0OtThsY+xG9VzejMXix65O51N4QQHqPNs3/P9MEhSOu/WX8tFpnJ9wNWHTyy
hWEUmZIUf89rNmmBxLKeg5UvdtTdw7jpEMzwaQxlBl8eTTlc28RwmcJrKtUrqi6v
0QOIA2RPSflvztSIlJ7sJWVD4XnAqsTZShBIS9x+EUAK91trU7aBRbTBOHO0KEs7
3k6E7mii7Jf6H8azjisKiKw/ZXKQbnFKiVZIk88cJ/2UbZ2THOhaI+xVaIZ0cXDZ
tptJLVCri/HLbO/38IOce5R3cY7lXUUisDpTXg3uUOoO3/WfV1YFp0EAcxYkZxq5
PCwPfTR/J1fHTHTPnDkK3tKxb6T0V2zLwTm7cs5Uipz7EStMHqqPqofNevIQLGv/
B3RtGmTuy0Z4TJS7+Ondxk6K/pnKwhoQOoZ32cpSmcbeJ8uwxMA=
=c5mx
-----END PGP SIGNATURE-----

--=-fFXjFIaIBuZk/XnNhcM/--
