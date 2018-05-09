Return-Path: <ksummit-discuss-bounces@lists.linuxfoundation.org>
X-Cyrus-Session-Id: sloti22d1t05-1016021-1525902723-2-13961111154442794959
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
    1525902722; b=exLpSUzLG3S6Ni7gsw2km/Ae0XPLJ19Fi7b9JNtbYrioAL7H+O
    qjUcjMC4iPSUz7skHxsHomGUp0EdoUgmVwoQ7XW7IvJW+rP2crCIjZerxqN7o6NM
    0BIstS6uYNzxGo3j0Wa/8T5SmK1UiAgY79f0AmswhB/2qFks96i23EpSD/bz1XPl
    akeq28wF4z+aFeZD2dsIidjJBqvMo71d0MGjP8wATEE99Y8jj5LaqPk5+OKYlNaI
    Wn9DMJu84qwkEnK/j98LRdL02evIZmNi5WFtGdRB51S3b5bWwTjc/t7gQGBUCdFe
    RYsOEBQpA6KoGVorL26v7yUgO7EPVkV5PW3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:message-id:in-reply-to
    :references:mime-version:cc:subject:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:content-type
    :sender; s=fm2; t=1525902722; bh=/UCZXTQ67p/RdzVLfksuzEoepJPvSw8
    /l1wCL/7fGOE=; b=BE1CxJ2lO91Q4gLvzLtFkdexvNqDY5sTs+CBCj7z1LGlZht
    eqk/LaCgRqX6nhHaqgemUpjSwN/p/r0hy4SAeeLLkpStoe4/2zZpiRn46yDlXJJD
    86cHePR8sa2hGgglYrahpGHu17A9rsMRi2lM0QLvSWHJ5BuEOz7BsUqPES8Du35t
    gYeDHCzo2eJQXwb11ONoY1pXP8OvVtvXZsAfIfE9R/GauDZpRXxknN2MiDOwTVVW
    p5SjL3noL1QRybnLYMC9OTQb78HBdnsLW68YaKA7aUewS3JZA6iq10a16AZs8/ow
    ESeOgr5N6UOQVz932WC8ubLTp/R+7AYY/s19+uA==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
    header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=Yrgn3ljq
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
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
      header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=Yrgn3ljq
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
X-CM-Envelope: MS4wfL47dALlQ+GjXwQPmsA+XcM4dVZLQasPRcRA/24efotKjfCiJAQcf2vMony5a2QUqoBfia9/MRMYxqxHIBGOAAABfg/b3kDPX7URb2bYO3R+C+jOXN7O
    RHVD4AQX61eb6Eh+qnilVkHxOtpZyGY6U3Z+txMgoHpm6CDe4L+4pgyCe2Ncvo9PfG4BxvDLPxc5thegeMkpU/H92fNYzwGliP7TKNCWI1YG4fdga11lsVjx
    wl7AjVadIoe+djq/pNwuAQ==
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=5MPDoNpceV4HFXFrvkM3CQ==:117
    a=5MPDoNpceV4HFXFrvkM3CQ==:17 a=VUJBJC2UJ8kA:10 a=-uNXE31MpBQA:10
    a=jJxKW8Ag-pUA:10 a=QyXUC8HyAAAA:8 a=VwQbUJbxAAAA:8 a=rOUgymgbAAAA:8
    a=08Tp_QEC-3M9le-MB3kA:9 a=CjuIK1q_8ugA:10 a=yGGlsrrTT82o892054AA:9
    a=ag1SF4gXAAAA:8 a=D-pE8fWRZ4KmsVp6X7MA:9 a=AjGcO6oz07-iQ99wixmX:22
    a=MP9ZtiD8KjrkvI0BhSjB:22 a=Yupwre4RP9_Eg_Bd0iYG:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: ksummit-discuss@mail.linuxfoundation.org
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none)
	header.from=canb.auug.org.au
Date: Thu, 10 May 2018 07:51:49 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Dan Williams <dan.j.williams@intel.com>
Message-ID: <20180510075149.57c3034a@canb.auug.org.au>
In-Reply-To: <CAPcyv4jtNXhMwCqpbKkHe5e-nDPK+2Wq=maFsB_SMSGyg7fw5w@mail.gmail.com>
References: <CAKMK7uHjA27K8y-kwYFyhLy3cSkJJw8Oe1gP=3hZXdfxcWAcNQ@mail.gmail.com>
	<20180502194632.GB18390@sasha-vm>
	<20180503020550.GP2714@sirena.org.uk>
	<20180503031000.GC29205@thunk.org>
	<0276fcda-0385-8f22-dbdb-e063f7ed8bbe@roeck-us.net>
	<20180503224217.GR2714@sirena.org.uk>
	<20180503230905.GA98604@atomide.com>
	<CAPDyKFrCKkRHwOh-7yfFbvMp+Ykhs7oXrDwhTShSPvUBvpn2ZQ@mail.gmail.com>
	<20180509084440.GW13402@sirena.org.uk>
	<CAKMK7uEWYmhA3owSeYM9tNA0tpMm5=4Yqda2j=VfMWi7i8ya8w@mail.gmail.com>
	<20180509090346.GY13402@sirena.org.uk>
	<20180509204727.7ff38021@canb.auug.org.au>
	<CAPcyv4jtNXhMwCqpbKkHe5e-nDPK+2Wq=maFsB_SMSGyg7fw5w@mail.gmail.com>
MIME-Version: 1.0
X-Remote-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU autolearn=ham version=3.3.1
X-Remote-Spam-Checker-Version: SpamAssassin 3.3.1 (2010-03-16) on
	smtp1.linux-foundation.org
Cc: "ksummit-discuss@lists.linuxfoundation.org"
	<ksummit-discuss@lists.linuxfoundation.org>,
	linux-nvdimm <linux-nvdimm@lists.01.org>,
	Greg KH <gregkh@linuxfoundation.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"w@1wt.eu" <w@1wt.eu>
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
Content-Type: multipart/mixed; boundary="===============7032430564375848809=="
Sender: ksummit-discuss-bounces@lists.linuxfoundation.org
Errors-To: ksummit-discuss-bounces@lists.linuxfoundation.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

--===============7032430564375848809==
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/KyNS2/d6MOKSvSK194yyHAA"; protocol="application/pgp-signature"

--Sig_/KyNS2/d6MOKSvSK194yyHAA
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Dan,

On Wed, 9 May 2018 09:04:31 -0700 Dan Williams <dan.j.williams@intel.com> w=
rote:
>
> Please add:
>=20
>     git://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm.git
> libnvdimm-fixes
>=20
> We currently merge this into libnvdimm-for-next for -next coverage,
> and resolve any conflicts vs new development. Do you want to see those
> conflicts? Otherwise I would recommend only pulling libnvdimm-for-next
> for -next and libnvdimm-fixes for this new -next-fixes effort.

The conflicts are usually fine (but if you do the merges, I won't see
them - which is even better :-)).  I like to have the fixes branches in
linux-next so that noone has to worry about probelsm in Linus' tree
that have pending fixes already.

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

--Sig_/KyNS2/d6MOKSvSK194yyHAA
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlrzbXUACgkQAVBC80lX
0GwzAgf/TxQI4NrJdZFoI7Y//UmYxwfeeSgkLWVg4aKZOOJPzX93qoqf+uLItfGn
RGKO51U4QQ+CFurwUXGuLOnjTKB2/ehyZYjDxj/UVsp709bDd+1A0vctYf8coYvn
dmPL+CpX9cLwl8w+FpP1ehy9wxDHlZich7Jh8fspSC34NZ/CuVSFn4e2QpTaq9zb
rJ2OaZ6Zy/t0+y/dFWtJD+o10Kp6aK4SXdF3o9sBEc9hp/nEBipVBK0BFnSYRbfo
4xfFh26jpvRLRV64JyK8kzsOJmn6mQRktV6xEEoeN9dDRH1XawwJVSAh7Rb4Xhri
/9UyA5kh8GCOqE8mQOuie/iO3IGFow==
=Sccc
-----END PGP SIGNATURE-----

--Sig_/KyNS2/d6MOKSvSK194yyHAA--

--===============7032430564375848809==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ksummit-discuss mailing list
Ksummit-discuss@lists.linuxfoundation.org
https://lists.linuxfoundation.org/mailman/listinfo/ksummit-discuss

--===============7032430564375848809==--
