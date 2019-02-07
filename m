Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB634C282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 06:15:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9FA9218FE
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 06:15:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="UKC8VunS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726764AbfBGGP6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 01:15:58 -0500
Received: from ozlabs.org ([203.11.71.1]:60401 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725912AbfBGGP6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 01:15:58 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 43w7NW5qS8z9s4V;
        Thu,  7 Feb 2019 17:15:55 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1549520155;
        bh=NNQFVJ6H0Bpbl6oc9VXLbu69ShQo256n4Ona0W62prY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=UKC8VunSu9ti7RW7yloP70oWkqR/+UW+MHlazDg0+h9M8/O4txYrwz0pHpagi5VHZ
         PVncrPbr3mt0XQi2IDD3fo72HoLUVSn6AO6g9/qSt2xvzvzL3tKv+Nb/g6HH0sX2La
         o7+hsmCbYP49/yhgBSEb2jqvKEPi0u/hSAGk+ZkxP7e+GjfJEDSsSFQBFHAyItMxbk
         TlAG1BfeRBMdbeAi1TRyD+luwIS5cPyoHJA1wpx1m7KxnCJNA16teBBauY3BjZ7sbC
         Rgk2hy5un5o3+qIzSGnoAwRo2L8OIBxIdzh4mpebjKBC2pUEdJpHpcZyjWTxBPpgqW
         iYqbWD5hcLWJA==
Date:   Thu, 7 Feb 2019 17:15:54 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: linux-next: manual merge of the scsi-mkp tree with the fixes
 tree
Message-ID: <20190207171554.59c91dbf@canb.auug.org.au>
In-Reply-To: <20190207165134.57c853dd@canb.auug.org.au>
References: <20190207154747.03209c75@canb.auug.org.au>
        <20190207165134.57c853dd@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_//gUIvffR+3eiz_1lp/KzzB6"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_//gUIvffR+3eiz_1lp/KzzB6
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Thu, 7 Feb 2019 16:51:34 +1100 Stephen Rothwell <sfr@canb.auug.org.au> w=
rote:
>
> On Thu, 7 Feb 2019 15:47:47 +1100 Stephen Rothwell <sfr@canb.auug.org.au>=
 wrote:
> >
> > Today's linux-next merge of the scsi-mkp tree got a conflict in:
> >=20
> >   drivers/scsi/osd/osd_initiator.c
> >=20
> > between commit:
> >=20
> >   24648908acac ("scsi: osd: osd_initiator: mark expected switch fall-th=
roughs") =20
>=20
> I will remove that from my fixes tree for tomorrow.

And that same patch appears in the kspp-gustavo tree as well ...

--=20
Cheers,
Stephen Rothwell

--Sig_//gUIvffR+3eiz_1lp/KzzB6
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlxbzRoACgkQAVBC80lX
0Gy3fAf9FuF+gmrSuy2vecljZu2FoEgFQYTgks5+762fF5L8Fs0J4yLIbLPtZ2Pu
M0FJqSa0mxfEFIvpTcRKpx5d2bIFr1iResq3gshY+nKXOeo7kokUTAAVEH8W1DiO
vRGygI6/JnRKLHmKhokV2UQjqjyzM9Jnw2GcnM5ctz+9933PxZ5bUHqs1voxq2iO
JRx4O3iYn4re1uGfxPJa7YzuGKx8klAHzKDYL0n67X/um8/20yOevkgQYz+l9wsM
ypb0rxjkggucDW/ZM5ku4CaTHd6X1WEa8gAzB4Re11geajD7ihJ7LEDO1RIqO+ct
tGFl/ol0bCBzZoBDsgk9CtmXI2r1+w==
=awF7
-----END PGP SIGNATURE-----

--Sig_//gUIvffR+3eiz_1lp/KzzB6--
