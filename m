Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01A84C282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 14:00:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF73321019
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 14:00:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728632AbfAVOA2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 09:00:28 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:58769 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728506AbfAVOA1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 09:00:27 -0500
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <mkl@pengutronix.de>)
        id 1glwbH-00018h-EA; Tue, 22 Jan 2019 15:00:23 +0100
Received: from [IPv6:2a03:f580:87bc:d400:d5ac:2cb8:946b:3c87] (unknown [IPv6:2a03:f580:87bc:d400:d5ac:2cb8:946b:3c87])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256
         client-signature RSA-PSS (4096 bits) client-digest SHA256)
        (Client CN "mkl@blackshift.org", Issuer "StartCom Class 1 Client CA" (not verified))
        (Authenticated sender: mkl@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id A3E9E3BC0B9;
        Tue, 22 Jan 2019 14:00:22 +0000 (UTC)
Subject: Re: [PATCH v2] can: usb: Kconfig: Remove duplicate menu entry
To:     Alexander Dahl <ada@thorsis.com>, linux-can@vger.kernel.org
Cc:     Wolfgang Grandegger <wg@grandegger.com>,
        linux-kernel@vger.kernel.org
References: <20181214093508.4825-1-ada@thorsis.com>
 <20190122135542.26166-1-ada@thorsis.com>
From:   Marc Kleine-Budde <mkl@pengutronix.de>
Openpgp: preference=signencrypt
Autocrypt: addr=mkl@pengutronix.de; prefer-encrypt=mutual; keydata=
 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
Message-ID: <e9028c97-c267-ddb4-f775-bb3b416a0fdd@pengutronix.de>
Date:   Tue, 22 Jan 2019 15:00:19 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190122135542.26166-1-ada@thorsis.com>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="8hYuV0MqR7TPZXJgtQPkLlwGwQnfhFTv2"
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--8hYuV0MqR7TPZXJgtQPkLlwGwQnfhFTv2
Content-Type: multipart/mixed; boundary="8ACNkqGULDMFeKNMskXeCJiJN9OUqD8z4";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Alexander Dahl <ada@thorsis.com>, linux-can@vger.kernel.org
Cc: Wolfgang Grandegger <wg@grandegger.com>, linux-kernel@vger.kernel.org
Message-ID: <e9028c97-c267-ddb4-f775-bb3b416a0fdd@pengutronix.de>
Subject: Re: [PATCH v2] can: usb: Kconfig: Remove duplicate menu entry
References: <20181214093508.4825-1-ada@thorsis.com>
 <20190122135542.26166-1-ada@thorsis.com>
In-Reply-To: <20190122135542.26166-1-ada@thorsis.com>

--8ACNkqGULDMFeKNMskXeCJiJN9OUqD8z4
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: quoted-printable

On 1/22/19 2:55 PM, Alexander Dahl wrote:
> This seems to have slipped in by accident when sorting the entries.
>=20
> Fixes: ffbdd9172ee2f53020f763574b4cdad8d9760a4f
> Signed-off-by: Alexander Dahl <ada@thorsis.com>

Added to linux-can.

Tnx,
Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--8ACNkqGULDMFeKNMskXeCJiJN9OUqD8z4--

--8hYuV0MqR7TPZXJgtQPkLlwGwQnfhFTv2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEENrCndlB/VnAEWuH5k9IU1zQoZfEFAlxHIfMACgkQk9IU1zQo
ZfEwnwf/fC+5C4UcyzSrttLHh6+EA8OXVICOOai3k7S0YRYjk74LpkhwgTylCTPq
w/6v2p+SO7PN6G9Nmy5hbe1c4fQTHTOhyeboRtYiCOxAzqrtHBuctQ+ewtj5L+aa
KMLffyqj104SiA+HexseSq9Wqt9iTlfv9azOqa4xY/FqOOiIrMQruRQoTZtIAOYe
Iz9yCNldkDViXn9TcgvYm1Rvc+WyDjJBYDvjEQkkcjhndstzoczbteuMp2qtrvgm
aubdLrOo2ZD2wQJJV0zURR4bMrSG8/ePLcM5I3q0tikf7NpY4kYekfk49a1wxEuo
WOA7kX4Ug+rUVcIUtp+L6sngLKHfEw==
=EXDH
-----END PGP SIGNATURE-----

--8hYuV0MqR7TPZXJgtQPkLlwGwQnfhFTv2--
