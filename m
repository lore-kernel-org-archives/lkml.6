Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC219C3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 17:00:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8300216FC
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 17:00:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8300216FC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=collabora.co.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933775AbeGFRA2 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 13:00:28 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:49786 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933157AbeGFRA1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 13:00:27 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id C200127942A
Date:   Fri, 6 Jul 2018 19:00:23 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.co.uk>
To:     "H. Nikolaus Schaller" <hns@goldelico.com>
Cc:     anish kumar <anish198519851985@gmail.com>,
        Krzysztof Kozlowski <k.kozlowski@samsung.com>,
        Anton Vorontsov <cbouatmailru@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, letux-kernel@openphoenux.org,
        kernel@pyra-handheld.com
Subject: Re: [PATCH 0/2] power: generic-adc-battery: fix out of bounds write
Message-ID: <20180706170023.mpz2vj2mj6vzsc2d@earth.universe>
References: <cover.1530019688.git.hns@goldelico.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="tyul24fgxwrwyztr"
Content-Disposition: inline
In-Reply-To: <cover.1530019688.git.hns@goldelico.com>
User-Agent: NeoMutt/20180512
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--tyul24fgxwrwyztr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Jun 26, 2018 at 03:28:28PM +0200, H. Nikolaus Schaller wrote:
> This patch set addresses two bugs in the gab_probe() function which are
> there since the first commit in 3.7-rc1:
>=20
> 1. there is an out of bounds write access by a miscalculated destination
>    address for the memcpy()
> 2. if iio channels are already represented by default properties, they
>    appear as duplicates in uevent

Thanks, both queued into power-supply-fixes.

-- Sebastian

--tyul24fgxwrwyztr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAls/oCMACgkQ2O7X88g7
+ppnGg//arX6a+lPENOZlMOs7L1LWLdO/nV8d67xC3sqSU/1+GGs1b0FvRc15NP7
aQ//Hh1b5ISiErnJ+c+G3cPDqldJZ5tl5pd0IYZVtLE4NqkyEqMgZdvovCjih5Uq
PpM33XmjcTGl1DUhxUvZIme73iI1X4QhGblh82skmjet2ReO1y88fW7QphdzJIpy
WZvjJ/G1a0v/Ktq3EgbOMyATEZB5TupiAF3mIk3gCEB9lXNshmC9nSuM0kfnbnl+
UWXDxfs9WFoJlijl07ZkU4RslB0pZVg4/6df5NFH08O4GnEgPeMK2CkjCqx1x2Ts
LTivvxuR+GZ0CrVr5S5niS96HHkE31CRc0T96xq7dvbHCSuggTnnJui80RWcs+fQ
9oHL1B+7RYPmImFGBp7iXh1mJfChvsohotZGTZUfG5I9Ew4j8IL1GY0SEJMmCPGu
TNjqx98/XaIeAxKshLm9ev659ku+x+vb/T6tbD16D/v8nuQ+g5urWM7vjKW1pDxk
9Mcy2gYQyrD0mkd5bNzzwTxW5/VccxDi402AVWyE19d0hWMyv2NHhmtLs2Br5l2n
5uFfOqMIoiSk6XdbFq0ykZ6/IIYjRfLf8xoCxw5q4AvG7a7Bf9+VJ2IV3OtokAqP
pzhQTN7e4V0NY7vPP/LAyEWHwxEWY6xMt8Rlys4+OtYgYOjYt4k=
=tUTR
-----END PGP SIGNATURE-----

--tyul24fgxwrwyztr--
