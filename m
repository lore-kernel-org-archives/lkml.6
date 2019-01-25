Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09027C282C0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 03:51:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A97C9218CD
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 03:51:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kde.org header.i=@kde.org header.b="NzJsm97m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728990AbfAYDvB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 22:51:01 -0500
Received: from letterbox.kde.org ([46.43.1.242]:49368 "EHLO letterbox.kde.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728468AbfAYDvB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 22:51:01 -0500
X-Greylist: delayed 566 seconds by postgrey-1.27 at vger.kernel.org; Thu, 24 Jan 2019 22:51:00 EST
Received: from archbox.localdomain (unknown [123.201.15.161])
        (Authenticated sender: bshah)
        by letterbox.kde.org (Postfix) with ESMTPSA id 63E9F280511;
        Fri, 25 Jan 2019 03:41:31 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kde.org; s=users;
        t=1548387692; bh=EIdYV+SmvJek5xcEdRcE3h87myBMee2Z4JkbSj8Afho=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NzJsm97m5iJyiLpw6F0xCLHUXB8b62LizOX3OUkeHQvuV5SwVLrjudP+fYt7pikJ2
         aONG8OiGmr0K3asSz5ON+xa2Gc9piLIvk3wx0Zga55j3vCY4TCAH/xDl4YlQKTIi4h
         UAJsKolGSXypExrko2vc2/NU34mQhtP3MB58fKEXA82b0oyQ05oFsJxdiHrG3ZxY0B
         BRpUVteI0KluSigJBMz8iH9Gj3o/lxxvFZOcDJcCmN2knqH1AGBb8o0TAC1O8EM1N7
         PzOcL59p9bfdRMsoWu/GkI+vjN6JRl4KO8K8jvfgarr/c0ZQsSbsImD675AmD1Xwyn
         GbzPeDDCUK/GQ==
Date:   Fri, 25 Jan 2019 09:07:40 +0530
From:   Bhushan Shah <bshah@kde.org>
To:     Jagan Teki <jagan@amarulasolutions.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Sam Ravnborg <sam@ravnborg.org>,
        Michael Trimarchi <michael@amarulasolutions.com>,
        linux-amarula@amarulasolutions.com, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Subject: Re: [v4,2/2] drm/panel: Add Feiyang FY07024DI26A30-D MIPI-DSI LCD
 panel
Message-ID: <20190125033737.GA12679@orion>
References: <20190124184313.30193-2-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="qMm9M+Fa2AknHoGS"
Content-Disposition: inline
In-Reply-To: <20190124184313.30193-2-jagan@amarulasolutions.com>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--qMm9M+Fa2AknHoGS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 25, 2019 at 12:13:13AM +0530, Jagan Teki wrote:
> Feiyang FY07024DI26A30-D is 1024x600, 4-lane MIPI-DSI LCD panel.
>=20
> Add panel driver for it.
>=20
> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>

Tested-by: Bhushan Shah <bshah@kde.org>

--=20
Bhushan Shah
http://blog.bshah.in
IRC Nick : bshah on Freenode
GPG key fingerprint : 0AAC 775B B643 7A8D 9AF7 A3AC FE07 8411 7FBC E11D

--qMm9M+Fa2AknHoGS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEs8s2ZVJUC+Bu6a2XEZaMRJKMrvwFAlxKhHwACgkQEZaMRJKM
rvxnIgf/QtvwCvxFx++R+XirncaKf9wSB5Reoctu16YlJtKn9dzrYvUuz1fg+AYO
Zb8oB1ePrzpCnq8eDQr9N27qU+TK5UG6DY7m8zuG7VQR0CIoTi28DbOkPOL5/Nzp
E/E+KerkWllu5fNliPem5i3Y47DGJ11sPfOchx9gUCMgpqBFdwytVGgu5vhRh3Vo
kKP0tX9SfCi8CZ9+/C9Ca/5eko48TdALWYlPMX9x6j8kYoH3JrM6512tBjG0U6rR
zJfL9X4TEtmaiJjlv+NFtJcnhIonBWIuXqiU2cAgiGrPMLTjgmluFGXwaLBuWwO9
nbYXY2jOsTsOd74y7LbHzuNJNwo2GQ==
=FCJ7
-----END PGP SIGNATURE-----

--qMm9M+Fa2AknHoGS--
