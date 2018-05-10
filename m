Return-Path: <ksummit-discuss-bounces@lists.linuxfoundation.org>
X-Cyrus-Session-Id: sloti22d1t05-2792679-1525989678-2-2992218937400407620
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_HELO_PASS -0.001, SPF_PASS -0.001,
  LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.169.12', Host='mail.linuxfoundation.org', Country='US',
  FromHeader='au', MailFrom='org'
X-Spam-charsets: plain='US-ASCII', plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: ksummit-discuss-bounces@lists.linuxfoundation.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525989678; b=ZKsjMZYR6JFQpbH6h3z+bZlgqKxXTBiS7xPmY7iukYs3LrhPjK
    9ErHB4eI6yErPDFcM2TWg6feO/pwOGdPNBkaCX3t37URYPF8Ttw/w+8bG/OPuIZj
    OIdzRY8JBtG6xtGq7PQ2zw2n5GZcRuc/giM0uWmz5OiTl9L0a6dxtb9NXviGfYbV
    slWV3U+3nFogHg4bxziypFdpyKo5eANYO6AkODP15GCK2f2IGMKWtXzZ1dsh/T7n
    Eo5zfLmNdqcinF5M/X0lWLsrLAjL77i4Kkj8FdZ/4tlLUyQTzTtzB2rEHZy8Tspa
    e5LYmt0fmBWl5W/U3ISLDDs/EakEzY5AZdgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:message-id:in-reply-to
    :references:mime-version:cc:subject:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:content-type
    :sender; s=fm2; t=1525989678; bh=sN64aKXEiTGgx3MjDW/pDqqdcwzpKXO
    g7P4s9Ewj+qE=; b=TYjO1sdtYB3DvRt2oCGmrrfdwKGxf9JAJUdUXGDXGv6CDNZ
    H+FAci/+f9CVmNrEfkea4iHvOXFK7eXWiRi2mjbJe+W0kEjWYE6fa+zQwYqRj40/
    XTQs2j3fVagelmOT6As+afYnObfkGPTxG15RlAo/UNyh0e+x6sE4Rg+eS0NPmWXG
    KimILPSVsdmNTAqkMzbwRyhe44itNV5JAkoVZJYhULaWYXqxny9EOvvdhcI7xdUE
    jbWljyKwzrhxcL70xwfCc1Gt/HQ/C/9+1Jgx9f8tsFjwxk5pcTcD1bJuD285wE+H
    9OCeMNfhP9VwZnl7za9wzUzOGvr+771T/PjvdSw==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
    header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=ZpLrmz8z
    x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=201702;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=canb.auug.org.au;
    iprev=pass policy.iprev=140.211.169.12 (mail.linuxfoundation.org);
    smime=temperror;
    spf=pass smtp.mailfrom=ksummit-discuss-bounces@lists.linuxfoundation.org
    smtp.helo=mail.linuxfoundation.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=pass x-ptr-helo=mail.linuxfoundation.org
    x-ptr-lookup=mail.linuxfoundation.org;
    x-return-mx=pass smtp.domain=lists.linuxfoundation.org smtp.result=pass
    smtp_org.domain=linuxfoundation.org smtp_org.result=pass
    smtp_is_org_domain=no header.domain=canb.auug.org.au
    header.result=pass header_org.domain=auug.org.au
    header_org.result=pass header_is_org_domain=no;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
    bits=128/128;
    x-vs=clean score=90 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
      header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=ZpLrmz8z
      x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=201702;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=canb.auug.org.au;
    iprev=pass policy.iprev=140.211.169.12 (mail.linuxfoundation.org);
    smime=temperror;
    spf=pass smtp.mailfrom=ksummit-discuss-bounces@lists.linuxfoundation.org
      smtp.helo=mail.linuxfoundation.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=pass x-ptr-helo=mail.linuxfoundation.org
      x-ptr-lookup=mail.linuxfoundation.org;
    x-return-mx=pass smtp.domain=lists.linuxfoundation.org smtp.result=pass
      smtp_org.domain=linuxfoundation.org smtp_org.result=pass
      smtp_is_org_domain=no header.domain=canb.auug.org.au
      header.result=pass header_org.domain=auug.org.au
      header_org.result=pass header_is_org_domain=no;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
      bits=128/128;
    x-vs=clean score=90 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfJuYKoGPNlDmaJ+upVmwiU0wcWktB7R+2jgJ/KcFNz/s5gUFE12/VhT0HKkcaXjOEwkMNltifoAwV/v/VFbpUY3TuvGc3pLtyLV/iwOCzTGMBu9OG0ah
    5BhM3Y9nQnZZq4lcc7VE16RPjEl7pos1mvxh9YshZe5ADaO60WGhD15GUu4aARIftCaVd2DGjkhaUuF/b679KF30RoxL0T97greMJBbPdSbA5jOmyeoF46k/
    E6vPVw/uoXaqRIVwa8N5/g==
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=5MPDoNpceV4HFXFrvkM3CQ==:117
    a=5MPDoNpceV4HFXFrvkM3CQ==:17 a=VUJBJC2UJ8kA:10 a=-uNXE31MpBQA:10
    a=jJxKW8Ag-pUA:10 a=VwQbUJbxAAAA:8 a=SHkIaQMFN-zHrwCTa5gA:9 a=CjuIK1q_8ugA:10
    a=3ErpWKUmivcZ4AI-xTMA:9 a=ag1SF4gXAAAA:8 a=D-pE8fWRZ4KmsVp6X7MA:9
    a=AjGcO6oz07-iQ99wixmX:22 a=Yupwre4RP9_Eg_Bd0iYG:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: ksummit-discuss@mail.linuxfoundation.org
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none)
	header.from=canb.auug.org.au
Date: Fri, 11 May 2018 08:01:01 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Mark Brown <broonie@kernel.org>
Message-ID: <20180511080101.04448571@canb.auug.org.au>
In-Reply-To: <20180510133628.GC949@sirena.org.uk>
References: <0276fcda-0385-8f22-dbdb-e063f7ed8bbe@roeck-us.net>
	<20180503224217.GR2714@sirena.org.uk>
	<20180503230905.GA98604@atomide.com>
	<CAPDyKFrCKkRHwOh-7yfFbvMp+Ykhs7oXrDwhTShSPvUBvpn2ZQ@mail.gmail.com>
	<20180509084440.GW13402@sirena.org.uk>
	<CAKMK7uEWYmhA3owSeYM9tNA0tpMm5=4Yqda2j=VfMWi7i8ya8w@mail.gmail.com>
	<20180509090346.GY13402@sirena.org.uk>
	<20180509204727.7ff38021@canb.auug.org.au>
	<20180509140532.GA949@sirena.org.uk>
	<20180510080909.47c3068b@canb.auug.org.au>
	<20180510133628.GC949@sirena.org.uk>
MIME-Version: 1.0
X-Remote-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU autolearn=ham version=3.3.1
X-Remote-Spam-Checker-Version: SpamAssassin 3.3.1 (2010-03-16) on
	smtp1.linux-foundation.org
Cc: "ksummit-discuss@lists.linuxfoundation.org"
	<ksummit-discuss@lists.linuxfoundation.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Greg KH <gregkh@linuxfoundation.org>, "w@1wt.eu" <w@1wt.eu>
Subject: Re: [Ksummit-discuss] bug-introducing patches
X-BeenThere: ksummit-discuss@lists.linuxfoundation.org
X-Mailman-Version: 2.1.12
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/ksummit-discuss>,
	<mailto:ksummit-discuss-request@lists.linuxfoundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/ksummit-discuss/>
List-Post: <mailto:ksummit-discuss@lists.linuxfoundation.org>
List-Help: <mailto:ksummit-discuss-request@lists.linuxfoundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/ksummit-discuss>,
	<mailto:ksummit-discuss-request@lists.linuxfoundation.org?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============3966010014704374621=="
Sender: ksummit-discuss-bounces@lists.linuxfoundation.org
Errors-To: ksummit-discuss-bounces@lists.linuxfoundation.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

--===============3966010014704374621==
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/xZ8ZdjYOgrNpiV0K=nvT7jv"; protocol="application/pgp-signature"

--Sig_/xZ8ZdjYOgrNpiV0K=nvT7jv
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Mark,

On Thu, 10 May 2018 22:36:28 +0900 Mark Brown <broonie@kernel.org> wrote:
>
> On Thu, May 10, 2018 at 08:09:09AM +1000, Stephen Rothwell wrote:
> > On Wed, 9 May 2018 23:05:32 +0900 Mark Brown <broonie@kernel.org> wrote=
: =20
>=20
> > > Well, all my trees have a for-linus branch to go with the for-next
> > > branch for a start. =20
>=20
> > The regmap and regulator trees have no for-linus branch (currently).
> > Added sound-asoc-fixes and spi-fixes from today. =20
>=20
> That's not what git claims when I try to push...  no idea what's going
> on there, I just deleted and repushed - hopefully that helps.

I have added regmap-fixes and regulator-fixes now.

--=20
Cheers,
Stephen Rothwell

--Sig_/xZ8ZdjYOgrNpiV0K=nvT7jv
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlr0wR0ACgkQAVBC80lX
0GzcDQf9E02dUZ9IOBaMF80oUfQ8tl1F89Ec010K589Byun+sxHiMElJ1rl4d0hM
IuZzXplBk9kD8GCSGbFtjISEDcRuzjCulXgU5U0JMZe0R3+6R9nIxHxhsSuBchFr
wGBfgoPBmSWmvvmAp0V+eoGUrkLimvqQbT3C4nB0wqvX7eYFMOivPta9uojN0+Zn
jUZ+NctObNZ+FLDvood/KEBZckFwlOXHX3ls2YL75nf8uivzzOdfvA7vGTWwCG4u
qFFfEvebKSywMlUFBnmRPRhH91SjA5JxFhB+LMVDzdNYaJ3kXZAIwSyYXX7yTYXE
2QnFl8KTx1Pin7yJG/ETWV5+dEkQGg==
=GKna
-----END PGP SIGNATURE-----

--Sig_/xZ8ZdjYOgrNpiV0K=nvT7jv--

--===============3966010014704374621==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ksummit-discuss mailing list
Ksummit-discuss@lists.linuxfoundation.org
https://lists.linuxfoundation.org/mailman/listinfo/ksummit-discuss

--===============3966010014704374621==--
