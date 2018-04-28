Return-Path: <wsa@the-dreams.de>
X-Google-Smtp-Source: AB8JxZo5Dv2g+5xMdsthwhM7wY9CxZc/jMb6zNZnA0RzGhGGoYeTWZOcV6+dT8Zi4iDFA/3cstIy
ARC-Seal: i=1; a=rsa-sha256; t=1524919448; cv=none;
        d=google.com; s=arc-20160816;
        b=Al2lizHAC/45QjPky9aBwHveIC/hwo2JcVIlWc5+insLPRYDO22DpH1yckAHa3B/vn
         TCurQXhiEHnRgwUDcGaUYHeBqm7q+wf0XWu7BEyvgAwxePuXEUe9ImFBuDh6ochFzYPB
         hugs/F2Nhvx2FiSudlPWi7XRLRWoKBhRqakR9TzmcMaMbcLwyqXL9nXzavvAGbXZwSkV
         N3F3D8szB2ghgvx6xUR/vh7hj1s63Ik+egL6v+ynjkocgzUH1w1AU849d31CM8l5JNQu
         OrsrfU2jViT0UI9GCp3Ss+qrYLy6VmCtZj8RgqbI9K9wqYM3mlQEuZ9ARefUMX9od+sy
         yZig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=sy2k1QYAGmZX+amCsd5QgIG0nfI+kuvGogsJDsffv6s=;
        b=jc7r76yQC2Z/R2LEyN82mqkUQNwBHeBIQwQsohIlMEpqvPsj/LvbsMiKkRMIZRufu2
         S/7iNbzcQBO1izyM41EtyRE58KReOE1tJXENSQP8ZoPPB7vtkC7hTobWYgjE4BMLzQHA
         AZbWEN0u7zCSl+2uKxz/LE9wM9jUUspS3KU9eGQCy5PyS1DF9CX7AAutdI6YSktFJdyh
         cnEu/symqqgaW++6xFB1ScDEKpzOp2Qhuvul7Ny5SzbOHFk6d6+MslU4svCS8XUh+IJ8
         ehWf0Et5Y1ObN3q38gqbGBbG9Lq2lbNPfOQ7EuK7UHPmS9ppRLR7xClXNlUAJdOrmyfr
         bFtA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of wsa@the-dreams.de designates 88.99.104.3 as permitted sender) smtp.mailfrom=wsa@the-dreams.de
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of wsa@the-dreams.de designates 88.99.104.3 as permitted sender) smtp.mailfrom=wsa@the-dreams.de
Date: Sat, 28 Apr 2018 14:44:07 +0200
From: Wolfram Sang <wsa@the-dreams.de>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Kukjin Kim <kgene@kernel.org>, Rob Herring <robh+dt@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>, Tejun Heo <tj@kernel.org>,
	Sylwester Nawrocki <s.nawrocki@samsung.com>,
	Tomasz Figa <tomasz.figa@gmail.com>,
	Chanwoo Choi <cw00.choi@samsung.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Eduardo Valentin <edubezval@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Hans de Goede <hdegoede@redhat.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Andi Shyti <andi@etezian.org>, Mark Brown <broonie@kernel.org>,
	Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
	Alan Stern <stern@rowland.harvard.edu>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org,
	linux-clk@vger.kernel.org, linux-pm@vger.kernel.org,
	linux-i2c@vger.kernel.org, linux-gpio@vger.kernel.org,
	linux-spi@vger.kernel.org, linux-usb@vger.kernel.org,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
	Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [RFC 05/10] i2c: s3c2410: Remove support for Exynos5440
Message-ID: <20180428124407.bpc47bo7ojebahpz@ninjato>
References: <20180424203239.21885-1-krzk@kernel.org>
 <20180424203239.21885-6-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="2ub5o5uu6wk62jsg"
Content-Disposition: inline
In-Reply-To: <20180424203239.21885-6-krzk@kernel.org>
User-Agent: NeoMutt/20170113 (1.7.2)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598661094308693488?=
X-GMAIL-MSGID: =?utf-8?q?1598993935205475628?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


--2ub5o5uu6wk62jsg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 24, 2018 at 10:32:34PM +0200, Krzysztof Kozlowski wrote:
> The Exynos5440 is not actively developed, there are no development
> boards available and probably there are no real products with it.
> Remove wide-tree support for Exynos5440.
>=20
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

Applied to for-next, thanks!


--2ub5o5uu6wk62jsg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlrkbJcACgkQFA3kzBSg
KbY0oBAAp5AZ22Iwc3g476LI/homGu6AP+TvzJ14ZHvvKXmBhKLST+eTqjibgy8y
ezyaVsMGoTAqZXpFAoPhMWB/ktsDNOM6QhshTyAR5EI634GhnTZ8j5quAXYwgPsL
Iugkw/DxGYGz+0iaPwvd7L4OnCHpufRomudIkx7wO5IObmbuFIAYiAvZIp6873Hq
UFWUlW4k67D+BcoYc+uVcvTteewzffXS/qyRim6TF4Xg2FKTPp9KRUjmL86xLHvl
FXDKa4djARTZz+HD0aQ27aOuv+g7yxLS9mfL4wSckymohGCtmDhHI6xdw3hyCDwM
yPElg4JICJDm4EuDjzYdYrcZlFjsXeuHN3RGaJfIRFnIhwC/CxiUnwtMosGCuWSK
BDU+esBF7qEXxherzLPJEJVPYW1z3XqLphkxoJ8Ma/9DpLDmItGythWIuMblLHWP
jWpb3DOgATifO3ZLkyNEp/6m4GMEZN29Xc81BLRgy+NMzaNPofgSflzW1QAHz8H8
qMtjIHp9zH9h4jn7LoUng1AsEBs4AW/xv5Bul8l4FhrfjSpzTCfb1+kF7QKAr8IW
0xuLrzW3GSd1/WC7BTnQMDD41d8sgd8YL8RyfFBYsst0L0TXvhgWLCLt7M40X42q
pUXIKPw/t0MR4uIsD8nQ9ZnWhb4chO2pzGSMabmZQDLeZQvGRBI=
=ObTl
-----END PGP SIGNATURE-----

--2ub5o5uu6wk62jsg--
