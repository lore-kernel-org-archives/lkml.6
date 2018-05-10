Return-Path: <ksummit-discuss-bounces@lists.linuxfoundation.org>
X-Cyrus-Session-Id: sloti22d1t05-2817802-1525989931-2-16550528085732919260
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
    1525989930; b=mPLATmh6BN7HkoF0Zel65PHZDap7SPhoiKGwcn9Tdf8BDzdn8C
    cAn+nWn6Vs3Y5E5HKP6nYyJcFJp71LOAccGfLPEGW8q1rOE7t73G53uQGy3KLsvp
    NVTeHqIl7urRS8I/NIhTa3pK1QoMPsjLcJUW4THNt0f5r6LarRnV1Roq9ewoMTIO
    NY+IGlLk8EJwoNhQbTmphzSg5TIbZZAr3aEFJz4hl2/zfDIXWfu2LtrY7ZAPA1im
    s60KhnmolSlj6Ry+FZ8xAwepc5rQRidBHwRrwB3qWrDrQFqMRZ6Hw7WKvoRMgo4m
    4QA7D3Gz7gti8SD/wxcaOJCTyzUuVcGBEwlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:message-id:in-reply-to
    :references:mime-version:cc:subject:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:content-type
    :sender; s=fm2; t=1525989930; bh=xr0gn22AQDvgC7A6TvvXHOYxujhVOux
    Kt/gXJzJR+OQ=; b=Ckuqv7zsk7GHjJWiNeE7X4PfTxE24fGZtqeyVXJxi3Qahye
    U4pcHGnH2MA1Ves8irtoSrlaFbYAtQGHYuFYULUI536RChsEtNS1icAAyQyOIsgq
    og3C0J5GgkW+tgF3t1HdIfiVq3sVSF0APWGY6Am7GeSt6hIRHetSuEv/0ATEvxDl
    Jqq/oQo6fU5zHTbfsxHuPlzwH8NjU25cwgRpohznVX7JETbCwk3mFX1wrJpTfg/p
    93UBbAJp0ddCbVjP94aidx2QQxMLFdxRolBam59OC2cfYQ9TYgQ89MXVbUh3KX+V
    0dwOmFlsDNpIA7CnXePeeg8RwKcmxD71mg6J6FQ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
    header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=NLhbfgEz
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
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
      header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=NLhbfgEz
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
X-CM-Envelope: MS4wfCnFaK05xpEEazANdCpcNB+iDAJDp1dQ5gE4KrMPMh9ivOu/zcOlnvTXcG/bRk1NdbyaZyOPSSug4wuL8yeHreJv6Od+MtU0wV1YkPrZ+aMmW9MVdrum
    Gx/yvMhdgkSTelZi7dFjbM6CxhMNSFI9qAC1D6wtVkO+dotsPdpzufVOU1R6izyv+2tPvVIkdFmCpa9F0QnwGGqjpiQeaokwwbbtsr3SvIISyljqpjCb7ALk
    Ae9u5gOSwM7iy3b050o1FA==
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=5MPDoNpceV4HFXFrvkM3CQ==:117
    a=5MPDoNpceV4HFXFrvkM3CQ==:17 a=VUJBJC2UJ8kA:10 a=-uNXE31MpBQA:10
    a=jJxKW8Ag-pUA:10 a=2KMo9-giAAAA:8 a=rOUgymgbAAAA:8 a=VwQbUJbxAAAA:8
    a=08Tp_QEC-3M9le-MB3kA:9 a=CjuIK1q_8ugA:10 a=ZFFWnAwRc3Xt840fTOwA:9
    a=ag1SF4gXAAAA:8 a=D-pE8fWRZ4KmsVp6X7MA:9 a=UeCTMeHK7YUBiLmz_SX7:22
    a=MP9ZtiD8KjrkvI0BhSjB:22 a=AjGcO6oz07-iQ99wixmX:22 a=Yupwre4RP9_Eg_Bd0iYG:22
    cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: ksummit-discuss@mail.linuxfoundation.org
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none)
	header.from=canb.auug.org.au
Date: Fri, 11 May 2018 08:05:18 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Tony Lindgren <tony@atomide.com>
Message-ID: <20180511080518.2de779d7@canb.auug.org.au>
In-Reply-To: <20180510155755.GF98604@atomide.com>
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
	<20180510155755.GF98604@atomide.com>
MIME-Version: 1.0
X-Remote-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU autolearn=ham version=3.3.1
X-Remote-Spam-Checker-Version: SpamAssassin 3.3.1 (2010-03-16) on
	smtp1.linux-foundation.org
Cc: Greg KH <gregkh@linuxfoundation.org>, "w@1wt.eu" <w@1wt.eu>,
	"ksummit-discuss@lists.linuxfoundation.org"
	<ksummit-discuss@lists.linuxfoundation.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
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
Content-Type: multipart/mixed; boundary="===============2895105859966848953=="
Sender: ksummit-discuss-bounces@lists.linuxfoundation.org
Errors-To: ksummit-discuss-bounces@lists.linuxfoundation.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

--===============2895105859966848953==
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/sVR/gqZXLskjHnu+jT+5Cd5"; protocol="application/pgp-signature"

--Sig_/sVR/gqZXLskjHnu+jT+5Cd5
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Tony,

On Thu, 10 May 2018 08:57:55 -0700 Tony Lindgren <tony@atomide.com> wrote:
>
> * Stephen Rothwell <sfr@canb.auug.org.au> [180509 10:49]:
> > I currently have 44 such fixes branches.  More welcome! =20
>=20
> Can you please also add mine:
>=20
> git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap.git fixes

Added from today.

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

--Sig_/sVR/gqZXLskjHnu+jT+5Cd5
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlr0wh4ACgkQAVBC80lX
0GwTdgf+IucXPezEsZpaYAEtrJzSKVbrsTLNFFRKET8q5L5hXb8dqSg8kDA4t6ie
6Fe2PFg9ncsr8AeEOSzvxD6OHptjnUTlxcbRnUeZsBdIJJkh13WkDB+LpQzWc9M6
6fjXjmvqe/HzkDneeaUio0AWGOolW/qHGstmiGyjhtX/D6Pg29qaETeoK8r1VpR9
gDDMoXXkW3Fg/5MpMGEpTx/XZWZGu0E6pKExTaHciOylL/+Qzwlmm3Dl3aWC0NT3
CsYi8vJN1X3L5MO2ze1BefSOyk6CNN7ptASZH9m3nNpEr+iviIAgINggWZ/EiGwC
+qWaS2iyjiG+QtRUDNxKaWmK+dUOXg==
=+F88
-----END PGP SIGNATURE-----

--Sig_/sVR/gqZXLskjHnu+jT+5Cd5--

--===============2895105859966848953==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ksummit-discuss mailing list
Ksummit-discuss@lists.linuxfoundation.org
https://lists.linuxfoundation.org/mailman/listinfo/ksummit-discuss

--===============2895105859966848953==--
