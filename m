Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 031E2C169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 08:27:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6A10207E0
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 08:27:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="bAhYVRvx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727571AbfA2I1K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 03:27:10 -0500
Received: from ozlabs.org ([203.11.71.1]:51275 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725468AbfA2I1K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 03:27:10 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 43pfk31z3cz9sDr;
        Tue, 29 Jan 2019 19:27:07 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1548750427;
        bh=w9EViLN9ZtuFTaZaZDLmdGDtYNekmcD1NoG+F6I1vO4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=bAhYVRvxKvLpI3bY6jY+h7Lok9JgNbjqMiHt2eGepI122p199yIDqim1mtcLMoutP
         z0H18ZJJ3zWyxYy+Jwa41G1QlU/HhRsMm7WDpysnaPWMV6+zXGNFEs2DzKSpeRXDDe
         oRiNEQueRaNxbxCV282VTto8GiF3BoimaAA/rX0x5EJqJgJLQlUVfV9l5h/NPzKFnu
         4dlNbLZLAqTbSCF51rNaK/7qRMGsWnYUekpAQwP/eV+X+YQ3slJTCXjaYja8CFzBgq
         HMqZmkZBePKpQyXX+DnqErVHxU0s/qQdXBJEa6FtlX/e1LEsVXebkM7Vz0QIcxaj6P
         K+rqOzHC760uw==
Date:   Tue, 29 Jan 2019 19:26:58 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        Boris Brezillon <bbrezillon@kernel.org>
Subject: Re: linux-next: build warning after merge of the spi tree
Message-ID: <20190129192658.72c88d0b@canb.auug.org.au>
In-Reply-To: <VI1PR04MB57262F1ADEEC151C11E0F48499970@VI1PR04MB5726.eurprd04.prod.outlook.com>
References: <20190129130237.677e5ac8@canb.auug.org.au>
        <VI1PR04MB57262F1ADEEC151C11E0F48499970@VI1PR04MB5726.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/nR.wLo.BV8Z2hlBxcL3ZgDf"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/nR.wLo.BV8Z2hlBxcL3ZgDf
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Yogesh,

On Tue, 29 Jan 2019 06:57:51 +0000 Yogesh Narayan Gaur <yogeshnarayan.gaur@=
nxp.com> wrote:
>
> > WARNING: modpost: missing MODULE_LICENSE() in drivers/spi/spi-nxp-fspi.o
> > see include/linux/module.h for more information
> >  =20
> Can someone help in pointing out that why above warning message is coming=
 for mentioned commit.
> Below MODULE_LICENSE string is present in the above mentioned file, drive=
rs/spi/spi-nxp-fspi.c.
>     MODULE_LICENSE("GPL v2");

The version in linux-next has no such line.

--=20
Cheers,
Stephen Rothwell

--Sig_/nR.wLo.BV8Z2hlBxcL3ZgDf
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlxQDlIACgkQAVBC80lX
0GwMyAgAlaxhXi/RTWjS/ke601GBHyLuVCuVlpvtFGJKsTUynKb9Q7MKSRMCUe1i
HRUSgcXihvAE3iCJVOcx0zgV8XqeG0X11G0x9l2QzZ/4LXqnFlynHD7fWGynDTf0
deDR6znEwfiaKzQ4eAuSz0QLMjwELAd/kwdbVzkAkDhk8nJ82dlF9d6o2eJ95GUj
Bo8Z2Fdt/zKGkzQSWK6l2BjsCV8prwvONiqxm8FiqkDwBZ8Z80QYmiDWjralR/Ko
4vcn+SNje0qR62QWojdg8hhrpLDjpVbo0i4KunKgblf+FuSX5BaAZhww++hgSQCQ
s7NeqH7wI+D4MhRookiF/Ydj/UQYMg==
=bDbJ
-----END PGP SIGNATURE-----

--Sig_/nR.wLo.BV8Z2hlBxcL3ZgDf--
