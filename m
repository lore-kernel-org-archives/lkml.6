Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF450ECDFBB
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 21:21:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E1C620858
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 21:21:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E1C620858
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729167AbeGTWLn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 18:11:43 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:35944 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728167AbeGTWLn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 18:11:43 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id C2736804DE; Fri, 20 Jul 2018 23:21:37 +0200 (CEST)
Date:   Fri, 20 Jul 2018 23:21:29 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Daniel Thompson <daniel.thompson@linaro.org>
Cc:     Kiran Gunda <kgunda@codeaurora.org>, bjorn.andersson@linaro.org,
        jingoohan1@gmail.com, lee.jones@linaro.org,
        b.zolnierkie@samsung.com, dri-devel@lists.freedesktop.org,
        jacek.anaszewski@gmail.com, robh+dt@kernel.org,
        mark.rutland@arm.com, linux-leds@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fbdev@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH V4 6/8] backlight: qcom-wled: Add support for WLED4
 peripheral
Message-ID: <20180720212128.GA13883@amd>
References: <1531131741-19971-1-git-send-email-kgunda@codeaurora.org>
 <1531131741-19971-7-git-send-email-kgunda@codeaurora.org>
 <e5bdf2fe-321a-f2e5-22f5-c886f019ac1a@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="EeQfGwPcQSOJBaQU"
Content-Disposition: inline
In-Reply-To: <e5bdf2fe-321a-f2e5-22f5-c886f019ac1a@linaro.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--EeQfGwPcQSOJBaQU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> >@@ -332,6 +529,7 @@ static u32 wled_values(const struct wled_var_cfg *cf=
g, u32 idx)
> >  }
> >  #define	WLED3	3
> >+#define	WLED4	4
>=20
> Are these macros always going to define 3 to be 3 and 4 to be 4. If so we
> probably don't need them (and they should be removed from patch 5/8 too).
>=20
> There is a degree of nitpicking here however. The rest looks OK to me.

Really nitpicking, and I don't care much either way, but as natural
numbering would be 0-based, I'd keep the defines.
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--EeQfGwPcQSOJBaQU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAltSUlgACgkQMOfwapXb+vKc9wCgl+DW32Mu1D+P2T/k85doKKNP
auoAn2rci/ZciPj1uUoVBrhTrw4JuCcw
=H4GY
-----END PGP SIGNATURE-----

--EeQfGwPcQSOJBaQU--
