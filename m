Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82485ECE567
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 16:03:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 473F621557
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 16:03:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 473F621557
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390615AbeIUVxK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 17:53:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60208 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728221AbeIUVxJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 17:53:09 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 3B6868CD0;
        Fri, 21 Sep 2018 16:03:38 +0000 (UTC)
Received: from haswell-e.nc.xsintricity.com (ovpn-112-17.rdu2.redhat.com [10.10.112.17])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 2005317D39;
        Fri, 21 Sep 2018 16:03:36 +0000 (UTC)
Message-ID: <5749e7cf632c43ffa87df5b2cdd7894581d24b66.camel@redhat.com>
Subject: Re: [PATCH] RDMA/cxgb4: remove redundant null pointer check before
 kfree_skb
From:   Doug Ledford <dledford@redhat.com>
To:     zhong jiang <zhongjiang@huawei.com>, swise@chelsio.com,
        jgg@ziepe.ca
Cc:     linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Fri, 21 Sep 2018 12:03:35 -0400
In-Reply-To: <1537437162-42846-1-git-send-email-zhongjiang@huawei.com>
References: <1537437162-42846-1-git-send-email-zhongjiang@huawei.com>
Organization: Red Hat, Inc.
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-Zc6UhuEnTOyWw/hV62x6"
Mime-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Fri, 21 Sep 2018 16:03:38 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-Zc6UhuEnTOyWw/hV62x6
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2018-09-20 at 17:52 +0800, zhong jiang wrote:
> kfree_skb has taken the null pointer into account. hence it is safe
> to remove the redundant null pointer check before kfree_skb.
>=20
> Signed-off-by: zhong jiang <zhongjiang@huawei.com>

Applied to for-next, thanks.

--=20
Doug Ledford <dledford@redhat.com>
    GPG KeyID: B826A3330E572FDD
    Key fingerprint =3D AE6B 1BDA 122B 23B4 265B  1274 B826 A333 0E57 2FDD

--=-Zc6UhuEnTOyWw/hV62x6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEErmsb2hIrI7QmWxJ0uCajMw5XL90FAlulFlcACgkQuCajMw5X
L93Mxg/+I76BAUtGBcxHED4JOlZPYkanNxkxMR9U1OQeBdIMDqsoPL4FSxZrHnkf
t2XBgO9QJEnnaBtO2G8AqMasykwFyRX+ZDL55ieUjENAeCnWseGg8l5FZk/Ydq9u
olpz5TUdDhE8MzGjPlQwCQCtNBmXY4e/RjdkO1ucwrlv0eEJzksa9sB8rCz6gAGE
5ZK0/5d2AXrcH226o1jjpWxlflqv/g2qLmgiV4dIS/ZFzOYtBWFtnd6iBFaleG1d
F2aMIcd78vSifEmCpXR53HIf7fjhxt8IQKr1HO1cc7w+ZdV8h7oaw6P46hzOXT4d
hBpzSqoQFagzNwXlFuXMUbSwzsyiy9o+c26ZEwkDxATGSBbBbQrPM7NeZPnfSBze
S12weyykz3gg1gWDbM6FxpmJuo3UvWF5s7lMuHjm65v7gyVoWVCi6SfKIEUhaGaC
RQniZ6jm6nDTlrPhvRidL8isfyC26sgmZxX8rK4RVnuxkV5pBYf8I8gvTmTwPGsz
ARgk6mX79X4blchsvCauM5B+vULZmCJY9SLOluYjll/PWOrUJM5Gre5KLUw3lQrJ
4b26g+PZJ8khUU6muWeuhw477rz4tr5Ajb9U9VLOafoll/G1LzgGHtKW5LX1dhAU
3o/tODd99WCXHMtfIxrBolN4kmlBiPzyRHOH4CLSx9yy4vIYAQw=
=zPiP
-----END PGP SIGNATURE-----

--=-Zc6UhuEnTOyWw/hV62x6--

