Return-Path: <quentin.schulz@bootlin.com>
X-Google-Smtp-Source: AG47ELtZgreA9InFY0PodCkWRNGLFEz1H1j2u/zSlzHpiENEtWPZRAOdYRu1v6I3jkX0o+RHb7El
ARC-Seal: i=1; a=rsa-sha256; t=1520582557; cv=none;
        d=google.com; s=arc-20160816;
        b=Dj5EYHU2AGYv33cXHbXBEQbjwb4J/lcSjKmdBsIt4eQ2ZYEFZDyZHM67cOlRuJlM/Y
         yDWMUbE/wYtK5UlMNqHwAOrnq6DJKiXw8M/qglcfSrK24VPisrsrF54xy8YGf7UG9DpC
         2nuqU1jqNFj2/TCmV2B+drc2E58o4UNqR5k/OCyrWwWrNTF4Z+XFyU0epzkKsOPWHsO+
         IyIfH9MaKDnn2KPOJZgJjhjfbl4avRvb/uJ8Yv04CrrmDlCxQW2XeG1djzOrRHYp5ZUH
         yT++81U/l6qkTh2GX9VSvzdXhttmwZD9PDE+XDlG2cS7MoD1/XrG+0FDbLQmcs3z8ZNM
         8o/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=xPSqiA9NW+vVfjG+qT6y+jHU5F72XT0lzTHQ+REAw+g=;
        b=pLYe4ZJEg9+KlV2PW0aGBzSNrfwkKnoFNNb0Fr9FXxiJ4d5uto8a7AUH/ccrvOsPpJ
         nYPVFSJUWHcXbUbOGgV3Cb6NlQQW9S/2V5lcMP/Di8FSz4CC89gkV4YFTVaqyVvpcHN5
         deZRyz+Xy9ISLXv20WeJotYxP85jSwqnQDOUS2BekCwnALK2BZ97dtswLgU5sjtKlyAi
         BH8YLKlKNmHhiIfS91r70jwHSBTtgzHn89nUQe7CMEU+kwx5D6YYZm0B0vVz62nDL+lf
         iQFwCJd9RRUl4STBJSBuO/ch+j+vneptEpM05y2MZEa81sb7nGHTdj63yGN8FJVUtpT1
         bWdg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of quentin.schulz@bootlin.com designates 62.4.15.54 as permitted sender) smtp.mailfrom=quentin.schulz@bootlin.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of quentin.schulz@bootlin.com designates 62.4.15.54 as permitted sender) smtp.mailfrom=quentin.schulz@bootlin.com
Date: Fri, 9 Mar 2018 09:02:35 +0100
From: Quentin Schulz <quentin.schulz@bootlin.com>
To: Kevin Hilman <khilman@baylibre.com>
Cc: "kernelci.org bot" <bot@kernelci.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net,
	shuahkh@osg.samsung.com, patches@kernelci.org,
	ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
	stable@vger.kernel.org, kernelci@free-electrons.com
Subject: Re: [PATCH 4.14 000/110] 4.14.25-stable review
Message-ID: <20180309080235.xu2ocjy3axsbn3wz@qschulz>
References: <20180307191039.748351103@linuxfoundation.org>
 <5aa0b9c4.f8aedf0a.117e1.748d@mx.google.com>
 <7h4llqf70y.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="jab4h3b77esbgwlm"
Content-Disposition: inline
In-Reply-To: <7h4llqf70y.fsf@baylibre.com>
User-Agent: NeoMutt/20170609 (1.8.3)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594309365480057936?=
X-GMAIL-MSGID: =?utf-8?q?1594446376007790358?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


--jab4h3b77esbgwlm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Kevin,

On Thu, Mar 08, 2018 at 04:05:01PM -0800, Kevin Hilman wrote:
> kernelci.org bot <bot@kernelci.org> writes:
>=20
> > stable-rc/linux-4.14.y boot: 148 boots: 4 failed, 133 passed with 7 off=
line, 3 untried/unknown, 1 conflict (v4.14.24-111-g66060ac1dfa0)
> >
> > Full Boot Summary: https://kernelci.org/boot/all/job/stable-rc/branch/l=
inux-4.14.y/kernel/v4.14.24-111-g66060ac1dfa0/
> > Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-4=
=2E14.y/kernel/v4.14.24-111-g66060ac1dfa0/
> >
> > Tree: stable-rc
> > Branch: linux-4.14.y
> > Git Describe: v4.14.24-111-g66060ac1dfa0
> > Git Commit: 66060ac1dfa02f02646a55f6ed888c0f2001623e
> > Git URL: http://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
> > Tested: 76 unique boards, 23 SoC families, 17 builds out of 182
>=20
> TL;DR; All is well.
>=20
> > Boot Regressions Detected:
> >
> > arm:
> >
> >     davinci_all_defconfig:
> >         da850-evm:
> >             lab-baylibre-seattle: failing since 1 day (last pass: v4.14=
=2E4-76-gf91a57b206e0 - first fail: v4.14.24)
>=20
> Operator error in my lab.
>=20
> >     multi_v7_defconfig:
> >         armada-375-db:
> >             lab-free-electrons: new failure (last pass: v4.14.24)

We're having a hard time with the serial of the armada 375 db since the
beginning. We're trying to find solutions to get a more reliable serial.

> >         sun8i-h3-orangepi-pc:
> >             lab-free-electrons: failing since 1 day (last pass: v4.14.1=
8-23-g8d861f5b27b0 - first fail: v4.14.24)
> >
> >     sunxi_defconfig:
> >         sun8i-h3-orangepi-pc:
> >             lab-free-electrons: failing since 5 days (last pass: v4.14.=
18-23-g8d861f5b27b0 - first fail: v4.14.23-116-g0ae11358b0bd)
>=20
> These three are also not kernel issues.  Seems the lab having problems
> connecting to the boards.  Cc'd Free Electrons team for closer look.

It seems like the bootloader is corrupted somehow. I'll reflash it.

These issues are definitely not kernel ones as you rightfully stated.
IIRC, LAVA in its latest version has updated the returned status of jobs
and shouldn't return the same error if it fails before actually starting
the kernel. For example, I have a "Job error: bootloader-interrupt timed
out after 294 seconds" for the OrangePi.

While we really appreciate you giving us feedback on these issues, I
think they shouldn't be mentioned in your overall boot summary (or at
least in a different section than kernel errors).

Or maybe you're waiting on all labs to migrate to v2018.02+ so that all
have this enhanced job status report before actually using it?

Thanks for the report, let me know if you have any question or remark,

BTW, we've changed our name from Free Electrons to Bootlin due to a
legal dispute around our name and we might lose our domain name so it'd
be great to send your mail to kernelci@bootlin.com for now on, thanks :)

Quentin

--jab4h3b77esbgwlm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAABCAAGBQJaoj+UAAoJEIS4mnU+4PGjd4oP+wWs9ow1NCRBjngG+rN+R2QW
oDNNrUuflKiyIgNFkibW4dBhKQKvUbLlw1d+ba9BYw1yIj+lhhsLeP50ABPQQ6+h
D3rI4B9qCq1eG1lrfRIqkRUU2eV7Y8THMH1zjoZEsCvh2nzTz/SwphHhKzz7m4kO
K1axXn+Li4AK4+p4aluAoreJGIOvrNl9fWxfpSixPf25wSb0lYlX5vaTFMAVQBHD
boIXaONEDiG6qTtvnVSM6J0pn761lKCpCoO6WcVJSWUqFBs7agmMuos5ymuuHh4M
qJXi2bMPHgsHY8/mIb4DXWvW/M27ZfMdRPFmNSkQz4c6zz1M1rXlrK2NhNeQujta
+jGJ8sQ/4qgszrCbAKKEd/mC5Ry1XnsGWShsxrVeAu/SR2Abn0FW7yc8suyqv7+t
s4H5+kB/3RpEWX2PSiEH7FouGKxf5gBf8UxscAZHEthpkzstAgtp/+2EhUvalbiI
R0j1ZWTG3jLCCqeKniSL4a0Mr8RslUPGpVr7vXed0NIkHwbOl1ZI+6gLXip8nZGQ
uO6h2qcAGttU5pZ+1jWhm3xLoAiAv7/ZxTikbu53PZ/1b+LG+45k9dYwMFjwYv38
nKcYVCX3ohP3WSh2GDC44RsFIvNG9L6sm6AX/zDv9E1PmuNQQzBhLwXs2Lg5Twj1
yjq1IjBNnHZ1kvpTNjw1
=tc4f
-----END PGP SIGNATURE-----

--jab4h3b77esbgwlm--
