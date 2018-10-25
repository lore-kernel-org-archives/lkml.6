Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEE92C46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 20:42:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 526EC207DD
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 20:42:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 526EC207DD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726450AbeJZFQO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 01:16:14 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:48169 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725946AbeJZFQN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 01:16:13 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id CEC5380834; Thu, 25 Oct 2018 22:41:55 +0200 (CEST)
Date:   Thu, 25 Oct 2018 22:41:56 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Jacek Anaszewski <jacek.anaszewski@gmail.com>
Cc:     Dan Sneddon <dan.sneddon@gmail.com>, linux-leds@vger.kernel.org,
        linux-kernel@vger.kernel.org, linus.walleij@linaro.org
Subject: Re: [PATCH] leds: gpio: Fix gpiod for DT based devices
Message-ID: <20181025204156.GA18016@amd>
References: <CACceFXdF9XQS6WeSWvO=EKUEGnKwG_VkqUOECA3kJY-Hy72fjQ@mail.gmail.com>
 <05996b8d-f35c-d2d6-3043-75456fbfe0fa@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="jRHKVT23PllUwdXP"
Content-Disposition: inline
In-Reply-To: <05996b8d-f35c-d2d6-3043-75456fbfe0fa@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--jRHKVT23PllUwdXP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu 2018-10-25 21:22:34, Jacek Anaszewski wrote:
> Hi Dan,
>=20
> Thank you for the patch. Nonetheless, I've just applied similar Liviu's
> patch [0], since it arrived one week ago already.
>=20
> I'll send it upstream with LED fixes for 4-20-rc2.
>=20
> [0] https://lkml.org/lkml/2018/10/18/154

If people are hitting it this often, maybe it is time to push it
early? Linus should not have problem taking two pull requests in a
merge window.

Best regards,
								Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--jRHKVT23PllUwdXP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlvSKpQACgkQMOfwapXb+vL69QCgrB8Ww6KMnhD0+f24/fAFK/hh
IkUAn0Ejc7WDoBfh/qwxgTWl6bjyOl2M
=/+2L
-----END PGP SIGNATURE-----

--jRHKVT23PllUwdXP--
