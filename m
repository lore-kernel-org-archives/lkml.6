Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFA54C282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 12:21:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9954E20861
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 12:21:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="dTRFFKhz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727309AbfAWMV2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 07:21:28 -0500
Received: from ozlabs.org ([203.11.71.1]:46659 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726029AbfAWMV2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 07:21:28 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 43l4C92fNkz9s3q;
        Wed, 23 Jan 2019 23:21:25 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1548246085;
        bh=ewT4294HGvgs2gu/z74ARslO8OAf9uBl/RdTEPSGUPk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=dTRFFKhza8LmY/VjF/47lnqonhvogw0K3dpz5uuHRzRhzqX287PJW20AfXF7sBcrJ
         KWP8D4LBkLbPpq4EV7VGvR7DZDF/t8AbWGmi+PN/Is4oQXWuxtfthLUxhwBmRDoUvc
         vQAwTw3Rs1F6CIZ3ueIn2CSaERHVqnO214WnLT2JbA4mpnXdH3JenWkIxozsa7CumS
         vJImZI4iQiraYbr3E9HfpDCSBg60BZVvqP2bFrQHihMC34ZYisd2hNgxg9ybJMg4OY
         5iWCNjhGRVvxoOZnSPL6UDYZMkbfK6x0XHHFvin+699KNlu40NYL3/mXbu9mp53tEa
         p0MiNUOLNWKgw==
Date:   Wed, 23 Jan 2019 23:21:24 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Cc:     Simon Horman <horms@verge.net.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: Fixes tag needs some work in the renesas tree
Message-ID: <20190123232124.1e5177a7@canb.auug.org.au>
In-Reply-To: <TY1PR01MB1770C404E14E88CB912D12D4C0990@TY1PR01MB1770.jpnprd01.prod.outlook.com>
References: <20190123075605.116ddbd0@canb.auug.org.au>
        <TY1PR01MB1770C404E14E88CB912D12D4C0990@TY1PR01MB1770.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/x2Q2h5UQ4TzeKwfxP._3_cK"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/x2Q2h5UQ4TzeKwfxP._3_cK
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Fabrizio,

On Wed, 23 Jan 2019 08:55:21 +0000 Fabrizio Castro <fabrizio.castro@bp.rene=
sas.com> wrote:
>
> I am sorry for the trouble. My editor is configured to automatically
> wrap lines when they are too long, I'll be more careful next time. Do
> you need me to do anything about this patch?

That is up to Simon.

--=20
Cheers,
Stephen Rothwell

--Sig_/x2Q2h5UQ4TzeKwfxP._3_cK
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlxIXEUACgkQAVBC80lX
0GykDQf+NkNN9eE9dcQZafxW/6c9jhVJktIMGAkcvXF94Z14BGnd2tIYn3vb1zCT
4WhdMqtD+Fj5Jp3/tFEECOIqAGzdLJdH8gro4/5l8S9SfxdON5xP0jwJCIxZEnR1
7BewrLmKFpi4s6OCOU+Zdv4Pi63xrpXVXCO+kg8irNfd1GoqZVbM4GqvYGOffkNU
k/hXhAYoG5ANv5AXAlH9kOlAwT/QadllxdSHLpK2HKdup69lYm1oW/znkFXOltfa
dhiOi+7qBeQ63Q6wxp6M+LHsuvZagQHHVkGn739q/9IoicM2LycVyWQUAudBGbPr
hmIiF0y83SQWQkY7uI8h7Hetsrebgw==
=XQkC
-----END PGP SIGNATURE-----

--Sig_/x2Q2h5UQ4TzeKwfxP._3_cK--
