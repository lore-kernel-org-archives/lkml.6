Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 307F5ECDFDC
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 17:35:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1581621536
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 17:01:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1581621536
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727730AbeIMWLU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 18:11:20 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54530 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726821AbeIMWLU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 18:11:20 -0400
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.25])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 08E20310E981;
        Thu, 13 Sep 2018 17:00:59 +0000 (UTC)
Received: from haswell-e.nc.xsintricity.com (ovpn-112-20.rdu2.redhat.com [10.10.112.20])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 16CAD2010CF1;
        Thu, 13 Sep 2018 17:00:57 +0000 (UTC)
Message-ID: <4aff78ec912c8e898c9b1bf1503689a7790f887e.camel@redhat.com>
Subject: Re: [PATCH -next] RDMA: Remove duplicated include from ib_addr.h
From:   Doug Ledford <dledford@redhat.com>
To:     Leon Romanovsky <leon@kernel.org>,
        YueHaibing <yuehaibing@huawei.com>
Cc:     jgg@ziepe.ca, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org
Date:   Thu, 13 Sep 2018 13:00:56 -0400
In-Reply-To: <20180913155826.GR5257@mtr-leonro.mtl.com>
References: <20180913134752.22780-1-yuehaibing@huawei.com>
         <20180913155826.GR5257@mtr-leonro.mtl.com>
Organization: Red Hat, Inc.
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-W93PfBi418HMMnwsnXHV"
Mime-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.25
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.42]); Thu, 13 Sep 2018 17:00:59 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-W93PfBi418HMMnwsnXHV
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2018-09-13 at 18:58 +0300, Leon Romanovsky wrote:
> On Thu, Sep 13, 2018 at 09:47:52PM +0800, YueHaibing wrote:
> > Remove duplicated include.
> >=20
> > Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> > ---
> >  include/rdma/ib_addr.h | 1 -
> >  1 file changed, 1 deletion(-)
> >=20
>=20
> Thanks,
> Reviewed-by: Leon Romanovsky <leonro@mellanox.com>

Thanks, applied to for-next.

--=20
Doug Ledford <dledford@redhat.com>
    GPG KeyID: B826A3330E572FDD
    Key fingerprint =3D AE6B 1BDA 122B 23B4 265B  1274 B826 A333 0E57 2FDD

--=-W93PfBi418HMMnwsnXHV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEErmsb2hIrI7QmWxJ0uCajMw5XL90FAlual8gACgkQuCajMw5X
L91XMg//W1ErPkJI5Yk8X7tjpHXRraqcCZ0AxDfj5ldd4q9840jOJPp8ZgSXEPOC
eQ+veWSYUz7+keNwqTwRFM56DRmAI6qzC5U2mMoAo1fV6YTQbDJtJJWVL2G0Vm47
XU84kVQ7N1kgxJg8I4R/OmkIEDDVAGMl+nTNaTwVV9qJM87g1WjGFEPAEvFDXgkv
tV+vr0mQ+KYK/RnrWvB4mqweF8SiaSKfx5vXJ9qGBe368+KQAf/7E1vcBnsNMqaI
KTzOR6qyvghlbsvd8CBM4hlWHxyxHqljj05pSLYICcZieDab6SidtyzUO5jL/mbk
dkqGUPUlUFDF6R5Ufi3KXAzHM8vURyXIstCPXsWeTPUPt43oeqeJ4O/Nb4uizImR
xrtd5ps2P8SuLGNUadozq9A6ndmWptzH1WIrgutBc+PHgzb29d8bF8ATAiibu+Jp
46h3dDbJpIE/V3MCcOxzcez93Yy6hAkXPW2qLtotgo1B52AvOXcwBkmNnOiXkRq1
rsHcMQqzMCMG9lCzegmhrMBKsAvLEgyx9gaqR0RGyr59s8kNrcDZu7DcC+oMjOun
kBQFQq7cmqqGvgt8xjt/HbikQWIPR7gCy9hFFu5JMscE1uBwBMseGwW859Lq9bWN
/mE3CRhixPGlWMFTOJ7MIc42+tTk0/eCmxDt+f2zYqBL3O0RA4U=
=jQoy
-----END PGP SIGNATURE-----

--=-W93PfBi418HMMnwsnXHV--

