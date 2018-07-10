Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B78CC3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 22:08:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCFE520A8B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 22:08:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CCFE520A8B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732318AbeGJWJN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 18:09:13 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:40195 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732237AbeGJWJM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 18:09:12 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 69FCA804CB; Wed, 11 Jul 2018 00:08:06 +0200 (CEST)
Date:   Wed, 11 Jul 2018 00:08:03 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Andy Whitcroft <apw@canonical.com>,
        Joe Perches <joe@perches.com>, jgg@mellanox.com,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Linus Walleij <linus.walleij@linaro.org>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] checkpatch: Require author Signed-off-by
Message-ID: <20180710220803.GA6387@amd>
References: <20180710121014.31119-1-geert+renesas@glider.be>
 <20180710204706.GA30083@amd>
 <CAMuHMdVZae7Nb-Nr=f1uJD9ASxaio0Ob-5__FHzN=gEp9MSc+g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="yrj/dFKFPuw6o+aM"
Content-Disposition: inline
In-Reply-To: <CAMuHMdVZae7Nb-Nr=f1uJD9ASxaio0Ob-5__FHzN=gEp9MSc+g@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--yrj/dFKFPuw6o+aM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue 2018-07-10 22:50:14, Geert Uytterhoeven wrote:
> Hi Pavel,
>=20
> On Tue, Jul 10, 2018 at 10:47 PM Pavel Machek <pavel@ucw.cz> wrote:
> > > Print an error if none of the Signed-off-by lines cover the patch
> > > author.
> >
> > Is it good idea? Signed-off-by system was _not_ meant to prevent
> > submission of third party patches.
>=20
> My main motivation is catching accidentally forgotten Sobs.
> It's still up to you to submit or accept a patch that triggers
> checkpatch errors.

Should it be at warning level, then, or explicitely saying this is
okay if you are not patch author?
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--yrj/dFKFPuw6o+aM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAltFLkMACgkQMOfwapXb+vLNywCfcTyBacOhMRz4xTChDqssG0fD
PhYAoK/zkFxslDXp0t3TtjdQOCt3S/u/
=CLpm
-----END PGP SIGNATURE-----

--yrj/dFKFPuw6o+aM--
