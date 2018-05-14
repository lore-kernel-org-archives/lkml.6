Return-Path: <sfr@canb.auug.org.au>
X-Cyrus-Session-Id: sloti22d1t05-121997-1526272452-2-15838938533270325359
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, SPF_HELO_PASS -0.001, SPF_PASS -0.001, LANGUAGES svdaen,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='203.11.71.1', Host='ozlabs.org', Country='AU', FromHeader='au',
  MailFrom='au'
X-Spam-charsets: plain='US-ASCII'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: sfr@canb.auug.org.au
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526272451; b=loCn+B1q/sGPVaCRYLjSLBsbW4T/QQjPXtg0STceH3o8/hSVQU
    yOCND5Q0PHjtU0XM1YFe1IrYfinO80vJ13I1whCuQLG0XlOCrKjceWK09BxJUiuf
    M5B2iGJ7w7uInMrAYoa737R/IDq1tgt74JvrokZpjZQjegIR3yccD8E0qu9ZH2Mc
    rjgUcDIupOS49PYwSfr6Iq6u7aw7ZKHwmqo6xVd9WkbR5lpASOUwdafqcY22E8qH
    ATOoaqJjBkytBD8QPwgC7ZvpM+aUBkpm0DuPnd7pwDRwyClHH7+BT2UkW1n+ZpuR
    fQsATOcpv4B9GA/RARCrb4ROnODcgots46bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :mime-version:content-type; s=fm2; t=1526272451; bh=ZcjaX4dlgnRe
    EuHLaBzegx5Hgfnpy6p+uy5gw1G+D0M=; b=j21tOCKWEe2gblpjOoXTRpptV503
    8qEqkGwYwicixovLLXTqqIsFsiB2+RIZ7JV4sKcEYwRhwzfBNBI0pl9RmMNUD3me
    17FESyjIEuKtVJutDxXGkqPHok686/LmKRdLfS/mUemZ2HJ+U0iZR9XjlOetBcpA
    Uk8vK0N/O/gTnooIXd9OiE0xHgNhBvvEyA+cViracr12ttF3JirX2cn2OKA3pSzB
    qeDT+AdJeF2njEJTSemZgyCBSeALSehvYaoCJjlNP+mXzNnodl9qDqjI0PFGE5kv
    JRXlFTu8mb5HGXzHj08Z+viTQz/UEwY3oKz1mpLsLgqdVNhng8QZp1H4YA==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=canb.auug.org.au
    header.i=@canb.auug.org.au header.b=ahENJ+4S x-bits=2048 x-keytype=rsa
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
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=canb.auug.org.au
      header.i=@canb.auug.org.au header.b=ahENJ+4S x-bits=2048 x-keytype=rsa
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
X-CM-Envelope: MS4wfDZJOeInSNL2NS8hEvsCdhtNTJthPXV57wv0v1khQtvpv+14+VW3zfovjR/wpwAmNaneulO1rlb4OR1J1i8KkTGHTHNuJQ31bZeCfLBn8lofrwd15q5x
    7imUkO/uEZOOPA64TdErZ14lUs4CWXkD3P/diB26Va9LhR9YIIHCe9l2
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=CXkk7yaifMICXdoo4J6eGQ==:117
    a=CXkk7yaifMICXdoo4J6eGQ==:17 a=VUJBJC2UJ8kA:10 a=CwoKSpiAJoL2ls-HpDUA:9
    a=CjuIK1q_8ugA:10 a=Yi6Em93UGeWImYIu7LsA:9
X-ME-CMScore: 0
X-ME-CMCategory: none
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Date: Mon, 14 May 2018 14:34:04 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Greg KH <greg@kroah.com>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>, Linux Kernel
 Mailing List <linux-kernel@vger.kernel.org>, Abdun Nihaal
 <abdun.nihaal@gmail.com>
Subject: linux-next: build warnings after merge of the staging tree
Message-ID: <20180514143404.28f0f4da@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/u+B+R8AE0DV4_D81VVehBkG"; protocol="application/pgp-signature"
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

--Sig_/u+B+R8AE0DV4_D81VVehBkG
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Greg,

After merging the staging tree, today's linux-next build (x86_64
allmodconfig) produced this warning:

drivers/staging/most/video/video.c: In function 'vidioc_enum_fmt_vid_cap':
drivers/staging/most/video/video.c:265:25: warning: unused variable 'mdev' =
[-Wunused-variable]
  struct most_video_dev *mdev =3D fh->mdev;
                         ^~~~
drivers/staging/most/video/video.c: In function 'vidioc_g_fmt_vid_cap':
drivers/staging/most/video/video.c:282:25: warning: unused variable 'mdev' =
[-Wunused-variable]
  struct most_video_dev *mdev =3D fh->mdev;
                         ^~~~
drivers/staging/most/video/video.c: In function 'vidioc_g_std':
drivers/staging/most/video/video.c:309:25: warning: unused variable 'mdev' =
[-Wunused-variable]
  struct most_video_dev *mdev =3D fh->mdev;
                         ^~~~

Introduced by commit

  7d7cdb4fa552 ("staging: most: video: remove debugging code")

--=20
Cheers,
Stephen Rothwell

--Sig_/u+B+R8AE0DV4_D81VVehBkG
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlr5EbwACgkQAVBC80lX
0GyGNwgAjA0LzxPi3bmlhD0W5wUpPD+XphUWqm2W41rF+ZxFzCudRh5naX04Ymrh
IoAd5qT7qv/76mo9fWsOA+jnWCfZtl9Y3gTQVq1ucnAiihJ9wiB41OGYN1RXMkPO
AS9UVNa7vpDmPPZw4Lgf8e/JVKKDjuy6lt6e56ki5RK13DExyoowMiAISpDboaWa
3AjC+Q+F6Cloue9PizpfIsCKKiIdu1hdSmME0cgHkJ5xeoGZzOGPhxDxFWaUCmXs
fv5flIaOqnQG5WLY6N+5zR9uWtzLUspjfuwjR+PPRoAdLnDoKeDHpBZirbkA+fmM
P+/rzJXMsW4CeEB8ow5PFFZWOg32kQ==
=406w
-----END PGP SIGNATURE-----

--Sig_/u+B+R8AE0DV4_D81VVehBkG--
