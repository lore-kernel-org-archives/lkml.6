Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DEE7C43144
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 07:17:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E023C27B71
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 07:17:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E023C27B71
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932673AbeF2HR1 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 03:17:27 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:37662 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752260AbeF2HRZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 03:17:25 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 7FCB3805BF; Fri, 29 Jun 2018 09:17:24 +0200 (CEST)
Date:   Fri, 29 Jun 2018 09:17:24 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Andreas Klinger <ak@it-klinger.de>
Cc:     jacek.anaszewski@gmail.com, ben.whitten@gmail.com,
        geert+renesas@glider.be, w@1wt.eu, pombredanne@nexb.com,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux-leds@vger.kernel.org
Subject: Re: [PATCH] leds: ledtrig-morse: send out morse code
Message-ID: <20180629071724.GA10079@amd>
References: <20180628134227.GA1719@arbeit>
 <20180628185630.GA6095@amd>
 <20180628202955.GA1534@imap.1und1.de>
 <20180628204516.GA29146@amd>
 <20180629064147.GA3219@arbeit>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="UlVJffcvxoiEqYs2"
Content-Disposition: inline
In-Reply-To: <20180629064147.GA3219@arbeit>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--UlVJffcvxoiEqYs2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> > Yeah, well... I don't think decoding sentences in morse code is going
> > to be much fun.
> >=20
> > And we don't really want encoder in kernel. Just do encoding in
> > userspace, and use pattern trigger to display it.
> >=20
> > For many uses, morse code is "too geeky", and other patterns will be
> > used.
> >=20
> > Like " X    " for error 1, " X X     " for error 2, " .xX .xX " for
> > charging, " .xXx. " for everything okay...
> >=20
>=20
> The hardware i'm using is not able to adjust brightness. It can just swit=
ch the
> LED on or off. That's it.
>=20
> If anybody is interested i can submit a version 2 of the morse trigger wi=
th the
> improvements suggested by Greg and Geert. Please let me know.

I'd prefer more general pattern trigger.
									Pavel
								=09
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--UlVJffcvxoiEqYs2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAls13QMACgkQMOfwapXb+vLowgCfe9CsRq/3XG1Brkcz+YqSw9dn
W+oAnjSOqYBGnSZNhoTUKy+6GXaEeov3
=Kq2f
-----END PGP SIGNATURE-----

--UlVJffcvxoiEqYs2--
