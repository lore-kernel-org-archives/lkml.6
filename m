Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D453BC169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 11:02:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD5292184E
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 11:02:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729489AbfBFLC4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 06:02:56 -0500
Received: from smtprelay03.ispgateway.de ([80.67.31.30]:39171 "EHLO
        smtprelay03.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729234AbfBFLCz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 06:02:55 -0500
X-Greylist: delayed 5059 seconds by postgrey-1.27 at vger.kernel.org; Wed, 06 Feb 2019 06:02:54 EST
Received: from [85.16.233.76] (helo=localhost)
        by smtprelay03.ispgateway.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <jochen@sprickerhof.de>)
        id 1grJf4-00038V-VQ; Wed, 06 Feb 2019 10:38:31 +0100
Date:   Wed, 6 Feb 2019 10:38:30 +0100
From:   Jochen Sprickerhof <jochen@sprickerhof.de>
To:     Roger Quadros <rogerq@ti.com>
Cc:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Vivek Gautam <gautam.vivek@samsung.com>,
        Andrzej Pietrasiewicz <andrzej.p@samsung.com>,
        Kishon Vijay Abraham I <kishon@ti.com>
Subject: Re: [PATCH] usb: dwc3: Enable GBit Ethernet on Odroid XU4
Message-ID: <20190206093830.GS26157@vis>
References: <20190121140204.GA2360@vis>
 <5C5A9DCB.8040507@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="BN1FuguMf1o6kBCi"
Content-Disposition: inline
In-Reply-To: <5C5A9DCB.8040507@ti.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Df-Sender: NTc3MDAz
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--BN1FuguMf1o6kBCi
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

* Roger Quadros <rogerq@ti.com> [2019-02-06 10:41]:
>Hi,
>
>On 21/01/19 16:02, Jochen Sprickerhof wrote:
[..]
>> I'm not sure why this it only works with the driver compiled into the
>> kernel nor why it needs a hard reset or why it was the line was dropped
>> when the patch was accepted. Would be great to get some feedback of the
>> authors.
>
>When XHCI driver is compiled into the kernel are the relevant PHY drivers
>compiled in as well?

Only CONFIG_USB_PHY=3Dy (I took the config from the=20
linux-image-4.19.0-1-armmp_4.19.13-1_armhf.deb Debian package as a=20
basis where this is the default).

Cheers Jochen

--BN1FuguMf1o6kBCi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEc7KZy9TurdzAF+h6W//cwljmlDMFAlxaqxIACgkQW//cwljm
lDNVOQ/8DtIeJF0w5mjVUE9y0rovtLANGiVn5BO/KbEqz6hyq6tH0a+wOs/F1a1F
K1uW+lzFw/Vlu4mMaUe04RPDfbtkMw3jOdnFiKHxt794m4qaaRWzOFmlRpadXH1E
5+R5inofs5aQnQUErpNyGWq0njfNc0G7PwxuOM9R5QzYgheXEOL/lM6X2AyI//5P
kPLyA4fAuyjD4FW5C8jpTTQjw40stSY4TrHmMCUbJ96mdY6IcCBMKHIqMbSu9UnN
sd/fndWw/mFskOLoVh1ejSGYVggSo9xWm2OFe3NRUo308zyeh3ZM7g08AgPKSOUL
4UMYuxy1xY5oGCOYDAtMWh9voloqkcu99NQYk84UT29R7ITcitoWj5OY8qzDM5wl
QweDex8iht4wtWg2Ky75FoQygnqPBOSHPc2yS9HyKfj/JqVayr2gm1Oi2YmTBWRQ
qqnD9i/SqbB0/jNa1WlDTEsGulEeCiL9q2aoVJYmmc3vNzigxQJNB0Is9mHvDiy5
hW3Paa2mTADFujhOWRTujyi7bvIsRb/s8jp6Yt0yJGy9pipZXvQ3OS43jjwv64Ll
IjfsfhxGszHc1UxJURuLIIz6szhjE+zu8n44LBHffRRNFDeEP9/nwrUoZc8bZHtK
Vy704fm+Ed5hIqHet4nuLV/DQVisixj68RhwoP1SmDrbDhsxFi0=
=glJf
-----END PGP SIGNATURE-----

--BN1FuguMf1o6kBCi--
