Return-Path: <broonie@sirena.org.uk>
X-Google-Smtp-Source: AB8JxZpompNUuS+nKM/KW8OUjDAYKq+y2T6/PZV/bPao6BkHCleE2JN4Tq0GixEmTcSDix5umwUC
ARC-Seal: i=1; a=rsa-sha256; t=1525874744; cv=none;
        d=google.com; s=arc-20160816;
        b=NA3Q6GJKvONeQU66vuTUsV5eS89fh3NLgtiZ/xVWx+Z7/JDpPDlo7casaRxF/EycNn
         LNgXadU4qK06omThMwqIUvA3ZY7qIiJoLdJ/C+XwgscAanfssfP2gJbwqVTFWGY+ceYJ
         xfHTtSylUhFo0hfF0rNt18zVqhZ9hGoEE8YRhZiE0XTVN5RVRxMz/0IJTgzwn8qjWbmM
         m2HV4rUqd1CZbJrSbpuXFkhfyY1w+Lm+sGyANVbOEVavoBmNiZATB0l1r+O6JnvQI97b
         xAtI6CjilF3cxu1i8i6XLKzXlTRVoq11aZuDESQXMHRPcY9SSbeVRGmeHyUno1TZ7hri
         xbOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=2EGiDnpr4Ck6rTdu88pZD2FSpG1OXgTF8mcPqUF+7YE=;
        b=G0L+7Dqp15Xj1ps7bKLw4UlmRDKkj+2LxAl0oFGXtUQstX5jmGXGLhDakGxJvsPpLl
         ccerzbhnVkm1yQtYQ4UwhWUWZ3bzsPIE83PsWB1MHWmMFSvab6YICqRCKgw/74XBV38p
         CRvldf3Ox/x2LAlpXBvRgXT53qhsvmAEvZPxRDJ31+Hp5IPBHfpGT6E54ATAea6WqJCj
         XHMDHduuz0lkXr7Rgsg+YK7hlMY2MvtyBf4pD7BbQMDC4vxZQfGmksHMbnoGjhUDAz7I
         RsoxMFFDquD5QCnXh20tuNfAohaPbfsCUfnZIPDPPA7gjXdNDp037SJmr5VyuW0bIzfW
         MZXg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@sirena.org.uk header.s=20170815-heliosphere header.b=JqfN8xPA;
       spf=pass (google.com: domain of broonie@sirena.org.uk designates 2a01:7e01::f03c:91ff:fed4:a3b6 as permitted sender) smtp.mailfrom=broonie@sirena.org.uk;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@sirena.org.uk header.s=20170815-heliosphere header.b=JqfN8xPA;
       spf=pass (google.com: domain of broonie@sirena.org.uk designates 2a01:7e01::f03c:91ff:fed4:a3b6 as permitted sender) smtp.mailfrom=broonie@sirena.org.uk;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=kernel.org
Date: Wed, 9 May 2018 23:05:32 +0900
From: Mark Brown <broonie@kernel.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>,
	Greg KH <gregkh@linuxfoundation.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"ksummit-discuss@lists.linuxfoundation.org" <ksummit-discuss@lists.linuxfoundation.org>,
	"w@1wt.eu" <w@1wt.eu>
Subject: Re: [Ksummit-discuss] bug-introducing patches
Message-ID: <20180509140532.GA949@sirena.org.uk>
References: <20180503020550.GP2714@sirena.org.uk>
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
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="qMm9M+Fa2AknHoGS"
Content-Disposition: inline
In-Reply-To: <20180509204727.7ff38021@canb.auug.org.au>
X-Cookie: Falling rock.
User-Agent: Mutt/1.9.5 (2018-04-13)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599280464106480109?=
X-GMAIL-MSGID: =?utf-8?q?1599995636194938483?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


--qMm9M+Fa2AknHoGS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 09, 2018 at 08:47:27PM +1000, Stephen Rothwell wrote:
> On Wed, 9 May 2018 18:03:46 +0900 Mark Brown <broonie@kernel.org> wrote:
> > On Wed, May 09, 2018 at 10:47:57AM +0200, Daniel Vetter wrote:
> > > On Wed, May 9, 2018 at 10:44 AM, Mark Brown <broonie@kernel.org> wrot=
e: =20

> > True.  It's currently only those -fixes branches that people have asked
> > him to merge separately which isn't as big a proportion of trees as have
> > them (perhaps fortunately given people's enthusiasm for fixes branches
> > that don't merge cleanly with their development branches) so we'd also
> > need to encourage people to add them separately.

> I currently have 44 such fixes branches.  More welcome!

Well, all my trees have a for-linus branch to go with the for-next
branch for a start.

--qMm9M+Fa2AknHoGS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlrzACsACgkQJNaLcl1U
h9AM4wf9HbaLz7zmjo8UU2Cxru60+sQAhl40X7n283AXOvOUB+4pWhjY80f+BYtU
L0RMovyujHyA75df9rlVPDAeIz2aGRVGJMED77szUhHm3N5XB5SdAkrH4e2CyO4n
gO3+8Y0lXiMnZqPupnQrFx6vrgNWeeAu9+c+znKIo9GKfsrXrOmC6EexzAT4dg7y
7qzgdF1DdNt/9GSSoWEcrVoTrGdZCGlN0PAU01NQOZUgm0VCiGJey+vCYETGUeVt
Ka6yW/BWCXb2XYWtiG/a996hoXqlslBesZRkcMVuXq2KA5gLG0wZIQuZSMvqJDNR
5mkBGlF+kj82fUXeu2PAKjctGaz5kA==
=Wsaq
-----END PGP SIGNATURE-----

--qMm9M+Fa2AknHoGS--
