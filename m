Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33BEDC32789
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 22:16:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02B8A20831
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 22:16:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02B8A20831
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728526AbeKCHZc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 3 Nov 2018 03:25:32 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:40870 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728505AbeKCHZb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Nov 2018 03:25:31 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id D80508080A; Fri,  2 Nov 2018 23:16:32 +0100 (CET)
Date:   Fri, 2 Nov 2018 23:16:34 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     Lubomir Rintel <lkundrak@v3.sk>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>
Subject: Re: [PATCH] irqchip/mmp: only touch the PJ4 & FIQ bits on
 enable/disable
Message-ID: <20181102221634.GD5322@amd>
References: <20180910120425.164416-1-lkundrak@v3.sk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="RhUH2Ysw6aD5utA4"
Content-Disposition: inline
In-Reply-To: <20180910120425.164416-1-lkundrak@v3.sk>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--RhUH2Ysw6aD5utA4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon 2018-09-10 14:04:25, Lubomir Rintel wrote:
> On an OLPC XO 1.75 machine, the "security processor" handles the GPIO 71
> and 72 interrupts. Don't reset the "route to SP" bit (4).
>=20
> I'm just assuming the bit 4 is the "route to SP" bit -- it fixes the
> SP-based keyboard for me and <mach-mmp/regs-icu.h> defines
> ICU_INT_ROUTE_SP_IRQ to be 1 << 4. When asked for a data sheet, Marvell
> told me to fuck off, politely.

"Marvell was not exactly helpful".

> Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>

Acked-by: Pavel Machek <pavel@ucw.cz>

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--RhUH2Ysw6aD5utA4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlvczMIACgkQMOfwapXb+vIu8QCcDsxHuPbNwbWZ+Nr6wXpDmW6S
EvgAn1kGuRup29/xH1+U5ScsYaH9ugDQ
=Cj92
-----END PGP SIGNATURE-----

--RhUH2Ysw6aD5utA4--
