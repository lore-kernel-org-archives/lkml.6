Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 004EFC5CFC0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 03:48:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99E4220020
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 03:48:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="slPVhRx0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99E4220020
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754628AbeFRDsx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Jun 2018 23:48:53 -0400
Received: from ozlabs.org ([203.11.71.1]:48269 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754549AbeFRDsw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jun 2018 23:48:52 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 418HBp31WPz9s3M;
        Mon, 18 Jun 2018 13:48:50 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1529293730;
        bh=Edbh7xCyOE57AA2Jfi/dFpnnQMdNYuJRZ0rDCmh8bNg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=slPVhRx01T+DF9SHwb9qL8dUT5NS5HPeEfEZY3gP2yrpjeNwI+6/2elwHGzG/LIh7
         i2IQZfTmG27og8hmYYC+svtPPe6Q2PFU7gbu/H3SXGWvf+eG5xFIO3zKJvc53tJ796
         wdGg9xq414gPx7TRDaFCIiVOM3a51/UYb/mXc+Ikp0ke+B0zktTvIJsV5bM89bJ+rc
         hpLqpDFRDXno976fioo0owzcvqkeJ37G5vFZIKrlW4w84P6/ZsDgnBld+GqK38wDzQ
         GLSq6XeMaAKoGjriiLTkjMU86mCdrDk7L51tDOJCJYZNsL5kKFFnH0yTGl8clueUq4
         ZtMj0Poda+AfA==
Date:   Mon, 18 Jun 2018 13:48:49 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Joerg Roedel <jroedel@suse.de>
Subject: Re: linux-next: manual merge of the rcu tree with Linus' tree
Message-ID: <20180618134849.70831fe2@canb.auug.org.au>
In-Reply-To: <20180612104607.69f6f15b@canb.auug.org.au>
References: <20180612104607.69f6f15b@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/_EDMy2JLIg6kqTbs3sy2/XA"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/_EDMy2JLIg6kqTbs3sy2/XA
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Tue, 12 Jun 2018 10:46:07 +1000 Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>
> Today's linux-next merge of the rcu tree got a conflict in:
>=20
>   drivers/iommu/amd_iommu.c
>=20
> between commit:
>=20
>   94c793accacd ("iommu/amd: Hide unused iommu_table_lock")
>=20
> from Linus' tree and commit:
>=20
>   1df9bb146146 ("EXP iommu: Placeholder for fix in mainline")
>=20
> from the rcu tree.

I am still getting this.
--=20
Cheers,
Stephen Rothwell

--Sig_/_EDMy2JLIg6kqTbs3sy2/XA
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlsnK6EACgkQAVBC80lX
0GxsMgf8C6KozWVLOqxZaozY45jMbywTE6LPfeNCnrQ5R7aDNy7KWbnhKFTMd2qP
urum5b8b0oGCMfsdAeCVnfyqWyfdFYzPcMQDOPupFkMar5a4/bpclj+vfs+KKCmw
cAegeXSqHPGxdxyuEVcQN0COyd8y8BRp8D3AznX0iFI5QTXuiQ0v90dwBwFaXDAS
PPDZ1VrubtE29fVJmqBJRZPDck/4VxsMFRFyG45qQg1ox9JlydtpjN2V4RtotujB
tAmaTAWCAcvpsSfYqbhoh+UEw67dcVO7f+STtA/HFXWc/WXgfh1ZBnOljJgE21Tb
GnOG2bqSgdr2IdWaUa6peTXWBZjMMQ==
=6Pnt
-----END PGP SIGNATURE-----

--Sig_/_EDMy2JLIg6kqTbs3sy2/XA--
