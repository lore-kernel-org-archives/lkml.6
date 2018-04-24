Return-Path: <broonie@sirena.org.uk>
X-Google-Smtp-Source: AIpwx48anEFjUSv8sr5ytxPw4tGNuDmJIUHM9IPv4LNE6uM0MtETe/+FMAcujJ/LiAARZQ9d8VaG
ARC-Seal: i=1; a=rsa-sha256; t=1524585469; cv=none;
        d=google.com; s=arc-20160816;
        b=AM9pLkKH26atuF3/taFLu4WDCWAhL3Rdow6Y4xWawNRGzlGn0RQM8Llg6WX3KnxTDm
         4glE2Nwn/P5im0NqfOBx+Yo8xdJ7dQMCf4al3AN6OK9zTK9W4OHcq/s+MuB1Y0jJmHNA
         kP1UQ5hS4zenfeogDyWxljk8hfpxXhUWAc2cJSFNTPD415ZfrHjy3EGVeXZD8M9NCplw
         Uf58/k3/iPX7t58A/q6PGO5zS9+2u7rwiNf0yExG8Y2LfqmBZU61slrdhgT+KUHlIm9Q
         w3hl4nW6LM4V2MBoPTuAhFsE4Gpf/IQsv2D6D4MQomW1rNyIIK4c13sy9jdSC9+K0ITF
         Sc7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=MojIHoU3ArtXywhAWfUiibuEmJHulJNvFyUB7qCMyvY=;
        b=gKEgwWt+L7+pqsFzAZUHwb9zF7av4g1n5MnpHlgEBccKrEK3jB4lJY1bkbD+Mje/gD
         k+3LttWMrPRwoKp97ce8pt5rykyRNzHZURT3izdk/8YRSGG6hQU/NOlgQZjHUS03sNI6
         fOxsEOPZN+Wu4/lqyS/0jwM86WsgXgVCdF/nXhx1Ug271dgmLT84gA0wl1yyEygGdBuo
         F/qXEPU2AFD+qusQirXNYacFnjbFrAuRWS8NFguobTxYsPtYzu1SAGcuFYLLBXFOCqRy
         ZP9U3J0/tjYJXm7VPH3zqL0Nk2pYQNESiddHw2XN2syYXuuSGfvsyq0k8u/e/FCD0nIw
         g/iQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@sirena.org.uk header.s=20170815-heliosphere header.b=lCKK6Sn2;
       spf=pass (google.com: domain of broonie@sirena.org.uk designates 2a01:7e01::f03c:91ff:fed4:a3b6 as permitted sender) smtp.mailfrom=broonie@sirena.org.uk
Authentication-Results: mx.google.com;
       dkim=pass header.i=@sirena.org.uk header.s=20170815-heliosphere header.b=lCKK6Sn2;
       spf=pass (google.com: domain of broonie@sirena.org.uk designates 2a01:7e01::f03c:91ff:fed4:a3b6 as permitted sender) smtp.mailfrom=broonie@sirena.org.uk
Date: Tue, 24 Apr 2018 16:57:39 +0100
From: Mark Brown <broonie@kernel.org>
To: Rob Herring <robh@kernel.org>
Cc: srinivas.kandagatla@linaro.org, andy.gross@linaro.org,
	linux-arm-msm@vger.kernel.org, alsa-devel@alsa-project.org,
	gregkh@linuxfoundation.org, david.brown@linaro.org,
	mark.rutland@arm.com, lgirdwood@gmail.com, plai@codeaurora.org,
	bgoswami@codeaurora.org, tiwai@suse.com, perex@perex.cz,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, rohkumar@qti.qualcomm.com,
	spatakok@qti.qualcomm.com
Subject: Re: [PATCH v5 01/23] soc: qcom dt-bindings: Add APR bus bindings
Message-ID: <20180424155739.GC22073@sirena.org.uk>
References: <20180418153157.1960-1-srinivas.kandagatla@linaro.org>
 <20180418153157.1960-2-srinivas.kandagatla@linaro.org>
 <20180424155226.fo6rgdea4kmqqjdy@rob-hp-laptop>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="hOcCNbCCxyk/YU74"
Content-Disposition: inline
In-Reply-To: <20180424155226.fo6rgdea4kmqqjdy@rob-hp-laptop>
X-Cookie: Take your Senator to lunch this week.
User-Agent: Mutt/1.9.4 (2018-02-28)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598098775422985978?=
X-GMAIL-MSGID: =?utf-8?q?1598643732910604952?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


--hOcCNbCCxyk/YU74
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 24, 2018 at 10:52:26AM -0500, Rob Herring wrote:
> On Wed, Apr 18, 2018 at 04:31:35PM +0100, srinivas.kandagatla@linaro.org =
wrote:
> > From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

> > This patch add dt bindings for Qualcomm APR (Asynchronous Packet Router)
> > bus driver. This bus is used for communicating with DSP which provides
> > audio and various other services to cpu.

> This should probably go under bindings/sound/ as it is at least mostly=20
> sound related.

AIUI the same interface is used for other DSP functionality - they're
upstreaming audio stuff right now but I believe there should be more to
come.

--hOcCNbCCxyk/YU74
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlrfU/MACgkQJNaLcl1U
h9BC0wf/ZuE09XBVQEqxfEPat5gCr+fdUgRFbyuGvaqFOSgavwg45nQSvL4wSGKg
J+oy/tW2YwfLfjJ6WpzMcjk7eo53iX9Y+aOxNLx7bgvlF/8TbiDtUz3VRZewMpws
5Pr3kvcvh6matkh6P4L3C8j7jw5z5LuL/4j3H3MPD1fH4nihOeabqWEQq8pLVVSI
CPMVxvhoFJdEtYwp8qe72NMchw0oLCwk4wjtTo708zPvqkn+/W/eb/T+eOrA4mkc
UUw9HufLYc1P2rtQ08wJtEXFkqYjzU8zKr5SLigs/l3ECDgsEdcx3OwenWZ8jVD8
gDEoP35iR4QGKRRwyXY+e/Hhnc9SOw==
=WtTX
-----END PGP SIGNATURE-----

--hOcCNbCCxyk/YU74--
