Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADBEDECDFB0
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 21:56:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74343208E3
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 21:56:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74343208E3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=the-dreams.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732408AbeGLWH6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 18:07:58 -0400
Received: from sauhun.de ([88.99.104.3]:60186 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726730AbeGLWH5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 18:07:57 -0400
Received: from localhost (p5486CFAA.dip0.t-ipconnect.de [84.134.207.170])
        by pokefinder.org (Postfix) with ESMTPSA id AED7D5747EC;
        Thu, 12 Jul 2018 23:56:25 +0200 (CEST)
Date:   Thu, 12 Jul 2018 23:56:24 +0200
From:   Wolfram Sang <wsa@the-dreams.de>
To:     Juergen Fitschen <me@jue.yt>, linux-i2c@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [v2,3/3] i2c: at91: added slave mode support
Message-ID: <20180712215624.qtdm3au6os4iobqo@ninjato>
References: <c9b749fca8e684aa47ead9a5d9e68751326f63cb.1510247114.git.me@jue.yt>
 <20180602213513.qv45gaq2kogagju3@katana>
 <20180709151504.6phtp4rm7of6b2qc@M43218.corp.atmel.com>
 <20180709155135.bjwhrmbk6j26fx4c@ninjato>
 <20180710084257.ewgnvroow5weffvf@M43218.corp.atmel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="6dxfcu6jjtvnquoj"
Content-Disposition: inline
In-Reply-To: <20180710084257.ewgnvroow5weffvf@M43218.corp.atmel.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--6dxfcu6jjtvnquoj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> Yes sure, you can add my Ack. I would be pleased to see the slave
> support taken.

Sadly, I can't get it to apply cleanly. Could you rebase and retest?


--6dxfcu6jjtvnquoj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAltHzogACgkQFA3kzBSg
KbbwjxAAiYX3APiOh7uOg3bb2MEgY3/r+AVSSAcUuDcoxU61OqW/fqsi7Gpf7SHZ
YCLJe3NkFgd2omsN02dxj6u4dXFD5gEpHresOwQIXs91YLpaPZX8tqU4rsb7LXwm
/HHue07gyeti07CJJbO4dKkmcS6iw1XVweP3wJg2rwoXTLEUUkNwkC4ACEyNvnYv
mXw519DhDJMB2iPuTf9v0/N2RB1IJXcPExd6Z7UCzPaUVTqhN64neHikuykh5iQZ
PUJpwacxAQI24NvgTXKEUWxQpSrSMt4f80h68kDTfbJxModJz5MTyv+jRoYCcnF7
UAinqH+tTxH2Qyn8gFYa67HkTsQJMIRtHHm0QZK9SeMjiJEKeO7QANPdH23m+v+C
a/FiSqRjQOxZXQ1zbtXjg/CqHLer2GOBux6yr2b5TNL2lyK364Tm6AmIdWOJJg82
dxO/Knl2/K45ecOqjBpp8yCncra7TiAeMRJGRvf173Gsr28KX+fz7DJa4LWEeSMB
8sGLJsu4lrEmW1AY2/yC9qaEl9XIas7rcqgU/Sw8cwqsAUz19p3J1/BjYtMxS//C
5ii2E4nZbch/ksEyX3Y6+H03rAkoSCYuioTDtEZZFTqXCEG1ggtgrHGjmVrggLLU
EVP2UWimQmQEKLb/GPxVQBeUkYnHg37hfE9NH4QO/wwm7Ajn9rI=
=89O0
-----END PGP SIGNATURE-----

--6dxfcu6jjtvnquoj--
