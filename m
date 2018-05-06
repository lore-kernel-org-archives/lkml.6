Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751256AbeEFE0X (ORCPT <rfc822;w@1wt.eu>);
        Sun, 6 May 2018 00:26:23 -0400
Received: from mail-pf0-f182.google.com ([209.85.192.182]:38561 "EHLO
        mail-pf0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750824AbeEFE0T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 May 2018 00:26:19 -0400
X-Google-Smtp-Source: AB8JxZqa9pOZtoJ44m388kp6HfO/L+BkAT4GtN9jFuQE0XPDtXQEZPfZCHuggWK3jrxXQ41AjlyTmg==
Date: Sat, 5 May 2018 18:26:15 -1000
From: Joey Pabalinas <joeypabalinas@gmail.com>
To: Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>
Cc: Joey Pabalinas <joeypabalinas@gmail.com>, x86@kernel.org,
        Ingo Molnar <mingo@redhat.com>, Thomas Gleixner <tglx@linutronix.de>,
        "H. Peter Anvin" <hpa@zytor.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/kvm: replace TASK_UNINTERRUPTIBLE with TASK_KILLABLE
Message-ID: <20180506042615.fflhefdcyhovkntt@gmail.com>
References: <20180316105729.ykomeftdvlzqm4p6@gmail.com>
 <20180329214116.GO26753@flask>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="xb75uyorqradflzk"
Content-Disposition: inline
In-Reply-To: <20180329214116.GO26753@flask>
User-Agent: NeoMutt/20180323-62-378db9
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--xb75uyorqradflzk
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 29, 2018 at 11:41:20PM +0200, Radim Kr=C4=8Dm=C3=A1=C5=99 wrote:
> I remember we had a bug where tasks were getting stuck when running
> nested and maybe there are going to be other cases to excuse the change.
> I'm slightly against changing the behavior as it's pretty hard to test,
> but I can be easily convinced with a well reasoned patch,
>=20
> thanks!

Yes, that was quite a thorough explanation, thank you for that :). Took
me a while to read through all of your reply as well as look through the
accompanying code. I can definitely see that, yeah, this is quite a bit
more complicated that it appears at first glance. This will take a lot
more thought before tackling, and I am unsure if honestl it may be a bit
over my head as well, but I suppose I will see, haha.

Regardless, I did learn a lot, so thank you for taking the time to make
such a detailed reply!

If I do end up seeing something I can improve will definitely cook up
a patch and send it in, thanks again!

--=20
Cheers,
Joey Pabalinas

--xb75uyorqradflzk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEKlZXrihdNOcUPZTNruvLfWhyVBkFAlrug+cACgkQruvLfWhy
VBn2Mw//eoJk/2FQA6wZ5F1NFiq66E6jmOzJoa1rCMtanii1/eINW3A8mboDARVR
lTeEdhNe+H2JJvAiSXdud6wBOwqgk0LshqBCK5C7A1f4QbH3oJcNLSWI5yrF++kS
p1UQWXgFbK7IHraq/V6ETmUkhY2ZZPD3c/bsyv18Iy4Cfb21Jvf/S+X8nZ2GX+YS
uxHzIAAS8wiBpXTsD6Wxs/D4fVOs9kWYotTU0T20zkWGaeYs01lihuUUcdAGjRCP
VlUd0MdtuT/3eWNSIYMKxMvRbbRZ2S3W3rZ9Ka+8JsPgIJwAY6roCFPnB76xKJjO
N2uQtuF/sbp58Rawb4ULer1n31EHAW5W2ANM992Zx4gviOUiliDiHLbeWXoqz+70
sbb+lTBP6S0Q8nS3Ack1Iiw3kIh4cOlkfMiayWcilc75KHqKQcgJKBa22H82vgHq
eYxZpGyr/QvHpNrIH9BGJKYT4aCXfLKfYFslCiQcqT+BGlWoX177Y1cLinkm8HRB
qjVYruqxvgRCnnXtZsdznSOcnljuP3lQ1qPQyBzqZ32PaHrC4ZYVwVMlk54z/ptS
qa5CilAyBzOYL9/xS6pYhXe61E9/T+nBHU/T4mvrUGamFb+gE/6MMYzN7R3ePLkI
1hrnHztvBg4s9njnjArYzm0H0P7e+2zWxhc5nWBgvHsxrwwsWVw=
=SgS3
-----END PGP SIGNATURE-----

--xb75uyorqradflzk--
