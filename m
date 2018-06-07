Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id j9VlCr0sGVuLIAAAmS7hNA
	; Thu, 07 Jun 2018 13:04:58 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id E0C4E608B8; Thu,  7 Jun 2018 13:04:57 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 63538601C3;
	Thu,  7 Jun 2018 13:04:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 63538601C3
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752857AbeFGNEz (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 09:04:55 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:56770 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750891AbeFGNEy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 09:04:54 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id B528FCB9C0;
        Thu,  7 Jun 2018 13:04:53 +0000 (UTC)
Received: from localhost (ovpn-117-192.ams2.redhat.com [10.36.117.192])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5D9A110EE6C5;
        Thu,  7 Jun 2018 13:04:49 +0000 (UTC)
Date: Thu, 7 Jun 2018 14:04:48 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Tiwei Bie <tiwei.bie@intel.com>
Cc: mst@redhat.com, jasowang@redhat.com, cohuck@redhat.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, virtio-dev@lists.oasis-open.org
Subject: Re: [PATCH v3] virtio: update the comments for transport features
Message-ID: <20180607130448.GM19032@stefanha-x1.localdomain>
References: <20180601112632.12651-1-tiwei.bie@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="VLAOICcq5m4DWEYr"
Content-Disposition: inline
In-Reply-To: <20180601112632.12651-1-tiwei.bie@intel.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Thu, 07 Jun 2018 13:04:53 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Thu, 07 Jun 2018 13:04:53 +0000 (UTC) for IP:'10.11.54.3' DOMAIN:'int-mx03.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'stefanha@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--VLAOICcq5m4DWEYr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 01, 2018 at 07:26:32PM +0800, Tiwei Bie wrote:
> The existing comments for transport features are outdated.
> So update them to address the latest changes in the spec.
>=20
> Suggested-by: Michael S. Tsirkin <mst@redhat.com>
> Signed-off-by: Tiwei Bie <tiwei.bie@intel.com>
> Reviewed-by: Cornelia Huck <cohuck@redhat.com>
> ---
> This patch is generated on top of below patch:
> https://lists.oasis-open.org/archives/virtio-dev/201805/msg00212.html
>=20
> v3:
> - Fix a typo in the commit message (Cornelia);
>=20
> v2:
> - Improve the comments (Cornelia);
> - Improve the commit message;
>=20
>  include/uapi/linux/virtio_config.h | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--VLAOICcq5m4DWEYr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJbGS1wAAoJEJykq7OBq3PIsQgH/juE93zamoKrVvX0dLQqbPh7
cO+fADWB/7gWbUTAivY6zhpmxKN22QaR8OTrbJHctlS2A8NV3Ra7NOjNq9ThZEWQ
lsVF58S3PHBZVoI11pbd1FYgJvhQbBtI18wdN0VWwu2bXfL18qIEpELnfS/ePkvJ
WUx6nPt8JcqDwPwQpVyQFfRLudcg5N8RLXxTGPhSOHjyiPzfHkxvrs/Qu51W75C7
rX9K3AjauK4Rc1nebJG/u4REDJch6zBiTCqGod4cZCR4Zc/oeXQKCz02RLL8/VeR
zvfilxTYEEelkYa/+5mUDnt1tGpAssOt+Es/h0uERnxnL3haa1D+ofI8DYX+IM4=
=qMT1
-----END PGP SIGNATURE-----

--VLAOICcq5m4DWEYr--
