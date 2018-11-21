Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF790C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 16:40:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC76E214C1
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 16:40:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC76E214C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731897AbeKVDPo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 22:15:44 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45011 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727100AbeKVDPo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 22:15:44 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 3AAF513A9B;
        Wed, 21 Nov 2018 16:40:34 +0000 (UTC)
Received: from natto.ory.fergeau.eu (ovpn-116-228.ams2.redhat.com [10.36.116.228])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E1D1C604A4;
        Wed, 21 Nov 2018 16:40:20 +0000 (UTC)
Received: by natto.ory.fergeau.eu (Postfix, from userid 1000)
        id 9E41B61F906; Wed, 21 Nov 2018 17:40:19 +0100 (CET)
Date:   Wed, 21 Nov 2018 17:40:19 +0100
From:   Christophe Fergeau <cfergeau@redhat.com>
To:     Gerd Hoffmann <kraxel@redhat.com>
Cc:     spice-devel@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [Spice-devel] [PATCH] drm/qxl: add spice-devel list to
 MAINTAINERS
Message-ID: <20181121164019.GF3883@natto.ory.fergeau.eu>
References: <20181121090129.23506-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Wo0oCZYLrer5S3Oe"
Content-Disposition: inline
In-Reply-To: <20181121090129.23506-1-kraxel@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Wed, 21 Nov 2018 16:40:34 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Wo0oCZYLrer5S3Oe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 21, 2018 at 10:01:29AM +0100, Gerd Hoffmann wrote:
> So qxl kernel patches are sent to the spice-devel list for review.
>=20
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 4caac2f6b0..d9945d57eb 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -4728,6 +4728,7 @@ DRM DRIVER FOR QXL VIRTUAL GPU
>  M:	Dave Airlie <airlied@redhat.com>
>  M:	Gerd Hoffmann <kraxel@redhat.com>
>  L:	virtualization@lists.linux-foundation.org
> +L:	spice-devel@lists.freedesktop.org

Should this also list dri-devel@lists.freedesktop.org ?

Christophe

--Wo0oCZYLrer5S3Oe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEElKn3VmH3emFoZJsjqdjCFCmsbIIFAlv1imoACgkQqdjCFCms
bIK0/A/8CHuj83wMKfoe9fruF7oDgPP1cwLzycxQZZFZGnkCvT0JDN8fhUptc+d8
RJ81ecwWhgWuF5RYNzqe6+PvMQuQ5DLXhnxQ+z0c8NrVTa3OsTG8TLLy8oq+3LR3
aITaO4uWQ6jLQcvLmxXCiE7El7pWLS1XJUrb6plxeRBZdq3q39aZ2nXL7RgeTn2r
IAndDbfmkQZEdjN79dB/2rdX2uh/e9ZpjFzXAGF8JKuHoDP851YPHzErPJHfBJSO
CD0fL3M6Xbkrn0mCH5gcdAgqzDXoW8svSHUPPG8TtBnDbHRVzdq0c3sx2Q6ojGoy
FSDSvmRWDvDTpoZQuOMmkltwEYAtglZrBvX8l1LB2uWRB8ba9hPYGzOvBsQQU84W
C3Xx8DMc64Q8L9c+jJm6FfMIqSccPgQ0CIw7yr5t1yHgQ5IJrBfgvl10iwU+j2us
g8sivh7/xfEgiEc56gdCHFTU603WHuvYvEy+dRvOGUXEmU4Wnn5gI3GWA51GDmEx
dfy9SCR8SB65FTcfSPpmRJWqWUUSt6C2Ui916URrPRQLWnhEg1n1GUL+y591ZVnn
dQJzPh3HRLTvzYTfAIR6yaCZDsjc6YKdANI7BxbUgnSulm6CiyQwowA3hwV3hh0e
XL2ca3WQLN9ZRgZwgUBTzCMwlRI1tihpwcixW8QL3y4GWXIvhIU=
=0jWh
-----END PGP SIGNATURE-----

--Wo0oCZYLrer5S3Oe--
