Return-Path: <SRS0=6aQE=N4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5FA8C43441
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Nov 2018 21:02:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A9602080D
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Nov 2018 21:02:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A9602080D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726948AbeKRHTS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 18 Nov 2018 02:19:18 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:49391 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726851AbeKRHTS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Nov 2018 02:19:18 -0500
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 76C0E806E3; Sat, 17 Nov 2018 22:01:18 +0100 (CET)
Date:   Sat, 17 Nov 2018 22:01:20 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     Sebastian Reichel <sebastian.reichel@collabora.com>
Cc:     Sebastian Reichel <sre@kernel.org>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Tony Lindgren <tony@atomide.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        "H. Nikolaus Schaller" <hns@goldelico.com>,
        dri-devel@lists.freedesktop.org, linux-omap@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com
Subject: Re: [PATCHv4 1/6] drm/omap: use DRM_DEBUG_DRIVER instead of CORE
Message-ID: <20181117210120.GB22813@amd>
References: <20181115230645.15748-1-sebastian.reichel@collabora.com>
 <20181115230645.15748-2-sebastian.reichel@collabora.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="mxv5cy4qt+RJ9ypb"
Content-Disposition: inline
In-Reply-To: <20181115230645.15748-2-sebastian.reichel@collabora.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--mxv5cy4qt+RJ9ypb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri 2018-11-16 00:06:40, Sebastian Reichel wrote:
> This macro is only used by omapdrm, which should print
> debug messages using the DRIVER category instead of the
> default CORE category.
>=20
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>

Acked-by: Pavel Machek <pavel@ucw.cz>


--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--mxv5cy4qt+RJ9ypb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlvwgaAACgkQMOfwapXb+vJOwACcCOtTQrgDbB/ik9yLD3T+JUgO
EXsAoLFCx7DPrG/xvETagp0h4lxatt9Y
=Sed9
-----END PGP SIGNATURE-----

--mxv5cy4qt+RJ9ypb--
