Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C147C04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 20:24:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD62E2084C
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 20:24:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD62E2084C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729430AbeLJUYF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 15:24:05 -0500
Received: from vmicros1.altlinux.org ([194.107.17.57]:50114 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728182AbeLJUYF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 15:24:05 -0500
Received: from mua.local.altlinux.org (mua.local.altlinux.org [192.168.1.14])
        by vmicros1.altlinux.org (Postfix) with ESMTP id 333DE72CC66;
        Mon, 10 Dec 2018 23:24:02 +0300 (MSK)
Received: by mua.local.altlinux.org (Postfix, from userid 508)
        id 27D457CF426; Mon, 10 Dec 2018 23:24:02 +0300 (MSK)
Date:   Mon, 10 Dec 2018 23:24:02 +0300
From:   "Dmitry V. Levin" <ldv@altlinux.org>
To:     Max Filippov <jcmvbkbc@gmail.com>
Cc:     Oleg Nesterov <oleg@redhat.com>,
        Andrew Lutomirski <luto@kernel.org>,
        Elvira Khabirova <lineprinter@altlinux.org>,
        Eugene Syromyatnikov <esyr@redhat.com>,
        Chris Zankel <chris@zankel.net>,
        Paul Moore <paul@paul-moore.com>,
        Eric Paris <eparis@redhat.com>, linux-xtensa@linux-xtensa.org,
        linux-audit@redhat.com, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 19/25] xtensa: define syscall_get_* functions
Message-ID: <20181210202402.GA18101@altlinux.org>
References: <20181210042352.GA6092@altlinux.org>
 <20181210043041.GS6131@altlinux.org>
 <CAMo8Bf+s6xObgYoOOR0NTQZR-ReBbXmNv_5Jf=jX7J+bnDsTYQ@mail.gmail.com>
 <20181210125315.GB11942@altlinux.org>
 <CAMo8BfLbk8wfUNVZ_Qa9XVTtg4f5k5Wj6LFauroheheoTCJPxw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="k+w/mQv8wyuph6w0"
Content-Disposition: inline
In-Reply-To: <CAMo8BfLbk8wfUNVZ_Qa9XVTtg4f5k5Wj6LFauroheheoTCJPxw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--k+w/mQv8wyuph6w0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 10, 2018 at 12:14:37PM -0800, Max Filippov wrote:
> On Mon, Dec 10, 2018 at 4:53 AM Dmitry V. Levin <ldv@altlinux.org> wrote:
> > On Sun, Dec 09, 2018 at 09:02:50PM -0800, Max Filippov wrote:
> > > How should we synchronize our changes?
> >
> > No problem, I can revert to the previous edition of this patch
> > that just adds syscall_get_arch.
> > Alternatively, you can just take that couple of patches (v5 18/25
> > and v2 15/15) into your tree.
>=20
> Sure I can do the second. Will it work for v2 16/15 that changes
> syscall_get_arch adding an argument to it?

No, I'm afraid it won't work for v2 16/15 (aka v5 22/25), which means
I'd have to keep them in the series.


--=20
ldv

--k+w/mQv8wyuph6w0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJcDsthAAoJEAVFT+BVnCUIDEMQAKlzFK2DLfgXd+Pyf5nmLsHC
J7sKHGVvkhwIFX+bCznFKT/kw7tcW8qdLPJipjQPRMzK3+YLImq488p5Iegh806D
vSJVfKSbj/ss29DEkZozCdwXIjLDbbj7yGQjpCTAtJ0aiPYV6iEV6kzxejoXjTta
U5AxGUL4SvCciP3tx6Nzoo8vQMh4gnHadFoSo/svEeBwFZDmJ+6lBr8zUBdg+63U
hYs5SJl/38kAZu1+ZV3DPq3iyJZIb8LBWLaA0tIQ7LJNy50QPrsg09B9z/pnROKg
2ZJfMjsTqOHuEp7dfQ5l/8e63Emc83b7j0w8+9QEB83ITvFVpyqkoGIyjBqjqpXG
p7bBOcuEs8Vpx7vG5pcN+SSBNh5TJBqZEy0XKC3zYuV6FCtptjj/o/EpFsyGnrcp
NuobIKvkGA4rZj876aPOzFsa0O+mjzsbqYd8Kgf2Wllv9S3Gfe4IckkULaL3RlB4
ffACMISTItqYbFUyXrstAsAyYEXlifGuO5IkI1PKFJ92MsahEDntImwtM0A+Fqgp
vb30ZEbWAkDs2SB5p+6QxDjwYipn3tS+yj5AzH3L4H4iuPAUHaoukLKOIMLgk/Cq
/4i4/rfwftEQ7G1bcNzny/LQLI74NYUK5P+uxfx+A2qHPINRQCcUDw+X7tCTrLVN
LKCmv+5ECo2I31TQ43eI
=x+NR
-----END PGP SIGNATURE-----

--k+w/mQv8wyuph6w0--
