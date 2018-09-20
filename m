Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44578C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 18:55:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D83E9214C2
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 18:55:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D83E9214C2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388280AbeIUAkE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 20:40:04 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:51573 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731448AbeIUAkE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 20:40:04 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 788508074D; Thu, 20 Sep 2018 20:55:10 +0200 (CEST)
Date:   Thu, 20 Sep 2018 20:55:10 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Cc:     Sakari Ailus <sakari.ailus@iki.fi>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH v2 4/4] [media] ad5820: Add support for of-autoload
Message-ID: <20180920185510.GB26589@amd>
References: <20180920161912.17063-4-ricardo.ribalda@gmail.com>
 <20180920183151.2933-1-ricardo.ribalda@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="yNb1oOkm5a9FJOVX"
Content-Disposition: inline
In-Reply-To: <20180920183151.2933-1-ricardo.ribalda@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--yNb1oOkm5a9FJOVX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu 2018-09-20 20:31:51, Ricardo Ribalda Delgado wrote:
> Since kernel 4.16, i2c devices with DT compatible tag are modprobed
> using their DT modalias.
> Without this patch, if this driver is build as module it would never
> be autoprobed.
>=20
> Signed-off-by: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>

1,4: Acked-by: Pavel Machek <pavel@ucw.cz>

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--yNb1oOkm5a9FJOVX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAluj7Q0ACgkQMOfwapXb+vJtTgCfRoxGPsg/I+q7DngmmPHFzZW5
xCgAoIEbXKOtLMK3grf/NFWANJGDNtcn
=yYb0
-----END PGP SIGNATURE-----

--yNb1oOkm5a9FJOVX--
