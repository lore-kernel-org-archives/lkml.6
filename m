Return-Path: <SRS0=4jry=KT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77108C4646D
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 21:27:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F01C217CB
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 21:27:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F01C217CB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=the-dreams.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730209AbeHDX3O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Aug 2018 19:29:14 -0400
Received: from sauhun.de ([88.99.104.3]:59130 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728882AbeHDX3N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Aug 2018 19:29:13 -0400
Received: from localhost (p54B337AD.dip0.t-ipconnect.de [84.179.55.173])
        by pokefinder.org (Postfix) with ESMTPSA id 277EF684EB3;
        Sat,  4 Aug 2018 23:27:12 +0200 (CEST)
Date:   Sat, 4 Aug 2018 23:27:11 +0200
From:   Wolfram Sang <wsa@the-dreams.de>
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     linux-i2c@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 07/12] i2c: stu300: use core to detect 'no zero length'
 quirk
Message-ID: <20180804212711.kdldzxfrawbwdh54@ninjato>
References: <20180723202617.15230-1-wsa+renesas@sang-engineering.com>
 <20180723202617.15230-8-wsa+renesas@sang-engineering.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ki5tidkcxh7bpgtd"
Content-Disposition: inline
In-Reply-To: <20180723202617.15230-8-wsa+renesas@sang-engineering.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ki5tidkcxh7bpgtd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 23, 2018 at 10:26:11PM +0200, Wolfram Sang wrote:
> And don't reimplement in the driver.
>=20
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Applied to for-next, thanks!


--ki5tidkcxh7bpgtd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAltmGi8ACgkQFA3kzBSg
KbZMgg//Zg7VrasoqjzWslUas6Bel1LQdHNOheNgWq0zDiKlNEIXE+2/IhmDem48
5MJqE2f9NDFnaEKnVnAJ0gCe+LoDHVXXtKz8pwPDHnb/eT9BJdAtGZ4Gu4AGm/C1
XAejLzeOqrAft6p5RcuMQwouPPFjbEcP2KuOayqNA2rnmK5cux5W3eu3xr6uTgRv
leN8/2wqdU53ilUutFV+zaKKH796Xxqj7es9oMAfjk+gGBBkikvDr9LR69ZPHj5R
Br4rpF19+P/7Veu9/DL0Swt45syas4drivBauX8uekyv7hteEpEUHqzC7WMXHYhR
eZtCitQy4CsyzT1sqxL77EXNn4M4dbV/fkVNbIwXoYmSbEf//UUuVKL/m+oanLbu
XFBYY/yf7sxCa4f5zcy9h1+XAp/WcnVvXqq70u2m+qXOkdmHyVmWqzi9VbBMDpkF
Bnn8jUh8bkvceSDFnkcWK/PgPhWuLtw7e26vy2MKN6kVwsdvuOmr3ujqrqpOl7ub
78OZufB1iLmh3BvNAYzfWtL/X7/+ntMnEfH/w0CtwyXagQox8NOaR3u+vDxoF+E/
ZenOGagl4dmRY5RLTiqYh6sMF57XX4AgnRLaPvxhVwdYh6412/zVBk/NQ/w63jw0
oYZQ5olrJSgOd+btJYZ7YG3y6S8Ffx0HfKq6Pqslw5unBtKL5e8=
=6eWJ
-----END PGP SIGNATURE-----

--ki5tidkcxh7bpgtd--
