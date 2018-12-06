Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA221C04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 23:07:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B76F20868
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 23:07:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="O1aEwCD+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B76F20868
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726194AbeLFXHc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 18:07:32 -0500
Received: from ozlabs.org ([203.11.71.1]:36993 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726040AbeLFXHc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 18:07:32 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 439rpn4LDZz9s3l;
        Fri,  7 Dec 2018 10:07:29 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1544137649;
        bh=/o2ZO0CPVxJNxmFq38QiBNKTuv8F8imMbwaRoN9Tl60=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=O1aEwCD+dPip3ZlLwoeQBiX1XmiqgK5jdZOoYxhgDGkMbZovl722CweLbE+xgRMBP
         J1vzzZ7pbZV8SG4GMjBkyvx/QPUM66QvX3yJ1rkcYjMz0Pnlff8RNlpfGCgZ9ebtev
         uZYxXxuWLrpVR5jnG55SzicxXkTOL1cDhWFxFJLJQXfi4tLMqV9yTi9AlMcH4gT57h
         VIOcJr9wUMtlQThDpR9cKzPFAW1MBvyP2nk/dBVjISFsl+u6TNEUTWGecoh+LSpeAm
         Mr3CVRq+U5iLqXS40dgJRq3W3LkUq8oLVLzUWOR+1M24LyDxF/8FYQIVjt2Ig9v6hO
         qgJawDf4N2wbA==
Date:   Fri, 7 Dec 2018 10:07:29 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: bad merge in the y2038 tree
Message-ID: <20181207100729.0ed0fc7a@canb.auug.org.au>
In-Reply-To: <CAK8P3a1U9y7rHq9GUd-BrY4=aLLyBYZLm8X0JcKU6j2_sYCCmQ@mail.gmail.com>
References: <20181207071147.3b41fb5c@canb.auug.org.au>
        <CAK8P3a1U9y7rHq9GUd-BrY4=aLLyBYZLm8X0JcKU6j2_sYCCmQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/2n92d5lkldTSpZBmyTD0Sgi"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/2n92d5lkldTSpZBmyTD0Sgi
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Arnd,

On Thu, 6 Dec 2018 23:09:01 +0100 Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Thu, Dec 6, 2018 at 9:12 PM Stephen Rothwell <sfr@canb.auug.org.au> wr=
ote:
> >
> > The y2038 tree contains a merge of next-20181206.  I cannot use a tree
> > that includes a version of linux-next.  I assume that this was just a
> > test merge, so please remove it. =20
>=20
> Fixed now, I had pushed the wrong branch after I had done the test build =
to
> make sure that it wouldn't conflict with anything in yesterday's linux-ne=
xt.

I figured something like that.  Thanks.

--=20
Cheers,
Stephen Rothwell

--Sig_/2n92d5lkldTSpZBmyTD0Sgi
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlwJq7EACgkQAVBC80lX
0GyW+wgAoNLe/mgbo5DZpSjEUo1sPipkaP0RI+ROZgxzRYaZ05vNCy6hWtmsIFdg
cBuiNlXbg3DwHWnylTr63CU8nZRrZ5ySys8CaQUcXaKa1IsIh2qRg0uo+1zlzJlk
l9Mu8QzL9WMAayWWYCZcypNGRHOPjMF56tmKyXIVm7J77hwLUn4bcp+2MWnT/S0H
ciMFqiPykjOcBVB5C2nIGYrBsN3rLCFZjSwCVJEoR9ye2/xAqhpV9tnmH96jjvbL
eQ6vrZCt1uxur5Wn65DIyUMNnOiZJjhe3OGibLcOHK/g6nwrGcmhdaN7ivYodvfg
OlR8W6wHSSidQUAeVn7DHbwfQ/v0sg==
=jo/D
-----END PGP SIGNATURE-----

--Sig_/2n92d5lkldTSpZBmyTD0Sgi--
