Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23E6BC32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 15:21:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBCBB20869
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 15:21:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DBCBB20869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387930AbeKGAri (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 19:47:38 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52038 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730495AbeKGAri (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 19:47:38 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A0289308212C;
        Tue,  6 Nov 2018 15:21:56 +0000 (UTC)
Received: from localhost (ovpn-117-210.ams2.redhat.com [10.36.117.210])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2A3BF5D9C8;
        Tue,  6 Nov 2018 15:21:55 +0000 (UTC)
Date:   Tue, 6 Nov 2018 15:21:55 +0000
From:   Stefan Hajnoczi <stefanha@redhat.com>
To:     Vitaly Mayatskih <v.mayatskih@gmail.com>
Cc:     borntraeger@de.ibm.com, Jason Wang <jasowang@redhat.com>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Subject: Re: [PATCH 0/1] vhost: add vhost_blk driver
Message-ID: <20181106152155.GA31579@stefanha-x1.localdomain>
References: <20181102182123.29420-1-v.mayatskih@gmail.com>
 <6a7f1668-bf2d-0caa-2efd-c8fab5f1db24@redhat.com>
 <c042686f-db95-514d-8bd8-92b72e4e087a@de.ibm.com>
 <CAGF4SLjC5Gs33k1XzK8vFF5FWE0pwHvB56iQ--DJ_4ADw5yuGg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="M9NhX3UHpAaciwkO"
Content-Disposition: inline
In-Reply-To: <CAGF4SLjC5Gs33k1XzK8vFF5FWE0pwHvB56iQ--DJ_4ADw5yuGg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.42]); Tue, 06 Nov 2018 15:21:56 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--M9NhX3UHpAaciwkO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 05, 2018 at 11:15:04AM -0500, Vitaly Mayatskih wrote:
> On Mon, Nov 5, 2018 at 10:48 AM Christian Borntraeger
> <borntraeger@de.ibm.com> wrote:
>=20
> > For the record, we still do use virtio-blk a lot. As we see new things =
like discard/write zero
> > support it seems that others do as well.
>=20
> Yes, trim/discard and writesame support is planned, at least for
> submit_bio path (not in this patch).

I agree, virtio_blk is quite popular and not deprecated/frozen.

Stefan

--M9NhX3UHpAaciwkO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJb4bGTAAoJEJykq7OBq3PINHAH/RMVu0n4qzOEyEky9DGqqMzA
03ZEJGv9GOSA9R/BywE6uDHWcFvn80MOx52U91O9Cz1wDwZsjVwujBLW/BXOQKGR
ZansMQbTdlEYLGtrmNV5y/O/Von2/FZuhHhhbACgMKM3VifByI3yYQgfyoItql+X
hZDRlaNFr59u9Ib8lOswPoXvMF/HiM3QsRKvYdd0QTGtItUuBRMaYuZgG40dsgdh
o8+9bk/FkmhY8QT6qx26vPp0Qc02A+6Opvf/MYBRDqbaHPqmL+gmIEYG6BGfyxaV
NdYjXPzOCve0OcvHtd2fmboYrlGeoduN/q0guVZgp6XC0cEvcw+HhH7IP56zirA=
=fSFj
-----END PGP SIGNATURE-----

--M9NhX3UHpAaciwkO--
