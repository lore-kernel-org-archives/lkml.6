Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B159CC0044C
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 12:08:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 597022054F
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 12:08:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="flIS9ssF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 597022054F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729203AbeJ2U5I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 16:57:08 -0400
Received: from ozlabs.org ([203.11.71.1]:51987 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728946AbeJ2U5I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 16:57:08 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 42kD095tCyz9s7T;
        Mon, 29 Oct 2018 23:08:41 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1540814922;
        bh=sGmYu/cA7PysI8BZotcGafa1vfPUNRnfLKMSGuc2tbA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=flIS9ssFZgeq2o4sQV0y2DmMJuIYPMBJGqv3vYWCJRrZvIWNXcagCAJ+GViMB6iC9
         6QRIg97314NXZrh+y4suy2HRBIcsXwm5BiZPUBWzpVD4ExsfXKKvtgZdn0qHYOEDyJ
         PPaBIJ3dZFuMVFd1kP3QOeGZyMsAklbH5UbrXLdofhYboTbYf/pOE1uYBbdGRP0kes
         FrLf8GfPVsCJDdpNc87SC30mdkFSaUZ622LDBJyfg5Qx8tmQeE8bp/G3pddN6IP5TZ
         KVFlPSMpjRMqlcdWqA4mIMYQ0sw2W4Tw6qiHCxUapZAfVJNoQEMqIRvLus/FYWolur
         RhIsbRdayT7BQ==
Date:   Mon, 29 Oct 2018 23:08:41 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     damian <linux_dti@icloud.com>
Cc:     linux-kernel@vger.kernel.org, webmaster@kernel.org
Subject: Re: linux-next: Tree for Oct 29
Message-ID: <20181029230841.1d9625ce@canb.auug.org.au>
In-Reply-To: <20181029114225.GA2395@zrhn9910b>
References: <20181029170212.4a34959f@canb.auug.org.au>
        <20181029063319.GC8104@Ubuntu-DTI>
        <20181029204142.7dbce8d8@canb.auug.org.au>
        <20181029114225.GA2395@zrhn9910b>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/M2i.LTG/fTm7vph/nmvFCam"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/M2i.LTG/fTm7vph/nmvFCam
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Damian,

On Mon, 29 Oct 2018 12:42:26 +0100 damian <linux_dti@icloud.com> wrote:
>
> On Mon, 29. Oct 20:41, Stephen Rothwell wrote:
> >=20
> > On Mon, 29 Oct 2018 07:33:19 +0100 Damian Tometzki <linux_dti@icloud.co=
m> wrote: =20
> > >
> > > on the site isnt available the new linux-next ?
> > > Only the old one.=20
> > >=20
> > > https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git =
=20
> >=20
> > It seems to be there now (at least for me).  Maybe just mirroring delay=
s?
>=20
> i tried it from diffrent localtion and different systems the same sitatio=
n. My last tag what i
> see is: linux-next-next-20181019.tar.gz =20

so, I see:

$ dig -tcname +short git.kernel.org
syd.git.kernel.org.
$ git ls-remote git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-ne=
xt.git | grep 20181029
0e2adec0725178efbb0b7019ee0198d93ba54843	refs/tags/next-20181029
b179f0826c6a13563c5ce0554c6da6748a1fa699	refs/tags/next-20181029^{}
$ git ls-remote https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-=
next.git | grep 20181029
0e2adec0725178efbb0b7019ee0198d93ba54843	refs/tags/next-20181029
b179f0826c6a13563c5ce0554c6da6748a1fa699	refs/tags/next-20181029^{}

cc'ing the kernel.org admins ...
--=20
Cheers,
Stephen Rothwell

--Sig_/M2i.LTG/fTm7vph/nmvFCam
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlvW+EkACgkQAVBC80lX
0GyN6Qf/VCA9HbqaZqrAYXDt9RCFYgA/+4Iro+vCvHE9g53Je743UGVQwkI6O49Z
T+VAane1wb7MpAoipwnjPkFqVDTAGKMgkSMMTwo2jj775cmYxlzd9tK36OSOOVi8
VVUqNH1H6khRD2NJJH4PSGaehaCcg9wbGbKZTKMDbE6sUvVtgXGCQzjq5S66w9M/
vGiW6K1udCvRkvyzov9cf//mguEe/6KdzGwV/1NFrt5ORIFFYGCcKnteCoIFLlsk
G+TTZBAAQt1EHPha1eUNxlJQqtYHHfCBP5v2fQlfrj2iVwMuo/79WYFkpz8hhWLB
IVJqNTKe1pR8gwZhqf9f5xXCGGe/Uw==
=CWmP
-----END PGP SIGNATURE-----

--Sig_/M2i.LTG/fTm7vph/nmvFCam--
