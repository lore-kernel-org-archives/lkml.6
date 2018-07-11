Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0CFDC5CFEB
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 07:34:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A01642086B
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 07:34:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A01642086B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=the-dreams.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726441AbeGKHhL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 03:37:11 -0400
Received: from sauhun.de ([88.99.104.3]:48956 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725808AbeGKHhL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 03:37:11 -0400
Received: from localhost (p54B3362F.dip0.t-ipconnect.de [84.179.54.47])
        by pokefinder.org (Postfix) with ESMTPSA id 0DE3956A487;
        Wed, 11 Jul 2018 09:34:15 +0200 (CEST)
Date:   Wed, 11 Jul 2018 09:34:14 +0200
From:   Wolfram Sang <wsa@the-dreams.de>
To:     Joel Stanley <joel@jms.id.au>
Cc:     Eddie James <eajames@linux.vnet.ibm.com>,
        linux-i2c@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Peter Rosin <peda@axentia.se>
Subject: Re: [PATCH v11 5/8] i2c: fsi: Add transfer implementation
Message-ID: <20180711073414.r27x3qgn3tmpnuic@ninjato>
References: <1530816030-13010-1-git-send-email-eajames@linux.vnet.ibm.com>
 <1530816030-13010-6-git-send-email-eajames@linux.vnet.ibm.com>
 <20180709224114.4h47enyt4tucqcou@ninjato>
 <d7128886-148f-d255-fb33-3727cad01569@linux.vnet.ibm.com>
 <20180710185042.x3slnms5wzocobqu@ninjato>
 <cda1b231-eeff-626d-5c79-a07c9bc5a9ec@linux.vnet.ibm.com>
 <20180710193944.34phe4zafzvwjm5v@ninjato>
 <479b3c82-ffe7-9e6a-569c-64fcb1b43d32@linux.vnet.ibm.com>
 <CACPK8Xf7mCuksfgH4jfxcgbT2h0-WH236=pWchzbucrrVsLF3A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="xx7t7u7eyooak2jg"
Content-Disposition: inline
In-Reply-To: <CACPK8Xf7mCuksfgH4jfxcgbT2h0-WH236=pWchzbucrrVsLF3A@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--xx7t7u7eyooak2jg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Joel,

> >> An EEPROM ist at 0x50 in Linux. There is no write addr 0xa0 and read
> >> addr 0xa1.
> >
> > OK, I understand! Will test and resend with conforming addressing. Than=
ks
> > for all the feedback!
>=20
> Nice one Wolfram. I wondered why the standard tools didn't work, but
> hadn't gotten around to working out what was going on.

Still, a report that the standard tools don't work with the driver would
have been very helpful already. We can then work together what is the
reason. Please do next time.

> Thanks for taking a close look.

You are welcome.

Kind regards,

   Wolfram


--xx7t7u7eyooak2jg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAltFsvIACgkQFA3kzBSg
KbZXcg//XMNWYGtX/B4mjcFNEFQPpjIBU2a3ihkxZHAF56GDZ86x2CQtLVW1cg87
FkMKMqMewP4dR7qrc9CmuRBCJrJ8g6evQuYjiC0FQU5rRGXoN8BCty5IazEoG3V1
AV/9s9B2JCgSapPFVvyU5G3BYvKwf2RLECHEsh3StDHyDe9HzOEGHSbEYBQXedXE
UPFBYSC+EAdrpvMA6QRX9Qa7nbh7Mj4UbibBByQ1JmvXG1TupOmaLmFzvGxyshn1
GwShilQFg2bGBoESFe9GoY60qbC8N0ixW37LGqmPFybonOqlZasQtyxikHarVEsy
9IFevIe8Nt3Jrzcdu3J4Bl8Ozz0+s//bwNPxBRWOyhoucQ0dNQhFPWujsID2Y7RK
MGIDRYjKmKfEhaDzksxsu+HZf7lz35Zvk7zC282grh2lXAL+24vYXoquqJNz4Wjs
uTnbdwg0Hm1y/21DjfwvsARkQlVUzl6oTcjwxfb8idrYbp8DTmS7mxZM6BlMYZRK
AkGdza0hISWNupvGIx1HmP0t+P9OGHYYXAk/LHYS450wjSQAjgt2ryIf8S4m9D7B
vToczy7jPyEqPyAqfj23B9/hm14NPRojVgPIzAQqkjgJAkPXHSgxwo44AUIQl0sS
EIJuYZVaFw38tjzYYiyXWvfj96cEFIeDtODAjpdgud5kWZf7YW4=
=hVNR
-----END PGP SIGNATURE-----

--xx7t7u7eyooak2jg--
