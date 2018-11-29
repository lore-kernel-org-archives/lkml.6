Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBDA4C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 01:53:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 941EB206B6
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 01:53:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 941EB206B6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727592AbeK2M5Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 07:57:24 -0500
Received: from shelob.surriel.com ([96.67.55.147]:49638 "EHLO
        shelob.surriel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726949AbeK2M5Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 07:57:24 -0500
Received: from imladris.surriel.com ([96.67.55.152])
        by shelob.surriel.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.91)
        (envelope-from <riel@shelob.surriel.com>)
        id 1gSBWS-0008Ta-SJ; Wed, 28 Nov 2018 20:53:44 -0500
Message-ID: <271c63187be418b0f9f0ec3b3e4892d95be79cb8.camel@surriel.com>
Subject: Re: [PATCH 04/29] x86/pkeys: Make init_pkru_value static
From:   Rik van Riel <riel@surriel.com>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, Andy Lutomirski <luto@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?UTF-8?Q?Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        kvm@vger.kernel.org, "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Dave Hansen <dave.hansen@linux.intel.com>
Date:   Wed, 28 Nov 2018 20:53:44 -0500
In-Reply-To: <20181128222035.2996-5-bigeasy@linutronix.de>
References: <20181128222035.2996-1-bigeasy@linutronix.de>
         <20181128222035.2996-5-bigeasy@linutronix.de>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-5tJLx9hlcVNhNIdfD93A"
X-Mailer: Evolution 3.28.5 (3.28.5-1.fc28) 
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-5tJLx9hlcVNhNIdfD93A
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2018-11-28 at 23:20 +0100, Sebastian Andrzej Siewior wrote:
> The variable init_pkru_value isn't used outside of this file.
> Make init_pkru_value static.
>=20
> Acked-by: Dave Hansen <dave.hansen@linux.intel.com>
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Reviewed-by: Rik van Riel <riel@surriel.com>

--=20
All Rights Reversed.

--=-5tJLx9hlcVNhNIdfD93A
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEKR73pCCtJ5Xj3yADznnekoTE3oMFAlv/RqgACgkQznnekoTE
3oMS3wf+Nn5ZVlzITlO/BSrs0tlU0vCdO91KhvmBw+JmhnQ2g9retoec0eV9VCJb
gSA9kS47OljB9dUUoKdT6AnGxn3aFf/TzFnOEPpsdO87JFgrfGYnWVudA6//09GS
09Uk+3M3blqoV9DV7CRt91EdT1Qln5Y35i70sEvJ/g0r4fzIKczGnHKKmulyqrwu
Gc2yBqt3Nxz95mLAOe4ohT9TLb8ims1ZDlE2Q7exlzGSvZZJRZAAA5mlamPLxChv
RNK+5UTl5hucXDe/ThhTHPP0OJ5Fzk0Az4FMeAuTnlt2fUs6IIWs9IQH0zAXDsqI
SaFtM3Jesvs6JVMrfLE1TxSYLkVA8w==
=RgUS
-----END PGP SIGNATURE-----

--=-5tJLx9hlcVNhNIdfD93A--

