Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 453E1C5CFEB
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 22:02:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3B8120849
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 22:02:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F3B8120849
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933275AbeGIWCP (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 18:02:15 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:38589 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933025AbeGIWCO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 18:02:14 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 3396980268; Tue, 10 Jul 2018 00:02:12 +0200 (CEST)
Date:   Tue, 10 Jul 2018 00:02:11 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     kernel list <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-omap@vger.kernel.org, tony@atomide.com, nekit1000@gmail.com,
        mpartap@gmx.net, merlijn@wizzup.org
Subject: Re: Vibrations on Droid 4?
Message-ID: <20180709220211.GA7760@amd>
References: <20180709081534.GA6799@amd>
 <20180709214910.tes6u4ivxomd3aja@earth.universe>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="vkogqOf2sHV7VnPd"
Content-Disposition: inline
In-Reply-To: <20180709214910.tes6u4ivxomd3aja@earth.universe>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--vkogqOf2sHV7VnPd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > Do you have vibrations on d4 working?
> > I believe I have required drivers enabled, but no luck:
> >=20
> > user@devuan:/sys/bus/platform/drivers$ ls pwm-vibrator/
> > bind  uevent  unbind
> > user@devuan:/sys/bus/platform/drivers$ ls omap-dmtimer-pwm/
> > bind  uevent  unbind
>=20
> Have you checked probe deferrals?

Not really. Is there easier way to do that than adding printks in the
probe function? (I can go through dmesg tommorow).

Thanks,
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--vkogqOf2sHV7VnPd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAltD22MACgkQMOfwapXb+vIGtACcDpWKMT4p4owpY2vRFRB482Fe
4doAn0TPYEnpjkZSpN/FjfaIzcY9YOzQ
=FGF2
-----END PGP SIGNATURE-----

--vkogqOf2sHV7VnPd--
