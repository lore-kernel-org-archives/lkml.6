Return-Path: <jhogan@kernel.org>
X-Google-Smtp-Source: AH8x227KSH0dEQjq+GBzI35XvSLzEZDXyw/J/Yn7LsJHLw8k0W5JrRP2RLugVmQulr2MKaLCxM11
ARC-Seal: i=1; a=rsa-sha256; t=1519383736; cv=none;
        d=google.com; s=arc-20160816;
        b=uagFf2NFiHNNAbdykzB3Ypdr1hrJduplNONNVKX/4unRneBPFwQPNcDF9fHPjplFtr
         noaqPnrhXMYvI/2WfqcH/+WUVyiMMK72ZEI/VVfx0OwChkUnrq5l3nQ8v3RdeT2DLteW
         snRKDcKsvqot0OHnMKKZcW3OnSZ/sHGKChnfDysp1MgvKzWm57ZuCdpqWb78sFVKp1EF
         uWoYotdts52y9h5x3NnPA2OjsDacfhpEgLT3QTXEmPX8zxh3Av/k6UPshVOApJTLI5s/
         As+B6dIhuDerxaANxEmu/28MfVKahW7I0YGzyu0rqZ50jBiXL6eowQ2UKgkxFTPFXRDY
         sqWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dmarc-filter
         :arc-authentication-results;
        bh=k4Iw1ZMgKqgq/YoYY4eZlGNFKL8tjB3TbIXPC9YiIWc=;
        b=lhLX98t08HE5DNMbDz24EDurft3DB3zguHZAh0yr0rmAYXSFir1v0qTy34yYd6GuP6
         DCpjFSvZ0VWBQIJVU4IPgOCywIXjXrUOFNFKyZmFvsuZyIS1PxyXfadyDnPwrl8KiQDc
         m+nEyASmthmMJlBf90I3ld5tdfJOXGAwGnuyRAv3sO3epNkxpNYr0tTHw+7Jvoblvd6x
         zRJsfaZbMjLxjoQoJt0tUScd8szG1Dj9cI1bV0BzLw5t0H313y84HjPEosbpzZxsY2OW
         7iOK9DmjKf/gDZqiiPRKjGmmjEXknMrk6SIR1fnOrX1DpJRNW0AjpsZwNRBGEoTG3B91
         w3ng==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of jhogan@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=jhogan@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of jhogan@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=jhogan@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60DBE217A0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=jhogan@kernel.org
Date: Fri, 23 Feb 2018 11:02:08 +0000
From: James Hogan <jhogan@kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-metag@vger.kernel.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Guenter Roeck <linux@roeck-us.net>,
	Jonathan Corbet <corbet@lwn.net>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Jason Cooper <jason@lakedaemon.net>,
	Marc Zyngier <marc.zyngier@arm.com>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jslaby@suse.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	Mauro Carvalho Chehab <mchehab@s-opensource.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Wolfram Sang <wsa@the-dreams.de>,
	"open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
	Linux-MM <linux-mm@kvack.org>, linux-gpio@vger.kernel.org,
	linux-watchdog@vger.kernel.org,
	Linux Media Mailing List <linux-media@vger.kernel.org>,
	linux-i2c@vger.kernel.org
Subject: Re: [PATCH 00/13] Remove metag architecture
Message-ID: <20180223110207.GA14446@saruman>
References: <20180221233825.10024-1-jhogan@kernel.org>
 <CAK8P3a3CuNn-dSE33mhEZ9-iM7NOE3Y4AiJzpmF6ob5wrMuZpg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="tThc/1wpZn/ma/RB"
Content-Disposition: inline
In-Reply-To: <CAK8P3a3CuNn-dSE33mhEZ9-iM7NOE3Y4AiJzpmF6ob5wrMuZpg@mail.gmail.com>
User-Agent: Mutt/1.7.2 (2016-11-26)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593055859238851284?=
X-GMAIL-MSGID: =?utf-8?q?1593189321076235883?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


--tThc/1wpZn/ma/RB
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 23, 2018 at 11:26:58AM +0100, Arnd Bergmann wrote:
> On Thu, Feb 22, 2018 at 12:38 AM, James Hogan <jhogan@kernel.org> wrote:
> > So lets call it a day and drop the Meta architecture port from the
> > kernel. RIP Meta.
>=20
> Since I brought up the architecture removal independently, I could
> pick this up into a git tree that also has the removal of some of the
> other architectures.
>=20
> I see your tree is part of linux-next, so you could also just put it
> in there and send a pull request at the merge window if you prefer.
>=20
> The only real reason I see for a shared git tree would be to avoid
> conflicts when we touch the same Kconfig files or #ifdefs in driver,
> but Meta only appears in
>=20
> config FRAME_POINTER
>         bool "Compile the kernel with frame pointers"
>         depends on DEBUG_KERNEL && \
>                 (CRIS || M68K || FRV || UML || \
>                  SUPERH || BLACKFIN || MN10300 || METAG) || \
>                 ARCH_WANT_FRAME_POINTERS
>=20
> and
>=20
> include/trace/events/mmflags.h:#elif defined(CONFIG_PARISC) ||
> defined(CONFIG_METAG) || defined(CONFIG_IA64)
>=20
> so there is little risk.

I'm happy to put v2 in linux-next now (only patch 4 has changed, I just
sent an updated version), and send you a pull request early next week so
you can take it from there. The patches can't be directly applied with
git-am anyway thanks to the -D option to make them more concise.

Sound okay?

Thanks
James

--tThc/1wpZn/ma/RB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEd80NauSabkiESfLYbAtpk944dnoFAlqP9K8ACgkQbAtpk944
dnqGqg//RwJWuqjtS6xKfuWgErALcEI5BIrgC7QevCr8kr37+YnzqVJM+Wmz/ROv
xW5kdhL8v/ocuxe+YBECennMjzbbPPvHWq1WieTxXOgOB8nxGduvsNFQiUg8I99O
ltjgj7sjnGp0R0GW4HflETXKGWjLn7NirFoCLjyTQT3Gwjpn8shDLx1trMPb8ujH
N6DvyyrojnBJ0kACtzEyGBPphrtk/a0t+zySdIuRLXReU9Q2/5yW2Vof4irxL9Ov
JQljE0/dTi4JgTvrieojAItgUsS3/D+XVe2HDTJw2PcwAX0AmExTtaT1ADh9Ujyr
TOg0uFwmed74V/wUwBxW6KMOyu0d0ITmTghXnWl4jbJvpR0pNXjJG1JCtpjyYgmd
3Lx7fzwDckUB+4ma2X2C7OAU4JaBU2tEKPo5a/b/pO0d7HqRGJIA0HApTaF8YQ4Z
tREK4jme67OuLs3POFHgbPLVrORrk4dhiBZHarPERXIEXYYD/0kVA5S7npvSmzD0
AmFh1T6b0VcQWak6aU9PoTmdIpPwmyhvOBsMAzOwounp2kmwObdgdgDB8yQkC5VK
EQCcmCWImEf7hz1RyTc6bawPRFkCip1k4ucmOO7KLYhuFL6uYj/Mg5JaDZLNQRyn
izvAzQ5AK0+VzznxZHkbKgISt54p1SuEMQuCvxYzpujBNY0Ti98=
=BIkF
-----END PGP SIGNATURE-----

--tThc/1wpZn/ma/RB--
