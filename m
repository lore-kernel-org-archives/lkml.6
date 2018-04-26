Return-Path: <broonie@sirena.org.uk>
X-Google-Smtp-Source: AIpwx49mGSeEDRsigsc/oeyFqXdBeC0KhrWlMoQg2l9FCmD4qyQD6FrEhIXI4H27JeGejMGKy7+M
ARC-Seal: i=1; a=rsa-sha256; t=1524742763; cv=none;
        d=google.com; s=arc-20160816;
        b=tX41Njw5BRpQv9GyeripeFZKO6pwsuOqma4uKPXq+dg8qfUFPta6Q+2nLJgyk+Btiq
         usViI10HKMQ4Izm5O6ILf5BY50kXj9DLrIzCIAb4LF/mbdqC2KzRLW1PudEy1pvB+QPt
         GD/OJQms0B4m6uSOFFfKDt8+lgqpkv/cWM6eyH9JWufXPmrH0L+JzVzKUrY7Kldulf2w
         /G52rQphLEv8dzomg6OSZM8b7ICuv+PvvAUI4FGgn4AgUfwHiRT091AHYeRzGYUh6bIA
         kw10pAibkuENhrFJnT0oKO4EaQ6MicvTNjTwFA4Wx/5PA9XSzN1deXGQ5oYeowS4uDTP
         HEHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=7/j2VCd0ifnO832zCM53sv7qGHvd7f+uJOuuMWj6x0g=;
        b=vj+y/pEfo4tfM03zmjJCtzzbBaLV3PqO1gz0a9w9I6pKRZ1SfVPOMGL4OD7EwdjsaS
         OgEzibFgIFtEhjlid5lcGDGzXan+jwo9dKV27pS6Q0Xik5dlHSXZovis1MS0cl3vxV4v
         Qt7X56e9xBXGSXw+K4MHFvgNyfxhAdNe4/NNsZHHE6Mqfx0UbMBvyjWf79O3abYqq9g0
         oZy0rY99BdGQc2MC1CuBppB86nrQ/Gwg2VFCBidnKTdhY/skh2VCP5/+HYFOJDfoWGso
         NtduYcoUBpeaZO412pOaWwOYs2jhK+RxA0wCW+VGxdFO8Ha4hrl4QKpaX6cVLC81yK0b
         854g==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@sirena.org.uk header.s=20170815-heliosphere header.b=X4XhW4J+;
       spf=pass (google.com: domain of broonie@sirena.org.uk designates 2a01:7e01::f03c:91ff:fed4:a3b6 as permitted sender) smtp.mailfrom=broonie@sirena.org.uk
Authentication-Results: mx.google.com;
       dkim=pass header.i=@sirena.org.uk header.s=20170815-heliosphere header.b=X4XhW4J+;
       spf=pass (google.com: domain of broonie@sirena.org.uk designates 2a01:7e01::f03c:91ff:fed4:a3b6 as permitted sender) smtp.mailfrom=broonie@sirena.org.uk
Date: Thu, 26 Apr 2018 12:39:11 +0100
From: Mark Brown <broonie@kernel.org>
To: srinivas.kandagatla@linaro.org
Cc: andy.gross@linaro.org, linux-arm-msm@vger.kernel.org,
	alsa-devel@alsa-project.org, robh+dt@kernel.org,
	bgoswami@codeaurora.org, gregkh@linuxfoundation.org,
	david.brown@linaro.org, mark.rutland@arm.com, lgirdwood@gmail.com,
	plai@codeaurora.org, tiwai@suse.com, perex@perex.cz,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, rohkumar@qti.qualcomm.com,
	spatakok@qti.qualcomm.com
Subject: Re: [PATCH v6 02/24] soc: qcom: Add APR bus driver
Message-ID: <20180426113911.GA21755@sirena.org.uk>
References: <20180426094606.4775-1-srinivas.kandagatla@linaro.org>
 <20180426094606.4775-3-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="bg08WKrSYDhXBjb5"
Content-Disposition: inline
In-Reply-To: <20180426094606.4775-3-srinivas.kandagatla@linaro.org>
X-Cookie: Where do you think you're going today?
User-Agent: Mutt/1.9.4 (2018-02-28)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598801756443527719?=
X-GMAIL-MSGID: =?utf-8?q?1598808667390641382?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


--bg08WKrSYDhXBjb5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 26, 2018 at 10:45:44AM +0100, srinivas.kandagatla@linaro.org wr=
ote:
> From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>=20
> This patch adds support toi APR bus (Asynchronous Packet Router) driver.
> ARP driver is made as a bus driver so that the apr devices can added remo=
ved

What is the plan for getting this patch merged?  I think the only review
I've seen from maintainers thus far has been from Rob on the DT binding.
It's obviously going to be a dependency for everything else.

Also just saw ARP->APR there.

--bg08WKrSYDhXBjb5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlrhul4ACgkQJNaLcl1U
h9CgQQf/auIda6Dzw79FRXmW5P9u1HmRvwFwIj/szesf68wOagvCtVRoYvjSDS1W
w9GujIX0dYGRMmClXB2WN+cR6nQYhaPsOLv02wAnLkhUjT6/qm0v73Oa7n3v20hN
okuwDTa03R2BBn7eyrBnt7iLT5PEu3oP4tsJZZL4WPb5STMVXhHLJyzv4SfSjAhM
yACHFUEBSMIoSP+ylpv+gaBW3ibu5wY5IAouxJ23BvwADCufIBT0enFihaUsMImd
QC6WHhQJEhIOq0lfrStSQ0UuI1e9lufN2d8GTwWf1FYQlyIl53G4fSGbZJymsLzZ
qeWZq7sY+4eJmQL0v6cJbPr8t+Y7cQ==
=MK0Z
-----END PGP SIGNATURE-----

--bg08WKrSYDhXBjb5--
