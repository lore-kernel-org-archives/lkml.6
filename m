Return-Path: <broonie@sirena.org.uk>
X-Google-Smtp-Source: AIpwx49eqvEuIk3ynb+tW4e8NSqiNRsFfZZ0Kz0G3Janft6wFCuEe1dzk1Q2KBl5OD9tzBpTwvyg
ARC-Seal: i=1; a=rsa-sha256; t=1524060051; cv=none;
        d=google.com; s=arc-20160816;
        b=YL1RfpphxRrr8Cs7UuIpnv/TGwLMS+ZCHCuKEJoNRt8PM2L3mo2FdwFm7h8uHBz2DO
         ifIRgLF9AHBceY2ipniBdffBbtfgD80mBlnJrZoyjd9DuI0jv6459ShZtRSgDgj7aoDY
         oy+5WRAahINOnrtjkVvThinW9dqImIOs6JhwJFs2AXQ8fZo6zQk+ItsLB7eUgZRNXuV1
         xBFXJlYPeBN6DfYMWPoDs/oPp4gnyWY9+iyUo7r/ZHljq7Ytbb0D9CniZ2rjoRudzeY2
         a+a4TL3NO0c5UQrcTB0ebnFIWxYOqtuvTtlcBEQRFjc+BCo1c1I4qm5koYWmwX4VGII8
         TYcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=EYPByxSrWiJpX6wPiv6WNi5XMCle679VIzzTj9GK6ms=;
        b=sPNDZlq5CHPAEVHzCYkg+QkB9GCdBqfDWjIvowyzzag7YjmV4OZNKO/lygYSatNcUW
         dY5dkpoKC/gGLqch8mufaJZVnMNPGPX2ORwZPTRkYh03c/AFEFp8Im51AO5jAYfeTM01
         LD2PDKqawlgvvRZSip+nlbHcxeb8jBo51ETdYVL7V48lrPZ2Olq4GVTPvr4aCi51ygKd
         u2iDKn6cqoeWusxCrO1Gyqahkfusurge36Qfd76BbLMAjTGIFJ+4eQ5lHiBhCO/LJUVe
         BuQYobF5bJeyFw8MPzEPl4onPzIPPCoj3fX6boj1vFiaS4NHvNwHyFHUOs5ObGlGDdI/
         tj4A==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@sirena.org.uk header.s=20170815-heliosphere header.b=KY52i07e;
       spf=pass (google.com: domain of broonie@sirena.org.uk designates 2a01:7e01::f03c:91ff:fed4:a3b6 as permitted sender) smtp.mailfrom=broonie@sirena.org.uk
Authentication-Results: mx.google.com;
       dkim=pass header.i=@sirena.org.uk header.s=20170815-heliosphere header.b=KY52i07e;
       spf=pass (google.com: domain of broonie@sirena.org.uk designates 2a01:7e01::f03c:91ff:fed4:a3b6 as permitted sender) smtp.mailfrom=broonie@sirena.org.uk
Date: Wed, 18 Apr 2018 15:00:41 +0100
From: Mark Brown <broonie@kernel.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Pavel Machek <pavel@ucw.cz>,
	Len Brown <len.brown@intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Marek Vasut <marek.vasut+renesas@gmail.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Linux PM list <linux-pm@vger.kernel.org>,
	Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH/RFC 0/2] regulator: bd9571mwv: Add support for toggle
 power switches
Message-ID: <20180418140041.GD10061@sirena.org.uk>
References: <1521026785-26456-1-git-send-email-geert+renesas@glider.be>
 <CAMuHMdXyWs1v_D4EUd-H75Q3cpQv6yD2V_MptjJP7FjYhu5c3g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="d01dLTUuW90fS44H"
Content-Disposition: inline
In-Reply-To: <CAMuHMdXyWs1v_D4EUd-H75Q3cpQv6yD2V_MptjJP7FjYhu5c3g@mail.gmail.com>
X-Cookie: Sank heaven for leetle curls.
User-Agent: Mutt/1.9.4 (2018-02-28)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594912189945282587?=
X-GMAIL-MSGID: =?utf-8?q?1598092792840028547?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


--d01dLTUuW90fS44H
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 18, 2018 at 03:29:36PM +0200, Geert Uytterhoeven wrote:

> Any comments/suggestions?

> In case you lost the patches from the thread:
> https://www.spinics.net/lists/linux-renesas-soc/msg24955.html

Please don't send content free pings and please allow a reasonable time
for review.  People get busy, go on holiday, attend conferences and so=20
on so unless there is some reason for urgency (like critical bug fixes)
please allow at least a couple of weeks for review.  If there have been
review comments then people may be waiting for those to be addressed.

Sending content free pings adds to the mail volume (if they are seen at
all) which is often the problem and since they can't be reviewed
directly if something has gone wrong you'll have to resend the patches
anyway, though there are some other maintainers who like them - if in
doubt look at how patches for the subsystem are normally handled.

--d01dLTUuW90fS44H
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlrXT4gACgkQJNaLcl1U
h9BGRgf/UK0584WhI/uF11UE360O9nzjxeZ0V49GOZeeNGdDKuEocD8E0WDJyjsC
7fS3e1O65HWrpo41ZwNKxPrlZJjjXLkpKc6K48RYKqSnJXHvrFFDkUXQcRDDfTl5
yJmxcpR08MUNvktu/Hnok7dMMN4G5p91uYEQX9PzNQriUkHLNAS/OXYlTQV+Ilig
Cls2T6V0KUSZeSRKyvyEaBrQWQ6BSHSXeGozmyCpZtgzhjW966HVvlEBOzHaaldd
vyeU+LWpKR1n8S0SPIeEJyXKzC/c3QNiof2p1G2DpHL5TbjdObm8cItiR1257lbC
ZP/hE90KJKrHZs7L5GM0LkJM2Pf5iw==
=GAQa
-----END PGP SIGNATURE-----

--d01dLTUuW90fS44H--
