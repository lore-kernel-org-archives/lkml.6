Return-Path: <SRS0=A5JR=LD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECD86C4321D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 09:14:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A160320C03
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 09:14:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A160320C03
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=the-dreams.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726657AbeHTM3F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Aug 2018 08:29:05 -0400
Received: from sauhun.de ([88.99.104.3]:57686 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726032AbeHTM3E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Aug 2018 08:29:04 -0400
Received: from localhost (p54B33943.dip0.t-ipconnect.de [84.179.57.67])
        by pokefinder.org (Postfix) with ESMTPSA id 973112D416B;
        Mon, 20 Aug 2018 11:14:13 +0200 (CEST)
Date:   Mon, 20 Aug 2018 11:14:13 +0200
From:   Wolfram Sang <wsa@the-dreams.de>
To:     Esben Haabendal <esben.haabendal@gmail.com>
Cc:     linux-i2c@vger.kernel.org, Esben Haabendal <eha@deif.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Lucas Stach <l.stach@pengutronix.de>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Phil Reid <preid@electromag.com.au>,
        Peter Rosin <peda@axentia.se>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/3] i2c: imx: Simplify stopped state tracking
Message-ID: <20180820091413.ranx7smh3f3swvvc@ninjato>
References: <20180816084315.7857-1-esben.haabendal@gmail.com>
 <20180816084315.7857-3-esben.haabendal@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="qryndpw7erqorbx5"
Content-Disposition: inline
In-Reply-To: <20180816084315.7857-3-esben.haabendal@gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--qryndpw7erqorbx5
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 16, 2018 at 10:43:13AM +0200, Esben Haabendal wrote:
> From: Esben Haabendal <eha@deif.com>
>=20
> Always update the stopped state when busy status have been checked.
> This is identical to what was done before, with the exception of error
> handling.
> Without this change, some errors cause the stopped state to be left in
> incorrect state in i2c_imx_stop(), i2c_imx_dma_read(), i2c_imx_read() and
> i2c_imx_xfer().
>=20
> Signed-off-by: Esben Haabendal <eha@deif.com>
> Acked-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>

Applied to for-next, thanks! I did not add stable because the cover
latter said minor issue? Not really sure here, though...


--qryndpw7erqorbx5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlt6hmUACgkQFA3kzBSg
KbYxdhAAp/ttL3yq0lKPgExJSQKKIqBSM5zRLeWgJbzAXmrz57i7mkdYGgrAU7Bb
aR4j+Iek2gmyCgJH1wuyLARlU113Ze19WRL550A96975Y42CnEeH2vG5MAXCqzVO
RXHG5y0tSyU/S4f1L3h0hWay+DDZtIVTSXUz0VxE8v0XaiETmr81RbKZBf3zT9yP
gg0GQSOF4hg+u11AhWocTcCLJS+TIyzxtxUxBGkOsajJGf3kA2bPNfdURcuDklo0
yoyalJVeIoBfPmIf8EGtiLVO/5Zu/bSBcrjj4USuTelHgC4nPXegwz/CCn9+peNd
hwk4frY5y/cc8THGF9BisNlr+czaX7ZjhQj6UNMjIAfA1NBihLzni1vBoxCUSv2I
FHF19x8spfqx/boQ1X3vpX3KliIQfmtJlBAMegIq0fPTf/XRpfxSkCUuO/zvs8Xj
tfr/lKoRy6u96+g30p/msF0T0bAMPhkAGvNGQFoFxGO+gelWGctb+UdRMjOX0iL2
PbEQT0wbpS0kojT05ny4z93JOJ+RitV8rLjiyL+kwe4sBNelLZ1VsvLkRQ5xJFol
jiv8jAUkb2nBkFw8FGW1okdymthlpg/WWkxEvlsgng5EwjqgfHV13wRsA1ARB/rU
JscQ24WkmItmLQ6uGJtad/uOpkJIlxJtqGSIqtYcBerBnIHYQho=
=ilaa
-----END PGP SIGNATURE-----

--qryndpw7erqorbx5--
