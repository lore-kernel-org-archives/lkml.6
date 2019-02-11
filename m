Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF5E6C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 12:47:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9AD28218A6
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 12:47:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549889268;
	bh=UqSEr17L1LV7h086WnSlCEdxYbi+eJNQ8bJcDoWTSf4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=IncV7savrjrR626oEii77A1JTb4BPemnkO/XkIG80mLRXvRVDVh/RZCZUFE+W8hXH
	 +tLH3lvQzzblv1vq99DI3j79OqFKKq7ZV4Wbcj54rtmcMPQ4T25gqMCi7Kth8QsY9v
	 JCwkMMX8Qr259T1leoCDTFZ+43TGw6801Cf715oI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727568AbfBKMrr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 07:47:47 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:49500 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727216AbfBKMrq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 07:47:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=EgW1/CMsijd/ta8j2zHhGem0ZITrh7t2nrqav3hnthQ=; b=CbVS7SjHZM3vG63P0L6Bw5Chi
        O9G7gQFNt7Du07TJJBqgwQA1TaX32px0pTdb4/0JSWeFeibZMlN1zDv+LccXuQzYZJ5ibdDV5Amb5
        eNSxKxnzsWQogSmvyu9W131l7ntnB1qmKjNH7fQCfsS5De3rZ29tfPXHmSPmjHkY8yxsU=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gtAzq-00033K-UT; Mon, 11 Feb 2019 12:47:38 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 2804211280BD; Mon, 11 Feb 2019 12:47:38 +0000 (GMT)
Date:   Mon, 11 Feb 2019 12:47:38 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Shuah Khan <shuah@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@amacapital.net>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-kselftest@vger.kernel.org, Dan Rue <dan.rue@linaro.org>
Subject: Re: [PATCH 2/2] selftests/x86/fsgsbase: Default to trying to run the
 test repeatedly
Message-ID: <20190211124738.GA22391@sirena.org.uk>
References: <20190203134017.9375-1-broonie@kernel.org>
 <20190203134017.9375-3-broonie@kernel.org>
 <20190211084916.GB62722@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ibTvN161/egqYuK8"
Content-Disposition: inline
In-Reply-To: <20190211084916.GB62722@gmail.com>
X-Cookie: Tell me what to think!!!
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ibTvN161/egqYuK8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 11, 2019 at 09:49:16AM +0100, Ingo Molnar wrote:

> So this isn't very user-friendly either, previously it would run a=20
> testcase and immediately provide output.

> Now it's just starting and 'hanging':

>   galatea:~/linux/linux/tools/testing/selftests/x86> ./fsgsbase_64=20

> I got bored and Ctrl-C-ed it after ~30 seconds.

> How long is this supposed to run, and why isn't the user informed?

On Intel systems I've got access to it's tended to only run for less
than 10 seconds for me with excursions up to ~30s at most, I'd have
projected it to be about a minute if the tests pass.  However retesting
with Debian's v4.19 kernel it seems to be running a lot more stably so
we're now seeing it run to completion reliably when just one copy of the
test is running.

AFAICT it's not terribly idiomatic to provide much output, and anything
that was per iteration would be *way* too spammy.

> Also, testcases should really be short, so I think a better approach=20
> would be to thread the test-case and start an instance on every CPU. That=
=20
> should also excercise SMP bugs, if any.

Well, a *better* approach would be for the underlying issue that the
test is finding to be fixed.

I didn't look at adding more threads as the test case is already
threaded, it does seem that running multiple copies simultaneously makes
things reproduce more quickly so it's definitely useful though it's
still taking multiple iterations.

--ibTvN161/egqYuK8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlxhbukACgkQJNaLcl1U
h9A1OAf/WKQVAqmx50jv0448xrLZi5lNwENWc3ftX6oIrPCwGtTpjjVYQIaoZZZk
53RhJrMSwfxfEkVomotBTjpQCip6R1O5QbmZlBBl6VFoDs+YYTWb6/ovCggD/imS
dqyeab1KZXo7ivBalS1i/byVqiXBF9A4T57VN4Ss+qm3EXStABH0kOERTo8boz74
+wVjzzwmhsly0yBt92YK0NAvS+O8eu6IrrIDU19Ev90Hgspu7E4vCncrMRRVXkpJ
Sk8eYCfD0WXZNAjcLq1LE1Qo74WAGjRfKSETo7IyU1daPAMiWOWV7vB9tE1+AIaf
Qbf9D3Vg+eqfADxpxKwD8qnFP3bVVg==
=kLSu
-----END PGP SIGNATURE-----

--ibTvN161/egqYuK8--
