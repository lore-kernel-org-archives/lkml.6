Return-Path: <SRS0=bZNE=OE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 032B2C04EBA
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 21:45:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C99802082E
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 21:45:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C99802082E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726233AbeKZIhH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 03:37:07 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:49787 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726167AbeKZIhG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 03:37:06 -0500
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id DE1818083E; Sun, 25 Nov 2018 22:44:58 +0100 (CET)
Date:   Sun, 25 Nov 2018 22:45:01 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     Baolin Wang <baolin.wang@linaro.org>
Cc:     sre@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, yuanjiang.yu@unisoc.com,
        broonie@kernel.org
Subject: Re: [PATCH 3/5] power: supply: sc27xx: Add fuel gauge low voltage
 alarm
Message-ID: <20181125214501.GA9913@amd>
References: <cover.1542185618.git.baolin.wang@linaro.org>
 <ee1dd39f126bd03fb88381de9663d32df994d341.1542185618.git.baolin.wang@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="PNTmBPCT7hxwcZjr"
Content-Disposition: inline
In-Reply-To: <ee1dd39f126bd03fb88381de9663d32df994d341.1542185618.git.baolin.wang@linaro.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--PNTmBPCT7hxwcZjr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed 2018-11-14 17:07:06, Baolin Wang wrote:
> From: Yuanjiang Yu <yuanjiang.yu@unisoc.com>
>=20
> Add low voltage alarm support to make sure the battery capacity
> more accurate in lower voltage stage.
>=20
> Signed-off-by: Yuanjiang Yu <yuanjiang.yu@unisoc.com>
> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>

Should we also shut down the system when that happens, as battery is
empty?

Or is there any lower threshold when we should do the shutdown?
								Pavel
							=09
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--PNTmBPCT7hxwcZjr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlv7F90ACgkQMOfwapXb+vJtRgCfS3fRJIeEdzw59EOEwnN8MoZ/
U7UAoJYHWQoh0LNWkvHLGSpc0IDzq2QH
=teVP
-----END PGP SIGNATURE-----

--PNTmBPCT7hxwcZjr--
