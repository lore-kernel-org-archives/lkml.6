Return-Path: <broonie@sirena.org.uk>
X-Google-Smtp-Source: AB8JxZqLiEbPp4iIjVchEzPr2Aj7LA9Ya3iuNTO9/U2XflR5kDsgcCnf67na0uTiuZJ0p9Fd5Q9K
ARC-Seal: i=1; a=rsa-sha256; t=1525853640; cv=none;
        d=google.com; s=arc-20160816;
        b=SYHa0otvjFn0v2MX25htfk/q3RJk4X5r7ktIsx61bXs7q6FMhOvlK4Ksu1hEmrFQiC
         xJGtt41N5ACRN0X+HSqdYgkun7u4AmotIVzhTYb0efEr7DDBzRjKv+rNzofGZSrHfrPL
         qFSoqSPGTNwnY2vzsSX0N4Hgw8yfcJX/eL2NtfIwhLRFz60FX458JwJkMDTLK93Mk9xo
         PIRThu1djiyR48JlP8XAGHveUnkVOxzN9duF2QGkc9rFLHbIb9bj1e/iM0TPOGzW8iUa
         ROBcE3af9zCPZSt6K4vqpKJ7uMb/9gXEC15SzeIszy13eAduKebrHHsGD9HjVbHDJXqK
         i41g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=MJTc9DWwZFIzVIHMrBkyBE6mX3k7NXRPRfpbi19R/go=;
        b=OHpSjrZiT1TDno8Bu0pzsA3OIhRNDNgCfwXdsZQnxCN/OZFML6XioedmjgCKOn9lpb
         mP2Nk4X+2QnumXT7WEQUFodDShKT7p6DyHoIiUbeLFBFyU2Kutb4oe1HOppHKINXKaRd
         JnBpM8ElMtbMi+NZrjsVaEcTCekgeu/CKvf710pfWHZ49uAM2sUlRPSCmvpGhPFmnK8n
         ZB7GcQr/Z3eZga2Aa3waugcM/XGDd2fmf3pcPZvtxldsK8BKz1I+80snQOCW9lRlFlwf
         sLHjeB6O6gKZqzfRQkGwm/wkdf5gRlNC8RShKreQtONTBlc7KfHKFpnjDEyzgkoaIfMY
         tRuw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@sirena.org.uk header.s=20170815-heliosphere header.b=g9LKSuKF;
       spf=pass (google.com: domain of broonie@sirena.org.uk designates 2a01:7e01::f03c:91ff:fed4:a3b6 as permitted sender) smtp.mailfrom=broonie@sirena.org.uk;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@sirena.org.uk header.s=20170815-heliosphere header.b=g9LKSuKF;
       spf=pass (google.com: domain of broonie@sirena.org.uk designates 2a01:7e01::f03c:91ff:fed4:a3b6 as permitted sender) smtp.mailfrom=broonie@sirena.org.uk;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=kernel.org
Date: Wed, 9 May 2018 17:13:49 +0900
From: Mark Brown <broonie@kernel.org>
To: Tony Lindgren <tony@atomide.com>
Cc: "Theodore Y. Ts'o" <tytso@mit.edu>,
	Sasha Levin <Alexander.Levin@microsoft.com>,
	Greg KH <gregkh@linuxfoundation.org>, "w@1wt.eu" <w@1wt.eu>,
	"ksummit-discuss@lists.linuxfoundation.org" <ksummit-discuss@lists.linuxfoundation.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [Ksummit-discuss] bug-introducing patches
Message-ID: <20180509081349.GN13402@sirena.org.uk>
References: <CAKMK7uHjA27K8y-kwYFyhLy3cSkJJw8Oe1gP=3hZXdfxcWAcNQ@mail.gmail.com>
 <20180502194632.GB18390@sasha-vm>
 <20180503020550.GP2714@sirena.org.uk>
 <20180503031000.GC29205@thunk.org>
 <0276fcda-0385-8f22-dbdb-e063f7ed8bbe@roeck-us.net>
 <20180503224217.GR2714@sirena.org.uk>
 <20180503230905.GA98604@atomide.com>
 <20180508023439.GA8514@sasha-vm>
 <20180508034820.GE999@thunk.org>
 <20180508144958.GU98604@atomide.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="GoZzJvFfKjxI3RhA"
Content-Disposition: inline
In-Reply-To: <20180508144958.GU98604@atomide.com>
X-Cookie: Advancement in position.
User-Agent: Mutt/1.9.5 (2018-04-13)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599280464106480109?=
X-GMAIL-MSGID: =?utf-8?q?1599973506277210031?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


--GoZzJvFfKjxI3RhA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, May 08, 2018 at 07:49:59AM -0700, Tony Lindgren wrote:
> * Theodore Y. Ts'o <tytso@mit.edu> [180508 03:50]:

> > The people who run Linus's tree and test -rc kernels tend to be kernel
> > developers and individual users who want to run bleeding edge kernels
> > and who generally are technically clueful.  If you were talking about
> > SLR cameras, you'd call them the "prosumers" segment of the market.

> Yup that's the category. People tinkering with their devices and
> using bleeding edge kernels because of some new device driver only
> being in thr -rc series for example.

You also get some people who are intending to ship on stable kernels but
are tracking upstream during product development so that they can be on
the most current stable release when they go to production.

--GoZzJvFfKjxI3RhA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlryrboACgkQJNaLcl1U
h9Dc+wf9F0r5XKEnBqY47HacZAQWOE4q7THQOV5bQCpuOCIwff7HNyX1jVBSX/ae
ZQvShjCsxZzoMNK+W3U/89FjBeUF8q/mZwIocoJpcvZUlFdoFzIVQcrsVk9SH5HF
DPdFjDvnu5KuT18T7d3wGobpyOr4w60tO8kzt9XjPIyrfdR9vwoQsLz4rtNVWJle
FoIJXFmKSo41MllAC6pKYbj4iTkX52KyH/2yvxF/a/usMHVIzOOu2FbsttOHTX3P
mYE2LgQgLD3mZvVp+MjYo7wpJ9Qn8Rj2X3xSP8SrPKHe5HtdXEBWNwo5s+lNIcvv
MqKmdK3DO6LEiyUnV2yb+s0riEPvLA==
=W2PF
-----END PGP SIGNATURE-----

--GoZzJvFfKjxI3RhA--
