Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D30B6C04EB8
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 00:18:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FFB620834
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 00:18:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="PZOLbfsU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7FFB620834
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726602AbeLEASa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 19:18:30 -0500
Received: from ozlabs.org ([203.11.71.1]:60445 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725905AbeLEASa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 19:18:30 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 438fTb06nqz9s3l;
        Wed,  5 Dec 2018 11:18:26 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1543969107;
        bh=GkptzgfaeH+TZOeMiUd7QHUndYrw1cFsHz+WqefH5v4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=PZOLbfsUDP6y2tlnxKgtrHEm6nxT0gv+zAOZ2cErCNxc7duwGAfP7RRjmM4kR+kR2
         z4gCm7inVmVacogvT9/nRHx80p60enWB0FcCw54OX3Lr+Jef8VjjWCMu2zymtI0nP0
         iLAkxlBTa8WGSwjLqNrpJu0ao3u31NDzdYA8dn3FZhT6YxsETF3ABb9hpKaWqfLP1A
         /fhUvEZrDs9UPef9vYLkfsVC4cnaH91V8RNC0hq7OhqJBT0SoWQ555jTeDH1ii5QS/
         m7ofWGjbP7qfq2co3dZ6jkHrHLw4qt+3Yh3teX98CKJ7AqmbqaPrE/GN4px/kRh50l
         UpOOT8+xl1qNQ==
Date:   Wed, 5 Dec 2018 11:18:21 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     akpm@linux-foundation.org
Cc:     broonie@kernel.org, mhocko@suse.cz, linux-next@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, mm-commits@vger.kernel.org
Subject: Re: mmotm 2018-12-04-16-00 uploaded
Message-ID: <20181205111821.76f2b1dd@canb.auug.org.au>
In-Reply-To: <20181205000059.PQ0hs%akpm@linux-foundation.org>
References: <20181205000059.PQ0hs%akpm@linux-foundation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/UaHe6/stNTjgMwUpk/mEyTN"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/UaHe6/stNTjgMwUpk/mEyTN
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

On Tue, 04 Dec 2018 16:00:59 -0800 akpm@linux-foundation.org wrote:
>
> * async-remove-some-duplicated-includes.patch

This patch has the wrong subject line (mentions kernel/signal.c).

--=20
Cheers,
Stephen Rothwell

--Sig_/UaHe6/stNTjgMwUpk/mEyTN
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlwHGU0ACgkQAVBC80lX
0GwVBgf/cNsclajJcaBCcidSR1LIRfzy7FplBOh7SEYt+DRwlmJl2JXjsxrWxW7i
G66BHyDr/P0c2qbu1Ulm3qhIq2kRUGrFVUiDZrbtc5K9G4qaF/DImCgnV/lY8JWz
LX/xioqWthcoGcDnnCTlgfX00QYdfvTLXJ1rX6GLZ6uNsYkh0q1y+KMyFyQkxowR
vOMf/ZFWsHsmJ/NQAj/v4WFCWGfLPh9m5rg2T5srVuTUdH7NtSso3HSdTo+HNOIq
x9Cm9SdjhLHWulyd3gIwBqXcCrRrscMPURAA67Zv8eNekOxuvwHGfGte6M4E+YDV
wGTTnastlHEFt7AskGh8pH89VzirFA==
=HBMt
-----END PGP SIGNATURE-----

--Sig_/UaHe6/stNTjgMwUpk/mEyTN--
