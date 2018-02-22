Return-Path: <jhogan@kernel.org>
X-Google-Smtp-Source: AH8x226zIR//Q6AVg6RgC0yA3Phg3xbqfdjbbqZwE1TrdTfX0HqD80CYo7BU1QkL6Q6LQ/PIt/4/
ARC-Seal: i=1; a=rsa-sha256; t=1519292952; cv=none;
        d=google.com; s=arc-20160816;
        b=MhDQ34QDV+myPGLEYXpzLz7ViQxbTxi6jj/XHrkx4+gtkAAaRwx42WLeP9UCUW0UBt
         OSAqlXEVvbu2DGpczkUcqwxL86Clu9nQSSQEmIjl3kgg64RTvam/eYAG1Ba1flRActQv
         35VXzUQQvHUUkOIzk9C+OkXjz/5dC0rt4SdsPSaHeyI+2Tvz16N8OchGFsbdt1WABmdT
         pXVN9KQIyyb5yVHgO/PfQWdR4oAB7D+9c+2LRZRLzenJGGNPSTTUWkn/hIzci4gOnO5g
         QCv4sBZ/KPVsw7Hsxo8duwkQSs4vLqpNzCEPcyZvXEjdVS9nq7QaSbt1AFYt0I7tuPFH
         +Wqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dmarc-filter
         :arc-authentication-results;
        bh=qVwqj8kVT+dRB5fo5kwLB9elgWxuAG6DZUFxYu8zEVA=;
        b=cgKcCY4kpHCQnkc2i5qaBF6upQhG5mT1xtYrK24aHpr2aF+wPdT/3eCzegSeFMvMsE
         X6+l825B8GMd0CAQ1cacIDBkwhiTegeNUDKpnrxg6SuEgtSFJKVqSLjMhhkDRhU+olCD
         b3+4O0kAePhsUihD08o/N2/to2b2z7lA1eAQibM8eIkw5l8uvp59dP/GYJE7OWJaCF7R
         i8NETRhz/AGactBkq6FjgHChyy6EBPPRraB/AwaztgLORGUN9F5NZUDVFQ13l4TRJtDs
         83zPTk7uHeVocX9Ugo5XUsGby+QfeA1vuOThyF6+boj3QasVKDPZFDTf7oLHCQPmBVRa
         EbJw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of jhogan@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=jhogan@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of jhogan@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=jhogan@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1E9F21784
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=jhogan@kernel.org
Date: Thu, 22 Feb 2018 09:48:44 +0000
From: James Hogan <jhogan@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-metag@vger.kernel.org, linux-kernel@vger.kernel.org,
	Guenter Roeck <linux@roeck-us.net>,
	Jonathan Corbet <corbet@lwn.net>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ingo Molnar <mingo@redhat.com>,
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
	Wolfram Sang <wsa@the-dreams.de>, linux-doc@vger.kernel.org,
	linux-mm@kvack.org, linux-gpio@vger.kernel.org,
	linux-watchdog@vger.kernel.org, linux-media@vger.kernel.org,
	linux-i2c@vger.kernel.org
Subject: Re: [PATCH 00/13] Remove metag architecture
Message-ID: <20180222094844.GB9891@saruman>
References: <20180221233825.10024-1-jhogan@kernel.org>
 <20180222092654.GN25201@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="SkvwRMAIpAhPCcCJ"
Content-Disposition: inline
In-Reply-To: <20180222092654.GN25201@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.7.2 (2016-11-26)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593055859238851284?=
X-GMAIL-MSGID: =?utf-8?q?1593094127424903240?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


--SkvwRMAIpAhPCcCJ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 22, 2018 at 10:26:54AM +0100, Peter Zijlstra wrote:
> On Wed, Feb 21, 2018 at 11:38:12PM +0000, James Hogan wrote:
> > So lets call it a day and drop the Meta architecture port from the
> > kernel. RIP Meta.
>=20
> So long, and thanks for all the fish!
>=20
> Nice cleanup though, most welcome :-)

I thought you might like it ;-)

> Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>

Thanks
James

--SkvwRMAIpAhPCcCJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEd80NauSabkiESfLYbAtpk944dnoFAlqOkfYACgkQbAtpk944
dnoHNw//araZkIz0fvrAT593YR6P+Sff9uhB2R9cOsuzBhV6cv3yci06pKrMLv3u
d5dIurnPaZB1mhADAPXB4B0jrvqx0evAJ45CKS8rAKZSjZNKrAnrEpOAlkPgo1xp
sFPCzh98J7qcYNkR2IRDtfWbC0ARAY8iuaN8Ejc7Y25t4POGh+6ZGloBisgZq6Af
H1IwLvM4gRTT2qkxoRO/dEECFLor06EXSp2AdibvaTb8Z00kWM8Tig+NFCRkDvR+
PAlL7D4Iv6GEZzU2Bac6caWFcWIfV4OzOHDiFcVUWgsWveuQGiX5F4q1dJSpGgRl
IPErO/pUMDUubn6bAZAWW/5m3VrKiyjwOixADGmY1O+LjsEjMfpO/gnuJJiDCv9J
7JgMmz4DnNtephmG2ZQYiaM4qL4ErNW+CunOaGl/tvHBJxgpzCrcaDHmBpw1Jpvc
FBqqz5p8G+FM+qSPIrhrymF9dhVyO9VuO8qtuVekO5PzgoGm7Gb+1gr/3brKodSd
BN7AdOCVKn0Zpj28KRkw7nL0GQKXsH4yCou68DQxWEx0gt+aaurAIMkPsPuM2lYC
pLqgNbj93IEYmSj0TnTcmcfVAl0WvviGbVmMo57YuU8fpFW1FHDji4R9R/zulmtF
MCUFugKKc61StB/kH95RHaehJ6Rly+yz7ioWI5JlrwZCbNmFJKM=
=gZvt
-----END PGP SIGNATURE-----

--SkvwRMAIpAhPCcCJ--
