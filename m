Return-Path: <ksummit-discuss-bounces@lists.linuxfoundation.org>
X-Cyrus-Session-Id: sloti22d1t05-1050770-1525903762-2-7749771384124298902
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
    1525903762; b=KlTwCNl992jvIHvfyHO6poPrSOwaXYArMGPxtleBQfeXvd0WC4
    QPvnEwbZ2zAoXRrf0EYfMkejm6uyf4Z8glaTqSIry+d4jwGr5GoBSMWsjqc4LP5C
    R3FEKj+3DG882A8CrWzyGfR5i0+bv6SEGXFi3LUhatCZc8SSEEdS9p9OOOX09Xtn
    HgYHUHxLqxlNrVJWU6WoTS40pX13rP/TYvYxTVp0HdaWL7LHZl9hBaW3bZvb+s6z
    0D+hxUxc7/PeE+OYRjakdBxLapXcUOEZoFQM/FTo54ZOzSae3rWe6xecM6GtkIpC
    iavnd0TDqlZtz4nXiac3VOz7pi7fSjHLiczw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:message-id:in-reply-to
    :references:mime-version:cc:subject:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:content-type
    :sender; s=fm2; t=1525903762; bh=qK4xSD5l6MXqcooq0SzChMetO26wdWn
    deSDni/IHQ5s=; b=J8sMyeJ16TtoOyTwWgnhce1yGBRBH0QbHP72UFiw7VlrOcW
    OgzZUoqB69SOhU4/6BPx5rrmAZYEta6hIh+o8Q6Q9nJMITI5xz5C0zXV8Qf05JtM
    LtDh2wt39EAMtVIvCxhKLyQQ6WflVlBN/+IcL79a3Mg3CMV+amFq5o0s4YRNbDYr
    knWrTfpr3ew1fSzqd94/TIF2SXNzsokHWhGMjyWp/TmTqc+dYLK4teX6t3nQKr54
    +E2LO1bX7jLqvaAl/9VX8xBPTX+RAWW0GaEpz6O7o2ZD5G2dfzNxs7chPaoCA3Y0
    UQuY8homz8UxXS4X9AROB96tGSKsx/8lzl0yrRw==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
    header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=BnKc2Bsl
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
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
      header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=BnKc2Bsl
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
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfPmLcfvKpOil7wY1mEsbDqmoZ0/vezoFrGRKLdCvCvEz1kAOV9ln0KML4lOd6IwoEvdRqrDSMiyIUL3Fc2DnqAZiaBn+O7xdHXgXmxvUAHXS4YlfbWH+
    p3WHKS2CKEmfuRvSv0UDCIMq/a1gp572dUqob29U7orhOHNnL1AtuBEunk6iqB4kDTNmcLUnKc20MzDN3tUBizvJqDJxk4jZfu4KrmJgQAz1VCE6ITYvJ6Bb
    IbWyNi5W7xxp6YraOjvQvQ==
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=5MPDoNpceV4HFXFrvkM3CQ==:117
    a=5MPDoNpceV4HFXFrvkM3CQ==:17 a=VUJBJC2UJ8kA:10 a=-uNXE31MpBQA:10
    a=jJxKW8Ag-pUA:10 a=VwQbUJbxAAAA:8 a=rOUgymgbAAAA:8 a=08Tp_QEC-3M9le-MB3kA:9
    a=CjuIK1q_8ugA:10 a=4Xzg8Nnj0jHAix4cmfcA:9 a=ag1SF4gXAAAA:8
    a=D-pE8fWRZ4KmsVp6X7MA:9 a=AjGcO6oz07-iQ99wixmX:22 a=MP9ZtiD8KjrkvI0BhSjB:22
    a=Yupwre4RP9_Eg_Bd0iYG:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: ksummit-discuss@mail.linuxfoundation.org
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none)
	header.from=canb.auug.org.au
Date: Thu, 10 May 2018 08:09:09 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Mark Brown <broonie@kernel.org>
Message-ID: <20180510080909.47c3068b@canb.auug.org.au>
In-Reply-To: <20180509140532.GA949@sirena.org.uk>
References: <20180503020550.GP2714@sirena.org.uk>
	<20180503031000.GC29205@thunk.org>
	<0276fcda-0385-8f22-dbdb-e063f7ed8bbe@roeck-us.net>
	<20180503224217.GR2714@sirena.org.uk>
	<20180503230905.GA98604@atomide.com>
	<CAPDyKFrCKkRHwOh-7yfFbvMp+Ykhs7oXrDwhTShSPvUBvpn2ZQ@mail.gmail.com>
	<20180509084440.GW13402@sirena.org.uk>
	<CAKMK7uEWYmhA3owSeYM9tNA0tpMm5=4Yqda2j=VfMWi7i8ya8w@mail.gmail.com>
	<20180509090346.GY13402@sirena.org.uk>
	<20180509204727.7ff38021@canb.auug.org.au>
	<20180509140532.GA949@sirena.org.uk>
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
Content-Type: multipart/mixed; boundary="===============7936910909277162426=="
Sender: ksummit-discuss-bounces@lists.linuxfoundation.org
Errors-To: ksummit-discuss-bounces@lists.linuxfoundation.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

--===============7936910909277162426==
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/ldJO_07QX328KjF_NOT_tX0"; protocol="application/pgp-signature"

--Sig_/ldJO_07QX328KjF_NOT_tX0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Mark,

On Wed, 9 May 2018 23:05:32 +0900 Mark Brown <broonie@kernel.org> wrote:
>
> Well, all my trees have a for-linus branch to go with the for-next
> branch for a start.

The regmap and regulator trees have no for-linus branch (currently).
Added sound-asoc-fixes and spi-fixes from today.

Thanks for adding your subsystem tree as a participant of linux-next.  As
you may know, this is not a judgement of your code.  The purpose of
linux-next is for integration testing and to lower the impact of
conflicts between subsystems in the next merge window.=20

You will need to ensure that the patches/commits in your tree/series have
been:
     * submitted under GPL v2 (or later) and include the Contributor's
        Signed-off-by,
     * posted to the relevant mailing list,
     * reviewed by you (or another maintainer of your subsystem tree),
     * successfully unit tested, and=20
     * destined for the current or next Linux merge window.

Basically, this should be just what you would send to Linus (or ask him
to fetch).  It is allowed to be rebased if you deem it necessary.

--=20
Cheers,
Stephen Rothwell=20
sfr@canb.auug.org.au

--Sig_/ldJO_07QX328KjF_NOT_tX0
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlrzcYUACgkQAVBC80lX
0GzZqQgApHxkyJiWf1G5HUnwNinxKQshxLRflaxKOCsPNEqEC7shFhnemvJPss/i
8JNyotvxeWjaykN+fGTcyYQ2227WeET+UkO/5WLT98V9DU0EcMVdoDWD+dskZtuS
Uk7X96hIJdOqYTACrzZossF2tlhKFXku2PmrzOP94CpNEttOCbFVzR4TKnQ/PLlY
m4SFIXrNrJNlDcJ/UUNFdSV19P6noRKkNjFHR2++A0UOEmAE+Y1xidcLY04tfWjt
vBUj/YRJtfNe/q+4HGo9u+UVd5fQp4BM2ZjO9TCNdV+EBgbbHRu6dzIHtXMSkbDh
XcFHxLdbWHC80LODYVlDFEV4nGIpVA==
=d/bF
-----END PGP SIGNATURE-----

--Sig_/ldJO_07QX328KjF_NOT_tX0--

--===============7936910909277162426==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ksummit-discuss mailing list
Ksummit-discuss@lists.linuxfoundation.org
https://lists.linuxfoundation.org/mailman/listinfo/ksummit-discuss

--===============7936910909277162426==--
