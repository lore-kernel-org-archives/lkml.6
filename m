Return-Path: <sfr@canb.auug.org.au>
X-Google-Smtp-Source: AB8JxZq5gSPbc6hOgntVXPnJPcFwqBQZ2dZnxSS9u0no0/K8ESisxax/GbJd5BmcvGYbMktiYkXV
ARC-Seal: i=1; a=rsa-sha256; t=1526099892; cv=none;
        d=google.com; s=arc-20160816;
        b=D8qQmToExtTVzdL0fmA0R1PJt+JeHLkJ5Vn3Tq5WPb1QykaD+U6D4m+4N5HwlDvc03
         9NP/k/OQT3xKxB/MWTpI8zRaYwj8npHM+z+QMVwUnDQdUsKVGLnF6w3lmErE9uxeexTv
         tfl9B6/IjoC4FN1E2b850zfkaa9mPGF8xFB5tCGlCOdRP9/4O2mjn+gDi9W4s+rgNn2D
         2LTIPaKiVgwjPbWMRY0WaXXWZW8xLcd3wMIDUOHmetQiVck9oKiJeIE2AOz+LTI+sQ0c
         YDm//O7UlWc+/TNVlUBv3h+H+asppAZDxvN7AfFTqavbK3wnx4s19YkiSHFv5qpRiqVk
         U6Ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:references:in-reply-to:message-id:subject:cc:to:from
         :date:dkim-signature:arc-authentication-results;
        bh=eoStZPITYgC/4JG24UfAV+lnHktjzZxZcQGt15mrVNQ=;
        b=cxR0uwolhnSvLgbKBq5a/vkA4XgYJn0+i+gBLW4B/kzXiIfOC4U+Ux0RAdKPT6PWcx
         Pn0LrrrF91j/RC18no1XQ3zwogAxOx7r0rUNAffxCm8haiwFRcnvTYV0vfXK3RuFPqRp
         SGTv37gTA0Z+rP1xah1r9UsjI+Scth1yozqtXboqfd8/CLpRHv6D5zPa7n7HtGzqV8Co
         HrBGQySVk+D7mltC7n5WI+qpqKOn2iyJJjKiqkiJsdMcrkmssXhXodfpaXMjvs48oO5m
         xdXXTkrZl7sXEwBZOeP0KmA7o1Je9exOb01yrFr7D5qJ98q5x1e7ZjtUTVdT/tQ0u8bJ
         yojQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@canb.auug.org.au header.s=201702 header.b=aggkQTbW;
       spf=pass (google.com: domain of sfr@canb.auug.org.au designates 203.11.71.1 as permitted sender) smtp.mailfrom=sfr@canb.auug.org.au
Authentication-Results: mx.google.com;
       dkim=pass header.i=@canb.auug.org.au header.s=201702 header.b=aggkQTbW;
       spf=pass (google.com: domain of sfr@canb.auug.org.au designates 203.11.71.1 as permitted sender) smtp.mailfrom=sfr@canb.auug.org.au
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Date: Sat, 12 May 2018 14:38:09 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Mark Brown <broonie@kernel.org>
Cc: "w@1wt.eu" <w@1wt.eu>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "ksummit-discuss@lists.linuxfoundation.org"
 <ksummit-discuss@lists.linuxfoundation.org>, Greg KH
 <gregkh@linuxfoundation.org>, Sasha Levin <Alexander.Levin@microsoft.com>
Subject: Re: [Ksummit-discuss] bug-introducing patches
Message-ID: <20180512143809.7c6a06ab@canb.auug.org.au>
In-Reply-To: <20180509204727.7ff38021@canb.auug.org.au>
References: <CAKMK7uHjA27K8y-kwYFyhLy3cSkJJw8Oe1gP=3hZXdfxcWAcNQ@mail.gmail.com>
	<20180502194632.GB18390@sasha-vm>
	<20180503020550.GP2714@sirena.org.uk>
	<20180503031000.GC29205@thunk.org>
	<0276fcda-0385-8f22-dbdb-e063f7ed8bbe@roeck-us.net>
	<20180503224217.GR2714@sirena.org.uk>
	<20180503230905.GA98604@atomide.com>
	<CAPDyKFrCKkRHwOh-7yfFbvMp+Ykhs7oXrDwhTShSPvUBvpn2ZQ@mail.gmail.com>
	<20180509084440.GW13402@sirena.org.uk>
	<CAKMK7uEWYmhA3owSeYM9tNA0tpMm5=4Yqda2j=VfMWi7i8ya8w@mail.gmail.com>
	<20180509090346.GY13402@sirena.org.uk>
	<20180509204727.7ff38021@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/O5P0jPeC4Hosbv4l.vGTlyZ"; protocol="application/pgp-signature"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcSW1wb3J0YW50Ig==?=
X-GMAIL-THRID: =?utf-8?q?1600003109861123526?=
X-GMAIL-MSGID: =?utf-8?q?1600231720608994817?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

--Sig_/O5P0jPeC4Hosbv4l.vGTlyZ
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Wed, 9 May 2018 20:47:27 +1000 Stephen Rothwell <sfr@canb.auug.org.au> w=
rote:
>
> On Wed, 9 May 2018 18:03:46 +0900 Mark Brown <broonie@kernel.org> wrote:
> >
> > On Wed, May 09, 2018 at 10:47:57AM +0200, Daniel Vetter wrote: =20
> > > On Wed, May 9, 2018 at 10:44 AM, Mark Brown <broonie@kernel.org> wrot=
e:   =20
> >  =20
> > > > I think this is an excellent idea, copying in Stephen for his input.
> > > > I'm currently on holiday but unless someone convinces me it's a ter=
rible
> > > > idea I'm willing to at least give it a go on a trial basis once I'm=
 back
> > > > home.   =20
> >  =20
> > > Since Stephen merges all -fixes branches first, before merging all the
> > > -next branches, he already generates that as part of linux-next. All
> > > he'd need to do is push that intermediate state out to some
> > > linux-fixes branch for consumption by test bots. =20
>=20
> Good idea ... I will see what I can do.

See my announcement of a pending-fixes branch in linux-next (on LKML
and others)

> I currently have 44 such fixes branches.  More welcome!

We are up to 55.

--=20
Cheers,
Stephen Rothwell

--Sig_/O5P0jPeC4Hosbv4l.vGTlyZ
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlr2b7EACgkQAVBC80lX
0GwlAAf6AuLkjRWau++c+HEK5ajPABMF71HxJgYkDErFfb0m53fS8dv54ki5M4a+
m7E5owJkRurUQ3T2uXsLhr1sr26EsUv522RicG8S3jpqXwlIMLNYzdBJVB+FpPx+
1d4DokeqwSMpsErTPDu1PGOSBbgolsNsThJX7FTF2mxR7zIwhowAQFGjTzOKnjQ7
Wt7dwRPG5NU+vVH0LgsjwqStiH9zm0L8Mrzat1XQPfxT9h8Xr5vPpBmN11/VeuvW
/8cy1TZh+jdGa6kl63IfjwRScwhAIxWzeO51KdsrH6eJ5TyElRbF9oCPyxzuH/i5
b2lNmH9JwgoN5TbTyVbP+vqZUYMqTg==
=aneN
-----END PGP SIGNATURE-----

--Sig_/O5P0jPeC4Hosbv4l.vGTlyZ--
