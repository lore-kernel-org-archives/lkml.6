Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66D50C43144
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 04:08:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 205C3243F8
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 04:08:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 205C3243F8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=the-dreams.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752090AbeF1EIp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 00:08:45 -0400
Received: from www.zeus03.de ([194.117.254.33]:60312 "EHLO mail.zeus03.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751855AbeF1EIn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 00:08:43 -0400
Received: (qmail 15353 invoked from network); 28 Jun 2018 06:08:38 +0200
Received: by mail.zeus03.de with ESMTPSA (ECDHE-RSA-AES256-GCM-SHA384 encrypted, authenticated); 28 Jun 2018 06:08:38 +0200
X-UD-Smtp-Session: l3s3148p1@BpDD4qtvLJggAwDPW84CAAId4P/+oMhl
Date:   Thu, 28 Jun 2018 06:08:37 +0200
From:   Wolfram Sang <wsa@the-dreams.de>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Boris Brezillon <boris.brezillon@bootlin.com>,
        linux-i2c@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        linux-doc@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Przemyslaw Sroka <psroka@cadence.com>,
        Arkadiusz Golec <agolec@cadence.com>,
        Alan Douglas <adouglas@cadence.com>,
        Bartosz Folta <bfolta@cadence.com>,
        Damian Kos <dkos@cadence.com>,
        Alicja Jurasik-Urbaniak <alicja@cadence.com>,
        Cyprian Wronka <cwronka@cadence.com>,
        Suresh Punnoose <sureshp@cadence.com>,
        Rafal Ciepiela <rafalc@cadence.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        ext Nishanth Menon <nm@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Pawel Moll <pawel.moll@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Kumar Gala <galak@codeaurora.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Vitor Soares <Vitor.Soares@synopsys.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Xiang Lin <Xiang.Lin@synaptics.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "Nori, Sekhar" <nsekhar@ti.com>, pgaj@cadence.com
Subject: Re: [PATCH v5 09/10] gpio: Add a driver for Cadence I3C GPIO expander
Message-ID: <20180628040837.25fpjubloxo277ag@katana>
References: <20180622104930.32050-1-boris.brezillon@bootlin.com>
 <20180622104930.32050-10-boris.brezillon@bootlin.com>
 <CACRpkdYmR3+urDk6StG7s=W3=oYHB6eqs7ORdMV=-S31QtOAqQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="a3od6fvxi7bwproo"
Content-Disposition: inline
In-Reply-To: <CACRpkdYmR3+urDk6StG7s=W3=oYHB6eqs7ORdMV=-S31QtOAqQ@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--a3od6fvxi7bwproo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> I see there was some heat in this discussion between you
> and Andy, and it seems to be resolved. Which is good
> because you are both senior contributors that I value
> a lot.

+1


--a3od6fvxi7bwproo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAls0X0EACgkQFA3kzBSg
KbZGuQ/+JXDMJCo6XGuicpcQb6G3cvLv/h/jkSJnR61ElmXs4kSOX8DFsszrMy+Y
YUV9Br988qAEvJPsfbcEexjBJ5y2K6A3hpTUMJY0un2s23hJECxN9bV0Il0SPInT
i0WwHnV7fn8aM7qbza/fuYh9N/5CXQRXE1SNJjyj8pVWwHXIayNla8lBaSCnyfgF
myyd0EmEAxaPze7O2r++K326YhZOFSrcVYT5ScqOIMt/EQd1S4xN91Qx9zTWwMAJ
27uES5566WnNJEclmuHQFu5hGAMB2X3k3w9HbHzxUInTHgB7g2IQbuHHTjqV8ogT
qPNXCKFwIJhz6bxYRxo5Lie+Y2a3J9W+Gu6CIIeeZHFgDUfs3svnvSbuog01LZ00
S+ysTxsSqn0PG2kYYJwNMWPueF6/t2IGsqsCpkB/KK6x0pWkv8c3bQsAtYGDC/Uv
JIMHJ2cE1JSrWtdUt/gnGn5yysnpim0mdV3mBlkSrwSm7PFsVjThUeEmML8+L1Fm
Y2VY+zDeJcd639d87ZTp+e8+r9HCqz+41HTC3zE94qXZVX9ZddgcubOm2WTaf6pa
O3TMQUrNzlLhH3eHnyTiW6PraobNIHCvv8HJ1BmOfWCFVPfa18ZtcA5xN93VYGXg
28nCx2jumkugOZ9KVoUABGMNaXhtHHhAAbN9DQs4cX4IuJky4C0=
=buoG
-----END PGP SIGNATURE-----

--a3od6fvxi7bwproo--
