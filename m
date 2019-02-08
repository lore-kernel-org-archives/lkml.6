Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95FEFC169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 09:26:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66D6A218D9
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 09:26:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="GSPNrxeF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727486AbfBHJ0J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 04:26:09 -0500
Received: from ozlabs.org ([203.11.71.1]:39173 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725998AbfBHJ0I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 04:26:08 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 43wqYK3fcdz9sN6;
        Fri,  8 Feb 2019 20:25:57 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1549617966;
        bh=7H9KOdAY7jHO8xB2wZeMN9Y+EcGsTb76X+0qt+OKUY0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=GSPNrxeFrhxpeouCGBH0+NghwFmkTTD+jSWeRR8Kn3h6iJ21YIDLsinH44hB8UKs+
         On2K8bMWgAZndrKui1aLTUxTY/pT2uByGgVvJZ+rVXsRWCGgrQvOHhow2OMSF+MYY3
         i9s7w/36kRKvpECtA9tLKjDwPxHrIrQ3U1Wt4c2O0s6nnbrTl87Tm9LIM4MlclaX+v
         D30YNA4T4eJ6iyzxNZUjpKlw3sMgmahQiDFYeKIrOIyJCifcViqLhiMmULcXqR6959
         zjxQJq4VR62/WWDKYhFcnafW8ij0Ag4JHfajg+FyaHBYbxTplXUYO3n9VqdYSPY+1g
         uLKaO890ByPng==
Date:   Fri, 8 Feb 2019 20:25:55 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Daniel Vetter <daniel@ffwll.ch>
Cc:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        Intel Graphics <intel-gfx@lists.freedesktop.org>,
        DRI <dri-devel@lists.freedesktop.org>,
        Dave Airlie <airlied@linux.ie>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Chris Wilson <chris@chris-wilson.co.uk>
Subject: Re: linux-next: manual merge of the drm-misc tree with the drm tree
Message-ID: <20190208202555.3aa6473c@canb.auug.org.au>
In-Reply-To: <20190208085333.GH23159@phenom.ffwll.local>
References: <20190208122744.4a63bec0@canb.auug.org.au>
        <20190208085333.GH23159@phenom.ffwll.local>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/IkI/MDgmKiqO9iooJ7Ip3a1"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/IkI/MDgmKiqO9iooJ7Ip3a1
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Daniel,

On Fri, 8 Feb 2019 09:53:33 +0100 Daniel Vetter <daniel@ffwll.ch> wrote:
>
> There isn't a "below" afaics ....

Oops :-(  However the merge diff is not very enlightening in this case
anyway.  It makes more sense to look at the final result when I finish
up in a while.

--=20
Cheers,
Stephen Rothwell

--Sig_/IkI/MDgmKiqO9iooJ7Ip3a1
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlxdSyMACgkQAVBC80lX
0GwU6AgAhGy5s9AdDKIb1AtaiQRHBDFOlJfBuGxosUXpSyHX9oXwwj3tDFdcb0JM
pTbfJhUnSYl2wds/hWpBS9pldGul39f9WvayXTLrvKhl0EgOHmZZBraiPwhVOPkf
r+SQBmQhReiI59ilX2Ss5EuwQBDmHK3TDjx2xB8LIrtnosDJbuyBjn5EmCMm9CLN
q6meExKyfX6G+tQ+Xupy+IxDIitV9aoF6Otj/YxUGKGd5rQzC6mOrWZ5RRCgc/XT
VDCanhuwF88GEXly4emLfuDk0zWHeRmImUMCxUeGop2GSdiApOIVQ5UDyTwDK0r8
bhmPQA9T0BU2pWE9c5myhQMSWm0CXQ==
=+TSK
-----END PGP SIGNATURE-----

--Sig_/IkI/MDgmKiqO9iooJ7Ip3a1--
