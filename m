Return-Path: <ksummit-discuss-bounces@lists.linuxfoundation.org>
X-Cyrus-Session-Id: sloti22d1t05-3702424-1525209372-2-5402693704002853370
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_HELO_PASS -0.001, SPF_PASS -0.001,
  LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.169.12', Host='mail.linuxfoundation.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii', plain='us-ascii'
X-Attached: signature.asc
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: ksummit-discuss-bounces@lists.linuxfoundation.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525209371; b=g9XiSMq1s2h/yQd84hMro+lKti2SfwTSuOnUTKj5zGbxYlFYWu
    pQi/9ktgR9/Qp5nFBnhLU9Qq8MfEX0T84U4fEWWfyUtpEEtAIwqGCR53unPb9Vtf
    HAMjAl9QdoIenn0AhZXJRyUQFpGV/IFiIzQLQ19QSALQU/BnBl5Ymt5Emf/Ylnft
    ZHgG3vAs1w+JdPioe4wFTbNrLo0fLQByoMlmjVJ1fgt58ImR93ECpQuGJ6QlmgpY
    zo8b38p0OPLWU4Km+orpTZXpxNbxx56IMxDUE/ouxwhF7rv3mBi5fTmVtrYcLV2s
    Er1lVDbBfn00+apekiD9Pa9E4ul2LX/s4B6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:message-id:references
    :mime-version:in-reply-to:subject:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:content-type
    :sender; s=fm2; t=1525209371; bh=CN0rKAeFd0wNVCyuMtmgr6w5/GxiVtY
    XVvDqMgTzpLs=; b=hjUXH4GG8JvOfHdhs8EX8v5ELXX9zD+BwZGBPrtPZVeVjzW
    6lHlvlDzNDz41VGjroIv4iHxQiLViT99WuOYkxFazhYapQCmqQGBW/a8CR9OC7QX
    iVDTtJT3+1d3LBULlCw2tE3R0gzd1zPdjxwHnNLhzN9cC3y2P/U5jmm613NQeFxb
    Ha5J38P+ewfdnlS4e4vQybyn78lMRK90tCj+6+PEiXyTp8OKDCXHUeCylt1PYWHM
    mkbhHPEWggtFPpY+9TGeQk9X2hls+MxcwThKJ5hHpkDABHOG/lvad4CXAkkiUzUA
    hz3mzS9uWGNayG6Fv80RtzCeRCAGyyAox14sYcg==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256)
    header.d=sirena.org.uk header.i=@sirena.org.uk header.b=AnAHwOHe
    x-bits=1024 x-keytype=rsa x-algorithm=sha256
    x-selector=20170815-heliosphere;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=140.211.169.12 (mail.linuxfoundation.org);
    spf=pass smtp.mailfrom=ksummit-discuss-bounces@lists.linuxfoundation.org
    smtp.helo=mail.linuxfoundation.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=pass x-ptr-helo=mail.linuxfoundation.org
    x-ptr-lookup=mail.linuxfoundation.org;
    x-return-mx=pass smtp.domain=lists.linuxfoundation.org smtp.result=pass
    smtp_org.domain=linuxfoundation.org smtp_org.result=pass
    smtp_is_org_domain=no header.domain=kernel.org header.result=pass
    header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
    bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256)
      header.d=sirena.org.uk header.i=@sirena.org.uk header.b=AnAHwOHe
      x-bits=1024 x-keytype=rsa x-algorithm=sha256
      x-selector=20170815-heliosphere;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=140.211.169.12 (mail.linuxfoundation.org);
    spf=pass smtp.mailfrom=ksummit-discuss-bounces@lists.linuxfoundation.org
      smtp.helo=mail.linuxfoundation.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=pass x-ptr-helo=mail.linuxfoundation.org
      x-ptr-lookup=mail.linuxfoundation.org;
    x-return-mx=pass smtp.domain=lists.linuxfoundation.org smtp.result=pass
      smtp_org.domain=linuxfoundation.org smtp_org.result=pass
      smtp_is_org_domain=no header.domain=kernel.org header.result=pass
      header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
      bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfBoYNl4kBRR4KjIBJULEZmLTuStx3EILLeLibunjGcM72Lei7FN5voHSh/V4gFQBB418Xz91CCzNpoVCZ38U67mtFUNfjg5we/V0QbsNLQmU9y1ztums
    y8Xcjd7IzbeVHmOOOEfzX1mPkrum5gXwMLEOYKWP8Wg2Xbxb86yg/fo3vdRrEvuChz9/sqakml6dlHDM1a2gDTEs0VQaY3k7lKoQwpkoc8t9rVxsUtAunPKI
    Lf7+tk0MxyMmSbLVy6krjQ==
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=5MPDoNpceV4HFXFrvkM3CQ==:117
    a=5MPDoNpceV4HFXFrvkM3CQ==:17 a=VUJBJC2UJ8kA:10 a=-uNXE31MpBQA:10
    a=jJxKW8Ag-pUA:10 a=fLdMjQ97uCuJOTpOgFkA:9 a=CjuIK1q_8ugA:10
    a=4hu6QYlMx1xuxYOKMe8A:9 a=ONNS8QRKHyMA:10 a=ag1SF4gXAAAA:8
    a=D-pE8fWRZ4KmsVp6X7MA:9 a=Yupwre4RP9_Eg_Bd0iYG:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: ksummit-discuss@mail.linuxfoundation.org
Date: Wed, 2 May 2018 06:15:51 +0900
From: Mark Brown <broonie@kernel.org>
To: "Theodore Y. Ts'o" <tytso@mit.edu>,
	Sasha Levin <Alexander.Levin@microsoft.com>,
	"ksummit-discuss@lists.linuxfoundation.org"
	<ksummit-discuss@lists.linuxfoundation.org>,
	Greg KH <gregkh@linuxfoundation.org>, "w@1wt.eu" <w@1wt.eu>,
	"julia.lawall@lip6.fr" <julia.lawall@lip6.fr>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Message-ID: <20180501211551.GI2714@sirena.org.uk>
References: <20180501163818.GD1468@sasha-vm> <20180501194450.GD10479@thunk.org>
	<20180501200019.GA7397@sasha-vm> <20180501205448.GE10479@thunk.org>
MIME-Version: 1.0
In-Reply-To: <20180501205448.GE10479@thunk.org>
X-Cookie: Rubber bands have snappy endings!
User-Agent: Mutt/1.9.5 (2018-04-13)
X-Remote-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1
X-Remote-Spam-Checker-Version: SpamAssassin 3.3.1 (2010-03-16) on
	smtp1.linux-foundation.org
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
Content-Type: multipart/mixed; boundary="===============7400735099666043567=="
Sender: ksummit-discuss-bounces@lists.linuxfoundation.org
Errors-To: ksummit-discuss-bounces@lists.linuxfoundation.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


--===============7400735099666043567==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="PWfwoUCx3AFJRUBq"
Content-Disposition: inline


--PWfwoUCx3AFJRUBq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, May 01, 2018 at 04:54:48PM -0400, Theodore Y. Ts'o wrote:

> I do think it's about AUTOSEL, because when I'm dealing with a
> regression, I want to get it fixed fast.  Because the alternative is
> the merge-window commit getting reverted.  AUTOSEL seems wants perfect
> patches that it can cherry pick once, as opposed to a case where if the
> user confirms that it fixes the regression, I want to send it to Linus
> quickly.  I do *not* want it to marinate in linux-next for 1-2 weeks.
> I would much rather that *stable* hold off on picking up the patch for
> 1-2 weeks, but get it fixed in Linux HEAD sooner.  If that means that
> the regression fix needs a further clean up, so be it.

We've had issues with the automated testing systems in the past where a
maintainer has had a policy of letting things percoltate for a week
before sending to Linus and there's been a bug that caused a substantial
set of tests to fail to run (generally it's something that had unnoticed
dependencies in -next so wasn't caught there) - we essentially end up
not getting the affected bits of test coverage for that period of time
which is not helpful.

--PWfwoUCx3AFJRUBq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlro2QcACgkQJNaLcl1U
h9DxnAf9HzUDmU+qq+4qRe4pUJ2JUqrxmOUrzh5xVDe59HtPwt3WOUjp5urbjJMB
GZirE6izFgY4kwP2uACJCOvNriAKh/WGpHpjOJXPMd9HMV8OD7KltB1z4K8PVcfM
SjMxJTgZRPDX5e7VsGkBkjcOI4bbLZuPa5zvD3QJnAmdXScyPEQz7qX/QZ1lFOVe
zFduJeyBXPf/UfUSNwUeWI6FV8sYSmvdbaayYFlJBSFaZLnYrN8MicGMHhn4mH7j
he7rLtGHqMwtLbS5zHIQ6uc/NTXJSLvxvHC/d7rzq1z2FJDe622u5q9nHt5gjTk1
UJXUaBdaUypURyopsJUgH04ZviJKWw==
=E0fI
-----END PGP SIGNATURE-----

--PWfwoUCx3AFJRUBq--

--===============7400735099666043567==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ksummit-discuss mailing list
Ksummit-discuss@lists.linuxfoundation.org
https://lists.linuxfoundation.org/mailman/listinfo/ksummit-discuss

--===============7400735099666043567==--
