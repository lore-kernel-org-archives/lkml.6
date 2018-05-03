Return-Path: <broonie@sirena.org.uk>
X-Google-Smtp-Source: AB8JxZp/Iao65YiW6Qyu2vsURdJrEJFpeSLOAT6CMLWNxu8ObmDmi7nV7aI7K9zcw6MnivK8s3Df
ARC-Seal: i=1; a=rsa-sha256; t=1525387346; cv=none;
        d=google.com; s=arc-20160816;
        b=NAKTctBQEE76MEL6nf4jZ+24PgFOsnFImmmdhEhwDztf6iCY12gfEQ4VVF0TlwHUBX
         QDDThwTwo3TAKxI4N3t9fq4RpSbVkgRayismEOmvB9mS7xjJqdEfpbqJ4jGQp1C8OAgW
         WFtRXRpUWAqqBZFZU5OCVv6UZb9bJ6HRXvdlqLt7bivs782Cgy/cAMTGEWCkoCOHl+gM
         +JnHi6ZIGx4yop4IC5RiLsbuVBK0jadB1tVtuhfAxGDjo6tgMzVerA1FgT0Vb6K/kC4w
         Cxy7uvaUa9VcQvrTpA4UkB6YXZ3zPP9zxqN6Narjm7P/pO/vad7BTXXG2paPkMnRrQr1
         raug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=wGzNNaAa535EptxAS77Dhri5cctey0OEu3hvwWBNyuA=;
        b=NzX1swnsCZuYcsHdfrjxXJ3sdXDOG12refg82titRKUeyOlmsyw9iRBRc28LwzZ9fj
         2ZGUWdYgVxRMTdakJQWuGN6F4YHKyzhJMQ3CYLHFDOm+doya6RU6ZmtOXyNzcnH8rAxa
         TBIVpOlMebzG96nCJoyNbpWYn6YqZtVG9OMFGoL2xUCjKmkOVayTlXNATsEBTtGd++aC
         wg9eDLfRWFaX+XRw6/kozP88iDzK7OC4BpngqXyqgmZk4V7m+bZOMp+3YCz0BouZQh+6
         oXZrR+pt6rOYGJSptKlrc6x8pU3gUnL4IPoKM1fq+sfr9Bsq+RxJGBsYZQYX+23tts7w
         62ag==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@sirena.org.uk header.s=20170815-heliosphere header.b=XNjYx8yw;
       spf=pass (google.com: domain of broonie@sirena.org.uk designates 2a01:7e01::f03c:91ff:fed4:a3b6 as permitted sender) smtp.mailfrom=broonie@sirena.org.uk;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@sirena.org.uk header.s=20170815-heliosphere header.b=XNjYx8yw;
       spf=pass (google.com: domain of broonie@sirena.org.uk designates 2a01:7e01::f03c:91ff:fed4:a3b6 as permitted sender) smtp.mailfrom=broonie@sirena.org.uk;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=kernel.org
Date: Fri, 4 May 2018 07:42:17 +0900
From: Mark Brown <broonie@kernel.org>
To: Guenter Roeck <linux@roeck-us.net>
Cc: "Theodore Y. Ts'o" <tytso@mit.edu>,
	Sasha Levin <Alexander.Levin@microsoft.com>,
	Daniel Vetter <daniel.vetter@ffwll.ch>,
	"ksummit-discuss@lists.linuxfoundation.org" <ksummit-discuss@lists.linuxfoundation.org>,
	Greg KH <gregkh@linuxfoundation.org>, "w@1wt.eu" <w@1wt.eu>,
	"julia.lawall@lip6.fr" <julia.lawall@lip6.fr>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [Ksummit-discuss] bug-introducing patches
Message-ID: <20180503224217.GR2714@sirena.org.uk>
References: <20180501163818.GD1468@sasha-vm>
 <20180501194450.GD10479@thunk.org>
 <20180501200019.GA7397@sasha-vm>
 <20180501205448.GE10479@thunk.org>
 <20180501211551.GI2714@sirena.org.uk>
 <CAKMK7uHjA27K8y-kwYFyhLy3cSkJJw8Oe1gP=3hZXdfxcWAcNQ@mail.gmail.com>
 <20180502194632.GB18390@sasha-vm>
 <20180503020550.GP2714@sirena.org.uk>
 <20180503031000.GC29205@thunk.org>
 <0276fcda-0385-8f22-dbdb-e063f7ed8bbe@roeck-us.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="soWJpSPh+l8Y6Fy7"
Content-Disposition: inline
In-Reply-To: <0276fcda-0385-8f22-dbdb-e063f7ed8bbe@roeck-us.net>
X-Cookie: Rubber bands have snappy endings!
User-Agent: Mutt/1.9.5 (2018-04-13)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599280464106480109?=
X-GMAIL-MSGID: =?utf-8?q?1599484561887038975?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


--soWJpSPh+l8Y6Fy7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, May 02, 2018 at 08:52:29PM -0700, Guenter Roeck wrote:

> As for -next, me and others stopped reporting bugs in it, because when we do
> we tend to get flamed for the "noise". Is anyone aware (or cares) that mips
> and nds32 images don't build ? Soaking clothes in an empty bathtub won't make
> them wet, and bugs in code which no one builds, much less tests or uses, won't
> be found.

You've been flamed for testing -next?  That's not been my experience and
frankly it's pretty horrifying that it's happening.  Testing is pretty
much the whole point of -next existing in the first place so you have to
wonder why people are putting their trees there if they don't want
testing.  I have seen a few issues with people reporting bugs on old
versions of -next but otherwise...

--soWJpSPh+l8Y6Fy7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlrrkEYACgkQJNaLcl1U
h9D6aAf/aWjbgLYQ25BOZg7Np2lo4EMzezJlcssRLQiCtkGkfdF8gyl/ZOJ2FokB
RPhuUzekpRnqp8uCZi1GjTPPEU5efGBlYbdxISDDU6Rc5zCRqz0w48lq0XJMLiEH
+Vo5MkdxKjTovaZ1/pz7VOk4dgv/cKdgRuKxzsMTX+rRsdzaBxACSIjWL7XCPxy7
17UaZSWkcjmO8AEkJe6oRoXOx7hrvT6SViX/+TQ7wrXzSrkL29n9/CG7MNR0TTUi
EnIB4P/PcZvHDqPMskzgD8Taf0zNGmQGyfGxd4vgC9V3u7RCzayUUQ9OI3jrpASo
tgKZVC1MOdMTB2GpgMekBFkGLEYHNw==
=uYX5
-----END PGP SIGNATURE-----

--soWJpSPh+l8Y6Fy7--
