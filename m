Return-Path: <broonie@sirena.org.uk>
X-Google-Smtp-Source: AG47ELvsEBm1rNX9civtLv0yE4TkU4b69VCIxQOJCTjYmb97mq8ETr/lkMlWT4h0k0V8/4B5pB3G
ARC-Seal: i=1; a=rsa-sha256; t=1520341161; cv=none;
        d=google.com; s=arc-20160816;
        b=0/r/5yB5fyKgsN+5ICstECriF/lKY1pPP5Jd6J3jaQzLV8e1KqaQZu73xQ6FRqjZAk
         jcwMN8gWB1BZEbS+5V6uMl0O1H/YzEq+hoHF8/UuUJgNPM6HSA8xV4ED/L1Z2HyeQCT/
         EZIXOnE+WntqF98jAPTdcyDBWFCr4CGgRrPX1PPZWfS79W8ILMI2sKAWaj5uyV2BrDS6
         g4IxrDGR45aHljk0sSPIbHlvAWVwU7xoC9Z5Ijznev1G46ue0n/cVaUcb66G+9d3oTAO
         Vx9nfJC55es1ZF1JBevKIdoxyFS3947hO9++26rLXFXsYDhcQ1Scw/gayVZkdacQmk8F
         NrAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=lVmyHirXt8W+kAcxHnqwe1v1UuWaej9u7v/9mg+2JGQ=;
        b=cg0+9mOdSep+mm+jpi+79kQDbmJJx5Ai2O/z1jhJEuP41QrBM0rUhfDR8N51HyUX9Y
         DAGyRedrQ7d+ykAOwnAC95qrfDd4hx5hT/+qiDlogKbR9LOc9pAQm+Qb9EDMU5VdsejC
         /vwGo6LoLsTXjNflX0R713pCtMicr7paKasdTXYP1gLFNxHZULC285D7t6QKJFSgN9kT
         nNtN7pWvtoQ+gkbLopf7NniMhzklBzsibxlY4HgwZnOXh3jYgu2IK6uu6Colwg4NHc+w
         /FTf27ESYiTMjPfyVkodLP9VMdTSCB8u7NHkTz0CNGkysuNak8tSrnW0ociHNKL5OsLv
         bNEQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@sirena.org.uk header.s=20170815-heliosphere header.b=wI8rTnN+;
       spf=pass (google.com: domain of broonie@sirena.org.uk designates 2a01:7e01::f03c:91ff:fed4:a3b6 as permitted sender) smtp.mailfrom=broonie@sirena.org.uk
Authentication-Results: mx.google.com;
       dkim=pass header.i=@sirena.org.uk header.s=20170815-heliosphere header.b=wI8rTnN+;
       spf=pass (google.com: domain of broonie@sirena.org.uk designates 2a01:7e01::f03c:91ff:fed4:a3b6 as permitted sender) smtp.mailfrom=broonie@sirena.org.uk
Date: Tue, 6 Mar 2018 12:59:16 +0000
From: Mark Brown <broonie@kernel.org>
To: Jeffy Chen <jeffy.chen@rock-chips.com>
Cc: linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v2 2/3] regmap: debugfs: Fix kmemleak in
 regmap_debugfs_init
Message-ID: <20180306125916.GA13586@sirena.org.uk>
References: <20180306110403.14438-1-jeffy.chen@rock-chips.com>
 <20180306110403.14438-2-jeffy.chen@rock-chips.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="8t9RHnE3ZwKMSgU+"
Content-Disposition: inline
In-Reply-To: <20180306110403.14438-2-jeffy.chen@rock-chips.com>
X-Cookie: DYSLEXICS OF THE WORLD, UNTIE!
User-Agent: Mutt/1.9.3 (2018-01-21)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594186041905499825?=
X-GMAIL-MSGID: =?utf-8?q?1594193253525635767?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


--8t9RHnE3ZwKMSgU+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Mar 06, 2018 at 07:04:02PM +0800, Jeffy Chen wrote:
> Use map->debugfs_name to store allocated debugfs name, so it would be
> freed in regmap_debugfs_exit().

I'm missing patch 1 in this series and I think this collides with a fix
I already have locally.

--8t9RHnE3ZwKMSgU+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlqekKIACgkQJNaLcl1U
h9BxvQf8CnjHo7Ub+vPD/GGScxzxdH1/RT/Xx/DS2LsjT2AiWU+aKVCGyEQel8ap
7bAs9JarS5YHYJ5mK8uDqJCNOcdGiXgjQFLKswezShAZ30L+HhkMIqrLf+Otsmyb
fKM7JEIhUYPsio0PTQW7w+Ky00pc0b5bI3IU/zzdHfUCv9SJejNtNLgO1P3mRZms
IsQ97XhSFF2RVUjhxd1WsXHjtuO1PbqzBZKVm1/MgTfMFu83PEkQDa6a3S05kTQg
fc2UtXJuLT56ixmTgvalZm5lIRQb6ca6nGqWm31oxNMNHLHdu3TBSNk3SIR4FrYY
36n4PwwJFYm83ogIStVZ5gJogb9y1w==
=DaWd
-----END PGP SIGNATURE-----

--8t9RHnE3ZwKMSgU+--
