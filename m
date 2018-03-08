Return-Path: <kernel-hardening-return-12261-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELsR00dWu6yNrOL4QacCLnEORFzdufe0d5mSZEbNkWJz+N9Bth047JxCTLcjQHF3CuJITvv3
ARC-Seal: i=1; a=rsa-sha256; t=1520542246; cv=none;
        d=google.com; s=arc-20160816;
        b=AVvIaj7rAE/eIvuq4odLzfzn/ErjleHFiUDTi2siXSgqomqFtR1DetGy4mdvACy41F
         XfRjYnCHXpK0fBgHHkWFTs3AwA81jBzwi5ipogKRzNA0nUglq9jbmNLi+o9Tv2rJXRoj
         7Jnslq1l7Mn+JCEGSqKE7B0JtOyVTCUpYNEIaOQiX1+93gNo0NU9WAlkiL7RcEIuRoW2
         I3OgcfiyTl0ktOykhJVyERB2C9NtcGWL4s+FWNiORgi3ToDkzwCizMxwKj7OKceeg6nq
         IzrURFdQbyqcEIdcvcpIsM66lARxA91s1+2emfMjh+6OfS/WNYD7pduZaFVAip4saVwu
         Flvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:references:in-reply-to:message-id:subject:cc:to:from
         :date:delivered-to:list-id:list-subscribe:list-unsubscribe:list-help
         :list-post:precedence:mailing-list:arc-authentication-results;
        bh=TngQvFG1dYuk6C+a+WeqDiz4+xpJj5kzvrSCEtdXsZs=;
        b=P3/uiDUyZ5Kk7gCb2x+zT4WLvO8gjXIHcPABl5eUkjsVEtuHv88TUOzzP/u4O0EtaN
         Dd4tCDhzdQDCih4NLeeYl6fzZdm/F82+u+f7Isuf+rmd4hiQx3XUi0j3OWRsJYP2MVJG
         51UYvKOzeOvmfEbh0iP01ihcedYTWhq0/+b6Py52C4EqvPFuzuQjjYooe4NhUa+vxhWb
         ZDMT7n+0m7l5vMsVBNAfDc4+jhx/sjxZ5YESVo/NQRB6BeBjyq9BntlTJ/87StFoTIxK
         lPv1aX7rGnbvMtUkohYuNfJ1UfhKnTg23NbeFnqFUNTk6GGQlf9dGBiD0v+u+sVYYq9K
         lEdg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12261-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12261-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12261-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12261-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
Date: Thu, 8 Mar 2018 21:50:19 +0100
From: Stephen Kitt <steve@sk2.org>
To: Kees Cook <keescook@chromium.org>
Cc: hare <hare@suse.com>, linux-scsi@vger.kernel.org, Kernel Hardening
 <kernel-hardening@lists.openwall.com>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] aic7xxx/aic79xx: remove VLAs
Message-ID: <20180308215019.399ebdb4@heffalump.sk2.org>
In-Reply-To: <CAGXu5jK=JhBFHBGpbWF46DC3-QMruiB0qqz1z+njcK2h7jVU9w@mail.gmail.com>
References: <20180308132225.13229-1-steve@sk2.org>
	<CAGXu5jK=JhBFHBGpbWF46DC3-QMruiB0qqz1z+njcK2h7jVU9w@mail.gmail.com>
X-Mailer: Claws Mail 3.14.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 boundary="Sig_/EbA69GcKFcB.rXi1iSj5RD0"; protocol="application/pgp-signature"
X-Ovh-Tracer-Id: 11678959735493512462
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedtfedrkeeggdduvdekucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddm
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594376653072055099?=
X-GMAIL-MSGID: =?utf-8?q?1594404106941279708?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

--Sig_/EbA69GcKFcB.rXi1iSj5RD0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Thu, 8 Mar 2018 11:52:25 -0800, Kees Cook <keescook@chromium.org> wrote:
> On Thu, Mar 8, 2018 at 5:22 AM, Stephen Kitt <steve@sk2.org> wrote:
> > -static const int num_critical_sections =3D sizeof(critical_sections)
> > -                                      / sizeof(*critical_sections);
> > +#define NUM_CRITICAL_SECTIONS 14 =20
>=20
> The compiler doesn't treat "const" as a literal, hence the need to
> change this. However, you can still use the sizeof (actually, this is
> exactly ARRAY_SIZE()). Perhaps:
>=20
> #define NUM_CRITICAL_SECTIONS ARRAY_SIZE(critical_sections)
>=20
> ?
>=20
> Otherwise, looks great!

Thanks, v2 incoming...

Regards,

Stephen

--Sig_/EbA69GcKFcB.rXi1iSj5RD0
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEnPVX/hPLkMoq7x0ggNMC9Yhtg5wFAlqhogsACgkQgNMC9Yht
g5y+vxAAhYiZaRdCTRVxuCtpCt3PtJk1fq4D+RwtPbQjYdM1ZNm5H7DN1tL7Qac/
vP8pnMh3jjU2s2+3lKth3SsM/3izj4KsHFk2XXZjncSIHZddvOhGOpYzGVSNRs97
CKl1JxeTzt+7IaT8u7bxT8sSoIuhMqpXAT+y0YjlG4ljFWpZ23wZ6AxD2EIhDrLi
wddbrvzGHMohAFYg+m4gM7E6SPx/N4dwFaW3ZD1bALvB284OIa0lkWrPQJLNI0m3
JahA6OgzrQkHm8qqwGQPyKWY1JC0nTm/euF387AnklyE9v7pjB0uRk6Muj7Yle55
yN4bKnXfFbQH1ANmbBMfvkIUTZESXaViPweHr3RbmbnMtEpvVkxt04qAOp7mhvBL
qoICxTDE4C1mTHrehCnCjmA095owv+ZJc7TBZGPyvKlBscQh8KBNiJ/b3mXlrTPV
RlLhOt9+oG/Sug/6J+30gYLV5CRJCAQK0H//zmeCKfKIq5Gtefm2CfX1Z+FiXTzM
nREDdG1Pqg0Q+Flh7Yyz7DRY2MYe91cprj1ZsWbl+jmy89ds1iIXR3Q+s2011N8T
/8QR4vIflUsVgaQoIkKyRqp4bAKxj83oN/vXvAauwTEfNfb0bAoeqAzesfBmc6M9
2xHL145DPD1fth4l4PFNsaYdgeYkw1ZnqAEy1TUTaQSbFKDoB3I=
=xGd9
-----END PGP SIGNATURE-----

--Sig_/EbA69GcKFcB.rXi1iSj5RD0--
