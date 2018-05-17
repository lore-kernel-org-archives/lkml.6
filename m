Return-Path: <broonie@sirena.org.uk>
X-Google-Smtp-Source: AB8JxZoV60q0+imoqrR7gUwlcSMRxvzxVivC8fMm3MRexm362KWxXWjQKxBTo4LnC3vBhro8mrk5
ARC-Seal: i=1; a=rsa-sha256; t=1526575503; cv=none;
        d=google.com; s=arc-20160816;
        b=COpqhiSf/chp2SISTnk7OrZUJGLPjKkLy0DB7Efp/VI1v1a4Y1pPEviag6AEeLLXFO
         R1HVqkeX9FdYyV8meMNngtr4ff5k5b0GLbn45ydGx8Pi/kVB0D7FbyXrq3UEcfvHHSYE
         hYKi00PY61+m3fzNTjrKAcL4Ptx1LVifgZtBHK9nFcAc5r9OwRd6CaFVZ+ZRTfz05r6s
         C4Nyb1PlB2Hi8U/PGOKsyg1L7kVle9vne9+75GSYf2NBA6tosW/HMoH+e4dt2Kr9axvq
         eeTStL+ySJDPgqPyEnSWm5wt2Wv6kE9ezunE942t7yLTbAh5FYw3a1J1dA7o3cCvXeZR
         wXCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=B2PKIcayfuKnJY/h4vuSWhPEkljXZNacPNRMsaCN2h4=;
        b=uyV2XNO/ghyr+0t2nxQBzp995I8p5SZ+SHukbq4/6LPVOjsfh2KlwEuWnCSldI/vrn
         q/yuHI0fnyjMVPNJxnwWyAtSFnbVTKk3P5Z2511iRaAILqt/OBPgOlGCCAH7UF8DI+5M
         bnhtXpcc5CqyhdKMjKp7uGgBJR2eAXZqwQ1D92Pk9ip6ewFgf8B3SfwlWwlnUYEYRI6x
         trVnIr2qGzpbMVQ18A/MpifVvmeD3V/dzs42CJJMn8DhigWsQw3ZwrJIGF9v/av/twgE
         E8Fcy1cubA4AGB6/UuqEeAR4Qnot4aV+k+waYqYKt+fo7KlzjmSZ6MDzpcKkdIagHVM6
         jMWA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@sirena.org.uk header.s=20170815-heliosphere header.b=AuN/IrI3;
       spf=pass (google.com: domain of broonie@sirena.org.uk designates 2a01:7e01::f03c:91ff:fed4:a3b6 as permitted sender) smtp.mailfrom=broonie@sirena.org.uk;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@sirena.org.uk header.s=20170815-heliosphere header.b=AuN/IrI3;
       spf=pass (google.com: domain of broonie@sirena.org.uk designates 2a01:7e01::f03c:91ff:fed4:a3b6 as permitted sender) smtp.mailfrom=broonie@sirena.org.uk;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=kernel.org
Date: Thu, 17 May 2018 14:10:15 +0900
From: Mark Brown <broonie@kernel.org>
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
	Daniel Vetter <daniel.vetter@ffwll.ch>,
	Greg KH <gregkh@linuxfoundation.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"ksummit-discuss@lists.linuxfoundation.org" <ksummit-discuss@lists.linuxfoundation.org>,
	"w@1wt.eu" <w@1wt.eu>
Subject: Re: [Ksummit-discuss] bug-introducing patches
Message-ID: <20180517051015.GH20254@sirena.org.uk>
References: <20180503031000.GC29205@thunk.org>
 <0276fcda-0385-8f22-dbdb-e063f7ed8bbe@roeck-us.net>
 <20180503224217.GR2714@sirena.org.uk>
 <20180503230905.GA98604@atomide.com>
 <CAPDyKFrCKkRHwOh-7yfFbvMp+Ykhs7oXrDwhTShSPvUBvpn2ZQ@mail.gmail.com>
 <20180509084440.GW13402@sirena.org.uk>
 <CAKMK7uEWYmhA3owSeYM9tNA0tpMm5=4Yqda2j=VfMWi7i8ya8w@mail.gmail.com>
 <20180509090346.GY13402@sirena.org.uk>
 <20180509204727.7ff38021@canb.auug.org.au>
 <CAPDyKFrhRtLUFfmNNg0iPtJ+Tj5ZzDq6EsYPFc=PY7CmqkFX-g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Enx9fNJ0XV5HaWRu"
Content-Disposition: inline
In-Reply-To: <CAPDyKFrhRtLUFfmNNg0iPtJ+Tj5ZzDq6EsYPFc=PY7CmqkFX-g@mail.gmail.com>
X-Cookie: Are you a turtle?
User-Agent: Mutt/1.9.5 (2018-04-13)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcSW1wb3J0YW50Ig==?=
X-GMAIL-THRID: =?utf-8?q?1600003109861123526?=
X-GMAIL-MSGID: =?utf-8?q?1600730435234789348?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


--Enx9fNJ0XV5HaWRu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, May 14, 2018 at 10:36:04AM +0200, Ulf Hansson wrote:

> I will ping the kernelci folkz to request them to include your new
> fixes branch for daily builds.

No need, I already added it.

--Enx9fNJ0XV5HaWRu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlr9DrcACgkQJNaLcl1U
h9Cq3wf/Tbiuue1NyeqRMTkySgYEB+jvkhuFBEjKp8jPufkrABCZS3rzqJ0rREPs
B6B+H0vbla3tWgY3BHwx6lCv1rt9E+ivY7JA70bSBwYrjkIEhSnbmi4t5dOz/Uc5
gaXS6B9a/sh54Kv6YbhcieWZOu8iApje0VRTYQg/634xexy2KkvjHps1Q0outpWw
Jzr2mUU/GwqKQHCIUVujyY+/CjitdXmi4yiOV+k8m+jCwValCtvydnlSJHyKFxHL
Pw/U9wLu4ZI5BbHGect8w1UBQAgDAVr/vZXXUYLzDo/FRJCsRPfn00gKhvQabEWE
3O7dtN2yt92srUYU51fcyPY6o7WWPA==
=569S
-----END PGP SIGNATURE-----

--Enx9fNJ0XV5HaWRu--
