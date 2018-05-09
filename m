Return-Path: <ksummit-discuss-bounces@lists.linuxfoundation.org>
X-Cyrus-Session-Id: sloti22d1t05-198351-1525862875-2-9249221184035289680
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
    1525862874; b=OJOrAi6ujH5lmEAOtyu8//HIZ8Jv/Rmio+sZ7Vzi9fmChYUQp3
    uqINqQNGSr9Ehb1O5YqLf0fi/78lGiG8U2veGdSHsdimIcbF621yzcy2I6POvqoa
    SPt+AKD7TqQvZrcoynRhNihvfV2Lp7ia2KH9HpRlywEmcmao7AOd0HDmQzuZfIX5
    rgz7Jm56R2rPmNupsrLe6v6kBcHL41qqrkOTm7qj3IXf+R1x7X6Mo8btfAwqjyje
    kF4L74m40AwfIxaia5wmkazspfIwGV2+yM069BklN9vFurcOstArMkvlZCBujOQK
    xYQqjTpEWX27RyouSelibAAPLyeVCCaOYpfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:message-id:in-reply-to
    :references:mime-version:cc:subject:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:content-type
    :sender; s=fm2; t=1525862874; bh=AKkbXfuJtJ7J76gDJmA7a9zabrUTA0k
    YuwLLhI/DTMI=; b=gwGX03BcQhDCqSGPts4sP6p3Ws3V5IkGB/hvQavpX9beGny
    i0FsLXvZ87GxXYgkNmKPo85Vg/i9lSrdCZmQgPefA4ER0c8PCY9fx5Ti03zzBy9p
    YRDgP+2SFzbF85bFF+nHsfLJc68FhoPZg0x5OWcsFDZzSmUF/UtRFcE33bLcJWfU
    p1fbqxO4DH01D8dbee/MnzCSo9Y1W2x5oa35UwjEVE+iFHmE3W1U/E1wd8RenWJP
    LnQENLFaYYFAV7AdOWWEEnOLzgzJxXmlEb/QZthD+cLk2x6qEbptZxs5MplZUrDU
    UqVmVwOFb5EfuwCM3VgR7ZZEX8mrw9ZDBZJ5ofg==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
    header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=BDA6MUkM
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
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
      header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=BDA6MUkM
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
X-CM-Envelope: MS4wfHBOTF1lvvaUbxf/lB5tbQEnCaBGFYaTl8Z3SmIA0Xh6ohL+ovL8lV9gm3EU1PoWttc0M1i9V+OZZNWzcScjGnrJwb946Y8tRR2nGahj62N0qQZOxgoj
    kIoM5kuvFiv10v+u7y26m9N3OjEyhDsP02nMsLtAfnBZurjWLMzMaO8odXp1Me6aEB/a4EMEsce47RZ4ZNGCaCLZ+HyCJAxhh6d9hZ8Vbsmq+S2Yd1xUbWa2
    tyEjLz1mza5YriV1u4L/Fg==
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=5MPDoNpceV4HFXFrvkM3CQ==:117
    a=5MPDoNpceV4HFXFrvkM3CQ==:17 a=VUJBJC2UJ8kA:10 a=-uNXE31MpBQA:10
    a=jJxKW8Ag-pUA:10 a=VwQbUJbxAAAA:8 a=sgKZgY2AqlUgpanTFIIA:9 a=CjuIK1q_8ugA:10
    a=-GJBuJxeZLOq_mw2b0oA:9 a=ag1SF4gXAAAA:8 a=D-pE8fWRZ4KmsVp6X7MA:9
    a=AjGcO6oz07-iQ99wixmX:22 a=Yupwre4RP9_Eg_Bd0iYG:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: ksummit-discuss@mail.linuxfoundation.org
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none)
	header.from=canb.auug.org.au
Date: Wed, 9 May 2018 20:47:27 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Mark Brown <broonie@kernel.org>
Message-ID: <20180509204727.7ff38021@canb.auug.org.au>
In-Reply-To: <20180509090346.GY13402@sirena.org.uk>
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
MIME-Version: 1.0
X-Remote-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU autolearn=ham version=3.3.1
X-Remote-Spam-Checker-Version: SpamAssassin 3.3.1 (2010-03-16) on
	smtp1.linux-foundation.org
Cc: "w@1wt.eu" <w@1wt.eu>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"ksummit-discuss@lists.linuxfoundation.org"
	<ksummit-discuss@lists.linuxfoundation.org>,
	Greg KH <gregkh@linuxfoundation.org>
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
Content-Type: multipart/mixed; boundary="===============6662639151495174686=="
Sender: ksummit-discuss-bounces@lists.linuxfoundation.org
Errors-To: ksummit-discuss-bounces@lists.linuxfoundation.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

--===============6662639151495174686==
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/XWBOwuj8mEn/E4JegrtF2g/"; protocol="application/pgp-signature"

--Sig_/XWBOwuj8mEn/E4JegrtF2g/
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Wed, 9 May 2018 18:03:46 +0900 Mark Brown <broonie@kernel.org> wrote:
>
> On Wed, May 09, 2018 at 10:47:57AM +0200, Daniel Vetter wrote:
> > On Wed, May 9, 2018 at 10:44 AM, Mark Brown <broonie@kernel.org> wrote:=
 =20
>=20
> > > I think this is an excellent idea, copying in Stephen for his input.
> > > I'm currently on holiday but unless someone convinces me it's a terri=
ble
> > > idea I'm willing to at least give it a go on a trial basis once I'm b=
ack
> > > home. =20
>=20
> > Since Stephen merges all -fixes branches first, before merging all the
> > -next branches, he already generates that as part of linux-next. All
> > he'd need to do is push that intermediate state out to some
> > linux-fixes branch for consumption by test bots.

Good idea ... I will see what I can do.
 =20
> True.  It's currently only those -fixes branches that people have asked
> him to merge separately which isn't as big a proportion of trees as have
> them (perhaps fortunately given people's enthusiasm for fixes branches
> that don't merge cleanly with their development branches) so we'd also
> need to encourage people to add them separately.

I currently have 44 such fixes branches.  More welcome!

--=20
Cheers,
Stephen Rothwell

--Sig_/XWBOwuj8mEn/E4JegrtF2g/
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlry0b8ACgkQAVBC80lX
0Gxj3gf/Xh5IYGStQouGu5wCw5mu9D5sM6AiSYuqSkX04xtZABc2xe+vqWZYMojQ
N05mKW36wjEjFVTmHNW7yavgK1pGVj93Tih44+AauPCSXFHbmsArsxmAcYTaeumG
yD2CztQVEm2bdAbahuWJyWlDGptXO+mUfdx0eI8g5oqZhSpxP7VsD8tOtYcRxZwJ
dH4Hns+mlLglEhpdo1bxye1bjtiZEdTKveEcERkjTsqY0wbeomkOPG3YoaZrNjbU
DY1EwewZn2QsLbEF3dLj8H/NJMDZtRjJEfNrauQAlYJ9tZQMUIhwyKTnm1vd5DBi
3U3VxxOBcqA10OobFCMQ0/K8UcPEhw==
=CG4/
-----END PGP SIGNATURE-----

--Sig_/XWBOwuj8mEn/E4JegrtF2g/--

--===============6662639151495174686==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ksummit-discuss mailing list
Ksummit-discuss@lists.linuxfoundation.org
https://lists.linuxfoundation.org/mailman/listinfo/ksummit-discuss

--===============6662639151495174686==--
