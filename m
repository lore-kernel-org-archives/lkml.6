Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F272DC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 02:00:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6249206B6
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 02:00:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6249206B6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727293AbeK2NDm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 08:03:42 -0500
Received: from shelob.surriel.com ([96.67.55.147]:49688 "EHLO
        shelob.surriel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726872AbeK2NDm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 08:03:42 -0500
Received: from imladris.surriel.com ([96.67.55.152])
        by shelob.surriel.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.91)
        (envelope-from <riel@shelob.surriel.com>)
        id 1gSBcX-000050-FD; Wed, 28 Nov 2018 21:00:01 -0500
Message-ID: <da61c2af8aab3348d6fb09889b5531bec7e2f842.camel@surriel.com>
Subject: Re: [PATCH 07/29] x86/fpu: don't export __kernel_fpu_{begin|end}()
From:   Rik van Riel <riel@surriel.com>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, Andy Lutomirski <luto@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?UTF-8?Q?Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        kvm@vger.kernel.org, "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Dave Hansen <dave.hansen@linux.intel.com>
Date:   Wed, 28 Nov 2018 21:00:01 -0500
In-Reply-To: <20181128222035.2996-8-bigeasy@linutronix.de>
References: <20181128222035.2996-1-bigeasy@linutronix.de>
         <20181128222035.2996-8-bigeasy@linutronix.de>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-s2m3wSeK6PdhtvqZM987"
X-Mailer: Evolution 3.28.5 (3.28.5-1.fc28) 
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-s2m3wSeK6PdhtvqZM987
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2018-11-28 at 23:20 +0100, Sebastian Andrzej Siewior wrote:
>=20
> + * Use kernel_fpu_begin/end() if you intend to use FPU in kernel
> context. It
> + * disables preemption so be carefull if you intend to use it for
> long periods

Just how careful do you want to be?

One l seems sufficient :)

Feel free to add my Reviewed-by: once that spelling
error is fixed :)

--=20
All Rights Reversed.

--=-s2m3wSeK6PdhtvqZM987
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEKR73pCCtJ5Xj3yADznnekoTE3oMFAlv/SCEACgkQznnekoTE
3oMUpgf9GO/LgXy7rjMkgUDVPMTGd/P/BciGgift1JQSHMqd2ipIFf61MadF0HMA
o7FgO4M/AQ+FVkNjEhOpTJxH7bFRmfpBzQkGHN9PdWMu0VPxUYn8pNQKYcT286Iv
XJONHrvhihaROzxgYf3OTQhcDQ+O8Sojz4YA9RH0fkU9bxqMQBMKVEL9ecN90qI+
lpH3ER51fd5v+2Y4aKXeMgBVFXTdiT/OOWygVX2/OLtopQ+lVBLwV5/+vCwbPHIB
WhXtD0Rn8U/KtxtuffKoloun1L6uR8MqBGDLd1JG0S8EgA1JSl+hMT1DTUk83xJJ
Ijb+s5Bacd26020ZALTMA2azO2Ay+Q==
=13J8
-----END PGP SIGNATURE-----

--=-s2m3wSeK6PdhtvqZM987--

