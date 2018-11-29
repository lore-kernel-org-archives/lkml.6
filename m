Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 453B3C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 01:53:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1367D206B6
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 01:53:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1367D206B6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727573AbeK2M45 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 07:56:57 -0500
Received: from shelob.surriel.com ([96.67.55.147]:49622 "EHLO
        shelob.surriel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726949AbeK2M45 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 07:56:57 -0500
Received: from imladris.surriel.com ([96.67.55.152])
        by shelob.surriel.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.91)
        (envelope-from <riel@shelob.surriel.com>)
        id 1gSBW0-0008TG-Qh; Wed, 28 Nov 2018 20:53:16 -0500
Message-ID: <0ed0e6fc3d2a78592f3fdab7a454b21d43284f95.camel@surriel.com>
Subject: Re: [PATCH 03/29] x86/entry: Remove _TIF_ALLWORK_MASK
From:   Rik van Riel <riel@surriel.com>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, Andy Lutomirski <luto@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?UTF-8?Q?Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        kvm@vger.kernel.org, "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Borislav Petkov <bp@suse.de>
Date:   Wed, 28 Nov 2018 20:53:16 -0500
In-Reply-To: <20181128222035.2996-4-bigeasy@linutronix.de>
References: <20181128222035.2996-1-bigeasy@linutronix.de>
         <20181128222035.2996-4-bigeasy@linutronix.de>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-jqh7yr3QG9jYuuiY8dSA"
X-Mailer: Evolution 3.28.5 (3.28.5-1.fc28) 
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-jqh7yr3QG9jYuuiY8dSA
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2018-11-28 at 23:20 +0100, Sebastian Andrzej Siewior wrote:
> There is no user of _TIF_ALLWORK_MASK since commit 21d375b6b34ff
> ("x86/entry/64: Remove the SYSCALL64 fast path").
> Remove unused define _TIF_ALLWORK_MASK.
>=20
> Reviewed-by: Borislav Petkov <bp@suse.de>
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Reviewed-by: Rik van Riel <riel@surriel.com>

--=20
All Rights Reversed.

--=-jqh7yr3QG9jYuuiY8dSA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEKR73pCCtJ5Xj3yADznnekoTE3oMFAlv/RowACgkQznnekoTE
3oO6fQf/WfpRwW8XEUW7YKC+1DkrONbnhAdArxszZcsWdNIMb+r1f3D7Y6aRKfvQ
zV9QAD8nlCVaOD67fuD60duxGgv6rHIBhegYfF3Jb0rt9A9kyXT92LhYk1/M0SRC
/8BmYGOSulnof/8C42Q/gvhtDt1sMxPVHA7u016YZFFa1PZn0afjjzGQjmMVdy2A
lFxYeTQYmCXDOES2Fak+o/N5aQA/Chl6s4NF3CYz+m7Ew02yEfVaCZ+llapNoFBs
8NrA4vPVWbq5E4GWkuDpIUAue3bpFHllyvjNkSEnB/ZakLjAamsPGNpolmlSliMB
LEoFth6+I60Uj5+BcCR/tqWORz9LEA==
=0e7W
-----END PGP SIGNATURE-----

--=-jqh7yr3QG9jYuuiY8dSA--

