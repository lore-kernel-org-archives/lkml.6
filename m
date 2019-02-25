Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12533C10F00
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 15:51:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DEBDA20C01
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 15:51:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727742AbfBYPvX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 10:51:23 -0500
Received: from mout.gmx.net ([212.227.17.22]:43911 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727660AbfBYPvW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 10:51:22 -0500
Received: from longitude ([109.90.232.48]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MPqtK-1guSmL40HK-0052Jk; Mon, 25
 Feb 2019 16:51:20 +0100
Date:   Mon, 25 Feb 2019 16:51:19 +0100
From:   Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Linux-Arch <linux-arch@vger.kernel.org>
Subject: Re: [PATCH] div64.h: Fix description of do_div parameter
Message-ID: <20190225155119.GA7654@latitude>
References: <20190225140355.4335-1-j.neuschaefer@gmx.net>
 <CAMuHMdXEY+ri8QO2AVGzD5vNuYujDNK-k62zz2Qd-ceMgT59tw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="YiEDa0DAkWCtVeE4"
Content-Disposition: inline
In-Reply-To: <CAMuHMdXEY+ri8QO2AVGzD5vNuYujDNK-k62zz2Qd-ceMgT59tw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Provags-ID: V03:K1:1rdV8/II6lRwqF/hPmUTLLv4qNZ5KLQbCq4gPbrk1/4HCGu1wCE
 dfdfDrcds4T0hbhzI3gmDrmIIgQFEVSKkgFhGGLd3WsL1+qoRYTJWQ/zbkGtXms3GUDiJHb
 LdOTQyQimAxH+GTnh7RXQJunm+re7ohfJ6hWivyp327HhtHRQkFbF0IIocDBJvxuvgIiFXE
 pa69ukWIqdwq9JOs522/A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:B4dGyAawDek=:RB/7P1nSrkTyPAQPs04V0J
 SrvccAJC6BoF8sODWkg8r+PkVNwMxAHRB3Vk7A8zpn0VVQ5dteCxZWcQJRpfiz64UywkRRtNw
 BL3km1/4YzFo83VOrX7vbJML6xxDgc/21+ju2QyBzXvY2Ahligqh74rFpDL4r55wQnok94xtI
 KdzRksAcEs/AsVMfGDu23VFK2cjl9hZAE52v0dEDUiv9sjsLLwrI2NiS5mKD6fEBiXg8TNdlh
 i2V0EPnsV3bgLyAE1xUEOBcNijemW8r0vzgeRFqhbFBNMulkDXS82dWyxV5gzV+wi8TOVXvO4
 jomSFIflUiG6ITdsWAJB3KDhrFcVfsHoDGTFtIjyVMUjvFuIowjRHtgs0vIWkjAXAFsn3f+xh
 IExeHkQBU09k/tVumiK5QgBT4CojkWrI7vu2Cdbm6xcy2qFS1EP2OwY4N+Duht8WvCEql+l80
 R5L7F11hZ++zFPJjgBtsYRkg/Vtq43a+XXIDbE+dowKz+hlPbRf6PKWIyxWlE3BWEuAyy+WSR
 ratoHDNUDsSr3rKxV0x+3rea+c1cxkpmur1ix6+QPEeusP5pk+A7KiZqajZz5+AvS6GjTSbmm
 KGVOj0AgbOT8WaLvzeb4Iw3tWEQl/uwdq5HFv7/CHCeMVBZlDhRo8EgqFJBDIWpW3/YrNIGG2
 RspvgzoQiYR/1p+qOxRKIzIEybjYpIBg+FDEutxNLS/NZZKwZ44av5sw0JHS7Vj7CVthAI2oC
 oIgMLatlVXGodDFq62uPUvC67hJrAziwB7bsEWNNCukxM218J05QOtjG1TvciMguDvCswTtEM
 RFopmxsoLAmn4TEh5tsRI7+rkLhaRnpAGPwbGsED40aY4EjlQV2AVReDeBdkR8vV31Fd2InJE
 xVVFe00g/CQwdm3Ccewh/DSopzTT3+NgtvEyb0WAFBUFAts8UF1/l01jmWJNNk
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--YiEDa0DAkWCtVeE4
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 25, 2019 at 04:19:02PM +0100, Geert Uytterhoeven wrote:
> Hi Jonathan,
>=20
> On Mon, Feb 25, 2019 at 3:05 PM Jonathan Neusch=C3=A4fer
> <j.neuschaefer@gmx.net> wrote:
> > Contrary to the description, the first parameter (n) should not be
> > passed as a pointer, but directly as an lvalue. This is possible because
> > do_div is a macro.
> >
> > Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
>=20
> Thanks for your patch!
>=20
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
>=20
> Shouldn't the "semantics" at the top of include/asm-generic/div64.h be
> updated, too?

Arguably, it's semantically close enough. I'm not sure.

> As this can't be expressed in a C function, perhaps that should be done
> using C++ syntax, like
>=20
>     uint32_t do_div(uint64_t &n, uint32_t base)
>     {
>         ...
>     }

That might confuse some people who aren't expecting C++ syntax.
I'll leave this as is, because I can't decide wether this is an
improvement.


Thanks,
Jonathan Neusch=C3=A4fer

--YiEDa0DAkWCtVeE4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEvHAHGBBjQPVy+qvDCDBEmo7zX9sFAlx0Du8ACgkQCDBEmo7z
X9ulPw//Z1CKR5K1NBXBN8FGwlzGRQAXIAcsnNzeCiqbcwjLENyGq5AgGsVhQPH3
wo8xrTbdzwq/ogn9zerH8uNhz02/ewDb8o6gMI6WjcK15tJrkspy7zCcUqn7RnY+
GH6kV70Sx3xIjWdklrsKnWGKfOtmCn1Gm5aoN3lAzMSRRSN+B0vf30ir5Y4csGgy
f3+uriehAIrWw6DQrVN/xvZhNpDdDUiDCM13Yabg+dXXPdic9LPC4c6ijHzysuC7
NXPlQZu87/sRr2Bu+qVp2noW0nnEQxdofcJBXyEE0s8N+7aVGjaVwt4K2UJ5vp6A
UesKCGw3wEJhrjXa+QR35jObA08vzh3vqIjiWk+XTQ/JA/bEiYBV/E5IUhzDOezb
WuyB6jo2flZzYezwYoketY6HIns/DlxXuHtn1awmfg5rTmxBmkkhFLsI2IRPadRT
qSlhFeP4DMHy2fHqDqZBllKSkeRMWXDGc1fqwurzrnGfvvMrMRsyQ6++/hcNNeQO
hV5LLM+G3sBiEkGUj1k4Xl2tytmCqsOlilvFivX9pqFeBeMocKTc8wtyFWohseqp
nG99luWuDzR67w5X8ETQj+GT2qskr7VfiGwDTar4/WW/Ll2AydJcnzBvy2GxcapZ
wDpGia8jZLEn/DUyf6AppqDb7JIkc515RHsGL8FTXIs3svFQpkg=
=uSc2
-----END PGP SIGNATURE-----

--YiEDa0DAkWCtVeE4--
