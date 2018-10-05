Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50DC7C00449
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 12:24:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C2FE208E7
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 12:24:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C2FE208E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=the-dreams.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728431AbeJETWy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 15:22:54 -0400
Received: from sauhun.de ([88.99.104.3]:38940 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727558AbeJETWx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 15:22:53 -0400
Received: from localhost (p54B3360B.dip0.t-ipconnect.de [84.179.54.11])
        by pokefinder.org (Postfix) with ESMTPSA id 8AA6D2C79EA;
        Fri,  5 Oct 2018 14:24:22 +0200 (CEST)
Date:   Fri, 5 Oct 2018 14:24:22 +0200
From:   Wolfram Sang <wsa@the-dreams.de>
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     linux-i2c@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 06/12] i2c: qup: use core to detect 'no zero length' quirk
Message-ID: <20181005122422.GI5433@kunai>
References: <20180723202617.15230-1-wsa+renesas@sang-engineering.com>
 <20180723202617.15230-7-wsa+renesas@sang-engineering.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="LYw3s/afESlflPpp"
Content-Disposition: inline
In-Reply-To: <20180723202617.15230-7-wsa+renesas@sang-engineering.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--LYw3s/afESlflPpp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 23, 2018 at 10:26:10PM +0200, Wolfram Sang wrote:
> And don't reimplement in the driver.
>=20
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Ping.


--LYw3s/afESlflPpp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlu3V/UACgkQFA3kzBSg
KbZXHA/+N6hfddOcX01gbCol367kzHol2md/H6PTSaLsq4/+Gc7+CVB2QZMi5/ao
OJcipA09/6idjhO/YkcCVF3MOJr1gLSbh8u3mZFvom+9bcjlZdIkI+7VZRP8J4cd
l+Bd8Y7/G8RUwHgbDWWtaCR/NpGb/0azh1SWTJRSiVy6x+QyxjapMAIuYSe+7bcV
Apmzm783ytzhS5SzqgRNWC9cgVM27Iger6az38uQyScNFabbuiSp9Whg3kT1HZfV
2WMc5WvN4TkZd8FFeHSshtmz/I38tCpaYE4FcZIIrJpnTPtEFNi8/WtzHS77rDrt
vE8U1CaUOBuC/4gHPEVqxK6w5w7lJRQX1qSaRXsIoY7JOAbzrQxclnuRqlxTzCsR
pyKaihmOo+gVnjC0N/RciPpx1jvHp61DZfe/EQFawXSGq+RsLX+KPaNaimpAf6hS
v8mkXzH2g4PTuOE+bxBlw7uBOCypWSSL8PLXdA7QegMlvifK9Z6OXGj+CbxovQHt
7oc+ASJ14/UqDe4QmNQbyeTdmGEEcXpofHARhFJ6lvzob8kfOnRx5gDSp0Q0/Wki
ma0AzdcIG39rGEVWreJY23KZG9K4PI8l1P1ohMrJZCA1iWf8gWZk7TgaFZI02RpU
gjTzd1OLBHZqrwFQ8B6BDwJLJUUU11A8p5TFVqO/r7msTcPtgec=
=5qTJ
-----END PGP SIGNATURE-----

--LYw3s/afESlflPpp--
