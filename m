Return-Path: <ksummit-discuss-bounces@lists.linuxfoundation.org>
X-Cyrus-Session-Id: sloti22d1t05-1474708-1526334325-2-8972479086399061951
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_HELO_PASS -0.001, SPF_PASS -0.001,
  LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.169.12', Host='mail.linuxfoundation.org', Country='US',
  FromHeader='au', MailFrom='org'
X-Spam-charsets: plain='US-ASCII', plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: ksummit-discuss-bounces@lists.linuxfoundation.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526334324; b=RpmwSeWLCYaV5JRD2YVszyGG8ICQtGNTsD3Od3/hSKKKZ+EJNE
    fgkZMXGxYYO5gCIEcRY7Of/WsCs/A/V295IWQSzY1kqWkw9o9VubI9CT3ysDJC5V
    uAXFpthh32yOvVs9j8YXJrRfzNB7Bv/eLABMv9kmsNMJLOCWLqlppTpwzvEg4mnc
    CaFc0vcxVpozlb2irfdRMkXQHLxXYGpwUppYJLnxdHMVxqkJb2Z/ddjSM42OXQkg
    uTOn9cIK5IaYw5g3Z0ADCzVD7yE0WxAuFlZl2KpTRQHr7BOmbTyYwiLocg8Tfz9+
    zwinMesCIeOQB33rJnk1N4+AQ0jI5Sl81fRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:message-id:in-reply-to
    :references:mime-version:cc:subject:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:content-type
    :sender; s=fm2; t=1526334324; bh=F6fDQHVQI+5V0hAH8dHYTrwftgMCf78
    a/TLirZbsOg0=; b=Xebrgw8MqcmdDYJNPY+vSu+rl4YnprQD2faq4yoUIoaW3aV
    581uidilZvmrxzFPa3o/8oFvR4vhLQbtDvWqGOiWHEv7rmP46SCmcXhCJy1AyKi3
    zLFsdwNbxRf9ZIGAMYcOPauOuMW20BRzvbrfNYiGVLCUPNtxDHbLZ0Ex0gkvc+Mg
    SLkPrgoEVuXQlplR0VxX1QDGK2bRELd1iX3tQU3dvR5ysNKL62u2dvtW24qkcAsK
    GxyLpDsCWqkTcF4KSWzCAZV0v+Tji3X0J2pl/y75OjiaKpsS6rhg6GlpmYlZuSXm
    GwA7pSHYIJOOHG+pq5Wkek/EGUzz1oefwlV1hdQ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
    header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=Bm7ooiRd
    x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=201702;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=canb.auug.org.au;
    iprev=pass policy.iprev=140.211.169.12 (mail.linuxfoundation.org);
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
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
      header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=Bm7ooiRd
      x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=201702;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=canb.auug.org.au;
    iprev=pass policy.iprev=140.211.169.12 (mail.linuxfoundation.org);
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
X-CM-Envelope: MS4wfFNQwfbbX3YgJ+OQcHFkr07auPUZV6LJOo2w0/e2CZFhKgfg8WIXQp5TtJeOR2ME8ccACt2rtYK4FrU0DC+G8WGiIrrWYYEpT+4vLjxRm4Ft+mcRhmOR
    z8NIYDuvfTboVxr6zWe45Iw9lmYYZ+OrgPzgrCRoP9j/2DJfKz1Ftr/CMU4htGKxtSPhqRkNYADZfH49X/+unKX1JDTapwjb1BqfX8M0YMTVglcIAgHXJ+ue
    dbPi62kOJgk68cKX9P8ViQ==
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=5MPDoNpceV4HFXFrvkM3CQ==:117
    a=5MPDoNpceV4HFXFrvkM3CQ==:17 a=VUJBJC2UJ8kA:10 a=-uNXE31MpBQA:10
    a=jJxKW8Ag-pUA:10 a=KKAkSRfTAAAA:8 a=VwQbUJbxAAAA:8 a=rOUgymgbAAAA:8
    a=08Tp_QEC-3M9le-MB3kA:9 a=CjuIK1q_8ugA:10 a=G-A8CdAlodYKu3v586wA:9
    a=ag1SF4gXAAAA:8 a=D-pE8fWRZ4KmsVp6X7MA:9 a=cvBusfyB2V15izCimMoJ:22
    a=AjGcO6oz07-iQ99wixmX:22 a=MP9ZtiD8KjrkvI0BhSjB:22 a=Yupwre4RP9_Eg_Bd0iYG:22
    cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: ksummit-discuss@mail.linuxfoundation.org
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none)
	header.from=canb.auug.org.au
Date: Tue, 15 May 2018 07:45:03 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Ulf Hansson <ulf.hansson@linaro.org>
Message-ID: <20180515074503.35ec6658@canb.auug.org.au>
In-Reply-To: <CAPDyKFrhRtLUFfmNNg0iPtJ+Tj5ZzDq6EsYPFc=PY7CmqkFX-g@mail.gmail.com>
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
	<CAPDyKFrhRtLUFfmNNg0iPtJ+Tj5ZzDq6EsYPFc=PY7CmqkFX-g@mail.gmail.com>
MIME-Version: 1.0
X-Remote-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU autolearn=ham version=3.3.1
X-Remote-Spam-Checker-Version: SpamAssassin 3.3.1 (2010-03-16) on
	smtp1.linux-foundation.org
Cc: "ksummit-discuss@lists.linuxfoundation.org"
	<ksummit-discuss@lists.linuxfoundation.org>,
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
Content-Type: multipart/mixed; boundary="===============1141369959894187339=="
Sender: ksummit-discuss-bounces@lists.linuxfoundation.org
Errors-To: ksummit-discuss-bounces@lists.linuxfoundation.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

--===============1141369959894187339==
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/nofJIjpfIzlhIonduYhKAWa"; protocol="application/pgp-signature"

--Sig_/nofJIjpfIzlhIonduYhKAWa
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Ulf,

On Mon, 14 May 2018 10:36:04 +0200 Ulf Hansson <ulf.hansson@linaro.org> wro=
te:
>
> I will ping the kernelci folkz to request them to include your new
> fixes branch for daily builds.

Excellent, thanks.

> For mmc, please add my fixes branch according to below.
>=20
> git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git fixes

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

--Sig_/nofJIjpfIzlhIonduYhKAWa
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlr6A18ACgkQAVBC80lX
0GwIaAgApYTmL+dWa+5871wsgGFrgIYW/DFTyePVGLr5j5wRZRyTP9uNmbru1IWl
/uvYZn7IT1O3gmCd0QMnSuhqk6VKr/B/DYzAiy3iIRg0gbByDgpXUOoBU/DJXt4z
1zZxVJcmlnxKJzNvtWaJkNjIqF89KdCrXcqoPR1uk0yBn3mlMqTnxRT/neK3kQyt
JQ85vxKSCoSOxhIOfAFvFqVmJFe3NAGK8uDNrFlrQbR4oPUMzNGlx+fdXez82/U8
lvVoAT0WqNh/ruA33M5skzgMpvcnl3QNgmO6oFzZJO8tOasJ4oLjoVMhCN5tVg5D
6MLlnF5ojog08uBq8z8n0ol7RNqhQA==
=FjhI
-----END PGP SIGNATURE-----

--Sig_/nofJIjpfIzlhIonduYhKAWa--

--===============1141369959894187339==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ksummit-discuss mailing list
Ksummit-discuss@lists.linuxfoundation.org
https://lists.linuxfoundation.org/mailman/listinfo/ksummit-discuss

--===============1141369959894187339==--
