Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D58FECDE3A
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 19:01:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08A4D214C4
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 19:01:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08A4D214C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727002AbeJJCUH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 22:20:07 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54084 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726445AbeJJCUH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 22:20:07 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A59B5300B915;
        Tue,  9 Oct 2018 19:01:43 +0000 (UTC)
Received: from haswell-e.nc.xsintricity.com (ovpn-112-45.rdu2.redhat.com [10.10.112.45])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id DE1FA183D9;
        Tue,  9 Oct 2018 19:01:42 +0000 (UTC)
Message-ID: <82b16785a865b01ff82870a83363cb905b11f3b2.camel@redhat.com>
Subject: Re: [PATCH rdma-next 00/18] RDMA: Add support for ib_device_ops
From:   Doug Ledford <dledford@redhat.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>, Kamal Heib <kamalheib1@gmail.com>
Cc:     open list <linux-kernel@vger.kernel.org>
Date:   Tue, 09 Oct 2018 15:01:41 -0400
In-Reply-To: <CALEgSQuQyA9JiqaLfC5Un=foTeDHQG6EFJSCqBLTevD1KKKBhA@mail.gmail.com>
References: <20181009162817.4635-1-kamalheib1@gmail.com>
         <5e5e8b964bf9d6234af22f042f647a66868d0449.camel@redhat.com>
         <20181009184406.GA5235@kheib-workstation>
         <CALEgSQuQyA9JiqaLfC5Un=foTeDHQG6EFJSCqBLTevD1KKKBhA@mail.gmail.com>
Organization: Red Hat, Inc.
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-kNnWWL+c3LDhrzey8R0K"
Mime-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.43]); Tue, 09 Oct 2018 19:01:43 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-kNnWWL+c3LDhrzey8R0K
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2018-10-09 at 14:46 -0400, Jason Gunthorpe wrote:
>=20
>=20
> On Tue., Oct. 9, 2018, 2:44 p.m. Kamal Heib, <kamalheib1@gmail.com> wrote=
:
> > On Tue, Oct 09, 2018 at 02:31:27PM -0400, Doug Ledford wrote:
> > > On Tue, 2018-10-09 at 19:27 +0300, Kamal Heib wrote:
> > > > This patchset introduce a new structure that will contain all the
> > > > infiniband device operations, the structure will be used by the
> > > > providers to initialize their supported operations. This patchset a=
lso
> > > > includes the required changes in the core and ulps to start using i=
t.
> > > >=20
> > > > Thanks,
> > > > Kamal
> > >=20
> > > Hi Kamal,
> > >=20
> > > Please repost this to linux-rdma@vger.kernel.org as that's how this g=
ets
> > > into patchworks.
> > >
> >=20
> > Hi Doug,
> >=20
> > Oops, My bad instead of picking the linux-rdma email from get_maintaine=
r.pl output
> > I picked the linux-kernel email, I'll repost them soon and thanks for y=
our reply.
>=20
> Wait for comments before reposting such a large series..

It didn't go to linux-rdma at all, so many of the people that might
comment on it don't even know it exists, so I'm not sure how many
comments he ought to wait for ;-)

--=20
Doug Ledford <dledford@redhat.com>
    GPG KeyID: B826A3330E572FDD
    Key fingerprint =3D AE6B 1BDA 122B 23B4 265B  1274 B826 A333 0E57 2FDD

--=-kNnWWL+c3LDhrzey8R0K
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEErmsb2hIrI7QmWxJ0uCajMw5XL90FAlu8+xUACgkQuCajMw5X
L92HNw//ZN3fRagFWIATfPdLmqwui8GedZG1mCnPgxe91WlAIsqZqSYYUaxvPHE+
3xkt9xCEwYFVJSqu1G38tXQ05hS8yRJRzHMUlo1v6dXQOH4SE2McpFcJoVY1Zfq6
SCg4b0288i4zblDdn3lxs9tecXljwdvUrI9jSUO9IGrL4DGqENnfQXJjWvXZZd1a
RJxwUl9WIh/qfK2eBxCmhZITE6STrj/eIluHDlLMEuOiyL7BVegx3cNF40A+hTPj
+pVIXx7NncKiISOjg1sMiqSuegRg5HUxMfCG6gEFlmqESLDzkPMhTFhzT6UluIGT
jKA+iW9h9PQMDtjDOskcSvh3Qt0JjD3TmEdH9flH4YOuupTO0YVJ4pptyMHJ11td
/FiAKcdz5KG/Kq3EhA18YF0WOj7PNvuQSW+l6+0g0r748YinxljaS8iM5mme7kem
rnl3SRhU9rcMTrt4OGHAuC9YtQoQX8FKX2C6IuqhlWsnLREG6isqVoK0L/yspJad
0MGfCR91msrwzAFSrvYYok5Y65jxKqbZhHenbRiAk5g1BUxtlAC7ec3rhC6pBHHM
6dKpzW+ocz1Z7DIsgyXc5tVYXqN9HIjEx1ORfGSyrW4zEHt5zFeyeS5N9Pq9nGPO
wLSujbALyD/iHurfknzFoeH0SEEP69jdE9g8aYGdaIZSOZfw0jM=
=gk6E
-----END PGP SIGNATURE-----

--=-kNnWWL+c3LDhrzey8R0K--

