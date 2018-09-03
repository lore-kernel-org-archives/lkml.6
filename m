Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A550AC43334
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 05:21:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4EAAD20645
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 05:21:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="UP+RVXIw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4EAAD20645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726199AbeICJj7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 05:39:59 -0400
Received: from ozlabs.org ([203.11.71.1]:51979 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725854AbeICJj7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 05:39:59 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 423dc53sz2z9s2P;
        Mon,  3 Sep 2018 15:21:25 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1535952085;
        bh=/C9+YtXXjBEVeROLXaiDECpL5q9A1U7FahwUebA4TWc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=UP+RVXIww7uN/k9Aj2fvRSqvxbW7yTQFGEJofpsQfAaQvGkfU3ZHZvoJp4baTlCM/
         YKAJyjnTZVkqIVNyg+mL3kiDtJukOGL94li/Qg4zzB3zOQ35MrF2HD4ZGeaqmJl2qN
         5Oei1gBOn6mtcI3SExX84LxSbiJjFKTFMm5x8/gSeCtPvBQIxQefDvX7sbtEpWYmDG
         fqlVzErDs9D2kf5asUfovNdVG2Zgfu5WVkv4gxM0ZOxR2zOXSz2779J5m3jktrstrQ
         q8BkiXyn/xkE9cwXrxiJqfgSzdhstuZntbSoYgDa3gLDqfVWzJLQ885Fgjae+bKOVK
         r08QUb9OR4/IQ==
Date:   Mon, 3 Sep 2018 15:21:25 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Vakul Garg <vakul.garg@nxp.com>
Cc:     David Miller <davem@davemloft.net>,
        Networking <netdev@vger.kernel.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: Signed-off-by missing for commit in the net-next
 tree
Message-ID: <20180903152125.57233880@canb.auug.org.au>
In-Reply-To: <DB7PR04MB4252FC3E1B9B2A56C5B81B268B0C0@DB7PR04MB4252.eurprd04.prod.outlook.com>
References: <20180903074043.65038277@canb.auug.org.au>
        <DB7PR04MB4252FC3E1B9B2A56C5B81B268B0C0@DB7PR04MB4252.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/qvKqqEPnL=cGsqyjTfk94jc"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/qvKqqEPnL=cGsqyjTfk94jc
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Vakul,

On Mon, 3 Sep 2018 05:08:08 +0000 Vakul Garg <vakul.garg@nxp.com> wrote:
>
> > -----Original Message-----
> > Commit
> >=20
> >   c2ad647c6442 ("selftests/tls: Add test for recv(PEEK) spanning across
> > multiple records")
> >=20
> > is missing a Signed-off-by from its author.
>=20
> It is my fault to miss adding signoff.

See section 11 of Documentation/process/submitting-patches.rst.

> I am sorry about that.

It happens ...

> Please advise if I need to do something to fix it.

Dave's tree does not rebase, so nothing can be done about this case.  I
guess you should just remember to add a Signed-off-by line in the
future.  Also, Dave should probably check before publishing to his tree.

That being said, I have not seen many like this in Dave's tree.
--=20
Cheers,
Stephen Rothwell

--Sig_/qvKqqEPnL=cGsqyjTfk94jc
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAluMxNUACgkQAVBC80lX
0GwVrQf/bejc7HG5fCIylZNrnuUrdzEwh82AinM+BoZKuSrr8CdmnbChf0QoAQii
JtQDGqoVXbUW9qEFeAgJcNsqMlgXl6CZmZJ9ZFNKPrmxRefCxttGhP9vR27tA+0N
FBIGkdsG+s4sZXbfiuk9EHbC/2k8CtIy9wsg825cOvkdS8g1WhcbuR3NBA/67Ra0
HTgFLWY5VvyEHZHm6DVlXXYM89MGr0D5fwGxVV9vDf8iUxK/HjIw/00EGKc/JJX7
Wsl6WcRVOkyT8oZZ5HdKar8wmMLt9iZ5RaOwPwhy8nuSw3hJgPmhW24UfntT11BY
U7orGF5t6ofEwLczBtNjibyg6zAtBQ==
=biop
-----END PGP SIGNATURE-----

--Sig_/qvKqqEPnL=cGsqyjTfk94jc--
