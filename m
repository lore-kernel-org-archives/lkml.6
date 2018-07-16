Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EB44ECDFB3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 21:44:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F17820844
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 21:44:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F17820844
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729881AbeGPWNQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 18:13:16 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:54641 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728290AbeGPWNQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 18:13:16 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 62CED80592; Mon, 16 Jul 2018 23:43:55 +0200 (CEST)
Date:   Mon, 16 Jul 2018 23:43:54 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     David Lechner <david@lechnology.com>
Cc:     Baolin Wang <baolin.wang@linaro.org>, jacek.anaszewski@gmail.com,
        bjorn.andersson@linaro.org, broonie@kernel.org,
        linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 1/2] leds: core: Introduce generic pattern interface
Message-ID: <20180716214354.GA10734@amd>
References: <05c235df7bbcc4b898e7b263bf38338d9c822005.1531711385.git.baolin.wang@linaro.org>
 <6ecb22d5-fac4-dbe9-87e7-196d87d6d06f@lechnology.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="1yeeQ81UyVL57Vl7"
Content-Disposition: inline
In-Reply-To: <6ecb22d5-fac4-dbe9-87e7-196d87d6d06f@lechnology.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--1yeeQ81UyVL57Vl7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon 2018-07-16 11:51:01, David Lechner wrote:
> On 07/16/2018 06:10 AM, Baolin Wang wrote:
> >From: Bjorn Andersson <bjorn.andersson@linaro.org>
> >
> >Some LED controllers have support for autonomously controlling
> >brightness over time, according to some preprogrammed pattern or
> >function.
> >
> >This adds a new optional operator that LED class drivers can implement
> >if they support such functionality as well as a new device attribute to
> >configure the pattern for a given LED.
> >
>=20
> Hmm... I was hoping that this would be a generic pattern trigger that
> could be used by any LED (e.g. gpio LEDs), not just LEDs with hardware
> support. I guess I cannot really test this after all.
>=20
> I think it looks good for your use case though.

Generic trigger doing patterns on any hardware would be welcome, too.

I even have a copy of code somewhere, if you want to dust it off,
clean up and merge...

									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--1yeeQ81UyVL57Vl7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAltNEZoACgkQMOfwapXb+vLr8wCfSAhGyEvmu8sdlw1crcLm1/Qg
whYAoJa4On8pQxgK8jAsPP5TpXuiyytL
=T15q
-----END PGP SIGNATURE-----

--1yeeQ81UyVL57Vl7--
