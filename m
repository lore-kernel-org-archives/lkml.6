Return-Path: <broonie@sirena.org.uk>
X-Google-Smtp-Source: AIpwx4+GOc4eG4HCHvhjV6KkAVmMphOnevI7TgodhXQxVDh0sj5CDWyUXae6M5Tq9rjCySYaP15f
ARC-Seal: i=1; a=rsa-sha256; t=1523981463; cv=none;
        d=google.com; s=arc-20160816;
        b=Xzya3yzzkOvACXBJAJcJ71OloWvucZAu4gXW+Ccjh59nlEvzGd3iYsMVViciYfqmnl
         CCmoRYjlNaQDfuFz2bhR/NpMx52gfkbrd54QlzAvGCkWSzs0cXRi6ggJnr8d5DQW59JG
         gBYofHgs/Z3isbBCq48NlFu9vwvkk5u9tEr2c4lDEsUlVGLU3umcu2KElVJSBXVxYlz+
         jpMeycIBRqsj4qmvFdEyXNfLnH4OBZM/eB9z1vOuwloxc0JP5pW+g9trn9GgojziE0wu
         FWjFGK15pSabXa5KRIHh8KkSVDYhk8XRcGPoxsIZ+YWgLrIw5No+0dAsUW1hdKLVFp25
         aPwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=S8QnlqCCepiEzICgmzeErNtU2zpT0UGQcppA6o1FVXc=;
        b=E/oXigur4oOWuIMFa24wPP+UjcTuwuhsjYrk8YGbXVONnXCBmefx0buDgVRLXLXwaC
         QBCsrTDa0kiVXzAneGTKyVqCvzr1KVOZpU71UioXIwGIM93rDDk8lxSzB3GmfUl9ojCX
         NDV9hY7kFftwYiTNdRkjl5+pQI9XzeAnF+Q2bIKvbalWG6syEBmR5EBRb5Ila9c6S4dW
         ePgDe7Ni8f8sE4eLzLGf4W6ITLVmq6+ywfg21bb4LVgWSLgAxhDS26W8qFjtzhi9TDdi
         ZqZguYiyxMXgCcdjsnJIGFYeWgFE7y/XrPkC1MMR+GWLyxRggZTLsANrvT9AFpvRVZc6
         vwgg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@sirena.org.uk header.s=20170815-heliosphere header.b=w5ElUQzD;
       spf=pass (google.com: domain of broonie@sirena.org.uk designates 2a01:7e01::f03c:91ff:fed4:a3b6 as permitted sender) smtp.mailfrom=broonie@sirena.org.uk
Authentication-Results: mx.google.com;
       dkim=pass header.i=@sirena.org.uk header.s=20170815-heliosphere header.b=w5ElUQzD;
       spf=pass (google.com: domain of broonie@sirena.org.uk designates 2a01:7e01::f03c:91ff:fed4:a3b6 as permitted sender) smtp.mailfrom=broonie@sirena.org.uk
Date: Tue, 17 Apr 2018 17:10:25 +0100
From: Mark Brown <broonie@kernel.org>
To: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Cc: Akshu Agrawal <akshu.agrawal@amd.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Dylan Reid <dgreid@chromium.org>,
	Jason Clinton <jclinton@chromium.org>,
	Guenter Roeck <linux@roeck-us.net>,
	Thomas Gleixner <tglx@linutronix.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." <alsa-devel@alsa-project.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V2 4/4] ASoC: amd: enabling bt i2s config after acp reset
Message-ID: <20180417161025.GI8973@sirena.org.uk>
References: <1523941201-15665-5-git-send-email-Vijendar.Mukunda@amd.com>
 <1523980325-4242-1-git-send-email-Vijendar.Mukunda@amd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="J+eNKFoVC4T1DV3f"
Content-Disposition: inline
In-Reply-To: <1523980325-4242-1-git-send-email-Vijendar.Mukunda@amd.com>
X-Cookie: Depart in pieces, i.e., split.
User-Agent: Mutt/1.9.4 (2018-02-28)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597968144319777100?=
X-GMAIL-MSGID: =?utf-8?q?1598010386975316954?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


--J+eNKFoVC4T1DV3f
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Apr 17, 2018 at 09:21:45PM +0530, Vijendar Mukunda wrote:
> On ST/CZ based platforms, for specific platform bt uart
> mux to be defined for bt i2s.

Please don't send isolated patches numbered like they're in a series,
the numbering is only there so people know what order a series should be
handled in - outside of a series they mean nothing so just number within
what you're posting.

--J+eNKFoVC4T1DV3f
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlrWHHEACgkQJNaLcl1U
h9Cq+Af/TaC+eA4q7acZzjEJEHNo/NV+rJ7jkXgyShPLc5gQPQwbO+KEMhKGQ+gy
x/yT0/oh70jSxfpfPDktVrNqBTg27d2M13dxp2GhGjg41hTqzWvLWlGuaZhfCXbx
5IWtmJe9883L8wclEdgiTaN3xFUZQyQAj1tft26t3xn4yBR4TNdB8M8kJq527bZV
NKESwZfyjV/SV8hQju2e1pDeXYjtdDxVpsHpYVZ34Bn7BGHG/QsFfq4wmp2+Ob+p
A7bvIiGRXCYZkZD5aEnBuH9fLIen4C8qVGy7YbNjeWlGSsuHny2xwrkZBknRjni0
CL81mSijuXwj00PxNf/QYBtKJ/K6Cw==
=TMm9
-----END PGP SIGNATURE-----

--J+eNKFoVC4T1DV3f--
