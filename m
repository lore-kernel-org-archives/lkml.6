Return-Path: <jhogan@kernel.org>
X-Google-Smtp-Source: AIpwx49F5eGGVnKdK4asNSUhM015aw4BxxML3R6bzNEb0fgWe6QhgHC4AjsILjQ8qvCDj9Kwtx/x
ARC-Seal: i=1; a=rsa-sha256; t=1522771654; cv=none;
        d=google.com; s=arc-20160816;
        b=r0J1s4XaKpvBVF0WRM/iS0M/hj6Z5dK4Cj12x6s48+yyjbV2v7zGwhQpCSnH52db+G
         a2N3q/yhxSvd1fSmCLKrMfYGyZ7LyPvX9HgSXrJdROyJTyFsunlzIfGaP7CiUWbPzGMT
         1gr+kkHa+fqD0e+9IoenAlJuCi0w6Qif4k2jy+qbgJKk2c/c6pt/54K0iNkCwzSWUOU+
         hn28C9g39zvqQlKnaLWSvxR32tKelfiWzeqGYN+VUAt/mxv7yEFCIRA0dRT3H6BxVEx8
         SLyHPXPO4uS+iIeGyj1HyP69/GAyEJqZ3AuoQcj+E9QKYse/62fVB9vTjO7tlACWCgQe
         Qn6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dmarc-filter
         :arc-authentication-results;
        bh=dkkEB9c7CZm4YM91l2kemCR9/HbDSMgwxDfNHPgQr6E=;
        b=S2TsclEXuBOUbdfzdf153xmye0Rou8lVijhpuRAVVtly0gcspzdzKaV3RZdkxMR7ox
         cor63vBEo0un13ZzPhZo3HY8DdMliX7gVT3qesdVRfhraFf2EWzG3qWaQaR+AGzuWRiJ
         UjOjMA5N0rHiqKJqUMKcRLF+H8zBahJgkx2NVzOs22f4hv2TTH/lklg+4gWVc6RSfIzl
         2Ol3Rek3KHvxTFmSsyIV7wx5047DyLc3rtWNSU3yzSUYp4R+LuHwvq+rTtW6u5e5Yu4T
         +DGD9HQPF7nQy6mRrWeKY/l+JS4+H0szbp4PO3710NZo42n7ePY2h6+4Hs7w3obcm3FC
         X+tg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of jhogan@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=jhogan@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of jhogan@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=jhogan@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C972620CAA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=jhogan@kernel.org
Date: Tue, 3 Apr 2018 17:07:29 +0100
From: James Hogan <jhogan@kernel.org>
To: Matt Redfearn <matt.redfearn@mips.com>
Cc: Palmer Dabbelt <palmer@sifive.com>,
	Antony Pavlov <antonynpavlov@gmail.com>,
	Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
	linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
	Philippe Ombredanne <pombredanne@nexb.com>,
	Paul Burton <paul.burton@mips.com>,
	Kate Stewart <kstewart@linuxfoundation.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH v5 3/3] MIPS: use generic GCC library routines from lib/
Message-ID: <20180403160728.GB3275@saruman>
References: <1522747466-22081-1-git-send-email-matt.redfearn@mips.com>
 <1522747466-22081-3-git-send-email-matt.redfearn@mips.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="neYutvxvOLaeuPCA"
Content-Disposition: inline
In-Reply-To: <1522747466-22081-3-git-send-email-matt.redfearn@mips.com>
User-Agent: Mutt/1.7.2 (2016-11-26)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596278698028411080?=
X-GMAIL-MSGID: =?utf-8?q?1596741810173005879?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


--neYutvxvOLaeuPCA
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 03, 2018 at 10:24:26AM +0100, Matt Redfearn wrote:
> From: Antony Pavlov <antonynpavlov@gmail.com>
>=20
> The commit b35cd9884fa5 ("lib: Add shared copies of some GCC library
> routines") makes it possible to share generic GCC library routines by
> several architectures.
>=20
> This commit removes several generic GCC library routines from
> arch/mips/lib/ in favour of similar routines from lib/.
>=20
> Signed-off-by: Antony Pavlov <antonynpavlov@gmail.com>
> [Matt Redfearn] Use GENERIC_LIB_* named Kconfig entries
> Signed-off-by: Matt Redfearn <matt.redfearn@mips.com>
> Cc: Palmer Dabbelt <palmer@sifive.com>
> Cc: Matt Redfearn <matt.redfearn@mips.com>
> Cc: James Hogan <jhogan@kernel.org>
> Cc: Ralf Baechle <ralf@linux-mips.org>
> Cc: linux-mips@linux-mips.org
> Cc: linux-kernel@vger.kernel.org

ci20_defconfig:
make[1]: *** No rule to make target 'arch/mips/lib/ashldi3.c', needed by 'a=
rch/mips/boot/compressed/ashldi3.c'.  Stop.
make[1]: *** Waiting for unfinished jobs....
make: *** [arch/mips/Makefile +395 : vmlinuz] Error 2

same for db1xxx_defconfig (and possibly others).

Thanks
James

--neYutvxvOLaeuPCA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEd80NauSabkiESfLYbAtpk944dnoFAlrDpsAACgkQbAtpk944
dnoiIQ/+KDxYNqNKyAK5CztRIZzY5OevXj6PV8PmNPNNAmpsYagbZsCPSBZDafvb
6gGENo7ZoCpTkQyj5nOBdmVFnUb6B7vSLG9Y2XwDC3Xj++tBRPb01zHcAPr7gbFh
A6edFgI3+D0Qp9/hthwg10ZS6K89dEeeLSiBcsAF5dWDnyyfj3mgEyhhwUKGr0g6
apGCOSWZBb+vwWOLZDyx5Mu5JyDTiiKZ4+176CDXlbOiLbam9DRV+QpwHnoX0NTp
6UcFSBJrHRBrXuLkWJKCWbjVBBy9RG+FMiaWtqbRoYCkLlYDL4PwQcs1jWPFiTuq
v9dCCFTHGuNWPNR6UwL/dbTlvxTEHEvyzmQjh12h7miFAh5BxOTGO67/9Ca9N7Yw
A3GkHR90lXeizplijUhbO92eIbmyRp9IOHNrZB6n6VXLlHKtdY2CD1dEXAB23h7n
lVzdJ+vsm+2sXk6if0Gx0SgFg/Qtr5jSg6748eG5dlT5I7q42ZhlswhTdvQhbt/o
Qjj5GMDjy/OES9Zj9/HZFyUf4rtu+9tRffHcRAFLadqyrPw2hg2Ks7ECUrl6pRXP
sEA/l/PowHSXv90I8GenKwEhpUn6YSSdv7JoPpqQKuhkcKotpgYKuSKrjfV9R7mL
AlesX/tQn8NlQwNRRtKprFeHn4m3/vg2mEYBSr9sEgTqReuJSpI=
=J1ZU
-----END PGP SIGNATURE-----

--neYutvxvOLaeuPCA--
