Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B34DAC5CFFE
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 20:30:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7ADC62084C
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 20:30:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7ADC62084C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729468AbeLJUao (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 15:30:44 -0500
Received: from vmicros1.altlinux.org ([194.107.17.57]:36234 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728182AbeLJUaj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 15:30:39 -0500
Received: from mua.local.altlinux.org (mua.local.altlinux.org [192.168.1.14])
        by vmicros1.altlinux.org (Postfix) with ESMTP id 43DBF72CC66;
        Mon, 10 Dec 2018 23:30:36 +0300 (MSK)
Received: by mua.local.altlinux.org (Postfix, from userid 508)
        id 342C37CF426; Mon, 10 Dec 2018 23:30:36 +0300 (MSK)
Date:   Mon, 10 Dec 2018 23:30:36 +0300
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
Message-ID: <20181210203036.GA18150@altlinux.org>
References: <20181210042352.GA6092@altlinux.org>
 <20181210043041.GS6131@altlinux.org>
 <CAMo8Bf+s6xObgYoOOR0NTQZR-ReBbXmNv_5Jf=jX7J+bnDsTYQ@mail.gmail.com>
 <20181210125315.GB11942@altlinux.org>
 <CAMo8BfLbk8wfUNVZ_Qa9XVTtg4f5k5Wj6LFauroheheoTCJPxw@mail.gmail.com>
 <20181210202402.GA18101@altlinux.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="vtzGhvizbBRQ85DL"
Content-Disposition: inline
In-Reply-To: <20181210202402.GA18101@altlinux.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--vtzGhvizbBRQ85DL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 10, 2018 at 11:24:02PM +0300, Dmitry V. Levin wrote:
> On Mon, Dec 10, 2018 at 12:14:37PM -0800, Max Filippov wrote:
> > On Mon, Dec 10, 2018 at 4:53 AM Dmitry V. Levin <ldv@altlinux.org> wrot=
e:
> > > On Sun, Dec 09, 2018 at 09:02:50PM -0800, Max Filippov wrote:
> > > > How should we synchronize our changes?
> > >
> > > No problem, I can revert to the previous edition of this patch
> > > that just adds syscall_get_arch.
> > > Alternatively, you can just take that couple of patches (v5 18/25
> > > and v2 15/15) into your tree.
> >=20
> > Sure I can do the second. Will it work for v2 16/15 that changes
> > syscall_get_arch adding an argument to it?
>=20
> No, I'm afraid it won't work for v2 16/15 (aka v5 22/25), which means
> I'd have to keep them in the series.

You can surely take them into your tree, but I'll have to keep them
in the series because of that change of syscall_get_arch signature.
Sorry for confusion.


--=20
ldv

--vtzGhvizbBRQ85DL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJcDszrAAoJEAVFT+BVnCUIPHsP/jmCV9w7FP7HaFO8ewlxKsCl
890myt44lNJeQQi4B5OY/Jo2YReg/+mQGtbZCIY/asQDgp0+Ae/mGij9vml59L/w
kfIZ77bAb+RrcV5hsDmmdIBUJy4cN7+ltGrWpcsasR1NjeLKg6QQpB3cpBUGtaFl
DukIjdjITh/8ysESS04sx/fW8SxwodWnkJSDYsfHyZzxNFDTs7ABEa/bGxtEIRy4
4j2eXn3GktezHx8GJms3P3shcaXGUqPCfEmR4+lsV1sAJSitLVH7QCPxjryLwDcr
o9kUrckcJ+ONbl22LZrhIAgiKvWNOR9lMFL3JgmzPsLT1sfi6LdxXtifgXlNTwnt
vw9uB4SXxCSSVhiRdX1ON3mM3/NjZ9/Ira3J4VFSiUvPhLwFpboEq4T7DVsIVKNb
8FYDnb7wMa0gw0W8S6B1jUmklMGjSnTcS1ovSHO0VINbWLHIQ4H5zjOtQd9v3D+W
SB6bA5Xb06/ReXINUDvE7Y9gXJ7bCuTXIdKi4Y61Gjtine+j9ZOQA9+hzYFcP8sV
q/8qzPUjNZTdcyuLmRKpzNjtnX24a0HfQ7X2NjvnJQ7lbboRwazmN2FC3Sxixcfi
r/fT9kkEO8Zf3uucw0GNfPhhMzD9Y1cij9KEwM6EMMWl2sbBMiIvM8T5H8s7GQaD
3cFRHHz+VOPFrbkshZDp
=8KiF
-----END PGP SIGNATURE-----

--vtzGhvizbBRQ85DL--
