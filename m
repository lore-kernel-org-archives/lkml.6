Return-Path: <ksummit-discuss-bounces@lists.linuxfoundation.org>
X-Cyrus-Session-Id: sloti22d1t05-1656041-1525313170-2-8461783817722327005
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, MAILING_LIST_MULTI -1, RCVD_IN_DNSWL_MED -2.3,
  SPF_HELO_PASS -0.001, SPF_PASS -0.001, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='140.211.169.12', Host='mail.linuxfoundation.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii', plain='us-ascii'
X-Attached: signature.asc
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: ksummit-discuss-bounces@lists.linuxfoundation.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525313170; b=c+Yu0twVDyiCxWPCjinYAcB4TK2dtau30Yx4a6Rr9tRIQjmfum
    9eeFW1NBfh0IpW+BgneROq3wAs2YVtZweb1Peirx39bTCvQNKZQzl65ntHPw58ih
    xCgxJdWAEpgSDbtjJMvEZ7FrLcolhAHGl7JaKIGkLxV76xtWgxm9DQws3ubGa/uA
    HQQwo+JyRm99QiuzrwukcXBNOmsFsb1g3UW4UaeOc+i/QR9czD/w1DY79Vm0UdvS
    oQyckvrjCIpL13Ti4QG33l4LRjQDBdizMZf4wmgzv3AycJxXyuAVNVj0Af2z8saV
    QOyk18US8S3sh4PGFEfWaN/Nd0Mz6X5Kbh9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:to:message-id:references
    :mime-version:in-reply-to:cc:subject:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:from:reply-to
    :content-type:sender; s=fm2; t=1525313170; bh=0rJXRGhUEPM24vZB3M
    A4MAvltvbx7BQbU3WCdQjL6zw=; b=ASsC5NuD8Iul9VNpZPh6I9u+dlY99zS4gi
    qRNG8knwUNVIDmUbpmAfO2pMY/M/va6TijBHit24vMHnj+51uXvq4VsgImB5449h
    HEfKw3MjIOUausMZqLcoyJISkyrG780/YYT7r9JvyH3/7pNQSTRgh4xbyeIjI3XL
    2Lj3/8STWJNucH7U9/a2Xk3QBoIRucST9+n+8waPdIiiAODOVDD3Kvy1c39TxVLy
    sXWZ978ktaFre1uazq5I+PGCC5/orl1P+JyN8NWB5EKckDUOg/gfBtFakIfManI6
    co/Xjp5KRk8XpoANAWjZUa8ZgaUCFMzz5MswJGMXuAbj81cQgLDw==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256)
    header.d=sirena.org.uk header.i=@sirena.org.uk header.b=ThQO3ZXM
    x-bits=1024 x-keytype=rsa x-algorithm=sha256
    x-selector=20170815-heliosphere;
    dmarc=none (p=none,has-list-id=yes,d=none)
    header.from=lists.linuxfoundation.org;
    iprev=pass policy.iprev=140.211.169.12 (mail.linuxfoundation.org);
    spf=pass smtp.mailfrom=ksummit-discuss-bounces@lists.linuxfoundation.org
    smtp.helo=mail.linuxfoundation.org;
    x-aligned-from=domain_pass (Domain match);
    x-cm=discussion score=0;
    x-ptr=pass x-ptr-helo=mail.linuxfoundation.org
    x-ptr-lookup=mail.linuxfoundation.org;
    x-return-mx=pass smtp.domain=lists.linuxfoundation.org smtp.result=pass
    smtp_org.domain=linuxfoundation.org smtp_org.result=pass
    smtp_is_org_domain=no header.domain=lists.linuxfoundation.org
    header.result=pass header_org.domain=linuxfoundation.org
    header_org.result=pass header_is_org_domain=no;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
    bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256)
      header.d=sirena.org.uk header.i=@sirena.org.uk header.b=ThQO3ZXM
      x-bits=1024 x-keytype=rsa x-algorithm=sha256
      x-selector=20170815-heliosphere;
    dmarc=none (p=none,has-list-id=yes,d=none)
      header.from=lists.linuxfoundation.org;
    iprev=pass policy.iprev=140.211.169.12 (mail.linuxfoundation.org);
    spf=pass smtp.mailfrom=ksummit-discuss-bounces@lists.linuxfoundation.org
      smtp.helo=mail.linuxfoundation.org;
    x-aligned-from=domain_pass (Domain match);
    x-cm=discussion score=0;
    x-ptr=pass x-ptr-helo=mail.linuxfoundation.org
      x-ptr-lookup=mail.linuxfoundation.org;
    x-return-mx=pass smtp.domain=lists.linuxfoundation.org smtp.result=pass
      smtp_org.domain=linuxfoundation.org smtp_org.result=pass
      smtp_is_org_domain=no header.domain=lists.linuxfoundation.org
      header.result=pass header_org.domain=linuxfoundation.org
      header_org.result=pass header_is_org_domain=no;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
      bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfJ1v4vQySiIahCdw0jCQnyoCoGMtcNxonmESkEPL3nTXhdUYA113eiGsdGecx+TL1vojb0o/0DLFq+XGAqoUGDwVIInGPCfN2ZVmpmm/8gOcuMv4439Y
    S4DvL+iUqjpuJP5b+eVtazYNaD69eYJqbUVIy437y7cUXJgEsNEDMF4RdM5bGvR0OYbY5gV/xa6BC57Yjc5EW95GzWPPEXvXip6MhwR/2V8D/XuvL00QRvOs
    bA/hyPlzhHAA1ddbUgiK1w==
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=5MPDoNpceV4HFXFrvkM3CQ==:117
    a=5MPDoNpceV4HFXFrvkM3CQ==:17 a=VUJBJC2UJ8kA:10 a=-uNXE31MpBQA:10
    a=jJxKW8Ag-pUA:10 a=jz3ow8r4PKu1gwgnwzMA:9 a=CjuIK1q_8ugA:10
    a=yC3u0-h1NtBS2hDbOw4A:9 a=ONNS8QRKHyMA:10 a=ag1SF4gXAAAA:8
    a=D-pE8fWRZ4KmsVp6X7MA:9 a=Yupwre4RP9_Eg_Bd0iYG:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: ksummit-discuss@mail.linuxfoundation.org
Date: Thu, 3 May 2018 11:05:50 +0900
To: Sasha Levin <Alexander.Levin@microsoft.com>
Message-ID: <20180503020550.GP2714@sirena.org.uk>
References: <20180501163818.GD1468@sasha-vm> <20180501194450.GD10479@thunk.org>
	<20180501200019.GA7397@sasha-vm> <20180501205448.GE10479@thunk.org>
	<20180501211551.GI2714@sirena.org.uk>
	<CAKMK7uHjA27K8y-kwYFyhLy3cSkJJw8Oe1gP=3hZXdfxcWAcNQ@mail.gmail.com>
	<20180502194632.GB18390@sasha-vm>
MIME-Version: 1.0
In-Reply-To: <20180502194632.GB18390@sasha-vm>
X-Cookie: Rubber bands have snappy endings!
User-Agent: Mutt/1.9.5 (2018-04-13)
X-Remote-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1
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
From: Mark Brown via Ksummit-discuss
	<ksummit-discuss@lists.linuxfoundation.org>
Reply-To: Mark Brown <broonie@kernel.org>
Content-Type: multipart/mixed; boundary="===============8710790824003969233=="
Sender: ksummit-discuss-bounces@lists.linuxfoundation.org
Errors-To: ksummit-discuss-bounces@lists.linuxfoundation.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


--===============8710790824003969233==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="TRkqPRiqIDKgfg/F"
Content-Disposition: inline


--TRkqPRiqIDKgfg/F
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, May 02, 2018 at 07:46:34PM +0000, Sasha Levin wrote:

> As you said, the regression should be fixed "asap", not "immediately".
> It should go through some sort of review and testing the maintainers are
> happy with, but unfourtenately it doesn't happen now.

Doesn't happen some of the time.  It's not like this is a universal
problem.

Especially for driver specific things there's at times no realistic
prospect of getting useful independent review of fixes, the hardware
isn't always widely available and if the fix isn't a pure software thing
at some point you just have to trust the judgement of the vendor.

--TRkqPRiqIDKgfg/F
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlrqbn0ACgkQJNaLcl1U
h9BAxgf/fXCIeM1jHh0QgTgSxBbF5rkYEeu+6LEre/3U8xRBNVLosMJNlLOMDK4S
18VLGZD1rC18DB6dx76eLejcJ65J+W2D5sa9E1UvCMArM7nWVOqukdyDUxEL94N2
ZFTnBNDTbOApi+AMQt8szMa8xCHjQCyhlHRpL5r9D5UABKfro8yAGN9khqk457Qu
nRLiEunpYw4EZTUeEOt0j+FOoAR3/L/JApWkriC011GPm7vjmDXMH7jQ69MODhLb
NTusEgzD7Nkzei44CPdciZ4HAAHm1E+I06icqlrUc4CEPUGlyWK1OZ3hrt/bdv1W
e/igKTf7raoKuXrYyjmUFWDqPUilrw==
=NE5d
-----END PGP SIGNATURE-----

--TRkqPRiqIDKgfg/F--

--===============8710790824003969233==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ksummit-discuss mailing list
Ksummit-discuss@lists.linuxfoundation.org
https://lists.linuxfoundation.org/mailman/listinfo/ksummit-discuss

--===============8710790824003969233==--
