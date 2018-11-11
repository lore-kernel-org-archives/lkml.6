Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67795C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 14:29:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B816208A3
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 14:29:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B816208A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728363AbeKLASe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 11 Nov 2018 19:18:34 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:47475 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727805AbeKLASd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Nov 2018 19:18:33 -0500
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id A03E4806D1; Sun, 11 Nov 2018 15:29:46 +0100 (CET)
Date:   Sun, 11 Nov 2018 15:29:41 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     Jacek Anaszewski <jacek.anaszewski@gmail.com>
Cc:     linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, robh@kernel.org,
        Xiaotong Lu <xiaotong.lu@spreadtrum.com>,
        Baolin Wang <baolin.wang@linaro.org>
Subject: Re: [PATCH 05/24] dt-bindings: sc27xx-blt: Add function and color
 properties
Message-ID: <20181111142941.GA5215@amd>
References: <1541542052-10081-1-git-send-email-jacek.anaszewski@gmail.com>
 <1541542052-10081-6-git-send-email-jacek.anaszewski@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="C7zPtVaVf+AK4Oqc"
Content-Disposition: inline
In-Reply-To: <1541542052-10081-6-git-send-email-jacek.anaszewski@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--C7zPtVaVf+AK4Oqc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue 2018-11-06 23:07:13, Jacek Anaszewski wrote:
> Refer to new "function" and "color" properties and mark "label"
> as deprecated.
>=20
> Signed-off-by: Jacek Anaszewski <jacek.anaszewski@gmail.com>
> Cc: Xiaotong Lu <xiaotong.lu@spreadtrum.com>
> Cc: Baolin Wang <baolin.wang@linaro.org>

Don't you want to keep both color and label? New dts on old kernel
should still work...?

Ok, I see these are only examples....

								Pavel


> @@ -25,17 +27,17 @@ led-controller@200 {
>  	reg =3D <0x200>;
> =20
>  	led@0 {
> -		label =3D "red";
> +		color =3D "red";
>  		reg =3D <0x0>;
>  	};
> =20
>  	led@1 {
> -		label =3D "green";
> +		color =3D "green";
>  		reg =3D <0x1>;
>  	};
> =20
>  	led@2 {
> -		label =3D "blue";
> +		color =3D "blue";
>  		reg =3D <0x2>;
>  	};
>  };

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--C7zPtVaVf+AK4Oqc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlvoPNUACgkQMOfwapXb+vKuwQCfb+wupIpbOy21flY+y3H9dWuV
Sl0AoLchTRSfoLQGrDsanAPqL1g176X4
=jS8d
-----END PGP SIGNATURE-----

--C7zPtVaVf+AK4Oqc--
