Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B54B6C43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 12:44:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86E8320652
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 12:44:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86E8320652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727850AbeJBT1o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 15:27:44 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:49618 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727528AbeJBT1o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 15:27:44 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id E6B4480713; Tue,  2 Oct 2018 14:44:32 +0200 (CEST)
Date:   Tue, 2 Oct 2018 14:44:32 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Cc:     Sakari Ailus <sakari.ailus@iki.fi>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v5 5/6] [media] ad5820: DT new compatible devices
Message-ID: <20181002124432.GA28811@amd>
References: <20181002073222.11368-1-ricardo.ribalda@gmail.com>
 <20181002073222.11368-5-ricardo.ribalda@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="VbJkn9YxBvnuCH5J"
Content-Disposition: inline
In-Reply-To: <20181002073222.11368-5-ricardo.ribalda@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--VbJkn9YxBvnuCH5J
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue 2018-10-02 09:32:21, Ricardo Ribalda Delgado wrote:
> Document new compatible devices.
>=20
> Cc: devicetree@vger.kernel.org
> Signed-off-by: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
> Reviewed-by: Rob Herring <robh@kernel.org>

Acked-by: Pavel Machek <pavel@ucw.cz>

> diff --git a/Documentation/devicetree/bindings/media/i2c/ad5820.txt b/Doc=
umentation/devicetree/bindings/media/i2c/ad5820.txt
> index 9ccd96d3d5f0..cc7b10fe0368 100644
> --- a/Documentation/devicetree/bindings/media/i2c/ad5820.txt
> +++ b/Documentation/devicetree/bindings/media/i2c/ad5820.txt
> @@ -2,7 +2,10 @@
> =20
>  Required Properties:
> =20
> -  - compatible: Must contain "adi,ad5820"
> +  - compatible: Must contain one of:
> +		- "adi,ad5820"
> +		- "adi,ad5821"
> +		- "adi,ad5823"
> =20
>    - reg: I2C slave address
> =20

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--VbJkn9YxBvnuCH5J
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAluzaDAACgkQMOfwapXb+vJPSQCfZ3PPf9kPROSGUYP9b+P0wbwL
8fUAoJAT71/dH7HZH9NUJOSC9T/YucRa
=0ksZ
-----END PGP SIGNATURE-----

--VbJkn9YxBvnuCH5J--
