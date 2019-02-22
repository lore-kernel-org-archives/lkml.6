Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2E24C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 23:16:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9211C2070D
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 23:16:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727302AbfBVXQe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 18:16:34 -0500
Received: from sauhun.de ([88.99.104.3]:49766 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725774AbfBVXQd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 18:16:33 -0500
Received: from localhost (pD95EF730.dip0.t-ipconnect.de [217.94.247.48])
        by pokefinder.org (Postfix) with ESMTPSA id 2EFE13E4AA3;
        Sat, 23 Feb 2019 00:16:32 +0100 (CET)
Date:   Sat, 23 Feb 2019 00:16:31 +0100
From:   Wolfram Sang <wsa@the-dreams.de>
To:     Jim Broadus <jbroadus@gmail.com>
Cc:     Charles Keepax <ckeepax@opensource.cirrus.com>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Linux I2C <linux-i2c@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] i2c: Allow recovery of the initial IRQ by an I2C client
 device.
Message-ID: <20190222231631.GA964@kunai>
References: <CAKgEEwsOHqV-PtJnc-5nXAuH3BVitXWt80eoENJa3wZ6vGZDpw@mail.gmail.com>
 <20190219193027.13882-1-jbroadus@gmail.com>
 <20190221232609.d4vxl3osj6mwooey@katana>
 <CAO-hwJ+4-sxwbdpzjTKyZ10SBv743JUF0sTFPJ4YRXURuR_CNQ@mail.gmail.com>
 <20190222102335.GA1771@kunai>
 <20190222103019.GD130153@ediswmail.ad.cirrus.com>
 <20190222113159.GB1771@kunai>
 <CAKgEEwt6ciUA27+c-v0qjwkGN3gdF95DF9msh4yQVArCCQ+irA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="x+6KMIRAuhnl3hBn"
Content-Disposition: inline
In-Reply-To: <CAKgEEwt6ciUA27+c-v0qjwkGN3gdF95DF9msh4yQVArCCQ+irA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--x+6KMIRAuhnl3hBn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

> I'm also more familiar with device-tree (just came across this on my personal
> laptop) but happy to review and test at the risk of learning something.

:) Thanks!


--x+6KMIRAuhnl3hBn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlxwgsoACgkQFA3kzBSg
KbZWIw//bLuc3UE2tTT73xv6LhwWQWxZtL1y34bk7ICAoiT/iHkkJ33ELPMz/ETV
WAxXgBv0UgxwT3aYXH/QP8vngYqVXwNdYCBY72AeyWvMGw7hO8vrSEqLMmjP3/8v
EoJgcHrg8IenQS/NH/g45T7BjUVyFEtZQrPzJQnwqzvc6xPdcoOiRujZ9grLXW6l
7SB3qMzTLkkSb1DDqAVXKakQVdsK9rsCqG0l0Vj1Wr+k8OTD/k/674eNbkS8Q1Et
0thVx7ki3S16BGnYxrA3gYn2U6ZRoO8tahRmKYPCDcMSMNFmcD0XkpBxiv3RCax3
6NuCbXHjrrDxTt8wKEScFUfe9uUeq/aAwTxb4Wh0dJVkBhEPlbHnbBUBecxV/qaq
x5F9q72zfOb6i+jRAjsdgHJwdmJkPICErJe3yHVeJyUECV/0gnPt25R3fCnENGCD
sRVIgKiTTX5t5be5Lox6HiG1YI9MFnUkKG4OEQIKJncEdJ2uGm1m8G47+V/3pdOW
UjcN6Qhy2w+g/0V5oDisBXye65oNfFUvLnMEeZdj8d/qI+LZNOKNsX2sCllp8iQC
B2ZwrgMeJr60sb7twi7ze2gMSGtq7kVJgAgz5wJx1apS0124VhXmqSKgoKRi8la3
Ne1SQAtu0qJBM3jmw8T7RVnbrtMb1fkEB8KPXXenUwmhNZmtBkw=
=Nypg
-----END PGP SIGNATURE-----

--x+6KMIRAuhnl3hBn--
