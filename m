Return-Path: <sfr@canb.auug.org.au>
X-Cyrus-Session-Id: sloti22d1t05-121997-1526272649-2-11253712804416698896
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
    1526272649; b=idK0rU+MXpIAY/Q6f6QpCGMc1fdhCetkhfEN/6m/UV16WwtG6P
    GDickoDPL0JEoV9Qd5IFRuW6S8su6emAI/ESjfjQzlxZRArgSi0T0dj0Dzgoz4vg
    FWIdhg9ueEN18sn/5+tE6PBa7B+omp8yvTKWkiOdyn8XmT62Dc+LSnE56fhgFLl6
    qbAlCmcm8885aDGQbCpfNamd94O7FvaTz5/xu59ytolskcn84TMQgvTkriYSgMNi
    TbIvOIQ71jMC1jibIBSPqoWPhqZraHNsJ38271xteY3WbPRaNR8ph5IlQjbCIU09
    q43iY9fSyCGdHCqAU4mhagLknimuNW1iAVvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :mime-version:content-type; s=fm2; t=1526272649; bh=IxBdU/O7ZQ+o
    vroj8FmssK1YPpLZSKqbE47zzWq/E3M=; b=YbmmsA+UQyiPRvdCEOKrbSPqi9P6
    kkXkljDX3mDAxFnti7nwk4345BE1L7pN6VHK3JR9fSahBpOy27vxc4UpwssIG4Hj
    jxeIY45hTUHadIgkEnN80IApAglpaP5u05KKq7iTV7ayA02A3PIY0TNK9BWqE2nl
    RE3LopP3ndK1KNYVph2RXB28GNowhsTzixnuVsUo5m2Hl1iH0XQdFHvTR2ce698O
    I1ZeixlBYit0gxY6dXmAxnaXFIM/aUMJQ/CWOSn7DQxB1PABLVZrVW1WbClBpp0y
    LmPDEFK/h8FeE5GeKxTNjEXBMidmkv18WBIHe2BGgQ0S4wdtNCJ8rMO6rA==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=canb.auug.org.au
    header.i=@canb.auug.org.au header.b=aaiABkw0 x-bits=2048 x-keytype=rsa
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
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=canb.auug.org.au
      header.i=@canb.auug.org.au header.b=aaiABkw0 x-bits=2048 x-keytype=rsa
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
X-CM-Envelope: MS4wfAGXFzGhqGi7Wa52WWcJRxmExpZOsXrrN3CJyIj2VTgyKR45ozQa6skQWus0l8KFWj2I30r6yEhqmKOmEhEbM4t6kaDfsNBSFksMYyPqXcS5JL88z6iI
    GYFdXv6UofaJISPvLRuELTlDDl+qWaa4yHAgX7F0zQCqcw78V/P1UjXa
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=CXkk7yaifMICXdoo4J6eGQ==:117
    a=CXkk7yaifMICXdoo4J6eGQ==:17 a=VUJBJC2UJ8kA:10 a=p1HXTWX0u1CjduapzaEA:9
    a=CjuIK1q_8ugA:10 a=gXYTQ4qaWoa2cTwOadcA:9
X-ME-CMScore: 0
X-ME-CMCategory: none
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Date: Mon, 14 May 2018 14:37:23 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Greg KH <greg@kroah.com>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>, Linux Kernel
 Mailing List <linux-kernel@vger.kernel.org>, Eric Anholt <eric@anholt.net>
Subject: linux-next: build warning after merge of the staging tree
Message-ID: <20180514143723.2227c8a5@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/D6XtAKlfQ2gPC2mW1H6jmmC"; protocol="application/pgp-signature"
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

--Sig_/D6XtAKlfQ2gPC2mW1H6jmmC
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Greg,

After merging the staging tree, today's linux-next build (x86_64
allmodconfig) produced this warning:

WARNING: drivers/staging/vc04_services/bcm2835-camera/bcm2835-v4l2.o(.data+=
0x0): Section mismatch in reference from the variable bcm2835_camera_driver=
 to the function .init.text:bcm2835_mmal_probe()
The variable bcm2835_camera_driver references
the function __init bcm2835_mmal_probe()
If the reference is valid then annotate the
variable with __init* or __refdata (see linux/init.h) or name the variable:
*_template, *_timer, *_sht, *_ops, *_probe, *_probe_one, *_console

WARNING: drivers/staging/vc04_services/bcm2835-camera/bcm2835-v4l2.o(.data+=
0x0): Section mismatch in reference from the variable bcm2835_camera_driver=
 to the function .init.text:bcm2835_mmal_probe()
The variable bcm2835_camera_driver references
the function __init bcm2835_mmal_probe()
If the reference is valid then annotate the
variable with __init* or __refdata (see linux/init.h) or name the variable:
*_template, *_timer, *_sht, *_ops, *_probe, *_probe_one, *_console

Introduced by commit

  4bebb0312ea9 ("staging/bcm2835-camera: Set ourselves up as a platform dri=
ver.")

--=20
Cheers,
Stephen Rothwell

--Sig_/D6XtAKlfQ2gPC2mW1H6jmmC
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlr5EoMACgkQAVBC80lX
0GzU1wf/QYYW7t0+CcLI/wcrqPR0Wqfx30JpHdVDIHuk6SAVhox+nkdmfud1lNUu
1cgujGkmpVJrrfjFr1uVmHjbPEQR+l3DrU2stdQZD9fTmi7CWpcozUdSmTP1ee4O
cxifICSTJ+E+ahlt9yitIYHHzc0Q4PmeiUMtKRntpFEMFw9SHXVu9mI/tQ/sPr6X
IJE2InvIxz19ItnGroESK+pTUjnRueGAcKXEWhC2k1xPDrrVmWvG68eaoKTugR43
BF6AxZ8zAqntFf5R2zXS3k7bgZmLetj7h7/tJde1MZNGed9XBOnexKlL1OeIug/Z
wvAR6v4EnV5d1FTdqCAFzChg3slqxw==
=zRyD
-----END PGP SIGNATURE-----

--Sig_/D6XtAKlfQ2gPC2mW1H6jmmC--
