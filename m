Return-Path: <broonie@sirena.org.uk>
X-Google-Smtp-Source: AB8JxZon4JvYBq/NKkWn2DB8CRKJL2ejwcDlrRvHNeLV24O038I7Sj21sYpui4D5LygfRAjRrEX8
ARC-Seal: i=1; a=rsa-sha256; t=1526004629; cv=none;
        d=google.com; s=arc-20160816;
        b=AX/S8lV4UxwTE9o54FGhLpV7Mg1ySRYCCm0YLcrx/UBwC0VCxwv7+yt/m5ckcO8S3F
         kTTGiIhAFD7ryYTKD01kOPgGrL2sat0S03daq3uWJl7WVwigOwXrt5Us4w4H+qBJVBC2
         q1sfYePi2EZIxH4ZUhz3O8DG0/wQu2MBdokmQyHwk5uLg3eHfTdnzjbFb+M+atpgxU1d
         zufqx4YDThmtoy7KutxdWBkwPMQUS9CAtb3gVnLmpMdE3ycg5y9AWKfbMM3mNsBMWxkS
         1pC3EV/wKHSmprzwMsx7b8WLGg4BDon+/0vGqO/5U3YjRDhlD4CjSmkf7c993ixigxS+
         n4BQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=j8YfIasyGJvvehmDEPqdbN+bez+gAVGRm6v/YPG/nOo=;
        b=ntJx0hLqwQb9g+nX5Pb42Jz8iBPJhmr4OcF0LDHBw+Ox5M8+eXkl2rexsGFDHTWqjX
         +Ma0pcJCE6rcotp5C/lo02OhyD3EkGQVW0l0oRncqtd19mS7ITL7zIO49jMhiHSs+zu+
         JLRqKwYCb7GnZe/ouFJsGuB8dVMkc0pVPIJM4XEzyunAFswLoaOtY9o+pL1BT71y2ew5
         ceNdr/v79rrQF3Dv9+zcScgPyyWBhL2fscCtPsxm4uKDs62P/cjq3S+3ukhIMPGyebZ/
         Xis1ZBVqeDNZiJ4lpmJiUijeINMkK2n8yynU+vmB7V/QVu8P8xiuN4OZuLw32yyMVuWz
         8qkA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@sirena.org.uk header.s=20170815-heliosphere header.b=ioyZI7Mx;
       spf=pass (google.com: domain of broonie@sirena.org.uk designates 2a01:7e01::f03c:91ff:fed4:a3b6 as permitted sender) smtp.mailfrom=broonie@sirena.org.uk;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@sirena.org.uk header.s=20170815-heliosphere header.b=ioyZI7Mx;
       spf=pass (google.com: domain of broonie@sirena.org.uk designates 2a01:7e01::f03c:91ff:fed4:a3b6 as permitted sender) smtp.mailfrom=broonie@sirena.org.uk;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=kernel.org
Date: Fri, 11 May 2018 11:10:18 +0900
From: Mark Brown <broonie@kernel.org>
To: Jiri Kosina <jikos@kernel.org>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>,
	Greg KH <gregkh@linuxfoundation.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"ksummit-discuss@lists.linuxfoundation.org" <ksummit-discuss@lists.linuxfoundation.org>,
	"w@1wt.eu" <w@1wt.eu>
Subject: Re: [Ksummit-discuss] bug-introducing patches
Message-ID: <20180511021018.GE949@sirena.org.uk>
References: <20180502194632.GB18390@sasha-vm>
 <20180503020550.GP2714@sirena.org.uk>
 <20180503031000.GC29205@thunk.org>
 <0276fcda-0385-8f22-dbdb-e063f7ed8bbe@roeck-us.net>
 <20180503224217.GR2714@sirena.org.uk>
 <20180503230905.GA98604@atomide.com>
 <CAPDyKFrCKkRHwOh-7yfFbvMp+Ykhs7oXrDwhTShSPvUBvpn2ZQ@mail.gmail.com>
 <20180509084440.GW13402@sirena.org.uk>
 <CAKMK7uEWYmhA3owSeYM9tNA0tpMm5=4Yqda2j=VfMWi7i8ya8w@mail.gmail.com>
 <nycvar.YFH.7.76.1805101802150.27054@cbobk.fhfr.pm>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="G6nVm6DDWH/FONJq"
Content-Disposition: inline
In-Reply-To: <nycvar.YFH.7.76.1805101802150.27054@cbobk.fhfr.pm>
X-Cookie: Falling rock.
User-Agent: Mutt/1.9.5 (2018-04-13)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcSW1wb3J0YW50Ig==?=
X-GMAIL-THRID: =?utf-8?q?1600003109861123526?=
X-GMAIL-MSGID: =?utf-8?q?1600131830543867134?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


--G6nVm6DDWH/FONJq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 10, 2018 at 06:03:22PM +0200, Jiri Kosina wrote:
> On Wed, 9 May 2018, Daniel Vetter wrote:

> > Since Stephen merges all -fixes branches first, before merging all the
> > -next branches, he already generates that as part of linux-next. All
> > he'd need to do is push that intermediate state out to some
> > linux-fixes branch for consumption by test bots.

> What I do for my trees is that I actually merge the '-fixes' branch (that=
=20
> is scheduled to go to Linus in the 'current' cycle) into my for-next=20
> branch as well.

> This has the advantage of (a) getting all the coverage linux-next does (b=
)=20
> seeing any potential merge conflicts early

> Is this not feasible for other trees?

That's obviously best practice which I hope everyone who doesn't have a
separate fix branch in -next is doing but it means that the fixes branch
is not getting tested without the changes in your -next branch, and also
reduces the coverage separate to other people's -next branches.  This
means that there's room for implicit dependencies to slip through.

--G6nVm6DDWH/FONJq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlr0+4oACgkQJNaLcl1U
h9AgNgf/bAT4jhMrJUeKLkhow6ag+iOj8415TKB+/4p5WdMsxL3NTK1+I2+yyL6s
FQ4pCIgT0MY29Gkxj778/kCcY1pZVsqp2RlGKELU9GTNY2FpblWnXoUoocibcbwO
s/fQhbkpHpkz5vDTa86rHaD5KgtY5GhYh1SW0N5P6zxm2K0PtKcVW6Z+tJlx46mG
XaRSJIKtzOQmKpXqWMP0cBGQlk7k7tQdH0Twxhj8IjVTvoBSbY0eo/z+S27j2TyS
hWH/Y3FRGqOVcbvfFA2G0jPHBGRlsV9N0JESO8JU1baMMoExvwZobDHHg0Xq0KF+
1VN+C1lVyWhFJrMPdpJL7A67nOnI3w==
=4Usi
-----END PGP SIGNATURE-----

--G6nVm6DDWH/FONJq--
