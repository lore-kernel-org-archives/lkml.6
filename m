Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A3B2C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 13:11:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEBA3214DA
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 13:11:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="HhF99YQY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726616AbfANNLx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 08:11:53 -0500
Received: from ozlabs.org ([203.11.71.1]:53553 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726491AbfANNLw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 08:11:52 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 43dYlV0zY1z9s4s;
        Tue, 15 Jan 2019 00:11:49 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1547471510;
        bh=OGMJdCR0rXjudXNxR24ycygsNDVXbH52SQ2jR65nZco=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=HhF99YQY3zXbJVSViFrd3Ab/TWjbEKRSc3GzEbhdS3gx+KpElBbO34Yf66L1aTpyv
         Ztx0I5SSir5ioCR5eaWTz0+iy7h1En2sYOAYXIru8J14BVRr9Hm70nXL3e8jGQqIwF
         nFb8iRC0mRIOEKvCxTdAy/KLOskzcoCzIhitJYYQ4uTngwL6kIlDrt1vhOZqzKSUab
         8CcD4lGq7SjYUUbP7ciDDv0xJaFZsBncqdv69d3K5Y4bO8NcBo0e9fI7iBjDnr7kTS
         3aW2G0u1/ov5dxfTQWmjaFuGgZSwnMPCS6OtSjV3y7idyIta/k3Pk9S4YUM9ibOAzV
         8EhAb2TvKwplg==
Date:   Tue, 15 Jan 2019 00:11:48 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Liviu Dudau <Liviu.Dudau@arm.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: Signed-off-by missing for commit in the mali-dp
 tree
Message-ID: <20190115001148.5963480c@canb.auug.org.au>
In-Reply-To: <20190114112916.GN20661@e110455-lin.cambridge.arm.com>
References: <20190114110909.39a7285c@canb.auug.org.au>
        <20190114112916.GN20661@e110455-lin.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/2T=LRkJVBHoNYEZpKCYQ5Ip"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/2T=LRkJVBHoNYEZpKCYQ5Ip
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Liviu,

On Mon, 14 Jan 2019 11:29:16 +0000 Liviu Dudau <Liviu.Dudau@arm.com> wrote:
>
> Sorry about that! I have now fixed those commits and also the build
> failure you were seeing.

Excellent, thanks.
--=20
Cheers,
Stephen Rothwell

--Sig_/2T=LRkJVBHoNYEZpKCYQ5Ip
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlw8ipQACgkQAVBC80lX
0Gw3cgf9FMDl1nT0c/jZoRZAvPhSONoqPRIu8yV6r6+WsFxlD6eG3h+iV2xJhzef
VY5Mom6HLioY/96UCYeeO0uPVHPK1ERHlL8zC8eufRP2QTvDgPNdveaNnbCVIDZZ
MpC74OtUYI77a4xz02noB73L7ehznqLlzurNefiIOptG1Up7M4SENcehGTFLPV/F
Hv5uNLyrJlsNmKMJZ+E97TaL3460TE6l+lWfXjNO8pxt7pb1GV17+wkt1/UJK7SV
M5wxM5/fASH1ZTaS8ukjXCuH8VH+vT/tzG8nJiSTED4RrjDgppqE+BolyS2FUY96
wbdu6lnGbgB9XXlAdxBxMrHFzuy7HA==
=M07R
-----END PGP SIGNATURE-----

--Sig_/2T=LRkJVBHoNYEZpKCYQ5Ip--
