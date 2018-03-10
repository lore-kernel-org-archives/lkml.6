Return-Path: <kernel-hardening-return-12374-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELtWKqBFiDGxTLta63AYW4aW+LK+MnwptSknni2Uemf2NWVTcS7FVdnwMrJhkp17qW6Pl5gp
ARC-Seal: i=1; a=rsa-sha256; t=1520688610; cv=none;
        d=google.com; s=arc-20160816;
        b=0/cObi/Yem/dGypDK9guuZqU7STDr9HYvjh7sNOarn7GPYhcT5eDzmfvFnczjRN2VY
         T2K0waDYfb8KelBLiXNZRtVmDUGE8qTPJ0cxVRPJmT7BSngUQA4JQNKYkTTCF3nzrP7g
         O9qRqOBAcRmspth9WOmLC29whk8ezrat8da/4GEN0ktcw4DmB1TWJMQDoGliljoMRn84
         ZwZrtH5QT5DmLvYsc3fjJToI7fX8z4MSiex9vht982dBKt7hSUe1WxhSdOvwA+5YFIZr
         Vgm+lDq1XdC4TeRhJmNEP8G5S0F2BfEO1w2VZu+bAUtqAFJx90z30RDDf/g8dxQvZ+SN
         kF7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:references:in-reply-to:message-id:subject:cc:to:from
         :date:delivered-to:list-id:list-subscribe:list-unsubscribe:list-help
         :list-post:precedence:mailing-list:arc-authentication-results;
        bh=3l8aRwLM/8+pZGpVJPB7X6fa7AJG169WO6sUTPz+dCk=;
        b=D+XOaoKg3ARFPMtlfOICeqWPKzGbJHaMeZun9EZqcotB0Y7DJ6bGSq78eNDf2vdKxo
         eABTjUMuttWyNH/qpicJaaITML0vGmWI8tP0Q2vzvbbAFMmIGbFSS1qCdYQq8txW3TIM
         TES9IC7V38p8LRBHbGSl5L6Px+KDtRXICNbd00l36YXoih885gyjdfpxhDC7U4zDQpbL
         bXnOJYF5UjAcdZz4s/Mn58LAX4NLzZt9lXYeOqKdEq2AHrhJPh1VUWYp90VNW76unoW6
         a0esMI0AemCzROvSGB+vQ4YPBhW1p9L6dAA6vTHzu63HNMwKfWLdzYCp0tgWivGCQ238
         2vqQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12374-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12374-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12374-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12374-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
Date: Sat, 10 Mar 2018 14:29:30 +0100
From: Stephen Kitt <steve@sk2.org>
To: Bart Van Assche <Bart.VanAssche@wdc.com>
Cc: "jejb@linux.vnet.ibm.com" <jejb@linux.vnet.ibm.com>, "hare@suse.com"
 <hare@suse.com>, "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
 "axboe@kernel.dk" <axboe@kernel.dk>, "linux-scsi@vger.kernel.org"
 <linux-scsi@vger.kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "linux-block@vger.kernel.org"
 <linux-block@vger.kernel.org>, "kernel-hardening@lists.openwall.com"
 <kernel-hardening@lists.openwall.com>
Subject: Re: [PATCH] scsi: resolve COMMAND_SIZE at compile time
Message-ID: <20180310142930.0692200b@heffalump.sk2.org>
In-Reply-To: <1520635631.2907.16.camel@wdc.com>
References: <20180309232933.14e39858@heffalump.sk2.org>
	<20180309223355.21222-1-steve@sk2.org>
	<1520635631.2907.16.camel@wdc.com>
X-Mailer: Claws Mail 3.14.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 boundary="Sig_/3N3tICVyMiJ8mX7TlQQ=.7+"; protocol="application/pgp-signature"
X-Ovh-Tracer-Id: 15983275080714636766
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedtfedrkeelgdegkecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594501214170730131?=
X-GMAIL-MSGID: =?utf-8?q?1594557579722799771?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

--Sig_/3N3tICVyMiJ8mX7TlQQ=.7+
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Bart,

On Fri, 9 Mar 2018 22:47:12 +0000, Bart Van Assche <Bart.VanAssche@wdc.com>
wrote:
> On Fri, 2018-03-09 at 23:33 +0100, Stephen Kitt wrote:
> > +/*
> > + * SCSI command sizes are as follows, in bytes, for fixed size command=
s,
> > per
> > + * group: 6, 10, 10, 12, 16, 12, 10, 10. The top three bits of an opco=
de
> > + * determine its group.
> > + * The size table is encoded into a 32-bit value by subtracting each
> > value
> > + * from 16, resulting in a value of 1715488362
> > + * (6 << 28 + 6 << 24 + 4 << 20 + 0 << 16 + 4 << 12 + 6 << 8 + 6 << 4 +
> > 10).
> > + * Command group 3 is reserved and should never be used.
> > + */
> > +#define COMMAND_SIZE(opcode) \
> > +	(16 - (15 & (1715488362 >> (4 * (((opcode) >> 5) & 7))))) =20
>=20
> To me this seems hard to read and hard to verify. Could this have been
> written as a combination of ternary expressions, e.g. using a gcc stateme=
nt
> expression to ensure that opcode is evaluated once?

That=E2=80=99s what I=E2=80=99d tried initially, e.g.

#define COMMAND_SIZE(opcode) ({ \
int index =3D ((opcode) >> 5) & 7; \
index =3D=3D 0 ? 6 : (index =3D=3D 4 ? 16 : index =3D=3D 3 || index =3D=3D =
5 ? 12 : 10); \
})

But gcc still reckons that results in a VLA, defeating the initial purpose =
of
the exercise.

Does it help if I make the magic value construction clearer?

#define SCSI_COMMAND_SIZE_TBL (	\
	   (16 -  6)		\
	+ ((16 - 10) <<  4)	\
	+ ((16 - 10) <<  8)	\
	+ ((16 - 12) << 12)	\
	+ ((16 - 16) << 16)	\
	+ ((16 - 12) << 20)	\
	+ ((16 - 10) << 24)	\
	+ ((16 - 10) << 28))

#define COMMAND_SIZE(opcode)						\
  (16 - (15 & (SCSI_COMMAND_SIZE_TBL >> (4 * (((opcode) >> 5) & 7)))))

Regards,

Stephen

--Sig_/3N3tICVyMiJ8mX7TlQQ=.7+
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEnPVX/hPLkMoq7x0ggNMC9Yhtg5wFAlqj3boACgkQgNMC9Yht
g5xKfA/+N51ED2mvt0PbJzGC415SSH48pWK+9c0efNme5li4Tqs8Hm2Y4EcBTWcq
h9EuQPL0Cd0p/Zd8pXzihlqlX1i0FevsKf/IpD7icJbaVrQxYZTQhIhDV3dUocqC
dW+BqTB4hL/iS6pTm+LEd0+e7i0D8T7noLEI5Z7y6WB9R1NLmfa5RnVBeD40pHRW
Khqz1Az8TieXASGur1GvaAtCBE5CQt5pUahOw5KAHodl57tsGHzW/6Hz5J+f2GOI
duKM1KEZ0vP5Yz/NGhHDoL278smJmhwCMr4T/VC7xlaTyRQCexME55hWQiTti3C9
v1LfWK5/Is04bUslqjQOL0CkuhXz9+Ql6SW9dcR8OPUbQRz0IyEvVKNLxc7YFqsM
m4TBJpfW9BrYc/w9u5VgXto6EY6t1bFr+CjdV3svfQWi+fhvKgZl5F/ed4MkBY8y
6P2cbsmh3Y8bWCJuM9tJD3E+e5WKclI2OpzzzmaA31ky5tDt250CCGcn7TpJHd5M
L6Rgt9Evdw2MpEKuDSzJFn9zYy3aI99Zs/S58Sg9AxKAcbw+qcLAfF9yJpxz1chb
xLE8YowvlvKMRK6DMjnO3skhvc5RNVFjes8+qfPoVY8oPuha/ygcMn9GPX3aNr0v
EWHercIjwlhZz9NrApIN1Lm9+ok/SDLVTsy4bah6XAuz97QQEH4=
=RlLD
-----END PGP SIGNATURE-----

--Sig_/3N3tICVyMiJ8mX7TlQQ=.7+--
