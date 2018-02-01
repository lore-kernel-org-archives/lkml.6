Return-Path: <jhogan@kernel.org>
X-Google-Smtp-Source: AH8x2268EHibWWIHGiNoCjP4fO3uiZDAwt1JcLGIhbzQPpd8uc8W1auJgETsDNqxdboi7NrxWLP2
ARC-Seal: i=1; a=rsa-sha256; t=1517485977; cv=none;
        d=google.com; s=arc-20160816;
        b=fHEu4eBN7EdeD1HIZ5V7bX6kFVD/aH5IiRwotw2fKiL62vmvGFvKbuqxRubHv15v1j
         wBMpUODTGHyFJM3J9JddSNq77y9YPskwA3KAcgN8Fp1+oSuNyb76XcEhNJR3WAyvG1Gb
         P+OW8rJx94EyWMM9NaEfpK3x9lwmiAl2n8g7RIH7Ie1rAvw4pntcR78CO4uVI+4BxZKa
         ylG9YAv+vOByEp612h+rwr9RjIu0optwymipRvVCjR/Qt6xIG76HReJd/5ypoUOmW61P
         4aMubP3LSmKoIszLby8QGmm5CjikjOfSI7P7WIAOMRkKQh2t7xSAalwKlVPUzv7/98wA
         Wfgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dmarc-filter
         :arc-authentication-results;
        bh=Egwz9EkHu93V/uoOn0QuQh4O/5+0Zlyj6bDI5o48VKg=;
        b=mqdICU5jWYg8+QFr0gu4MUgxIMPtQUtBn7QB3HkBeG26KXXAOC1NtEErB4Ke7tPQU+
         CI+oOgLiQz7cGarJVR9edv297q9WxyFwKZfLiRa3ZlpVzLXOD5qm+slU5VrY0GEP/6R7
         8EZ7tmpnbIk4QLCOJrbiOW6iBmY39IrKLUcwVnrlDEPBniGmUUOlpG9wREKDDxHAGW4C
         vYJMrC4I+27XWwRmnroaXMHvKUnikhIqbCMH5D/gQjz/+jF5nIHG+AB1JfgOTjth53zD
         1lECI4TrMIVfOZ7ParV2InW3G2E49XZrwTmsVXMaTnDz6M6SVypTWXU4ol0PCB6CS1Wf
         TUDw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of jhogan@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=jhogan@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of jhogan@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=jhogan@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 302E421799
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=jhogan@kernel.org
Date: Thu, 1 Feb 2018 11:52:24 +0000
From: James Hogan <jhogan@kernel.org>
To: Huacai Chen <chenhc@lemote.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Stephen Rothwell <sfr@canb.auug.org.au>,
	Ralf Baechle <ralf@linux-mips.org>, Rui Wang <wangr@lemote.com>,
	Binbin Zhou <zhoubb@lemote.com>, Ce Sun <sunc@lemote.com>,
	Yao Wang <wangyao@lemote.com>,
	Liangliang Huang <huangll@lemote.com>,
	Fuxin Zhang <zhangfx@lemote.com>,
	Zhangjin Wu <wuzhangjin@gmail.com>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>, r@hev.cc,
	zhoubb.aaron@gmail.com, huanglllzu@163.com, 513434146@qq.com,
	1393699660@qq.com, linux-mips@linux-mips.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] MAINTAINERS: Add Loongson-2/Loongson-3 maintainers
Message-ID: <20180201115223.GD7637@saruman>
References: <1512628268-18357-1-git-send-email-chenhc@lemote.com>
 <1512628268-18357-2-git-send-email-chenhc@lemote.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="RIYY1s2vRbPFwWeW"
Content-Disposition: inline
In-Reply-To: <1512628268-18357-2-git-send-email-chenhc@lemote.com>
User-Agent: Mutt/1.7.2 (2016-11-26)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1586105673205275691?=
X-GMAIL-MSGID: =?utf-8?q?1591199375633108235?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


--RIYY1s2vRbPFwWeW
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 07, 2017 at 02:31:08PM +0800, Huacai Chen wrote:
> Add Jiaxun Yang as the MIPS/Loongson-2 maintainer and add Huacai Chen
> as the MIPS/Loongson-3 maintainer.
>=20
> Signed-off-by: Huacai Chen <chenhc@lemote.com>
> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> ---
>  MAINTAINERS | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index cdd6365..bf449da 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -9141,6 +9141,26 @@ F:	arch/mips/include/asm/mach-loongson32/
>  F:	drivers/*/*loongson1*
>  F:	drivers/*/*/*loongson1*
> =20
> +MIPS/LOONGSON2 ARCHITECTURE
> +M:	Jiaxun Yang <jiaxun.yang@flygoat.com>
> +L:	linux-mips@linux-mips.org
> +S:	Maintained
> +F:	arch/mips/loongson64/*{2e/2f}*
> +F:	arch/mips/include/asm/mach-loongson64/
> +F:	drivers/platform/mips/
> +F:	drivers/*/*loongson2*
> +F:	drivers/*/*/*loongson2*
> +
> +MIPS/LOONGSON3 ARCHITECTURE
> +M:	Huacai Chen <chenhc@lemote.com>
> +L:	linux-mips@linux-mips.org
> +S:	Maintained
> +F:	arch/mips/loongson64/
> +F:	arch/mips/include/asm/mach-loongson64/
> +F:	drivers/platform/mips/
> +F:	drivers/*/*loongson3*
> +F:	drivers/*/*/*loongson3*

Ralf applied this patch without the drivers/platform/mips/ changes,
adding that instead to the main MIPS entry. I have already cherry picked
both into my 4.16 branch.

Thanks
James

> +
>  MIPS RINT INSTRUCTION EMULATION
>  M:	Aleksandar Markovic <aleksandar.markovic@mips.com>
>  L:	linux-mips@linux-mips.org
> --=20
> 2.7.0
>=20

--RIYY1s2vRbPFwWeW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEd80NauSabkiESfLYbAtpk944dnoFAlpy/3cACgkQbAtpk944
dnoo2Q//RSrmp9HvCILdTaw/uWRWBiTo4rdwwfz6dUZwkXb4n6vDVDl099kZty7E
AyKvo0dE9c5WLYgxf7s9zL9rE1/k6uzTBtQNwEiMLcl9onwv7+CgyglJ1RH5VXGt
g8yyuWNONGGW2Y4GXz1YN+Ti+AAarIniVgybqgldOH0L5PMQlHDx/aJUheFC7ent
HRKhzgqhch16VZR/w1+Iw2NBdqKcAJYtChI0Ns1olj9SJz68gwh0gVCMWY2v6lal
B/TyF0fOS8Aud6+3/DYXBEm4shcH4coP2FBcmnl+/Bq3JjbrYhfLaOmzNcApMvCk
r4FjT0+ynNOO2LT+ptRwx1WRTHVpMd2S62q5UyBB/6cMyVhMzTpfZEuHlhEVCzH+
oBksYvCZefYLGxYzZF5DyDPRpqVAV54IJW15J55A4Gb+eIrxs6IIInOM93Y2XzJK
/QleBGEhHczP4w86FuFi7Sqhvh4rZ06cb17ny8BN8tByjyAGIsw7KrVi4Yalq9nz
YG/nSqbREiN3cOxnPmVyy4muOeK6fXT4zArneP4TDrIMjPLr4FzAG62WHbC5YfUl
T2BibSGINIuzJ58AgqeLCHQfT7fSTDU107cxwdnYXbgfJoOA+cHG8+wlF5GVryP9
4EFOwqd5QaW6Ekl5mJ8uB8tSFXTpUXJPQYtHeux1D/lFddZ6PjI=
=b0VP
-----END PGP SIGNATURE-----

--RIYY1s2vRbPFwWeW--
