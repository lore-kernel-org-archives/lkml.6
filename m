Return-Path: <broonie@sirena.org.uk>
X-Google-Smtp-Source: AB8JxZq+wexchAHVcgHscLgKpcHrI/0ZEj2rUXA1eYjm5pbk8upS7iB3sJ2eWQrpAB8Bs4eu7F/X
ARC-Seal: i=1; a=rsa-sha256; t=1524827186; cv=none;
        d=google.com; s=arc-20160816;
        b=QGIrahHfnOxKHKv8+WVNZmV1YKV25iDX1CNU38llI+Q4Pu8veLQ2dVaqWEw6hczSte
         /fsaBND0mwSOPy+CTRhts3hETY46BDXUylwjWikLvjSoxLAKUMWMBBKKlghxsci8KHOM
         WN+44ELFXLPyz1+hOdvdVnQZ8z/mdVe2VKQ9393BU7EpYosCpg3NB3S9zWqNjhl3J4zh
         wtvKD+zP828QMt9srFDyvdXRDAshqOHYmxpcNgaHxJwmoQ6eEWqBrgiGgLjGSuRJ4bRP
         GUTsEMguME3hbdj5GFDnjS8iwzlFTSBu/wwOD4dcKhL8gXapmxsnFGBPDZkn1iMxyHiW
         IJyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=Zk0VDvAdT7Y+p+KFtXAzxC0k31nVdvG2ZxOsCYAdZTw=;
        b=zTloRhIjKAJj7wJLFlHnW11wXpGOQjlROCfKdOcMvt51hd2/uLmnv/7wJEgXaafJ7S
         GgPyIc0Huk/1ZivKyt6Qtqi5kVGQttMINzy5sUJRvsM23fWKBB3/nsHyYf7px4TotqiW
         6zXIe4PISFYTX2AP9KjmGza9EKeOqEYYda8Olx9cFveB9KVw5VLQp9ESHuDdbATVLyIz
         r6HJLtA/IVwJqlGMh2wBsCHRp611HJ4a2U+mDI1s0+dfxQEmO4zoXdwD5PJQKW13QFvl
         0poS7cT5LDOvE+509bUvVVRimAGq5HblefbqURWbNDVew0m6TnXDzwvxvAHL0kU8iYZX
         QH4A==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@sirena.org.uk header.s=20170815-heliosphere header.b=Fe+TJWqv;
       spf=pass (google.com: domain of broonie@sirena.org.uk designates 2a01:7e01::f03c:91ff:fed4:a3b6 as permitted sender) smtp.mailfrom=broonie@sirena.org.uk
Authentication-Results: mx.google.com;
       dkim=pass header.i=@sirena.org.uk header.s=20170815-heliosphere header.b=Fe+TJWqv;
       spf=pass (google.com: domain of broonie@sirena.org.uk designates 2a01:7e01::f03c:91ff:fed4:a3b6 as permitted sender) smtp.mailfrom=broonie@sirena.org.uk
Date: Fri, 27 Apr 2018 12:06:12 +0100
From: Mark Brown <broonie@kernel.org>
To: Andy Gross <andy.gross@linaro.org>
Cc: srinivas.kandagatla@linaro.org, mark.rutland@arm.com,
	devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
	bgoswami@codeaurora.org, rohkumar@qti.qualcomm.com,
	linux-arm-msm@vger.kernel.org, plai@codeaurora.org,
	spatakok@qti.qualcomm.com, lgirdwood@gmail.com, tiwai@suse.com,
	david.brown@linaro.org, robh+dt@kernel.org,
	linux-arm-kernel@lists.infradead.org, gregkh@linuxfoundation.org,
	perex@perex.cz, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 02/24] soc: qcom: Add APR bus driver
Message-ID: <20180427110612.GD6872@sirena.org.uk>
References: <20180426094606.4775-1-srinivas.kandagatla@linaro.org>
 <20180426094606.4775-3-srinivas.kandagatla@linaro.org>
 <20180426113911.GA21755@sirena.org.uk>
 <20180426211740.GC25699@hector.attlocal.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="fXStkuK2IQBfcDe+"
Content-Disposition: inline
In-Reply-To: <20180426211740.GC25699@hector.attlocal.net>
X-Cookie: Honk if you love peace and quiet.
User-Agent: Mutt/1.9.4 (2018-02-28)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598801756443527719?=
X-GMAIL-MSGID: =?utf-8?q?1598897191822552211?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


--fXStkuK2IQBfcDe+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Apr 26, 2018 at 04:17:40PM -0500, Andy Gross wrote:

> I just acked this, so it'd be great if you took it along with the others.  If
> you don't want to do that, I can just pull it in with my pull requests.

> Up to you,

That's fine, I'm happy to take it - I just wanted to work out what was
going on.

--fXStkuK2IQBfcDe+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlrjBCMACgkQJNaLcl1U
h9AaSgf9F1GOLrMf39dFFBWFnDM7HginCwTVyqz9rxLCJbOd1cU/32DztQembUnH
haj5X7AC14see7qqLNMfL3t0UAjFkqYVIyapxHTfWTSCyjWUDqWbwSF1Nn+7SkYN
giikT0zMJugfrvEUdRnY35AObZLKpEjQM4XlJ8Wf710pMoQ2/voosVXwZUhvyWa7
Z80OzB/kaHPLlXoMWaKLBj+kHkkhWsgsP38Ppby6KawEUJWExVuDmCvwmJoVrDWC
kYEjpSEeR2mfT0eMkBWvhtAkOtXTMM324EfUbbIFo7DSUASLgUFRP74b//SWjHJP
B1BY7wyfwZ9Ma0mFkkHDTWL4NzY0Pg==
=aRHi
-----END PGP SIGNATURE-----

--fXStkuK2IQBfcDe+--
