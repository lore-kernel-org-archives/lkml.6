Return-Path: <broonie@sirena.org.uk>
X-Google-Smtp-Source: AB8JxZoSAm8hJ3zcaUcIQr1OWFTdQ9UpLebPYITZebyRoa05+oYpFq0jxlZjAn4VLP0WPzTRfInb
ARC-Seal: i=1; a=rsa-sha256; t=1526575040; cv=none;
        d=google.com; s=arc-20160816;
        b=juMw6mKhhv+ksDeC4Ze3SHaNS/HKFF6LHYDE8Y4S1Vp4VOcFswbUQhTzlj8L61vdoB
         99OhUZZx152lLIx33tXgfYnTgSAbjccKbdXXnVLGaPVzvzXor/RfngXp4Rw+zCsLPlTR
         JygVtkR7dlOy/XRVOW6YDMeEkoif0wbtM3/8I7am1agLhkFhNXZpjSyaOJ0g8MGezZBF
         9zn4gax/3QIDjZoMTYkD4P/5K3xl401DpG/IXs8NuUE13KWa/vFCra8hBUB4RvV91U5B
         hRJQo6ll/6rZnpB5E2rW/QP2blHT0uJ/zj5ZkmEjzfyOHqzFvcvDK6GvmmBz8yKoafU9
         3RmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=2NSTggbcPxPwwj2dBFSWhBh0L+RAZRYZpxNcQkjzRc8=;
        b=TTf6vB76AQm0+SoeGuYXZv6zR8qvKJMWQLT81H3s7LmjycDQDqhQsG9ojK/PcQxe2C
         W7JTBHw3YKrdd5gJNtW8M3sNs4TQQCfuSyN+nEc56j0zr+SytndU4IsfEgDTMUjDjDHC
         hYaUFSgwmINFaa1wq/BFKFbr1LuSXa7cfQs8rVpAz79LJLaOp6kcDYXmcNCK/IWR8HBU
         fdx5JVwd0IkGRh0KfatDTNJNuUhR58FmoZ1xCGx56h963HctxseAtQgkIbh2DsW+Ap69
         VlqtjCetEhekeNryZ/x0wsJ1yMTfdBUjyxo0hySdYjmCtH/3n3Oa8gTGMLRlUxV2D6aI
         otqw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@sirena.org.uk header.s=20170815-heliosphere header.b=F7Sh0FWe;
       spf=pass (google.com: domain of broonie@sirena.org.uk designates 2a01:7e01::f03c:91ff:fed4:a3b6 as permitted sender) smtp.mailfrom=broonie@sirena.org.uk;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@sirena.org.uk header.s=20170815-heliosphere header.b=F7Sh0FWe;
       spf=pass (google.com: domain of broonie@sirena.org.uk designates 2a01:7e01::f03c:91ff:fed4:a3b6 as permitted sender) smtp.mailfrom=broonie@sirena.org.uk;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=kernel.org
Date: Thu, 17 May 2018 15:16:37 +0900
From: Mark Brown <broonie@kernel.org>
To: "Mukunda,Vijendar" <vijendar.mukunda@amd.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Daniel Kurtz <djkurtz@chromium.org>,
	Akshu Agrawal <akshu.agrawal@amd.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." <alsa-devel@alsa-project.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V2 04/10] ASoC: amd: pte offset related dma driver changes
Message-ID: <20180517061637.GK20254@sirena.org.uk>
References: <1525754888-14124-1-git-send-email-Vijendar.Mukunda@amd.com>
 <1525754888-14124-4-git-send-email-Vijendar.Mukunda@amd.com>
 <c8d87b3b-6f8e-c125-4a8b-f47a6f920eb8@amd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="YQEH9CATo+4lan7A"
Content-Disposition: inline
In-Reply-To: <c8d87b3b-6f8e-c125-4a8b-f47a6f920eb8@amd.com>
X-Cookie: Are you a turtle?
User-Agent: Mutt/1.9.5 (2018-04-13)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599869826856023070?=
X-GMAIL-MSGID: =?utf-8?q?1600729949553779844?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


--YQEH9CATo+4lan7A
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 15, 2018 at 03:22:46PM +0530, Mukunda,Vijendar wrote:

> You have merged 1-3 patch series. Still patch no 4 to 10 remaining.
> Could you please take them.

Please don't send content free pings and please allow a reasonable time
for review.  People get busy, go on holiday, attend conferences and so=20
on so unless there is some reason for urgency (like critical bug fixes)
please allow at least a couple of weeks for review.  If there have been
review comments then people may be waiting for those to be addressed.
Sending content free pings just adds to the mail volume (if they are
seen at all) and if something has gone wrong you'll have to resend the
patches anyway.

--YQEH9CATo+4lan7A
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlr9HkQACgkQJNaLcl1U
h9CWVAf/V4dJxgRpHrqUTscwyP6exn07dZqCAG4Gz/WiOMZvaC6G+j6uLYquRaJT
Q3tRcBtbG4CTTXHBWPz2BOeUXMT9lccypenmJ9kHCgwoCIuMylotzi1yd+aORoJD
Wv5pZDIJSUZ+0iTUqQEBN6YedkV+7eZsYdW8J1yYI1g7HnQKz2uukqFWemBS96zD
xcn5/PjzVN+ZHPa2aNLvs6MNadsCjtWkiJq+dbAEUDZ+Ign9BRe9JHvIJMfDYi3c
GEsf7cx12bVzAWWfD1p3UnjYeN6T2sfEwRS8FUIdo97PQfXKz24sjCyuazqESrVQ
TDo8/vFJgNLVkNITDUoJPhRceGT5Dw==
=Tziv
-----END PGP SIGNATURE-----

--YQEH9CATo+4lan7A--
