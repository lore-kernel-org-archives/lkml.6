Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBCEBC433F5
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 01:22:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16CB22077C
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 01:22:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="JqHJhxv2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16CB22077C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726093AbeIDFpH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 01:45:07 -0400
Received: from ozlabs.org ([203.11.71.1]:50081 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725845AbeIDFpH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 01:45:07 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 4248Fl2D3rz9ryn;
        Tue,  4 Sep 2018 11:22:19 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1536024142;
        bh=1GZzXqc8F1hbFnC7gY5LUV8rfXzwhThPlA2AEhNiTTI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=JqHJhxv2qKEMda8bcV4X3odRXUvAZJeBeviGhqcd/HBqNeFgoCVY5ACXOOnoX+U2i
         pCbPEJtRBxVTTyab88p+w4UjAhmj+QSqMhOMgpNqzL20rnlVEO9K6LlfK9khiJhKRb
         4TQt6YBvLRpdeAq9yT612G2h4Ud79bnXaGxrHZme+u6/ajF3ZJbGoSjRXimQUdyBq2
         Y4GCBHjKC8K8cB+8NXmvB/Dc9S5VGC3p3pr2b7Lq+74m9NgRo2cDwFcjT/KQSJfOhV
         uBTZoU9AtKJtddTyAFG+dohBBX5FTtdPFdHOxV0fFEqvuKqwGQOJ8uraFA1f82g0vT
         OwxZwy0q7S9dg==
Date:   Tue, 4 Sep 2018 11:22:18 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Steve French <smfrench@gmail.com>
Cc:     Steve French <sfrench@samba.org>,
        CIFS <linux-cifs@vger.kernel.org>,
        samba-technical <samba-technical@lists.samba.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] fs/cifs: suppress a string overflow warning
Message-ID: <20180904112218.3f7e3337@canb.auug.org.au>
In-Reply-To: <CAH2r5mu99E39iwx=70w6F5MxvNh1MrzbVwTRb2e8dmz9WU52sw@mail.gmail.com>
References: <20180903131558.21cdeb35@canb.auug.org.au>
        <CAH2r5mu99E39iwx=70w6F5MxvNh1MrzbVwTRb2e8dmz9WU52sw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/kbqeILRHxWRI.P51Ik0MYhj"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/kbqeILRHxWRI.P51Ik0MYhj
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Steve,

On Mon, 3 Sep 2018 09:44:17 -0500 Steve French <smfrench@gmail.com> wrote:
>
> Merged into cifs-2.6.git for-next
>=20
> Is the message annoying enough on powerpc to merit going into
> 4.19-rc3, presumably should wait for 4.20?

Up to you, but 4.20 is probably fine.

--=20
Cheers,
Stephen Rothwell

--Sig_/kbqeILRHxWRI.P51Ik0MYhj
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAluN3koACgkQAVBC80lX
0GzrmQf/Ve8hQUTM1f4nkGK+HsgLYxG/iO95r5ffvMH3cpIXD4bCJBAyd/+w6dn+
mH+uRsqTkAOwOFHIzByacUbgQJn9wHzNWfF/v+PyRplJC8AbfBj8607ktJulS+pU
c5c9yWLvE9T4fETrrpRGas8YNDIzY7RyOKrA0d4T0XUyUsDTSW72kWrX+njUh+n2
HIszle/iIsSyz6YL9EO2/V/ZbfOglZYQ8PGegyRQo5l2vVivDhMglIh1xGoAJM7r
dvdbFGv/3grCCV0MsYMgvkE6D963rVrqH7mmpJTzjAB6oHdlSle3MTK26Xd5GS7O
Rq9AlaRBOOvOJQRv3tQN6YrAwDRwPA==
=3x/f
-----END PGP SIGNATURE-----

--Sig_/kbqeILRHxWRI.P51Ik0MYhj--
