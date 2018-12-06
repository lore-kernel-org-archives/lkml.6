Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5604FC64EB1
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 22:06:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2118F214DA
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 22:06:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2118F214DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=the-dreams.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726160AbeLFWGN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 17:06:13 -0500
Received: from sauhun.de ([88.99.104.3]:59530 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725948AbeLFWGN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 17:06:13 -0500
Received: from localhost (p54B332AE.dip0.t-ipconnect.de [84.179.50.174])
        by pokefinder.org (Postfix) with ESMTPSA id 49E8E3E409B;
        Thu,  6 Dec 2018 23:06:10 +0100 (CET)
Date:   Thu, 6 Dec 2018 23:06:09 +0100
From:   Wolfram Sang <wsa@the-dreams.de>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/4] UniPhier I2C fixes
Message-ID: <20181206220609.GA1100@kunai>
References: <1544068528-27657-1-git-send-email-yamada.masahiro@socionext.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ReaqsoxgOBHFXBhH"
Content-Disposition: inline
In-Reply-To: <1544068528-27657-1-git-send-email-yamada.masahiro@socionext.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ReaqsoxgOBHFXBhH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 06, 2018 at 12:55:24PM +0900, Masahiro Yamada wrote:
>=20
> Masahiro Yamada (4):
>   i2c: uniphier-f: fix timeout error after reading 8 bytes
>   i2c: uniphier-f: fill TX-FIFO only in IRQ handler for repeated START
>   i2c: uniphier: fix violation of tLOW requirement for Fast-mode
>   i2c: uniphier-f: fix violation of tLOW requirement for Fast-mode

They all look like bugfixes to me, so applied to for-current, thanks!


--ReaqsoxgOBHFXBhH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlwJnUwACgkQFA3kzBSg
KbbVWg//SKoF8iqLVzVaLHhyaqytaaee2i2wicaihztkC0smv+LNc63fzMf4ozL3
AyqCa/1NKy2qfBW9bXl7Dd6T4RpXZmQAPQ67vVlk74Dn6S89pk1lZztG61/m+HsB
dBlzXxPoF87/cPbq9aU9GLEvsSJcy57h7Z03m24rtemdKDcNFEaxkZy26i5+Ccku
kdFVQm70SUyQyg6ScQLX9bl/X8JDOvhpv/xI49iTXYvdK+Xeu+dAgGNcjkUhMDYQ
ynLdb3F/XNfNmqXjgsABe3A0cYwuBqstqKBSUzWax/66rgSOFv2cUO7cI04bPg9C
5gNbaeoOGE8FGvaxptO+VmasGcF08rhw+KRoMKxEoag3vNdFTOtUf13UwbmVxGHi
0b+02hUbXEBSVSDVT0vrmeIFA3906R4gmyyNsTYMhlt4BM8r/w1cSsXAEAhuHrc8
hdNeyA58t8Fj3Si2/aoNd6rpKEKQbCsPtlIXaFbmmC3CedP4M565oGsIt2rL7jZ3
IU9W/6Mqe274W6ztifoaccJIn13x19Z04EUS5PrLWh++bnL4QOksQu/vEw+ZNl6+
6Tv4JKmLziiajhbAxGL2jfd9Hu8n457VSFu3esz1hO1qS5ZI3ucquQ8zOsCWyOrG
zYteCM5Oyx8ECP/m2uQikinXpBNYA8Ci4n5MGTzjYJnHmQuwXpE=
=MQIn
-----END PGP SIGNATURE-----

--ReaqsoxgOBHFXBhH--
