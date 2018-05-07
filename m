Return-Path: <j.neuschaefer@gmx.net>
X-Google-Smtp-Source: AB8JxZpmlli8JTb5RAgAbB/v/4yIlkGJE/oW/r9DanQJxVjK3KACTpH7V8U+7Gwy4hh1O7T90VaH
ARC-Seal: i=1; a=rsa-sha256; t=1525715618; cv=none;
        d=google.com; s=arc-20160816;
        b=LQkObps//o8OGkjoMyJ9zWwVblPfzyKRBGm1X1ZM7UgCjUc48ozSDg4XTQ5riG6joz
         QnPWtwXSf/ae6wNMZJH0LQoxvUoqfbizvM3Zo9oDWMdPlcyfQW8WUCvINSLhg2wkKFDW
         ggMpL8AbM4MpZpMcTurJTccQSqKfgxX++8V6AyLo621r5cbUzwlqCCblwqScSMAqtroj
         CAiXDSaL5vjMnlnd2HAk4WQ+5yXG6Y+wMOuGD3TRhSQKeWxAVBgnNN5Ezsq/TEtSMVCz
         CnFBpsKqP9N7NjvsmMcImFQoX+ctVNwRHjzWN7xHOY8JmiJS2LVtDAicdz7HRbR2edC8
         HPIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=Tl6OwM3JGLAkjM+4SpbzDzPT+6VhMaUIqRSkqeZPSWs=;
        b=Oi8H7vO2cjDQyitjvgPguJBajKTDPYUJbjPPfhwWtQQIAN3Evl0JLJ0g5NY/FsIgVr
         /k5pNPKuHAjkEvVoAvQeN/2Z6hANEJoHV/NiOwVhQJvfxOM998UJ0RtR7QtK8jVzZc+F
         Ozo3yh5W/SY4DEYIen4oJ3Y06hOVDd+w5wJbw3Y9hxHqbOIk1j8lDHF8yzfkwpbwP6Rh
         or9dQnKdfp5keq3VSuy3c3c6+jIwIHkVnMbBCk4onKTauQT5T13ttZGxr5SjC2gRIsqw
         0vdYGB99hKpKuu9IEa3vPc/f3QlRpoi6BMntJP/zZUR0/oIVDv+Npwnm2kUnQTKIbylG
         lirg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of j.neuschaefer@gmx.net designates 212.227.15.15 as permitted sender) smtp.mailfrom=j.neuschaefer@gmx.net
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of j.neuschaefer@gmx.net designates 212.227.15.15 as permitted sender) smtp.mailfrom=j.neuschaefer@gmx.net
Date: Mon, 7 May 2018 19:47:33 +0200
From: Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To: Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
Cc: linuxppc-dev@lists.ozlabs.org, Joel Stanley <joel@jms.id.au>,
	linux-kernel@vger.kernel.org,
	Benjamin Gilbert <benjamin.gilbert@coreos.com>,
	"Robin H. Johnson" <robbat2@gentoo.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Paul Mackerras <paulus@samba.org>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH v2 0/4] powerpc: wii_defconfig updates
Message-ID: <20180507174733.GB32665@latitude>
References: <20180507142019.32669-1-j.neuschaefer@gmx.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="dTy3Mrz/UPE2dbVg"
Content-Disposition: inline
In-Reply-To: <20180507142019.32669-1-j.neuschaefer@gmx.net>
User-Agent: Mutt/1.9.5 (2018-04-13)
X-Provags-ID: V03:K1:eztwWP/vHyOYaKFsyV2AGLPTFNpdlDS8buoB0VQJ+jjeEM/88KF
 1ytRqr7J14RbELEMkgufwcZlTNbY5mK07KEEgt8g40YlHobYeKxp+X202cWHSzFAMw1E3la
 +md00b1D8UExcdSuPKBySQMovfi67D+SnbMWDjG2pwzQwDoWKeC8fX8t0cWP+ZjWLHRcw21
 XBLrRE3cryO14LNCnF7Eg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:10FylVc2C2U=:jq+qVE5G1L+tQ5uSmXZ5mv
 HipbjWOkWc0ZRYeKugU7XaW+sFFWbA452jDONwX6LnNlcHt3UTDoR15HnIEpi9LDpZpDb80o9
 qKOQLt2ABRD/dPoJ2iQkOe00tZAHPFJJlQ9kMvsQvo2E5W2OhO82UiKXG69C5sqls7Bo4huY1
 r8Jb9JGHdGkKmIL5cTjyfhEGrz0aIlPbOvMDAeEXgvsYv/nzReEtoyL4u7kDixQABnsGs/awF
 xcBNpRgClEwbE8c+v8Yuci4UpbVUYwCQkXXUuGBriHb3N8gnmWkAVFW7bOphvjdvXI6MDRQ62
 tDd4soTUUzCfUeLy1/iitRPp9M20jwhfjJXsoZ13Cc8rZDEG4NTjF836t3zK9+Grf6iLoCUqp
 nHR5Dc7ve2FdBxZFHIza/1sIiNV2qPeIyrVT/mjFeqCDkT8s+Cn+Ww9da/TOhveYNpelODF7e
 6eZ023k7Zus0xByjpP/xLpyivoes47QNpcIhSzEQQrDkppQ8pgYudvHkpK+ZjEltS4qape4Fq
 UQwa7b4IJYqOhAXz9GtcZsbE6KCDBYNkROgrcPnzEcHFOeLmCTOhFm92+LrkAso+h/IpgLxxp
 Bg2+uyzr9FFDHo4fBPPF6EQ770TIPlD2hlqV+2+nq/X7V9HHD9F2C0di//uAqA3cdWGm6NYgM
 c4BoVx3e8W6BFlGvriU2xpLLciLpSagC+qQV0jIs7dA+CW1IAni9ENxuLzxnvxD/94CqWqehZ
 CshIhpxL9lUByJwu8/kbEQ2qs1qeU+F/EZkZ4hGRb96rQO6Zo/GoyrDvsKI=
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcSW1wb3J0YW50Ig==?=
X-GMAIL-THRID: =?utf-8?q?1599828781094407683?=
X-GMAIL-MSGID: =?utf-8?q?1599828781094407683?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


--dTy3Mrz/UPE2dbVg
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I forgot to CC the right set of people/mailing lists on the cover
letter. Sorry. Here it is:

On Mon, May 07, 2018 at 04:20:15PM +0200, Jonathan Neusch=C3=A4fer wrote:
> v1: https://www.spinics.net/lists/kernel/msg2790389.html
>     https://www.spinics.net/lists/kernel/msg2790385.html
>=20
> In the previous version of patch 2, I forgot to set CONFIG_NEW_LEDS and
> CONFIG_LEDS_TRIGGERS, so the more specific LED-related options weren't
> actually enabled, due to Kconfig dependencies. This is now fixed.
>=20
> I took the opportunity of a v2 to add two more patches that I wanted to
> send anyway. The SDHCIs in the Wii are currently unusable due to bugs/
> problems in the flipper-pic/hlwd-pic drivers, but I know how to fix
> those, and will send patches.
>=20
> Jonathan Neusch=C3=A4fer (4):
>   powerpc: wii_defconfig: Disable Ethernet driver support code
>   powerpc: wii_defconfig: Enable GPIO-related options
>   powerpc: wii_defconfig: Enable Wii SDHCI driver
>   powerpc: wii_defconfig: Disable BCMA support
>=20
>  arch/powerpc/configs/wii_defconfig | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>=20
> --=20
> 2.17.0
>=20

--dTy3Mrz/UPE2dbVg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAABAgAGBQJa8JEsAAoJEAgwRJqO81/bpY4QAKvB4XdQdzV2LswTM9PbQt2a
tkwSsa8zAJa6QWDZDp7wgZ1RMRZPhB/ZIrmDZ3S+6pApFpiv9JFSddsvtGkHvarY
j5o/P8TxKkdaGVbUslHCc5L8UUW/8EpPxo0aExi9U6vmvXpFjDY93RZJiXPb/PWs
/Q53GQuv2CRL9C41QhU/ZevZO5Nt0zdUVInmVuSbvL7fXMjC7E7UJPC97H9NU2ZL
DguxpG7yAhoQ4RNsH7bv254g+ZYHXRFKJzKEvhj/2cVnv3bOExLTnHmWJ/D4LjIC
GY/n1IzreL9YS7JHlx5bbOQ8R1SSpw1HJV8UNyDxiHzycIO8quUCr5TbqDnGL+nz
DHFpxHl4M1Dof6UmMW7uHZaDKjZwwSlJy+4DlE0sbFYYMg2PUZEwjNh5zOYHMB7z
sliFV18JgRPfsyc8GkfhDk/6SZz+F0zYvA1/lty0WT9dyGavj+GoulAvy3ybqqHM
8FL9SxdVXEMh47Dt7tzEgOh8p1HI9Xb+jY4uUmPTeTdRJ05r6zwJ5ySwmb6A8zHh
/viX64JfW2/pMqiQJZnahwQqVt3fe/xJPfV6uXVLeOIgfHAWB6AREQ0WwJhWfZll
eOof5HkLg0nOvKiofArh+a3IOebcrHjM2aY+GqIM1kZ19ALECYm+DCXpnnhkwbwe
/xfaDiBv7yjkLAj5gAuV
=DszJ
-----END PGP SIGNATURE-----

--dTy3Mrz/UPE2dbVg--
