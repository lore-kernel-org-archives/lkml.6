Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE059C67839
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 16:29:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDE2E2086D
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 16:29:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BDE2E2086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=the-dreams.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729582AbeLMQ3B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 11:29:01 -0500
Received: from sauhun.de ([88.99.104.3]:34554 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728059AbeLMQ3B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 11:29:01 -0500
Received: from localhost (p54B335AC.dip0.t-ipconnect.de [84.179.53.172])
        by pokefinder.org (Postfix) with ESMTPSA id E18EB4C0E8F;
        Thu, 13 Dec 2018 17:28:58 +0100 (CET)
Date:   Thu, 13 Dec 2018 17:28:58 +0100
From:   Wolfram Sang <wsa@the-dreams.de>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Fabrizio Castro <fabrizio.castro@bp.renesas.com>,
        linux-renesas-soc@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pinctrl: sh-pfc: r8a77990: Fix IOCTRL reg state after
 s2ram on R-Car E3
Message-ID: <20181213162858.GC2549@kunai>
References: <20181213162027.13137-1-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="f0KYrhQ4vYSV2aJu"
Content-Disposition: inline
In-Reply-To: <20181213162027.13137-1-geert+renesas@glider.be>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--f0KYrhQ4vYSV2aJu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 13, 2018 at 05:20:27PM +0100, Geert Uytterhoeven wrote:
> Due to an interaction with commit 9f2b76a2db3c4387 ("pinctrl: sh-pfc:
> r8a77990: Add R8A774C0 PFC support"), the state of the I/O Control
> Registers is saved/restored during s2ram on RZ/G2E, but not on R-Car E3.
> Hence on R-Car E3, SDHI voltage state is lost after system resume.
>=20
> Fix this by registering the I/O Control Registers on R-Car E3, too.
>=20
> Fixes: 33847a71373cd6ae ("pinctrl: sh-pfc: r8a77990: Add voltage switch o=
perations for SDHI")
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Obviously correct:

Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>


--f0KYrhQ4vYSV2aJu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlwSiMUACgkQFA3kzBSg
KbYC6w/9EBRPFwadY8nfmIk8diOOVTkI8LwMGp8cTk/mo4sSFVm98+GSqzdEKqVD
8l/YMdToplQpec9TNd6B5Lt2KNrWpQissR2/N1OfQAEI246c9OhLt+TzNdvK5iwx
dzCGi+J9T5tdfxhx3OXOyL3Nx9C4rTHYmDFagqqRTSE8VlAg1zQPgWFn3vnve2V2
rfI3qUSRoeQQ1/CVG+lR/VfA6xYRMqS/dkmOV3bUEz1WYPei/FS3r1DVIXacydPM
3dufWD62TrmwVpKXPf8tBxcR7YKd2EiOgk96GHTcmL3pk2zRcn3y6U2EbnYRaExo
FfB/g7szwndJwQ0BMEppaK1qhBVF5wqbfWz4A/H3GK3njcoXJ9Zn4okI12t2+Iv4
6UhPEC73tOTEFfl9UJGAzuMIwS5uNW1WBTOfk3PBH2GPWjqIgiU+zZR7X+PTqDsF
uNwmmRHClCueD/i7AlB+TBMri1JPgom/T6GmLQFo/8H+ca9jXtvCBlYx79WBpiYa
O8xxPe+jTLLfxfWKbTwtzqXYT4RgMnuPKyqpW5Mz5shxn+s9PswtKKgedFnVX0lE
S38JLQtNj+x9HSopmCDYxRWkeDFOJIC7tSJvEw2LKobnaFk3XIV8XASAIIiK4Hc7
CDBrIGOe+B4jyZxto7NaI5qEZS4BePQBpRshI0rc/9p0Mqrbm3Y=
=p0ye
-----END PGP SIGNATURE-----

--f0KYrhQ4vYSV2aJu--
