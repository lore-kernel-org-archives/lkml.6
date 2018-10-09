Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79EB0ECDE3A
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 18:31:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35EE62085B
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 18:31:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35EE62085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726718AbeJJBtr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 21:49:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39440 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726460AbeJJBtq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 21:49:46 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 29EF33002C65;
        Tue,  9 Oct 2018 18:31:30 +0000 (UTC)
Received: from haswell-e.nc.xsintricity.com (ovpn-112-45.rdu2.redhat.com [10.10.112.45])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 54AD875541;
        Tue,  9 Oct 2018 18:31:29 +0000 (UTC)
Message-ID: <5e5e8b964bf9d6234af22f042f647a66868d0449.camel@redhat.com>
Subject: Re: [PATCH rdma-next 00/18] RDMA: Add support for ib_device_ops
From:   Doug Ledford <dledford@redhat.com>
To:     Kamal Heib <kamalheib1@gmail.com>, Jason Gunthorpe <jgg@ziepe.ca>
Cc:     linux-kernel@vger.kernel.org
Date:   Tue, 09 Oct 2018 14:31:27 -0400
In-Reply-To: <20181009162817.4635-1-kamalheib1@gmail.com>
References: <20181009162817.4635-1-kamalheib1@gmail.com>
Organization: Red Hat, Inc.
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-qVMBI5ZMdn822WeUHCng"
Mime-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.46]); Tue, 09 Oct 2018 18:31:30 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-qVMBI5ZMdn822WeUHCng
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2018-10-09 at 19:27 +0300, Kamal Heib wrote:
> This patchset introduce a new structure that will contain all the
> infiniband device operations, the structure will be used by the
> providers to initialize their supported operations. This patchset also
> includes the required changes in the core and ulps to start using it.
>=20
> Thanks,
> Kamal

Hi Kamal,

Please repost this to linux-rdma@vger.kernel.org as that's how this gets
into patchworks.

--=20
Doug Ledford <dledford@redhat.com>
    GPG KeyID: B826A3330E572FDD
    Key fingerprint =3D AE6B 1BDA 122B 23B4 265B  1274 B826 A333 0E57 2FDD

--=-qVMBI5ZMdn822WeUHCng
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEErmsb2hIrI7QmWxJ0uCajMw5XL90FAlu88/8ACgkQuCajMw5X
L92HhRAAnTTikU2Gmq98ymV9fLYdvbl2Q8T5Dcak8iW0HCPl6IQnIO3kONhhGB0O
0hWJrLaGtBLMG59+f5wlBJmJi3FUPQeeAkRuGHrUE/qRss6ujyIE817ALry+Civi
owL0u7FqtfUaoCXN1GMs4N8T5SfH2XqoDy4LBesSUqwSf4+xYdcDkwxJek9hD0/V
MZId4WzbsHTuzd/bv/mQtSilc6SLzE4kcCyMyWK+/lMz3iYhvBvOKm5YtRPQIYmw
snbsykPj0UWrCKdqrOH3OHq/cf0AuaEYKBJ/IPMyqTZVbL3pcL8W4PbMU6RkmRJZ
4/N0t6JDg6hgCuN/bkhLtDlhzaz0BctzYwg2dcmy3kGZVgXz3Ca1IJNorxvSOCeU
jRH+hJghi0MZ3tqFqZXEFy6/UBjuhy8/rv26cPbBnNgP+L9fSGmed5+CyTDRyrky
RsDIzzJacVWyzWeu0adC6fypQQHyOzJeOzw3CH9uTWnl3zLeOVnMhrHQkftngH6z
Mp55FS6BU3bAyp6a5366QIkZznzRrjZeqa00o2mKZ8TG2lix8Yu/xm86Qa6EjtGw
+2IWQTR561uT1bVYNWto4sRlT3tvH2TcUSF6QsQZP5HhazZ/xmIizT2zNqGnEUjk
pnyJ8fQbwWI8AjPJgZzIIsxDyK6+u7Z6gKLMRd2CunCYttdJrTQ=
=3y66
-----END PGP SIGNATURE-----

--=-qVMBI5ZMdn822WeUHCng--

