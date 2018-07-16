Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B6ECECDFAA
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 08:29:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F55F20779
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 08:29:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="N/j4ZUKw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F55F20779
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731551AbeGPI4G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 04:56:06 -0400
Received: from ozlabs.org ([203.11.71.1]:39947 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730828AbeGPI4E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 04:56:04 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 41Tc6147TGz9rvt;
        Mon, 16 Jul 2018 18:29:45 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1531729786;
        bh=GVJ+ssWzQ6Xh+MBla7fdLVY+H0CuoyWsuRoi5fYCSIo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=N/j4ZUKwVWjKQwBEILLXmGbJzWBFDJmBcteS4J8L1fYYSUgn/vk46XseJDyZ7gjhq
         SlXtCphj70uMYC7Bc4dlPLNFqLDQAprMj9cuchKyX0Frtn2FQa+cuQY8aszC9TjcBe
         hIzTslmCcz5AYhkgkaMnYGgYUChQI3cYly3BBtqz8zGGE/TmBUyhV1aWm+iiSFpKY9
         69+l5RCwudUh8LWFtZRz1AFqQNu6x6kMY8Vs+t2xZtCFSNsUvaM7TbC/hS4JBLp1PL
         PhJrGAfG16uUVaKmB0//TId+ZxJXsPVXrsYa5+rf92xNj8Z/tIf90adGuydVsgP/iq
         vEeqzW1VMl8yA==
Date:   Mon, 16 Jul 2018 18:29:44 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: Signed-off-by missing for commits in the pinctrl
 tree
Message-ID: <20180716182944.593cca3c@canb.auug.org.au>
In-Reply-To: <CACRpkdZ5BA1wn=TPn4yWkwWd3pAKh9wuMHd9woBF=+6+L1jtFA@mail.gmail.com>
References: <20180716081018.21bfe495@canb.auug.org.au>
        <CACRpkdZ5BA1wn=TPn4yWkwWd3pAKh9wuMHd9woBF=+6+L1jtFA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/kLgnjxYTczi979.lb9L=53H"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/kLgnjxYTczi979.lb9L=53H
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Linus,

On Mon, 16 Jul 2018 09:52:44 +0200 Linus Walleij <linus.walleij@linaro.org>=
 wrote:
>
> On Mon, Jul 16, 2018 at 12:10 AM Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>=20
> > Commits
> >
> >   bc319333c156 ("pinctrl: sh-pfc: r8a77965: Add HSCIF pins, groups, and=
 functions")
> >   99500c6a4836 ("pinctrl: sh-pfc: r8a77990: Revise USB ID pin name")
> >   3d3c62d3458a ("pinctrl: sh-pfc: r8a77990: Add USB2.0 pins, groups and=
 functions")
> >   1e0f13198edf ("pinctrl: sh-pfc: r8a77990: Add USB3.0 pins, groups and=
 functions")
> >
> > are missing a Signed-off-by from their committer. =20
>=20
> I am looking at this and I just feel confused. Top to bottom:
>=20
  ...
>=20
> This is very confusing, it looks correct to me.
>=20
> As usual it must be some minor syntactic thing like a character missing or
> something, I am just soo.... what's wrong here, really?

In the tree I fetched this morning, those commits are all committed by
you, but you did not add a Signed-off-by to then.  This usually happens
when you rebase a branch/tree.

$ git show --pretty=3Dfull bc319333c156
Author: Takeshi Kihara <takeshi.kihara.df@renesas.com>
Commit: Linus Walleij <linus.walleij@linaro.org>

    pinctrl: sh-pfc: r8a77965: Add HSCIF pins, groups, and functions
   =20
    This patch adds HSCIF{0,1,2,3,4} pins, groups and functions to
    the R8A77965 SoC.
   =20
    Signed-off-by: Takeshi Kihara <takeshi.kihara.df@renesas.com>
    Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

...
--=20
Cheers,
Stephen Rothwell

--Sig_/kLgnjxYTczi979.lb9L=53H
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAltMV3gACgkQAVBC80lX
0GxMWwf/YZvd4hqOAfL2UhJyun7iZGlsrpadv91AJ4UhAUAa2HSlvZxm2+tzvKIz
8rtPPKdGAfdD7Vat+ERMnXGqopUPB/nDWS6sHgkvcYOocPbrfpD6B2bwx6vGlD/V
E83iWksEpWSdw1DxI+CApncqY5CZl57H0rpatsgZ8Nz5Q6iGHbD7JGBddPpyiYU1
gQtV9E8Tu/DMHyRbUbwdKzdVHWztWOgckHuMeMrcoLhFLyA1J0/OfRAujlWqubkG
kvryf1/WdOvNbhi4VDlYhoPnAzxpLZDIANihK/lUELPVmLtf1GRtCY86Ro0sRY9o
rjp2hE6Ao3zEAmQOG70PDMlz8HcYsw==
=l3ht
-----END PGP SIGNATURE-----

--Sig_/kLgnjxYTczi979.lb9L=53H--
