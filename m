Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78D93C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 16:16:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EEE8C206E0
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 16:16:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729932AbeLNQQf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 11:16:35 -0500
Received: from anholt.net ([50.246.234.109]:45350 "EHLO anholt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727795AbeLNQQe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 11:16:34 -0500
Received: from localhost (localhost [127.0.0.1])
        by anholt.net (Postfix) with ESMTP id E8A7610A1DF8;
        Fri, 14 Dec 2018 08:16:33 -0800 (PST)
X-Virus-Scanned: Debian amavisd-new at anholt.net
Received: from anholt.net ([127.0.0.1])
        by localhost (kingsolver.anholt.net [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id Vr6MTYyH5WUt; Fri, 14 Dec 2018 08:16:32 -0800 (PST)
Received: from eliezer.anholt.net (localhost [127.0.0.1])
        by anholt.net (Postfix) with ESMTP id B41BC10A0211;
        Fri, 14 Dec 2018 08:16:32 -0800 (PST)
Received: by eliezer.anholt.net (Postfix, from userid 1000)
        id 562772FE2D15; Fri, 14 Dec 2018 08:16:32 -0800 (PST)
From:   Eric Anholt <eric@anholt.net>
To:     Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc:     David Airlie <airlied@linux.ie>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Eben Upton <eben@raspberrypi.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Subject: Re: [PATCH] drm/vc4: Limit SAND tiling support to semiplanar YUV420 formats
In-Reply-To: <20181214141218.12671-1-paul.kocialkowski@bootlin.com>
References: <20181214141218.12671-1-paul.kocialkowski@bootlin.com>
User-Agent: Notmuch/0.22.2+1~gb0bcfaa (http://notmuchmail.org) Emacs/25.2.2 (x86_64-pc-linux-gnu)
Date:   Fri, 14 Dec 2018 08:16:32 -0800
Message-ID: <87d0q4f5i7.fsf@anholt.net>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha512; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain

Paul Kocialkowski <paul.kocialkowski@bootlin.com> writes:

> Despite what the HVS documentation indicates, the VC4 does not actually
> support SAND tiling modes for any RGB format and only semiplanar YUV420
> formats (NV12/NV21) can be used in these tiling modes.
>
> The driver currently claims to support RGB formats for the associated
> modifiers, so remove them from the supported list in the
> format_mod_supported helper for RGB formats.
>
> Remove further checks that are no longer necessary along the way, since
> semi-planar YUV420 formats support every SAND tiling mode.
>
> Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>

Reviewed-by: Eric Anholt <eric@anholt.net>

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE/JuuFDWp9/ZkuCBXtdYpNtH8nugFAlwT12AACgkQtdYpNtH8
nugZYA/+PAIlKsui2MAMm22khMKoBTc8/+H4QzUPwoOx5AbP1IXuWGcGlbmS4qRh
ppNSYx35fxCRdE6050+75qO3tq21z60sSZ6amdbck8Js3iHq3jZMOTYZ/r+5t0Zh
rmSvRK+AaPy2nXhypTpcYPpgy9SGV7d6XGanBvv2ynLc6UsLLXFTiAbXopyyWjls
1eKfgLGbXcPf0yQNGbN2d20WDO0wVp0xMtNTL3md5WiH3e3iV60g3yFzzWiZ7bqm
mjP0+QAoMUTP8yYn87ilGAPXTSUxvsgAnKaGjF+eT/Ga1deJ/8vU+hrlZ/5wbqhk
UpJJecYkGW6RO1nRiBzAdXBaD8/CKDnD9wmMJeXF9/Evr1HHaEW8YulJnPAslyoG
Of2Do7OsNBG0rv881Z5ByfwkSqJssd4a4C9qYitWS5Ddy81i/uzdRp16PvPscqRl
i3lungXfQ9Mk8hNxYazU6B+Azepl4UotBrs9n9cZ8CrIc6chlWgJZUasZP38fmL0
T4E767DSua89Ji6QoFcewxp3/CMY44v7D7ji+a6m6iyvDsDmsZfycwJHE0sFHxfb
EXTkuFW8Op6/RUPpK+KUKdSef4V7Z5HVNIAqQq9I+bTMK7MTIaOwgxLsotcua1nc
yJDe2UqFL9dXCkC13sdS38yrqHVOQzNYxJez+hQzcxvPIxe/7W8=
=OCa7
-----END PGP SIGNATURE-----
--=-=-=--
