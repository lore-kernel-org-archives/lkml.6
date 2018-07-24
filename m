Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56B65C6778A
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 12:35:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12D5E20671
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 12:35:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12D5E20671
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388406AbeGXNl0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 09:41:26 -0400
Received: from mail.bootlin.com ([62.4.15.54]:58579 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388256AbeGXNl0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 09:41:26 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 63BF420737; Tue, 24 Jul 2018 14:35:07 +0200 (CEST)
Received: from localhost (AAubervilliers-681-1-78-122.w90-88.abo.wanadoo.fr [90.88.20.122])
        by mail.bootlin.com (Postfix) with ESMTPSA id 2CCD4203EC;
        Tue, 24 Jul 2018 14:35:07 +0200 (CEST)
Date:   Tue, 24 Jul 2018 14:35:07 +0200
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Ayan Kumar Halder <ayan.halder@arm.com>
Cc:     liviu.dudau@arm.com, brian.starkey@arm.com,
        ville.syrjala@linux.intel.com, airlied@linux.ie, wens@csie.org,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        nd@arm.com
Subject: Re: [PATCH] drm/sun4i: Use (struct drm_format_info) fields to
 determine if a format is yuv and multi planar or not.
Message-ID: <20180724123507.rqnq4dkjjvk24w4t@flea>
References: <1532336220-3791-1-git-send-email-ayan.halder@arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="yc2wbemgvjqr2pc4"
Content-Disposition: inline
In-Reply-To: <1532336220-3791-1-git-send-email-ayan.halder@arm.com>
User-Agent: NeoMutt/20180622
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--yc2wbemgvjqr2pc4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 23, 2018 at 09:57:00AM +0100, Ayan Kumar Halder wrote:
> We do not need sun4i_backend_format_is_packed_yuv422() /
> sun4i_backend_format_is_planar_yuv() to determine if the format is yuv mu=
lti planar
> or not. (struct drm_format_info *)->is_yuv tells if the format is yuv or =
not.
> And (struct drm_format_info *)->num_planes denotes the number of planes.
>=20
> This issue was identified during a review on a previous patch:-
> https://lists.freedesktop.org/archives/dri-devel/2018-July/183840.html
>=20
> Signed-off-by: Ayan Kumar halder <ayan.halder@arm.com>

Applied, thanks!
Maxime

--=20
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com

--yc2wbemgvjqr2pc4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAltXHPoACgkQ0rTAlCFN
r3QqyBAAigSGBzqNcB70W79YTi3xGns3wp4IuRPb8QuMofbMjosCiu0Z5WsVuP8i
DzoCd5eLvo2dhgFD+HYbF6aBbHLZkaP6jVnWmmRAzoTWjhpuNr3Qtl/WvD+C+xdE
oUKyeuulSerVloBTz161oDL6oqSu/iTszRcr80FJYE7rv37JhqmAMPb1h4UPBqfw
Qmpdezdf9Ci/OzvFpBkkEHAuoQZOxtSdPxEVbbGwUmoNgBC2cEubAWiYHxMKO4f6
fRHHYJX27x0k2q2OZUGoFLTmiHCI48mf0hnxBSINhvUgVJyQO025qZYERu9Z2YxM
Dr7Ky1sTTDMSBL8W55g5Usc6ga1d2SNI9pyB4vDvxf6WlDZaTuQSQmWknGM7zoFp
K9r87hB9kyZvNkskuj6SnB8y3IVr6HbqE65xg9OUTKznTaClaInPbNvqYpfO2SW8
05FJiGDxq8G/w1iKGSY6CdcJoqvkKIS0k+JLsVRnHRxO4BPj1T/gcB86QPQFkd96
7lL4wrh+Vk+yqH5NX4OlUmA0Fk5dyxzYVA5LOEIFJA9v0gOY5cRJJhLwwpMxlq4U
dV0bIk1ObXf2D45CsK4B23FMBqnAUyTBEEEGr6MOGQ4p3Og1oxyXtqUyLCIWHRlz
Gzf1wSb7gVa8z+yfMf2GqBVO4nQNoUV7OXvLCQ21PjLy9a8MpHw=
=Xsw+
-----END PGP SIGNATURE-----

--yc2wbemgvjqr2pc4--
