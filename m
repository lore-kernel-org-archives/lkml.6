Return-Path: <sfr@canb.auug.org.au>
X-Cyrus-Session-Id: sloti22d1t05-1141254-1519336337-3-9067053357802966590
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, RCVD_IN_DNSWL_MED -2.3, SPF_HELO_PASS -0.001,
  SPF_PASS -0.001, LANGUAGES unknown, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='103.22.144.67', Host='ozlabs.org', Country='AU', FromHeader='au',
  MailFrom='au'
X-Spam-charsets: plain='US-ASCII'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: sfr@canb.auug.org.au
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519336336; b=QQ6PKPUHwBvqg+T2Tc7bsE3SHeEudC8mVVZHaw9qBVGIO7g
    JmF1IRXJuQIk5d3FMOKb1vXZhQCysKXbGe/FTd6rHk4+GfCIqAoc/5f8MierPl9m
    Iy4td4uE0bECBRKKxfN5/KI58lo4P39igaAXTpxfn0c0TdIletVolanfid7lhOyU
    o60tpzjG8rvfXk/aqNOwh+R+c4WH6qacOg/AA1g5SaIH/rirz3IDfETS39jPgM0h
    +DiaTG45Nl9pGu88vxVNdyJdSsuEiJjNliTE25BocjINtW5vumh8FQTR3fTEAjOy
    RqpG5UAFwVqhOBNXQX9gPbDV0Xgt1SOBkmBkBOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :mime-version:content-type; s=arctest; t=1519336336; bh=DvQtB7Tv
    XNkzimRJLVY2Hzj1S6eLxYHA+ou+llbTJcY=; b=bhd8GKraV9C8EoQG85q5/cnL
    A8/T3qZDEMt0+thWJOrUZjdOsdsJ6IGcoc3l7aYu+fIj8nTAjs8Gi+MCQRZ1nPE6
    nVcmWk5xUPI8PYInEz1cCfLPpzthHtZZdm5GRrjsh1yZlUp9i5G5djDhLp8gmr8V
    fACHIlvshKplGh0dhXsSnNmAVS+uxaok0q3HjGj2sxp5TVhF7xi76wCWuRcCmHfq
    xntqVNNpEgT7MVOoxcixwVfEYLjFPJUoYLAFIsjHI1Y85+1rp6zYyv/3f3iMFlnl
    ErhXrR/pD45tvJknPETIeJVAdBzzGsC6eJ1mrrv55AKP2NREfz2ISYRj+YUlLg==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=cjvLx6ZO x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=201702;
    dmarc=none (p=none,d=none) header.from=canb.auug.org.au;
    iprev=pass policy.iprev=103.22.144.67 (ozlabs.org);
    smime=temperror;
    spf=pass smtp.mailfrom=sfr@canb.auug.org.au smtp.helo=ozlabs.org;
    x-aligned-from=pass;
    x-ptr=pass x-ptr-helo=ozlabs.org x-ptr-lookup=ozlabs.org;
    x-return-mx=pass smtp.domain=canb.auug.org.au smtp.result=pass smtp_org.domain=auug.org.au smtp_org.result=pass smtp_is_org_domain=no header.domain=canb.auug.org.au header.result=pass header_org.domain=auug.org.au header_org.result=pass header_is_org_domain=no;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=cjvLx6ZO x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=201702;
    dmarc=none (p=none,d=none) header.from=canb.auug.org.au;
    iprev=pass policy.iprev=103.22.144.67 (ozlabs.org);
    smime=temperror;
    spf=pass smtp.mailfrom=sfr@canb.auug.org.au smtp.helo=ozlabs.org;
    x-aligned-from=pass;
    x-ptr=pass x-ptr-helo=ozlabs.org x-ptr-lookup=ozlabs.org;
    x-return-mx=pass smtp.domain=canb.auug.org.au smtp.result=pass smtp_org.domain=auug.org.au smtp_org.result=pass smtp_is_org_domain=no header.domain=canb.auug.org.au header.result=pass header_org.domain=auug.org.au header_org.result=pass header_is_org_domain=no;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Date: Fri, 23 Feb 2018 08:51:37 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Greg KH <greg@kroah.com>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>, Linux Kernel
 Mailing List <linux-kernel@vger.kernel.org>, NeilBrown <neilb@suse.com>
Subject: linux-next: Signed-off-by missing for commit in the staging tree
Message-ID: <20180223085137.625574c2@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/Dk8PI7qbJ9IeIbOrbNb95PE"; protocol="application/pgp-signature"
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

--Sig_/Dk8PI7qbJ9IeIbOrbNb95PE
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Greg,

Commit

  cc738c1a69da ("staging: lustre: opencode cfs_cap_{raise, lower, raised}")

is missing a Signed-off-by from its author.

--=20
Cheers,
Stephen Rothwell

--Sig_/Dk8PI7qbJ9IeIbOrbNb95PE
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlqPO2kACgkQAVBC80lX
0Gy/DggAlXspU8m5/CBOLHJEaDFfBZs6Opuh8186wj4e6WkDAAtnKyd/8H2bkVva
07+eZRzmQmPf4iujP978bwFo642JED87zu0Lh/Yt4/kcjowicYKVqK1QpxgLAkhT
in6NIK04Y6MaH9Zx+r1kN4B8ykHOMsJnTp2iPgHmrGhCdGTqdyhZ/nS7qqSygzhV
nRymUzEQbzgvEu/nLPQGT0Awluc2Z/SqlYJCm0Zh6O90HZddeGqsnyPL2zYyYsuj
q/mdvvVDqfozO4V46f0oP1Psk3f6JrGUK5AuG8KZj2pTq7Js52inZqp1xDn8LhtP
JmF7ErkLIW+CeWBRCdDkP3ELy2Fnaw==
=kxtJ
-----END PGP SIGNATURE-----

--Sig_/Dk8PI7qbJ9IeIbOrbNb95PE--
