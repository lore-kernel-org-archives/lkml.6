Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A936CC07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 12:54:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C1AE20849
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 12:54:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C1AE20849
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726507AbeLKMy0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 07:54:26 -0500
Received: from mx1.redhat.com ([209.132.183.28]:53566 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726230AbeLKMy0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 07:54:26 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id F1AA6C00EB03;
        Tue, 11 Dec 2018 12:54:25 +0000 (UTC)
Received: from localhost (ovpn-117-164.ams2.redhat.com [10.36.117.164])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 825445C1B4;
        Tue, 11 Dec 2018 12:54:25 +0000 (UTC)
Date:   Tue, 11 Dec 2018 12:54:24 +0000
From:   Stefan Hajnoczi <stefanha@redhat.com>
To:     Vivek Goyal <vgoyal@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, miklos@szeredi.hu, dgilbert@redhat.com,
        sweil@redhat.com, swhiteho@redhat.com
Subject: Re: [PATCH 00/52] [RFC] virtio-fs: shared file system for virtual
 machines
Message-ID: <20181211125424.GB21137@stefanha-x1.localdomain>
References: <20181210171318.16998-1-vgoyal@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="rJwd6BRFiFCcLxzm"
Content-Disposition: inline
In-Reply-To: <20181210171318.16998-1-vgoyal@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.32]); Tue, 11 Dec 2018 12:54:26 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--rJwd6BRFiFCcLxzm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 10, 2018 at 12:12:26PM -0500, Vivek Goyal wrote:
> Hi,
>=20
> Here are RFC patches for virtio-fs. Looking for feedback on this approach.
>=20
> These patches should apply on top of 4.20-rc5. We have also put code for
> various components here.
>=20
> https://gitlab.com/virtio-fs

A draft specification for the virtio-fs device is available here:

https://stefanha.github.io/virtio/virtio-fs.html#x1-38800010 (HTML)

https://github.com/stefanha/virtio/commit/e1cac3777ef03bc9c5c8ee91bcc6ba478=
272e6b6

Stefan

--rJwd6BRFiFCcLxzm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJcD7OAAAoJEJykq7OBq3PIh7cIAK/A7ogv+93TBVp47MX7WwGA
o0wwXN7Tb4g0F3hA90GG6778qIHRbbW0Nh2ECLw3+bpNJOEYDSnvKF51KcZ2Vz/Q
S8pKHTFG0REpmAA9GXHfTtjhQMHfXcY7pyj9oElAihn5qzB/GumDbbPScnO81r08
tSnLb7Qr15ES+puv0Wth5ednCsjV0CqXQr54mpfVZBX6Vm+IJ2gfFWM/tVkOcrUo
XiaESGE/JMqxctanQOGUPxbPgYUFLjYTprIQUHR9pMD10RDLfJT8qfSFDYLinzoV
WdeiDxhzzOPwmqAcvIJJWn6b6qzzBslpn8njt8B+qP7JTfpz3tvii1KSP6WH3sc=
=KZX+
-----END PGP SIGNATURE-----

--rJwd6BRFiFCcLxzm--
