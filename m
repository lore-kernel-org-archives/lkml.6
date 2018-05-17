Return-Path: <sfr@canb.auug.org.au>
X-Cyrus-Session-Id: sloti22d1t05-1376423-1526530656-2-9827661306699449272
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, SPF_HELO_PASS -0.001, SPF_PASS -0.001, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='203.11.71.1', Host='ozlabs.org', Country='AU', FromHeader='au',
  MailFrom='au'
X-Spam-charsets: plain='US-ASCII'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: sfr@canb.auug.org.au
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526530655; b=X7SKIoGF8tP1kPpYFk/kg2577HzIwRsG8E5b8gDZzTLXoviozj
    jIBOgplv4lHZWbNKAXVRu4mCl9vwKO9r1la+ohhsbol506ULRrAvUDUt3DrWzJzG
    2uY3UavtGzSMw3/vSluV/dihl2o9Y0nyIRQY8zH7A/AZ42XNhLFCiqgUC/GDjZRZ
    vMWmzVx4IY7W0J7PbZiegMTiBZknUNP3Iy6N8gtGGWhDjNngLx8x0BAME4MhBUk7
    DCgMUmohAuJt0EAjBf9eordRWVHrkqXNTt8e6qNQyj4Qu0PoEIRF2Fdih7fcvi9/
    4TurHBrsm+LCD2tNp5ZmbhTEBOTGDMoX1WGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :mime-version:content-type; s=fm2; t=1526530655; bh=iLiKkS7ZqN9e
    wj3oZ+aReG6MGkrIIMNiJohzNwb8R4g=; b=iEEFVPABt994s56gopYGrr+YNoDt
    7Arxk0krossPsOrqgFIPnjALKFokLPNmgFub4thp6OAHJ6T0WZ4Gned6UzQg65FQ
    QFRQgDN5OZLt0m6URzQgYdZ1bZu2PrqW5NLiX/PYlK2i1GlrS4EbJmgc9GnLIdY8
    nvkJAHEcr4qJoz3e+WStabaRhLe44UxGg1nTDa+NPqxJwOEfIF5z8Bjag/Vys2I/
    R8Ig6gG67UjKysd4lnwAGHkogXVGChadyVLl85elq8L0PPPzED/tHvR3j8YwaHmI
    k3B2X4DCWpFW3mclq734Bwj/yVpHlsWZD/0gZX6fgRTFfQV85Ok5rVqoSw==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=canb.auug.org.au
    header.i=@canb.auug.org.au header.b=uq8MhUbP x-bits=2048 x-keytype=rsa
    x-algorithm=sha256 x-selector=201702;
    dmarc=none (p=none,d=none) header.from=canb.auug.org.au;
    iprev=pass policy.iprev=203.11.71.1 (ozlabs.org);
    spf=pass smtp.mailfrom=sfr@canb.auug.org.au smtp.helo=ozlabs.org;
    x-aligned-from=pass (Address match);
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=ozlabs.org x-ptr-lookup=ozlabs.org;
    x-return-mx=pass smtp.domain=canb.auug.org.au smtp.result=pass
    smtp_org.domain=auug.org.au smtp_org.result=pass smtp_is_org_domain=no
    header.domain=canb.auug.org.au header.result=pass
    header_org.domain=auug.org.au header_org.result=pass
    header_is_org_domain=no;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
    bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=canb.auug.org.au
      header.i=@canb.auug.org.au header.b=uq8MhUbP x-bits=2048 x-keytype=rsa
      x-algorithm=sha256 x-selector=201702;
    dmarc=none (p=none,d=none) header.from=canb.auug.org.au;
    iprev=pass policy.iprev=203.11.71.1 (ozlabs.org);
    spf=pass smtp.mailfrom=sfr@canb.auug.org.au smtp.helo=ozlabs.org;
    x-aligned-from=pass (Address match);
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=ozlabs.org x-ptr-lookup=ozlabs.org;
    x-return-mx=pass smtp.domain=canb.auug.org.au smtp.result=pass
      smtp_org.domain=auug.org.au smtp_org.result=pass smtp_is_org_domain=no
      header.domain=canb.auug.org.au header.result=pass
      header_org.domain=auug.org.au header_org.result=pass
      header_is_org_domain=no;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
      bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfDaCoYJntq/29ca1qJRgHdcH0lHemTa/xDPFvDxAXm1XfSepiEhW5p6MhPfhGgbgApnd3+Yv1jAStbptDxkgubjxERJCrh6n1nr4xE1/ijuAR3Pb8r72
    JEd+a/qBe6CDdLTNWqEy7VSNd9ExYuulityU8n/Kiml7VNhriI2bjc6e
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=CXkk7yaifMICXdoo4J6eGQ==:117
    a=CXkk7yaifMICXdoo4J6eGQ==:17 a=VUJBJC2UJ8kA:10 a=l7hcehSRk-cl0uQWkQoA:9
    a=CjuIK1q_8ugA:10 a=HJvMzH8fk0rqN5kH_UMA:9
X-ME-CMScore: 0
X-ME-CMCategory: none
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Date: Thu, 17 May 2018 14:17:27 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Greg KH <greg@kroah.com>, Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>, Linux Kernel
 Mailing List <linux-kernel@vger.kernel.org>, Sakari Ailus
 <sakari.ailus@linux.intel.com>, Linus Walleij <linus.walleij@linaro.org>,
 Alan Cox <alan@linux.intel.com>, Andy Shevchenko
 <andriy.shevchenko@linux.intel.com>
Subject: linux-next: manual merge of the staging tree with the v4l-dvb tree
Message-ID: <20180517141727.3119e1da@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/VDskecHVq82fb9TxccKhCFK"; protocol="application/pgp-signature"
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

--Sig_/VDskecHVq82fb9TxccKhCFK
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the staging tree got a conflict in:

  drivers/staging/media/atomisp/TODO

between commit:

  51b8dc5163d2 ("media: staging: atomisp: Remove driver")

from the v4l-dvb tree and commit:

  1bd421154821 ("staging: atomisp: Augment TODO file with GPIO work item")

from the staging tree.

I fixed it up (I just removed the file) and can carry the fix as
necessary. This is now fixed as far as linux-next is concerned, but any
non trivial conflicts should be mentioned to your upstream maintainer
when your tree is submitted for merging.  You may also want to consider
cooperating with the maintainer of the conflicting tree to minimise any
particularly complex conflicts.

--=20
Cheers,
Stephen Rothwell

--Sig_/VDskecHVq82fb9TxccKhCFK
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlr9AlcACgkQAVBC80lX
0GwJLAf/VZ+BycYvK+7jWCqN9o/7YALaOwXxFdqD4XGhlJ9+RQCgwhyoNrP7maVR
U0rbFrAkUV83bqT5jupQCHMwd8xna9bquBLohfq6KYEvhA8e1ozAULsIQPiJNKD2
rQOjyQHK8Cmh/VLpeDECJbgFrotCC/D+ypfAxxWUEKbRg9ukZwRaFtE9eTKm3QbV
APJpX8pUNd6Xs/Ey24yyc8GTRRMhzIuLn6L3i75OdNlM2LwOmBgxftjbE2CRlvM3
8C+AqbHPxyFRsp66Bsz4yk82bo3tfsdY17SfvgQ3CB8YUAZBUulwNQzbiS4uwFb0
cchSwAyhyM2IbIwYwmjJVGnxNgWEzQ==
=hzCw
-----END PGP SIGNATURE-----

--Sig_/VDskecHVq82fb9TxccKhCFK--
