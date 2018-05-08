Return-Path: <jhogan@kernel.org>
X-Google-Smtp-Source: AB8JxZo2p/GgEJ4qIy/ZGc2bkxRz/NZUg31A9VHi5TaUTTvxywxDD/Z+svixQiZgza6DY7/73ExA
ARC-Seal: i=1; a=rsa-sha256; t=1525819482; cv=none;
        d=google.com; s=arc-20160816;
        b=pE0k1PZTSc25E7VWPyviJ+guftrH36qFEIGArk14wNuK3XykcS/gCeplRJXN1Jcayf
         uLuDdcEUJY399oNjd6ICUBFNY3dfjflgasdF30/cJMvCCipMeKjJYpqNDTXpTWtEG2mq
         KeLQsg4kgN2AB1q4zwhuurOo1Jgzugajv3nvCmpAxGDQolIyaqgwcRIv73A5+zO4GuyV
         amnX3XxJoVIoYerRGy8P9NCWpgsxS7+LzJAVrqBt+maojbH16USQ0mUyp8l6MOJZYv+F
         1jnwUAe3gbwTNS11sbcY+R9nSNnxxDCQ6YagF3s2F90rLpl/MHvw7NGRFZ7wJ45QQLcq
         h9Qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=dQBjWQAVoNb82foVpLmk0TWkev4TQojMN8haHkuqxjI=;
        b=StDz3jBH8eFlqKx+xxXiBWHp9DiR0qh0IZqgXGQx9mLpbzP8A+Qsm1vAlZeZlbKvTZ
         18RXh+9INm7odd8MiuBPV8jmBDDdQLazgbzOtpJv8i0R2gRxYXV/tFlyACAJF6xhiyw3
         Ul9Us7VbGWeFFUL9CK0MqaBZHJtE9wygseM0dUoYpPmV5uJD7M6lSaw9S2IjXmoG8Wug
         uA+TjvQesQ77EsGYo0jiWsLj+QZuX9Rc7Djr956dxmsyAvj73kZjOZ0univvICXt/tb3
         BnZzOzPJiDadda0HwpNujJ1rNiSoLQR9jVmRz4AHRoPnsyjL2iiMA3FMtqJclfdMn140
         rObg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=0roW37LK;
       spf=pass (google.com: domain of jhogan@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=jhogan@kernel.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=0roW37LK;
       spf=pass (google.com: domain of jhogan@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=jhogan@kernel.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=kernel.org
Date: Tue, 8 May 2018 23:44:36 +0100
From: James Hogan <jhogan@kernel.org>
To: Baolin Wang <baolin.wang@linaro.org>
Cc: ralf@linux-mips.org, kstewart@linuxfoundation.org,
	gregkh@linuxfoundation.org, tglx@linutronix.de,
	pombredanne@nexb.com, arnd@arndb.de, broonie@kernel.org,
	linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MIPS: sni: Remove the read_persistent_clock()
Message-ID: <20180508224435.GA14903@jamesdev>
References: <0b52cfd4def5dd0287a1fd48c632a32e7cc3117b.1524122311.git.baolin.wang@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="4Ckj6UjgE2iN1+kY"
Content-Disposition: inline
In-Reply-To: <0b52cfd4def5dd0287a1fd48c632a32e7cc3117b.1524122311.git.baolin.wang@linaro.org>
User-Agent: Mutt/1.9.5 (2018-04-13)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598158286152327391?=
X-GMAIL-MSGID: =?utf-8?q?1599937689712465867?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


--4Ckj6UjgE2iN1+kY
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 19, 2018 at 03:21:06PM +0800, Baolin Wang wrote:
> The dummy read_persistent_clock() uses a timespec, which is not year 2038
> safe on 32bit systems. Thus remove this obsolete interface.
>=20
> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>

Thanks, Applied for 4.18

Cheers
James

--4Ckj6UjgE2iN1+kY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYIAB0WIQS7lRNBWUYtqfDOVL41zuSGKxAj8gUCWvIoUgAKCRA1zuSGKxAj
8vS4AP9G9TITH8OmV4hy28j1OuTtQir/h6zdcIAbY7cVMPZidwD+OnxkYVBoTgzF
EmysGvCMlIsqgndv2ld2F4zHvbozOw4=
=18he
-----END PGP SIGNATURE-----

--4Ckj6UjgE2iN1+kY--
