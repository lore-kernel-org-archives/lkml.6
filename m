Return-Path: <SRS0=ZAeg=KF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0788ECDE5F
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 23:01:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DF4C20858
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 23:01:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4DF4C20858
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=the-dreams.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728429AbeGUXxe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Jul 2018 19:53:34 -0400
Received: from www.zeus03.de ([194.117.254.33]:46636 "EHLO mail.zeus03.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728175AbeGUXxe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Jul 2018 19:53:34 -0400
Received: (qmail 6970 invoked from network); 22 Jul 2018 00:59:06 +0200
Received: by mail.zeus03.de with ESMTPSA (ECDHE-RSA-AES256-GCM-SHA384 encrypted, authenticated); 22 Jul 2018 00:59:06 +0200
X-UD-Smtp-Session: l3s3148p1@fpMDXIpxlq4gAwDPW+PTAAId4P/+oMhl
Date:   Sun, 22 Jul 2018 00:59:06 +0200
From:   Wolfram Sang <wsa@the-dreams.de>
To:     Boris Brezillon <boris.brezillon@bootlin.com>
Cc:     Vitor soares <Vitor.Soares@synopsys.com>,
        linux-i2c@vger.kernel.org, corbet@lwn.net,
        linux-doc@vger.kernel.org, gregkh@linuxfoundation.org,
        arnd@arndb.de, psroka@cadence.com, agolec@cadence.com,
        adouglas@cadence.com, bfolta@cadence.com, dkos@cadence.com,
        alicja@cadence.com, cwronka@cadence.com, sureshp@cadence.com,
        rafalc@cadence.com, thomas.petazzoni@bootlin.com, nm@ti.com,
        robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com,
        ijc+devicetree@hellion.org.uk, galak@codeaurora.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        geert@linux-m68k.org, linus.walleij@linaro.org,
        Xiang.Lin@synaptics.com, linux-gpio@vger.kernel.org,
        nsekhar@ti.com, pgaj@cadence.com, peda@axentia.se,
        Joao.Pinto@synopsys.com
Subject: Re: [PATCH 0/3] Add driver for Synopsys DesignWare I3C master IP
Message-ID: <20180721225906.krcmed35ylnspl2h@katana>
References: <1532120272-17157-1-git-send-email-soares@synopsys.com>
 <20180720215801.dmklhwxsgakj4exd@ninjato>
 <20180721191515.6b20d23b@bbrezillon>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="yhk2v2hz3qojdbpu"
Content-Disposition: inline
In-Reply-To: <20180721191515.6b20d23b@bbrezillon>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--yhk2v2hz3qojdbpu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Boris,

> I was waiting for the I3C framework to be merged before creating the ML
> and the git repo, but if you think we should do that now I can create
> them.

I'd think so. It will already be beneficial to have a central discussing
point and a location to pull stuff from.

Thanks,

   Wolfram

--yhk2v2hz3qojdbpu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAltTurUACgkQFA3kzBSg
KbZBURAAn8RzMrsBu9CGwSgFBGUBDK17R0eEpYdGwUDDCrMDGp2uWsiLXHtQK+IU
aC4VrjT3QVq2iHj143dC3LVGHccFemZp8KymZLNEhjrsiEfpmeukLvoUYIHfdDFv
41C8d9B0RHvBuxLWMlj8qRfOhHU0dxNKUeejl5L9lgbziZKAj6ynNzguH7V1noJX
fJ2eOW4IxobwA1bDieZn2fIgDJ30+SCFI+KLlKOpzr5KnArA2PFjRIQEIaYxQovC
n3rpOVcR67/wDpB9pniHW6t1Rdy019J1h8/fxAH1uUwBvoNraC5LgDmMBefrypgx
lE1g4K9HUf942sreZJdgcOZcRyg0TPBHym/OTojOvPSvDGDOE65KjXNK82WyIab3
syjsKSMCQYfzkLYYSsnk0rywAiuGZbR7aQs8Wduonj0iAjSCwzAdJ/S7IuHdaKdL
6/pLw5WoS+jgMfsC1Xi8zYo2NfWqdGthGvR9PzmXA+fcmYjvct74YRqchMaY1vCB
gF1ZcSNa8aK+l80HqyXWcLsKN98BukGmSynJKAC0pmuJHf2ZFTOd+Q6flFdvd+Zs
qs7htijB3B0h6yyGIsAXfp8QeXf6F7NZXuh9jB4gZh7w1vvsD3Ikfdl4/Nubo0Ze
f3tCjI8XjppYySAZfF2TtIeqtO/2GwC0t8ffzgiNWgbrqczES48=
=K2aK
-----END PGP SIGNATURE-----

--yhk2v2hz3qojdbpu--
