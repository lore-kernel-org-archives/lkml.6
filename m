Return-Path: <broonie@sirena.org.uk>
X-Google-Smtp-Source: AIpwx48JzBueOiAZTe/fjH7Pza92YHkA0zEHdFeqcK8/+U1vYITaZl4JwRYBE8hqTqxbNj5UwzKR
ARC-Seal: i=1; a=rsa-sha256; t=1524673307; cv=none;
        d=google.com; s=arc-20160816;
        b=0cKHUyYyuSXz+Kqzf4r94KZC9FQOcVRvL52M9VTi4SBmbGZy398JCS8VEwR/TWWPd0
         ky5vuZF6hB8ABBzDXvkDL1c7btB/pD/VRK1vBXovV3ntE+U5iwlOB9PmflIxLkYQS/5L
         Ro70YDYjKP4Fn/HrgxxTyiF+vXT2pTWlP8XHcQllRKGw7zoEihrKTb5b7gqres4bIQf9
         JRNRE8i5LBkXB+KFGTZS566UHnD6UZt5AYu80qbJsV+JbPYPTZ2bxXyY5ANNRryRvcSN
         xhnSthroItQAUigCYNWQs7YBaqLTGcsCsVfuMdZoLHNd6LnXJ3NKKYz6EE2as544c05J
         fLGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=8dY+rYdniQp2AZdL2xpG7bwhPyRJrE1LG4PgcGalzfI=;
        b=MurIe1f0Q97Vfwa0SRwhWSVgz8s/j5uYg9XN/yEFwInxGSvuu00QulkP+/r6fjFrd4
         8giJWVcDRFT+Lb6B5H4em4WdIlwiQUOnknUIjvoVEspvIiHOVghVg3fVYiD+fEdhn8L6
         /1fstCyFlgdfNOYlBf4spm0maaFlC7HmT0MiExa3AaOjpYD/Kue6TOrbsPjv57S2Z1BM
         84dXlFjO5Eojkd9DHrOEOvzw6WDT2yigQsDCujLGYuUcYwzd5IiO/druSLMYKs39PB2Y
         69tGGdQsCJUcS6twXzYxmH6/SFGdyrFZ9Xa1Jb1E8mc9O8U4Hiwc1pCgUYY3KAVWOEKP
         sMuw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@sirena.org.uk header.s=20170815-heliosphere header.b=sGsLUbEI;
       spf=pass (google.com: domain of broonie@sirena.org.uk designates 2a01:7e01::f03c:91ff:fed4:a3b6 as permitted sender) smtp.mailfrom=broonie@sirena.org.uk
Authentication-Results: mx.google.com;
       dkim=pass header.i=@sirena.org.uk header.s=20170815-heliosphere header.b=sGsLUbEI;
       spf=pass (google.com: domain of broonie@sirena.org.uk designates 2a01:7e01::f03c:91ff:fed4:a3b6 as permitted sender) smtp.mailfrom=broonie@sirena.org.uk
Date: Wed, 25 Apr 2018 17:21:41 +0100
From: Mark Brown <broonie@kernel.org>
To: Rob Herring <robh@kernel.org>
Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Andy Gross <andy.gross@linaro.org>,
	linux-arm-msm <linux-arm-msm@vger.kernel.org>,
	Linux-ALSA <alsa-devel@alsa-project.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	David Brown <david.brown@linaro.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Patrick Lai <plai@codeaurora.org>,
	Banajit Goswami <bgoswami@codeaurora.org>,
	Takashi Iwai <tiwai@suse.com>, Jaroslav Kysela <perex@perex.cz>,
	devicetree@vger.kernel.org,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>,
	rohkumar@qti.qualcomm.com, spatakok@qti.qualcomm.com
Subject: Re: [PATCH v5 21/23] ASoC: qdsp6: dt-bindings: Add apq8096 machine
 bindings
Message-ID: <20180425162141.GG24769@sirena.org.uk>
References: <20180418153157.1960-1-srinivas.kandagatla@linaro.org>
 <20180418153157.1960-22-srinivas.kandagatla@linaro.org>
 <20180424162517.msxscjfg36xc22mo@rob-hp-laptop>
 <655a593b-021c-3bf2-35c2-eb77cb0a4b95@linaro.org>
 <CAL_JsqJXpei5vFUKwrQGaV4q3Twkg=SKF=Cx_my7KaLmOc42NQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="kjpMrWxdCilgNbo1"
Content-Disposition: inline
In-Reply-To: <CAL_JsqJXpei5vFUKwrQGaV4q3Twkg=SKF=Cx_my7KaLmOc42NQ@mail.gmail.com>
X-Cookie: MS-DOS must die!
User-Agent: Mutt/1.9.4 (2018-02-28)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598098804369863616?=
X-GMAIL-MSGID: =?utf-8?q?1598735837932239733?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


--kjpMrWxdCilgNbo1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Apr 25, 2018 at 10:04:54AM -0500, Rob Herring wrote:
> On Tue, Apr 24, 2018 at 11:49 AM, Srinivas Kandagatla

> If you don't have the values, then how does one validate a DT is correct?

> Honestly, a single property like this seems insufficient to describe
> audio routing.

It's perfectly fine, it's a list of source to sink mappings which can
handle any set of N:M links.

--kjpMrWxdCilgNbo1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlrgqxQACgkQJNaLcl1U
h9DELAf/bORYkD4n6wKwrpVkFfB9Xu31idq7TNuMrLMWf6VecnyTH8rYs9U556Ju
sS21UxQb4ogZ3cVAT8gq1ZRWPDbovgrbkWoVpXo6CFYzEZQA3x1MUDCJbb4w4tvg
DuN0TN1xlwIcdeKR+uGItmSepTcuqgCpCVklDTSPNr6yRMtfRHsAg3YBb8HCle0M
kDUTxt6tJ0lHd9O+z8zLUOoYfZWyh74max9hD0GJ6wC/ACxw1k4t9u3c1wRLl2OB
QWbwdukau5ZtSL38ZUQpW4w+bUpbn7aHQc/bb6z70+sPET/e3g/PPK+e8OZmAyAU
9xKbQpMGVLKqPANICZl7GBFGzJ1+bg==
=VFT4
-----END PGP SIGNATURE-----

--kjpMrWxdCilgNbo1--
