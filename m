Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46507C0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 23:19:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 012E420825
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 23:19:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="Zts84GRo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 012E420825
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726765AbeKFIlv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 03:41:51 -0500
Received: from ozlabs.org ([203.11.71.1]:35859 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725738AbeKFIlv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 03:41:51 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 42ppY94ngCz9sBN;
        Tue,  6 Nov 2018 10:19:41 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1541459981;
        bh=YglW3ySUqpGi2OwFCCWx4ujkGVY7+LLzqpy3BJcl4fA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Zts84GRoCKIZ+Djx6U5Z1BoPIMxtljnvVvRF2FoM+KmfBIWD04V1bTSbiEB+1OGoM
         ZC+HlXy7K3/Ux1XbzbFwbNT0LslOYK4CYVtkfSS31jVeUreo51fyesx4u8pwaRukIt
         hHSqAyv0B9yKg86BeRdZ6vq9gBQPuZiW6gqI+wmj+2J6BMJuyh/EjTboAO3IVnp6k2
         SAN+KFtojcFYC45v+uYb+0CurFkLmDgcByf4U67af7tcmULbtRL4wR+vKOS6lrOxMO
         5YS1HzIVGOKEksrq3p4DyRUGbs/sOlTHoHJouztQIO1qQ0ESwl8QmBSnUn2KngU1cb
         19R3vuK7tAgjA==
Date:   Tue, 6 Nov 2018 10:19:41 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Max Filippov <jcmvbkbc@gmail.com>
Cc:     Linux-Next <linux-next@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: Signed-off-by missing for commit in the xtensa tree
Message-ID: <20181106101941.458c46f8@canb.auug.org.au>
In-Reply-To: <CAMo8BfLfkk864aRwy0jG9Tq5CizyDax85Sq6+5=3N0wrA_Cg5w@mail.gmail.com>
References: <20181106100856.0c9bdf3a@canb.auug.org.au>
        <CAMo8BfLfkk864aRwy0jG9Tq5CizyDax85Sq6+5=3N0wrA_Cg5w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/gk8UFKR49FldlWIkYZpK2dP"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/gk8UFKR49FldlWIkYZpK2dP
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Max,

On Mon, 5 Nov 2018 15:14:44 -0800 Max Filippov <jcmvbkbc@gmail.com> wrote:
>
> On Mon, Nov 5, 2018 at 3:09 PM Stephen Rothwell <sfr@canb.auug.org.au> wr=
ote:
> > Commit
> >
> >   12e90ddd8dbf ("Revert "xtensa: xtfpga: implement platform DMA address=
 helpers"")
> >
> > is missing a Signed-off-by from its author and committer.
> >
> > Reverts are commits too. =20
>=20
> Thanks for catching that. Should I rewrite that branch fixing up that com=
mit?

There is nothing else you can do.  The only reason not to is if you
strictly do not rebase your branch (or there has been lots of other
activity - which there is not in this case).

--=20
Cheers,
Stephen Rothwell

--Sig_/gk8UFKR49FldlWIkYZpK2dP
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlvg0A0ACgkQAVBC80lX
0GzGuwf/e2WEiT7htd3FFPfPcxhlIVJdHeJGOJGD/I/0UNg06Bg4ly66x3CKqnQ7
BcXCDUDv4IHd1Ll1qCyopc3gE85T4dUgcbnuNTeXs+wu8nm7woJNdF0TJKn3WnNg
YDUjZUh2B5GAhD7u2zSSDrIegYKfW7C5CHegeIlHGppOdc0RFcPemwqoVWndyejf
GUkAmfy0awMF7y4vXHEs8GdmelCI/zVtKueBXyvGCkwAfbuwMvSEyEEEfXM0cLTN
TSDz4RFSvjLsimQbB4wPXTnItI7la93LhBcYgKysEcQn8nDez9YPtOutO1WsfNqI
V8Jd57b5PnPsdxEGoz5MVl/4t+byCA==
=gh6J
-----END PGP SIGNATURE-----

--Sig_/gk8UFKR49FldlWIkYZpK2dP--
