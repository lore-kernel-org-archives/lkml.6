Return-Path: <SRS0=7f4r=L6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.6 required=3.0 tests=DATE_IN_PAST_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A973ECE563
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Sep 2018 20:03:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBD072087E
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Sep 2018 20:03:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CBD072087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=collabora.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728562AbeIQB0m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Sep 2018 21:26:42 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:47036 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728533AbeIQB0l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Sep 2018 21:26:41 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 7961127DAE5
Received: by earth.universe (Postfix, from userid 1000)
        id 370903C0C47; Sun, 16 Sep 2018 13:21:47 +0200 (CEST)
Date:   Sun, 16 Sep 2018 13:21:47 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, Pavel Machek <pavel@ucw.cz>
Subject: Re: Cont: power_supply: Introduce power supply charging driver
Message-ID: <20180916112147.qvhysnlcpt6m5nca@earth.universe>
References: <8aa19d71c6d4114249a3a49b21dc3a6595494faa.camel@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="6x4sp5uikka7zwfk"
Content-Disposition: inline
In-Reply-To: <8aa19d71c6d4114249a3a49b21dc3a6595494faa.camel@linux.intel.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--6x4sp5uikka7zwfk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Andy,

On Sun, Jul 29, 2018 at 06:30:03PM +0300, Andy Shevchenko wrote:
> It has been a while. I didn't get from archives what happened to the
> patch series [1]? Is it still actual to apply?
>=20
> [1]: https://lwn.net/Articles/608527/

Sorry for my late reply. The discussion died off at some point if
I remember correctly. Proper support in the power-supply framework
to have a charger state machine is still missing.

-- Sebastian

--6x4sp5uikka7zwfk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAluePMsACgkQ2O7X88g7
+pppZRAAo7eKDrHkeblWpzv35R22oaI3hrksGma6B3DDpO7l+DKFWS1IVnS4+174
PzBEIS5JncXJEknBf9unq3xoT59qkr++H0I2IkICr8MrxDXUPl1U2F2TEA4tqmhV
xOiTtHBGZn63bZ086vu7nGegWeiKBbkL4pPw6ULqGh0X9O8UkUl1NHrC73HJdGD4
fmHmWz2gDq2Qf4WuXy68m7feA7gtBuCCPxeL0uG7jQEhLR95VAXVLuXJTluHeM+H
RfzJ4kxdWKnTd3rpvB2B2rTedM0/q4CRMtZxpOgmcZNFzUke2AYuEL+QB2yKLHG9
eC6k9ockMo7XJ7sK/OxK7GxYm9A+x66//eCMUTP6+ePEbL82DmDU9vXSMl2K/NG+
oe796ZaFS/Ro3PFt75VGd27DNVJTQwxa+3ZqgXcx6IjhKdOtXPCdGQKdx040IRj2
qNzRm8XKixifPZTrf9bZ+kyMFilSUIqQWhCbxSUiFnYkQAOUxZQ+yGNVrM7L5okb
MKL3ibWDaDFlQiD4M7F8pk3IW5tp2/PQD4pyQV76Obn3EBDn5nMMnJYs57DDWD0e
cAVaNh6lUVkItH9y0EdWQnblJ+Dw0gBUWb7jOIewotu18WgX22sXf3jCljVEpOdU
ZfqYE+QGc/ozbFDNie3YIw59EqqzT3VY3/vn6EzY2p/0Jkh74Xw=
=QpYc
-----END PGP SIGNATURE-----

--6x4sp5uikka7zwfk--
