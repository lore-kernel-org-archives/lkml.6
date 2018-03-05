Return-Path: <broonie@sirena.org.uk>
X-Google-Smtp-Source: AG47ELsFuxUYvb4p6UvzrS5NveXzGV6GVwZ/cHSTUsJOSvRYSKtuy8TMRzlnI5nal5e5H0Lbq4lY
ARC-Seal: i=1; a=rsa-sha256; t=1520252686; cv=none;
        d=google.com; s=arc-20160816;
        b=lf+3CvvwF86Bysc+zYq3/Y5Igq6KIwkvu8AGq/HsIFPf+eK2qRiOWq8F3jmcF328lU
         TrAs6EhNwlRXZKH3XES9PqkeaXIcIXM4AUJeh3bUuWIU+NJQIheZ4BG61YcI61m0Qz9t
         bg0hGUYxSApLg+Y6I9PS1qRqmfckBYP+tHK+jX1aCoucR5T8weDQB9DAYplNf0dmfVAI
         8pq3QTJVcj74U4/5xQkZhNJLBlSAWmiBZjLC/g9dcWEYTdZVrm3O0KQNShZl93KNVmb9
         h8pzb+RTaJIPf2ICP4djMozQTKyMzflp3aAXYmJN/VrH5iTfdNqgE3ezVTkMDHqrYnk3
         5Qtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=nPW8w4HP6fAbEwN5vgaoGyEZ9w0X8MIsOaA/LbxOwEM=;
        b=V9BOGdfDXT6q85y5jTHLTRn8QAi9jQMEYH3XaTLsCzesf8aEF3Juo3kw8zH3yWmIzN
         mA+AvUxp2lGFyy8dGjtzF7j+Ig1tfYZsTZdmvedBQ/nguhTBfyvzWduyZMum126LjPR+
         hENKTbrnmkS5BnH8iGp/6tYdlPToV9MRzMAAMcpueeEkEhNcuu5bBi4hFww2vPXYNzde
         mcQRQEO/GMeOt4IYjx5dBS8+d8MYwWgxGtZlaKVAtRK96fAQuuPBIUB69xYZdL0Uyfpq
         fcY3zv2FIeF/a6W8e9K29Umcur1RrpHnGMuopyasfJkmkC+1SewKg42qH3OLdB98l7Si
         shBg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@sirena.org.uk header.s=20170815-heliosphere header.b=SqW7/lZC;
       spf=pass (google.com: domain of broonie@sirena.org.uk designates 2a01:7e01::f03c:91ff:fed4:a3b6 as permitted sender) smtp.mailfrom=broonie@sirena.org.uk
Authentication-Results: mx.google.com;
       dkim=pass header.i=@sirena.org.uk header.s=20170815-heliosphere header.b=SqW7/lZC;
       spf=pass (google.com: domain of broonie@sirena.org.uk designates 2a01:7e01::f03c:91ff:fed4:a3b6 as permitted sender) smtp.mailfrom=broonie@sirena.org.uk
Date: Mon, 5 Mar 2018 12:24:29 +0000
From: Mark Brown <broonie@kernel.org>
To: Jeremy Linton <jeremy.linton@arm.com>
Cc: linux-acpi@vger.kernel.org, mark.rutland@arm.com,
	austinwc@codeaurora.org, tnowicki@caviumnetworks.com,
	catalin.marinas@arm.com, palmer@sifive.com, will.deacon@arm.com,
	linux-riscv@lists.infradead.org, morten.rasmussen@arm.com,
	vkilari@codeaurora.org, lorenzo.pieralisi@arm.com, ahs3@redhat.com,
	lenb@kernel.org, john.garry@huawei.com, wangxiongfeng2@huawei.com,
	dietmar.eggemann@arm.com, linux-arm-kernel@lists.infradead.org,
	gregkh@linuxfoundation.org, rjw@rjwysocki.net,
	linux-kernel@vger.kernel.org, hanjun.guo@linaro.org,
	sudeep.holla@arm.com
Subject: Re: [PATCH v7 10/13] arm64: topology: rename cluster_id
Message-ID: <20180305122429.GA25758@sirena.org.uk>
References: <20180228220619.6992-1-jeremy.linton@arm.com>
 <20180228220619.6992-11-jeremy.linton@arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Q68bSM7Ycu6FN28Q"
Content-Disposition: inline
In-Reply-To: <20180228220619.6992-11-jeremy.linton@arm.com>
X-Cookie: A mushroom cloud has no silver lining.
User-Agent: Mutt/1.9.3 (2018-01-21)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593684158298600286?=
X-GMAIL-MSGID: =?utf-8?q?1594100481582967141?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


--Q68bSM7Ycu6FN28Q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Feb 28, 2018 at 04:06:16PM -0600, Jeremy Linton wrote:

> Lets match the name of the arm64 topology field
> to the kernel macro that uses it.

I called it cluster ID in the code because that's what the documentation
for MPIDR called it IIRC.  Googling around suggests that this naming may
be being used by some of the DynamiQ stuff.

--Q68bSM7Ycu6FN28Q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlqdNvwACgkQJNaLcl1U
h9Ailwf/Qwu+y7xdbT7GgtW6ui93DR1UZAYyz6x9z58aVSxR9X96WSBLHdgEW3P1
3ieteClAVIxkmHxNDB6yEIw8895FcPrpZlLWbyAJTaDF/PdNd+AL0w99J+MC5yfR
It/terKGKUUbvdTOqK4ej7y2Bj+Q9kxt2/deRtpFVemBI0RI3IjCh14CsVb8+BqB
pCC8zWnDyrkp9YieLANgKCS5gFg6uJtRjo7gXSa/crPFrLLBX1acz7evv+2repu+
36Qn1o/j2K4NvmA80Q1Du/Xz/zh9P+X/v+zBgXu/j2J8rj10jE8Mfjpv+t/SG52n
AFYjinG601pr5pUrfarlII6W7ge0MA==
=zkjJ
-----END PGP SIGNATURE-----

--Q68bSM7Ycu6FN28Q--
