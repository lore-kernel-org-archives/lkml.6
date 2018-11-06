Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E73DC32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 21:34:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EAEBE206BA
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 21:34:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EAEBE206BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727473AbeKGHBV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 02:01:21 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54146 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725958AbeKGHBU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 02:01:20 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C0256308424D;
        Tue,  6 Nov 2018 21:34:06 +0000 (UTC)
Received: from haswell-e.nc.xsintricity.com (ovpn-112-74.rdu2.redhat.com [10.10.112.74])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 686B75D75C;
        Tue,  6 Nov 2018 21:34:05 +0000 (UTC)
Message-ID: <ac8361beee5dd80ad6546328dd7457bb6ee1ca5a.camel@redhat.com>
Subject: Re: [PATCH V2] mlx5: Fix formats with line continuation whitespace
From:   Doug Ledford <dledford@redhat.com>
To:     Leon Romanovsky <leon@kernel.org>, Joe Perches <joe@perches.com>
Cc:     Saeed Mahameed <saeedm@mellanox.com>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Tue, 06 Nov 2018 16:34:04 -0500
In-Reply-To: <20181101073412.GQ3974@mtr-leonro.mtl.com>
References: <f14db3287b23ed8af9bdbf8001e2e2fe7ae9e43a.camel@perches.com>
         <20181101073412.GQ3974@mtr-leonro.mtl.com>
Organization: Red Hat, Inc.
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-xF+pCoJdhHQPP7mzVYF8"
Mime-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.40]); Tue, 06 Nov 2018 21:34:06 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-xF+pCoJdhHQPP7mzVYF8
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2018-11-01 at 09:34 +0200, Leon Romanovsky wrote:
> On Thu, Nov 01, 2018 at 12:24:08AM -0700, Joe Perches wrote:
> > The line continuations unintentionally add whitespace so
> > instead use coalesced formats to remove the whitespace.
> >=20
> > Signed-off-by: Joe Perches <joe@perches.com>
> > ---
> >=20
> > v2: Remove excess space after %u
> >=20
> >  drivers/net/ethernet/mellanox/mlx5/core/rl.c | 6 ++----
> >  1 file changed, 2 insertions(+), 4 deletions(-)
> >=20
>=20
> Thanks,
> Reviewed-by: Leon Romanovsky <leonro@mellanox.com>

Applied, thanks.

--=20
Doug Ledford <dledford@redhat.com>
    GPG KeyID: B826A3330E572FDD
    Key fingerprint =3D AE6B 1BDA 122B 23B4 265B  1274 B826 A333 0E57 2FDD

--=-xF+pCoJdhHQPP7mzVYF8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEErmsb2hIrI7QmWxJ0uCajMw5XL90FAlviCMwACgkQuCajMw5X
L90r+g/+Jmdkw3PjfGgZm0CAjbhF0TdDMCc3RnpVCdJmRxQF7kVCHPJCBcX4PDlM
ODVXyWqgKE9n8itHTL+am85ioG5jxeJwriOLW4ei0OdKzbSQ//eR0DJMJB89EYVl
rUVGWLCFOjDjqoN3zIUm4U9beZM7/gkgtNE5X9XEE/JkaHvdRTiwPTgyBDmz1r7J
UgvfU5LLg6AJIrjcRuIxkZ5I2pzkEcUt0Tnh16+81va0mEQAxDZrTXcaiz9lItGS
FPw86v+I3YkaKC5nuQekmRVn9yHimS7WJZih+F61gCKFmVEBSJAoAp/QL82AIUll
kdWct31aZF4Dw6FyHxGuAI1NGvaevr0rCmOt+jIfp/cYpyXQKdAJoEPDH3cFTQJm
NTeKhrMVuIrNFmf2W/CIyETLG6ohLDzQCqfQBdnBpmnr8aDFaQlgL6HXyalqlfxz
JKzUtWn1QgYVEiQRw+JMrcuPXWthyZgDXrY7RwhO7CH4jNg30TmAXTpO+9WEH6Uv
Vwk31T6PmXZyrqE5CuQ+fX9HUIYnlPqaNvGAFgqBxeAWOccpVFQLkCxozLykGa5t
9a2Hs8NsVrVfsxh2JkQvcJksP7XgmXHMKWNhyK2bsMry07bgr6zigolt/yFO+6Cc
3bRxR6NIAm87Q3CQ0BSWA0LavGTthh1+9bqR1UM1LC05/xoNwzA=
=1u0t
-----END PGP SIGNATURE-----

--=-xF+pCoJdhHQPP7mzVYF8--

