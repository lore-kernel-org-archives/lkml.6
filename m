Return-Path: <broonie@sirena.org.uk>
X-Google-Smtp-Source: AB8JxZpatdvJgRFf4d/3gPe65niTQyB5rzYlAABhOnNkdDcav+PnKiSX5Hhc52iFKhSXQRlPVneT
ARC-Seal: i=1; a=rsa-sha256; t=1525959404; cv=none;
        d=google.com; s=arc-20160816;
        b=j+vfFHSU3LxgNyFTZp/HHxwetF1dRMiLXL3M0eprxY+rjlxB5PSwov7pd5h4UrJoYd
         RA2+WQ+lLkBkQWNwNizg98352o8P2lOfugAZQdDmaOZgRzdcal5FzquUzzR81F0aDYIw
         k654w5CZ1mLkeN0pdHtBxNx0817pny0tsQKBEYbwqiDSonaOU3Hff2Knj9bdE1FEhSsL
         hCneINjSjCpOw2KiBMxTMgGTpN6TaQl1NUem6w+QMi5J8umAIR6BI09ncXRtfLE4zwdO
         14WDaSlBMq69fsNS7+LTr+i7tD8JsrSoHI8+BTg7oVcRi0UrURZ19lPXr/gbquAMJkRM
         hBMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=vJyCr9OzcTkegqcVGJRON3PU2fIA7j4n9r8AMWGvR/A=;
        b=ix0NT0NqqkwE5hTZgFDaLJQ3OOTFYAZoMtQ/AkW6UOY27OAKjyBmvAdKAHHSnuFuKw
         NMeZ64tl+80IK6Z/YhlkB/tewvaiE2lPXmfhk4dGlsUR2JTDbaCUkTvqj5gzX3u4pH3d
         blRoQ3BYGkazNLe/28X1DYGiRff/5yP+5uGsd9LcuhJ7krkvVSL7d/YQ2qh+PkNkjPLY
         ZDKH1j9LQvo0x96M9T/2OvSOKtHuHKBMrpQhlwxkdcaMukZ32uIkjITeVimofT27WijD
         iitFTxyX739BT8fBGwpuVBhxDvQb9ioDCshU5DYBq0CwtUz/bUN6wZLbh5UUi6CwlXzS
         zlIA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@sirena.org.uk header.s=20170815-heliosphere header.b=C6y202ZR;
       spf=pass (google.com: domain of broonie@sirena.org.uk designates 2a01:7e01::f03c:91ff:fed4:a3b6 as permitted sender) smtp.mailfrom=broonie@sirena.org.uk;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@sirena.org.uk header.s=20170815-heliosphere header.b=C6y202ZR;
       spf=pass (google.com: domain of broonie@sirena.org.uk designates 2a01:7e01::f03c:91ff:fed4:a3b6 as permitted sender) smtp.mailfrom=broonie@sirena.org.uk;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=kernel.org
Date: Thu, 10 May 2018 22:36:28 +0900
From: Mark Brown <broonie@kernel.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>,
	Greg KH <gregkh@linuxfoundation.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"ksummit-discuss@lists.linuxfoundation.org" <ksummit-discuss@lists.linuxfoundation.org>,
	"w@1wt.eu" <w@1wt.eu>, Liam Girdwood <lgirdwood@gmail.com>
Subject: Re: [Ksummit-discuss] bug-introducing patches
Message-ID: <20180510133628.GC949@sirena.org.uk>
References: <0276fcda-0385-8f22-dbdb-e063f7ed8bbe@roeck-us.net>
 <20180503224217.GR2714@sirena.org.uk>
 <20180503230905.GA98604@atomide.com>
 <CAPDyKFrCKkRHwOh-7yfFbvMp+Ykhs7oXrDwhTShSPvUBvpn2ZQ@mail.gmail.com>
 <20180509084440.GW13402@sirena.org.uk>
 <CAKMK7uEWYmhA3owSeYM9tNA0tpMm5=4Yqda2j=VfMWi7i8ya8w@mail.gmail.com>
 <20180509090346.GY13402@sirena.org.uk>
 <20180509204727.7ff38021@canb.auug.org.au>
 <20180509140532.GA949@sirena.org.uk>
 <20180510080909.47c3068b@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="3siQDZowHQqNOShm"
Content-Disposition: inline
In-Reply-To: <20180510080909.47c3068b@canb.auug.org.au>
X-Cookie: Falling rock.
User-Agent: Mutt/1.9.5 (2018-04-13)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcSW1wb3J0YW50Ig==?=
X-GMAIL-THRID: =?utf-8?q?1600003109861123526?=
X-GMAIL-MSGID: =?utf-8?q?1600084408393526655?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


--3siQDZowHQqNOShm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, May 10, 2018 at 08:09:09AM +1000, Stephen Rothwell wrote:
> On Wed, 9 May 2018 23:05:32 +0900 Mark Brown <broonie@kernel.org> wrote:

> > Well, all my trees have a for-linus branch to go with the for-next
> > branch for a start.

> The regmap and regulator trees have no for-linus branch (currently).
> Added sound-asoc-fixes and spi-fixes from today.

That's not what git claims when I try to push...  no idea what's going
on there, I just deleted and repushed - hopefully that helps.

--3siQDZowHQqNOShm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlr0StsACgkQJNaLcl1U
h9Dj6Af6A7R2O0TcCWtDoFPSCYveXPFG4Akuszbhtrx28lTaMIF7BxQcPxnCDD37
pwYt3AIwXkLYwRsmYRnsV9GdF3iY6AGPsmfPJl4P8eRMlKvKGNgE7Lnb0zyqbXil
srPIv6hQ3LO1lKcaIyM65pPexYDb8UBR+gyNd8LrgVP7DQjSg88zE8+R4NkVykv0
KLloURnFuKjBTVPbLWjU1LAraoEVkIuSs8q0j4uNcfGiATjQkLVTvHb0KC2jKMel
YL8Y3ZxE5dBhg/iqcDKLDOcHC9sZRAcrI7TTcLXL1QKDQf6BbitGQfh3uRMxSUSc
vupY7VFThTJyuCCkXq6eWELul7a/AQ==
=sZvA
-----END PGP SIGNATURE-----

--3siQDZowHQqNOShm--
