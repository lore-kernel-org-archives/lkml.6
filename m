Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFD40C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 01:52:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E599206B6
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 01:52:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E599206B6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727531AbeK2M4a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 07:56:30 -0500
Received: from shelob.surriel.com ([96.67.55.147]:49612 "EHLO
        shelob.surriel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727022AbeK2M43 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 07:56:29 -0500
Received: from imladris.surriel.com ([96.67.55.152])
        by shelob.surriel.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.91)
        (envelope-from <riel@shelob.surriel.com>)
        id 1gSBVa-0008Se-6C; Wed, 28 Nov 2018 20:52:50 -0500
Message-ID: <272363031cecc6641ccaaf3fc7cc1dd9dc749b9f.camel@surriel.com>
Subject: Re: [PATCH 02/29] x86/entry/32: Remove asm/math_emu.h include
From:   Rik van Riel <riel@surriel.com>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, Andy Lutomirski <luto@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?UTF-8?Q?Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        kvm@vger.kernel.org, "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Dave Hansen <dave.hansen@linux.intel.com>
Date:   Wed, 28 Nov 2018 20:52:50 -0500
In-Reply-To: <20181128222035.2996-3-bigeasy@linutronix.de>
References: <20181128222035.2996-1-bigeasy@linutronix.de>
         <20181128222035.2996-3-bigeasy@linutronix.de>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-ULI3fVaZ3PXAivI0K2zE"
X-Mailer: Evolution 3.28.5 (3.28.5-1.fc28) 
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-ULI3fVaZ3PXAivI0K2zE
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2018-11-28 at 23:20 +0100, Sebastian Andrzej Siewior wrote:
> The math_emu.h header files contains the definition of struct
> math_emu_info. It is not used in this file.
>=20
> Remove asm/math_emu.h include.
>=20
> Reviewed-by: Andy Lutomirski <luto@kernel.org>
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Reviewed-by: Rik van Riel <riel@surriel.com>

--=20
All Rights Reversed.

--=-ULI3fVaZ3PXAivI0K2zE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEKR73pCCtJ5Xj3yADznnekoTE3oMFAlv/RnIACgkQznnekoTE
3oOHlAgAsNEbn8+igOGYmllpdslwKqe7W2JVJ3nMOJpReTTtcuqjfo9GJ05ZhX/5
MJ/Bj9zYneTvcyo8ZXALPbZBrQRcQmyDUq4Wk5Gb+Z/4M9f2wsCTMPsjuF/eaRTV
OzBMtDp7SMrFGo1utWCEe5onYMAy/bFYNEf2IYhEPE2SqwoY0UgCC4OWmJG5SUec
Ym9/xagMjdJOSzz9HInCrWQq3hcJBCBbh7Fqddzl2xXZBLoo8NaZbyZO28yLvSCA
cClpp8wq22A12POOfpcby9G3atga8C2TM4nU7+dj6rqmCftsgwzyxo3FR3rG5fBJ
/h11TRt/pmFVA8Ol0M3cxtDHrDRBrQ==
=MIUF
-----END PGP SIGNATURE-----

--=-ULI3fVaZ3PXAivI0K2zE--

