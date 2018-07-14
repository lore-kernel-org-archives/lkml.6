Return-Path: <SRS0=T5ek=J6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF986ECDFB0
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Jul 2018 06:29:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71F09208CC
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Jul 2018 06:29:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71F09208CC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727085AbeGNGrM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 14 Jul 2018 02:47:12 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:55802 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725809AbeGNGrM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Jul 2018 02:47:12 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 6FAA980498; Sat, 14 Jul 2018 08:29:16 +0200 (CEST)
Date:   Sat, 14 Jul 2018 08:29:16 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Baolin Wang <baolin.wang@linaro.org>
Cc:     jacek.anaszewski@gmail.com, bjorn.andersson@linaro.org,
        broonie@kernel.org, linux-leds@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/2] leds: core: Introduce generic pattern interface
Message-ID: <20180714062916.GB13242@amd>
References: <a0b874372f9ccd0491b54c79ac63b41812efef56.1531460834.git.baolin.wang@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="3lcZGd9BuhuYXNfi"
Content-Disposition: inline
In-Reply-To: <a0b874372f9ccd0491b54c79ac63b41812efef56.1531460834.git.baolin.wang@linaro.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--3lcZGd9BuhuYXNfi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> @@ -446,4 +455,14 @@ static inline void led_classdev_notify_brightness_hw=
_changed(
>  	struct led_classdev *led_cdev, enum led_brightness brightness) { }
>  #endif
> =20
> +/**
> + * struct led_pattern - brigheness value in a pattern

"brightness".

									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--3lcZGd9BuhuYXNfi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAltJmDsACgkQMOfwapXb+vKCeQCfUNRrcPgzKJM2XY9H7bGGIM4n
NToAnA24PLxSwKB/HhUVHJwwF3LesEjH
=Tk+O
-----END PGP SIGNATURE-----

--3lcZGd9BuhuYXNfi--
