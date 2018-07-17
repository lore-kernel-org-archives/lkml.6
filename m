Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 273A6ECDFB8
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 22:21:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C972D2075E
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 22:21:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="XK4Bkupa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C972D2075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731190AbeGQW4M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 18:56:12 -0400
Received: from ozlabs.org ([203.11.71.1]:49339 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729741AbeGQW4M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 18:56:12 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 41VZW91VkLz9s3R;
        Wed, 18 Jul 2018 08:21:25 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1531866085;
        bh=z1EfrmeLabqbiR5F5CswNHWJKU/tuuIWX3N9hoXTYnw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=XK4BkuparGaHNCVrq/GEkTRJvM/p+OuSWB5Ar+WRuIwnymHNM5dbbSq/YzdW2MMkG
         7UIF+OcXMIaDXW70mTbLcdoajrQIgFUN3yttHBdpBKq4hnLytgYklhSS7cQjFUdlbt
         hyPlOplWhW57ZWB/R4qZjy+hnCmt4MUDcbQyhsNIZSr16YWWPEExx6ndMRApnGs42L
         odXTRERFhLGmmCEXKrNllGrREKzbSiIWWGkHkAnNg7iOGatOpykuMwrPJZUj9puojb
         Y+4N8+MEzprhv6WCEqhkKivaWqsGdyV4lY+WkS6/FTCpT5JR9zMfit/YnWRSAtHNzf
         r9C2Cr52lUxbg==
Date:   Wed, 18 Jul 2018 08:21:24 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        James Morris <jmorris@namei.org>
Subject: Re: linux-next: build failure after merge of the integrity tree
Message-ID: <20180718082124.136546d2@canb.auug.org.au>
In-Reply-To: <1531833486.3380.18.camel@linux.ibm.com>
References: <20180717144038.50394022@canb.auug.org.au>
        <1531833486.3380.18.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/3PVrC1+GHFGZdzHh+gUfgBi"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/3PVrC1+GHFGZdzHh+gUfgBi
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Mimi,

On Tue, 17 Jul 2018 09:18:06 -0400 Mimi Zohar <zohar@linux.ibm.com> wrote:
>
> Done

Thanks

--=20
Cheers,
Stephen Rothwell

--Sig_/3PVrC1+GHFGZdzHh+gUfgBi
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAltOa+QACgkQAVBC80lX
0Gy/twf/bjdXPCJDeLIgRLTi9knQ/kmpFxikl5hYBayGzOViqKJ7twqLm9coK0Cv
GGQPDCcG/jx2Hj9UNlJL33KHDUoX5vxado7xbtRdxf0jZ080GcaxNnwCx+j5DVn8
aCbVXuPtrr/dMUxVpfxJy8iHpPRE2qs5/MrttMy7/i8Q4uTFL00Ji1WOdGHY3RdF
i2vyCDZidQC9Klo03UkzXy5Q8KrmVvHb0I1EWPtsAjVkbxzTudLyI3U5UK9qrIoU
LY7dOQtMYJt9yyVD7BEH1It6vbKokPq2JE8rIa1mhxiU3azMHF85N2dVZ8WgvGSj
c2W0WCEdiTrHpAxohwivx47lGjgL4w==
=KH3s
-----END PGP SIGNATURE-----

--Sig_/3PVrC1+GHFGZdzHh+gUfgBi--
