Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79E42C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 06:35:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F6502156D
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 06:35:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F6502156D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sf-tec.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727175AbeI0Mwf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 08:52:35 -0400
Received: from mail.sf-mail.de ([78.47.74.12]:44873 "EHLO mail.sf-mail.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726698AbeI0Mwe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 08:52:34 -0400
Received: (qmail 22455 invoked from network); 27 Sep 2018 06:35:54 -0000
Received: from dslb-092-076-190-100.092.076.pools.vodafone-ip.de ([::ffff:92.76.190.100]:54444 HELO daneel.sf-tec.de) (auth=eike@sf-mail.de)
        by mail.sf-mail.de (Qsmtpd 0.34dev) with (DHE-RSA-AES256-GCM-SHA384 encrypted) ESMTPSA
        for <leobras.c@gmail.com>; Thu, 27 Sep 2018 08:35:54 +0200
From:   Rolf Eike Beer <eike-kernel@sf-tec.de>
To:     Leonardo =?ISO-8859-1?Q?Br=E1s?= <leobras.c@gmail.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/7] drivers: dio: Avoids building driver if CONFIG_DIO is disabled
Date:   Thu, 27 Sep 2018 08:35:54 +0200
Message-ID: <19230260.Wfr244ejmm@daneel.sf-tec.de>
In-Reply-To: <20180927013956.GA8956@WindFlash>
References: <20180927013956.GA8956@WindFlash>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2874343.h6rZ4p9Wyb"; micalg="pgp-sha1"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart2874343.h6rZ4p9Wyb
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

Am Donnerstag, 27. September 2018, 03:39:56 CEST schrieb Leonardo Br=E1s:
> Avoids building driver if 'make drivers/dio/' is called and
> CONFIG_DIO is disabled.
>=20
> Signed-off-by: Leonardo Br=E1s <leobras.c@gmail.com>
> ---
>  drivers/dio/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/dio/Makefile b/drivers/dio/Makefile
> index ae92d17083f2..f5cffe232448 100644
> --- a/drivers/dio/Makefile
> +++ b/drivers/dio/Makefile
> @@ -2,4 +2,4 @@
>  # Makefile for the linux kernel.
>  #
>=20
> -obj-y :=3D dio.o dio-driver.o dio-sysfs.o
> +obj-$(CONFIG_DIO) :=3D dio.o dio-driver.o dio-sysfs.o
> \ No newline at end of file
  ^^^^^^^^^^^^^^^^^^

One more.

--nextPart2874343.h6rZ4p9Wyb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQSaYVDeqwKa3fTXNeNcpIk+abn8TgUCW6x6SgAKCRBcpIk+abn8
TkahAJwKarDg3CDT4sM9d64jx+MUb/CPwQCeKtSFvnXRT44vpaXJMMJi2lw5G0s=
=iknn
-----END PGP SIGNATURE-----

--nextPart2874343.h6rZ4p9Wyb--



