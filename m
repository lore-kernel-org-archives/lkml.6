Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD488C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 16:25:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 886F920C01
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 16:25:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730335AbfB0QZM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 11:25:12 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52308 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726223AbfB0QZL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 11:25:11 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 292B7E860;
        Wed, 27 Feb 2019 16:25:11 +0000 (UTC)
Received: from haswell-e.nc.xsintricity.com (ovpn-112-14.rdu2.redhat.com [10.10.112.14])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 9F7136B8FC;
        Wed, 27 Feb 2019 16:25:09 +0000 (UTC)
Message-ID: <16f0ac6227f948165b7062a72e1fa82f1dfe4697.camel@redhat.com>
Subject: Re: linux-next: manual merge of the net-next tree with the rdma tree
From:   Doug Ledford <dledford@redhat.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        David Miller <davem@davemloft.net>,
        Networking <netdev@vger.kernel.org>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Shamir Rabinovitch <shamir.rabinovitch@oracle.com>,
        Jakub Kicinski <jakub.kicinski@netronome.com>
Date:   Wed, 27 Feb 2019 11:24:51 -0500
In-Reply-To: <20190227112522.2f32b5d7@canb.auug.org.au>
References: <20190227112522.2f32b5d7@canb.auug.org.au>
Organization: Red Hat, Inc.
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-Ztt69rjC7eLb5Zkdd3kZ"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Wed, 27 Feb 2019 16:25:11 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-Ztt69rjC7eLb5Zkdd3kZ
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2019-02-27 at 11:25 +1100, Stephen Rothwell wrote:
> Hi all,
>=20
> Today's linux-next merge of the net-next tree got a conflict in:
>=20
>   drivers/infiniband/hw/mlx4/Kconfig
>=20
> between commit:
>=20
>   6fa8f1afd337 ("IB/{core,uverbs}: Move ib_umem_xxx functions from ib_cor=
e to ib_uverbs")
>=20
> from the rdma tree and commit:
>=20
>   f4b6bcc7002f ("net: devlink: turn devlink into a built-in")
>=20
> from the net-next tree.
>=20
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.
>=20

Thanks Stephen, we'll add it to the (largish this release) list of
conflicts to bring to Linus' attention.

--=20
Doug Ledford <dledford@redhat.com>
    GPG KeyID: B826A3330E572FDD
    Key fingerprint =3D AE6B 1BDA 122B 23B4 265B  1274 B826 A333 0E57 2FDD

--=-Ztt69rjC7eLb5Zkdd3kZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEErmsb2hIrI7QmWxJ0uCajMw5XL90FAlx2udMACgkQuCajMw5X
L908zg//WyrOBrH4aY9dpVct3tcwhj1OqaBUCNOwdkFkqB4VShFRf0tajMZLjWM7
aJamWayMn4uR9C6IkwbWhxnc6BYClwXIF1HetZIYXWBlj8ehoQI3Do9yuaBDzJsV
RvQ1bWbiIbHGmBQJ00f+0ZYsk4Dkfcu/4QCjWGWX3QpCRbUKucUgdovEL7XJFZil
Ydg8tRPck/t/U58pxugdRuSSnjHx3Bq/dRflSueti8vWv6BsGm+xtyH8U/cKIsgn
FvMZ1xLz+vnG1K9m7o/eXTCRJ4xv4FRt08nqdlPTENQndgLvTPLUnAvgcTIUrbyQ
EQW0PvV3k0z/bqQnGPpWnW50+evj3IsnEpBIcKkUn8FXjKc1yBobYMUF72QO7MEF
Mp90zsDbp9PVb3Z+fRZfZ2hli/iwoDQ67vvSHrZQkRvEJm+liCod3ac3cmZVUaOQ
tAwIkpRq50bWSrwBeRf8NagbyeKTRJTz5tg37Sr7cr2w1JPmpAXGgN6UZp+0b/r5
foPvseoQNA7U7OjYLb8IEEicFz3RYjcj3sO/5tAmEpAbn9GxFUpFbWJgmQa77T5W
ZytHSytt7drPKY8GQUvW4uaiSNIRLy24Pkojdanpyr/LsSvpkoDUmTRbUXVEcQL7
odXeNcozRvns3/7hbXh0g2a1RsvZloAl4xunjPpQC9iI+4ry1Z4=
=XnDM
-----END PGP SIGNATURE-----

--=-Ztt69rjC7eLb5Zkdd3kZ--

