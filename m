Return-Path: <pavel@ucw.cz>
X-Google-Smtp-Source: AIpwx4/Qh0Tq7ux8YErxcdYI+V7e8rtYc0O4fhMdmYiHVwSeESeKhVkbr6OiRQj9NIR6zQ6c6pjM
ARC-Seal: i=1; a=rsa-sha256; t=1524168837; cv=none;
        d=google.com; s=arc-20160816;
        b=LmJbt7sA9IPcfexaZye0kPTf/O2jHw1KQArv2oFpgFSUIAQVXrScU1MfpzLNYGp/bU
         jTh7qGDLw0hda0/i2Fqk8o5ZbiRVaUOBj1NY0fSzwbd5UOsh8EoOB/+oPHFCoVY427lg
         rFoaVg66xA7oC/lDQqOi0iWnkfDlSXEOK9bg1JPz13RYFUKTNY+VggJsU9YV5MXRyWyB
         MjHi0+v9CsKyw9Q0oJ2wkpAYHlvL5JpMcSgS8h4gw+e0nY0f0z8ANV1QMW5QQ6gL5Uu3
         Hk+5Y/p3XSyMs5mYz5mTc/aSmp9S6YtvR74udO0oMch7g9J8C43T0kFDX3R9Y+hH7MMN
         s10A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=zR2bqg3zM/RK30ITJ0MloKFdIF6gxbMOzfyz5fLy8Cw=;
        b=XkJGJxcAZn04DzG5euGPgD3SL3GBTjfZnAqq1zdl5nGbnPpKSxzeFQ9NI7kQjIJVof
         kaPrjrwTssN4MURgJLvCeyoHea2ep5RB9CfGY5pbdKritSjiDbCkLVh9uMcIapGIV+cU
         elN+j1LlavUmSLvi8VZKspu2aDs3IdXUVbSSamPHJ6bk8U1nBPF2pGu5uHq8DYD9Xp9L
         N5DsDuyj47vddv5NqIhTwC/DVn7352/LGkxXooKpk5MrOyFG6CrqBOO27vfyNWuktUh7
         60JV9/DQ7WSDn4CWr7zRXpRQA9KZbujfIbilfvlbM5KNescJyUmM7I3HXQ8KSwrnJ29a
         6J9A==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 195.113.26.193 is neither permitted nor denied by best guess record for domain of pavel@ucw.cz) smtp.mailfrom=pavel@ucw.cz
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 195.113.26.193 is neither permitted nor denied by best guess record for domain of pavel@ucw.cz) smtp.mailfrom=pavel@ucw.cz
Date: Thu, 19 Apr 2018 22:13:56 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Mark Brown <broonie@kernel.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
	"Rafael J . Wysocki" <rjw@rjwysocki.net>,
	Len Brown <len.brown@intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Marek Vasut <marek.vasut+renesas@gmail.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Linux PM list <linux-pm@vger.kernel.org>,
	Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH/RFC 0/2] regulator: bd9571mwv: Add support for toggle
 power switches
Message-ID: <20180419201356.GC25034@amd>
References: <1521026785-26456-1-git-send-email-geert+renesas@glider.be>
 <CAMuHMdXyWs1v_D4EUd-H75Q3cpQv6yD2V_MptjJP7FjYhu5c3g@mail.gmail.com>
 <20180418140041.GD10061@sirena.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Clx92ZfkiYIKRjnr"
Content-Disposition: inline
In-Reply-To: <20180418140041.GD10061@sirena.org.uk>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594912189945282587?=
X-GMAIL-MSGID: =?utf-8?q?1598206862979433121?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


--Clx92ZfkiYIKRjnr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed 2018-04-18 15:00:41, Mark Brown wrote:
> On Wed, Apr 18, 2018 at 03:29:36PM +0200, Geert Uytterhoeven wrote:
>=20
> > Any comments/suggestions?
>=20
> > In case you lost the patches from the thread:
> > https://www.spinics.net/lists/linux-renesas-soc/msg24955.html
>=20
> Please don't send content free pings and please allow a reasonable time
> for review.  People get busy, go on holiday, attend conferences and so=20
> on so unless there is some reason for urgency (like critical bug fixes)
> please allow at least a couple of weeks for review.  If there have been
> review comments then people may be waiting for those to be

If I follow the logs right, there was one month before ping. That
seems pretty reasonable time.

> Sending content free pings adds to the mail volume (if they are seen at
> all) which is often the problem and since they can't be reviewed

Yep, and sending content free complains about pings also adds to the
main volume :-(.

Anyway, last time I sent you a patch... you _had_ time to complain
that I'm pinging too often, but you apparently did not have time to
look at the patch. That patch would have been in time for v4.16-rc1
IIRC.

									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--Clx92ZfkiYIKRjnr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlrY+IQACgkQMOfwapXb+vLzqgCeL7ZTf7fKhjiIrRwjNAwROwiz
kdsAni5RaYPZ16cP2+bhWpf5juj0RsL5
=aa5D
-----END PGP SIGNATURE-----

--Clx92ZfkiYIKRjnr--
