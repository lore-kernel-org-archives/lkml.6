Return-Path: <broonie@sirena.org.uk>
X-Google-Smtp-Source: AIpwx4+z/omTFDeBbYibvWQYZkmTggA4rooMaLr2w2eblcrjsxywyzzXAGqD6XLp95gzO/eIDr5L
ARC-Seal: i=1; a=rsa-sha256; t=1524742787; cv=none;
        d=google.com; s=arc-20160816;
        b=QQHv39moL0d8QYmDIlG+CSTF1M1+wwXiO4F3jNe3YeZ7wElgQqxVBpGjxLQQNpHO8b
         EtJdkdFGkPazWMdr4nEQHU8PhxfYlbIR6+pz0nHwa1C17sW6o2fWZqniyibAcn7YtBE1
         DocHBFy/ChRruzTZMVWO/5PYe8hQgoBGZ33bnp0kgZ/CNTDZkRss/a2NWX/gqKUT+qgg
         MWn+ktNt1EpogZJ9kO2mgpbl2xc2IBLjtetlr5UBEFCngdqR44yzxB+XahvhigACSxzJ
         6wmg2cti8cRGcBpCrMapTu/FQK1Mqjk9chW3j4mkft/k9ZizJFs19TqGR8O0ewbNGPF2
         jcyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=SjGOrY5i5+GToXWD7L6yMOnkSwOKcegWEhH4ap/cQGU=;
        b=qKnADv3YgP+dM+PhzLmcQRx8GrqDOhjfCnLR2TRCtozi9uSJMfUHO3qaDtRciV+uuO
         BIczmLkga+ZEOmNpvTVmIhHdBsR6VEcR0Ka/sx+awGgCCkPP64IwL8JovI3qJBmtKkz7
         yXipxRcE398eMTFAFC62QRrB16sTqCjFSUpohk3VPWvt1AGBTXJt63hECftoBZQkuTNX
         7maPEewyuP95jksQ8bhmH+7WSvXynrq7P9k+7QnAhfBoTECzWziiNi6vbpufOHLFMrkr
         vulZWgGZIY+iTyP1mF75rzpXlsQLfDCcXz+o9mIskHPvHp8iGtCPf3IQK1phjqhV7U8X
         6mZw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@sirena.org.uk header.s=20170815-heliosphere header.b=RDG45Bbi;
       spf=pass (google.com: domain of broonie@sirena.org.uk designates 2a01:7e01::f03c:91ff:fed4:a3b6 as permitted sender) smtp.mailfrom=broonie@sirena.org.uk
Authentication-Results: mx.google.com;
       dkim=pass header.i=@sirena.org.uk header.s=20170815-heliosphere header.b=RDG45Bbi;
       spf=pass (google.com: domain of broonie@sirena.org.uk designates 2a01:7e01::f03c:91ff:fed4:a3b6 as permitted sender) smtp.mailfrom=broonie@sirena.org.uk
Date: Thu, 26 Apr 2018 12:39:34 +0100
From: Mark Brown <broonie@kernel.org>
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "Rafael J . Wysocki" <rjw@rjwysocki.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-pm@vger.kernel.org, Kevin Hilman <khilman@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Vinod Koul <vinod.koul@intel.com>,
	Sanyog Kale <sanyog.r.kale@intel.com>,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
	Wolfram Sang <wsa@the-dreams.de>,
	Russell King <linux@armlinux.org.uk>, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 11/11] spi: Respect all error codes from
 dev_pm_domain_attach()
Message-ID: <20180426113934.GB21755@sirena.org.uk>
References: <1524732790-2234-1-git-send-email-ulf.hansson@linaro.org>
 <1524732790-2234-12-git-send-email-ulf.hansson@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="RASg3xLB4tUQ4RcS"
Content-Disposition: inline
In-Reply-To: <1524732790-2234-12-git-send-email-ulf.hansson@linaro.org>
X-Cookie: Where do you think you're going today?
User-Agent: Mutt/1.9.4 (2018-02-28)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598798231336171631?=
X-GMAIL-MSGID: =?utf-8?q?1598808692924707776?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


--RASg3xLB4tUQ4RcS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Apr 26, 2018 at 10:53:10AM +0200, Ulf Hansson wrote:
> The limitation of being able to check only for -EPROBE_DEFER from
> dev_pm_domain_attach() has been removed. Hence let's respect all error
> codes and bail out accordingly.

Acked-by: Mark Brown <broonie@kernel.org>

--RASg3xLB4tUQ4RcS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlrhunUACgkQJNaLcl1U
h9CMmQf+KRWcQQKCEHfr+D2f1485UVJqBCyZrLuN8vRgon7ZNa3S1sq72ZQvrN8x
4vFBqF9p9kKoHo/MzgyBQXITYk0mpk3gLtgIQSGBnIog9DtKA6MDY2D/OtvGjMob
g4+Lml0u5ZmcysNOpa7vzipvBeuoOC5KkMuL5vrCGxp1UFZnFxCg76sDUccVeqVr
zSpkopLF2ZW68v9x+XJmhpKl5hNdu4xFUoVU4oaVHSUwIjMYt6goVSo4WZjf5cGa
zhx0HETAwL1iNX5Nurw51g6e3WaiLeHHSmtv6dgFlg1pac/kEeL3Cj23T8Q9d1oq
d466W6BB/El+rPkU5UN8ci96SVWPOA==
=b7nj
-----END PGP SIGNATURE-----

--RASg3xLB4tUQ4RcS--
