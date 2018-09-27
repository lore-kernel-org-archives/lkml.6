Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B98D3C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 06:34:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B5B72156D
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 06:34:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B5B72156D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sf-tec.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727142AbeI0Mve (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 08:51:34 -0400
Received: from mail.sf-mail.de ([78.47.74.12]:57985 "EHLO mail.sf-mail.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726669AbeI0Mve (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 08:51:34 -0400
Received: (qmail 22394 invoked from network); 27 Sep 2018 06:34:54 -0000
Received: from dslb-092-076-190-100.092.076.pools.vodafone-ip.de ([::ffff:92.76.190.100]:54432 HELO daneel.sf-tec.de) (auth=eike@sf-mail.de)
        by mail.sf-mail.de (Qsmtpd 0.34dev) with (DHE-RSA-AES256-GCM-SHA384 encrypted) ESMTPSA
        for <leobras.c@gmail.com>; Thu, 27 Sep 2018 08:34:54 +0200
From:   Rolf Eike Beer <eike-kernel@sf-tec.de>
To:     Leonardo =?ISO-8859-1?Q?Br=E1s?= <leobras.c@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 6/7] drivers: oprofile: Avoids building driver from direct make command
Date:   Thu, 27 Sep 2018 08:34:47 +0200
Message-ID: <5236278.7dVKUIXYaR@daneel.sf-tec.de>
In-Reply-To: <20180927014138.GA8988@WindFlash>
References: <20180927014138.GA8988@WindFlash>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart12115357.1jVS6xkInD"; micalg="pgp-sha1"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart12115357.1jVS6xkInD
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

Am Donnerstag, 27. September 2018, 03:41:38 CEST schrieb Leonardo Br=E1s:
> Creates new Makefile to avoid building driver if
> 'make drivers/oprofile/' is called directly.
>=20
> This driver is usually built from arch/$ARCH and seems to have
> no meaning building alone.
>=20
> Signed-off-by: Leonardo Br=E1s <leobras.c@gmail.com>
> ---
>  drivers/oprofile/Makefile | 2 ++
>  1 file changed, 2 insertions(+)
>  create mode 100644 drivers/oprofile/Makefile
>=20
> diff --git a/drivers/oprofile/Makefile b/drivers/oprofile/Makefile
> new file mode 100644
> index 000000000000..acaed2ad6eee
> --- /dev/null
> +++ b/drivers/oprofile/Makefile
> @@ -0,0 +1,2 @@
> +#Does nothing, since the source is called from arch/$ARCH/ tree.
> +

Now there is a blank line where it does not need to be.

Eike

--nextPart12115357.1jVS6xkInD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQSaYVDeqwKa3fTXNeNcpIk+abn8TgUCW6x6BwAKCRBcpIk+abn8
Tvl7AKCFkZepc2zqW4LzYndekkBzHyhugACdEVf+VOoOZe6h52weydIXrk8pdfg=
=hiYj
-----END PGP SIGNATURE-----

--nextPart12115357.1jVS6xkInD--



