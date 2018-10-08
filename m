Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFC96C65C20
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 20:54:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74EEC2085B
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 20:54:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="XauEjqN2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74EEC2085B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726722AbeJIEID (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 00:08:03 -0400
Received: from ozlabs.org ([203.11.71.1]:44061 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725749AbeJIEIC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 00:08:02 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 42TXfR2Pspz9s4Z;
        Tue,  9 Oct 2018 07:54:23 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1539032063;
        bh=3aUj9oXkTjlHXVe4wABheK8AgnfFzJAUfxq441OBOuo=;
        h=Date:From:To:Cc:Subject:From;
        b=XauEjqN2ZMgU/WJkH+e5+HOGRcJYEPV/junppNww76ZKm49EgDR9MLYjaYP0UY1xk
         Hv757CMYcDTfnn8+FiUIG1sE8339uvNgGWmr3k370bLy3xc1wrW83GkJHt2Dg5OoHw
         neUEhHOuA9qpaj7AJexjgfG+nQhzX/F8oHrZzA+Ysuhc19Zahzx+IP56t9G3QJUgjP
         i9HpjgZ8sMVq5IUvXscqcWSN8tTXECC1rGEJIwHWEvuTySt5aE/xCitQxhBovRHVPC
         AAldEyKfTLPQu2I+dx/MpbIGDRYKrLsigWa4SwaiKA5A7T/tR6KEP7jqabocLz2r3y
         x22lKujPx3rWQ==
Date:   Tue, 9 Oct 2018 07:54:17 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Steven Whitehouse <swhiteho@redhat.com>,
        Bob Peterson <rpeterso@redhat.com>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commit in the gfs2 tree
Message-ID: <20181009075417.5bdfa00a@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/u5TFqKa4.yTS2H6ptK9qICs"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/u5TFqKa4.yTS2H6ptK9qICs
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commit

  b7f5a2cd27b7 ("GFS2: Flush the GFS2 delete workqueue before stopping the =
kernel threads")

is missing a Signed-off-by from its committer.

--=20
Cheers,
Stephen Rothwell

--Sig_/u5TFqKa4.yTS2H6ptK9qICs
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlu7w/kACgkQAVBC80lX
0GylUQf+MB1IxXhH15CfriKBO3rzN0ZywjOgr8Vl0qD4e0xVQ+ItP9Dg5fISvl/s
jaFbw9xywLOsu+PsoxQX8LEI4KZHkNnCxDZk/Hu2YXjoCHrG+Mrmc9OAzv2+g6Ju
gVTjyyZFz8fBvrJfuCDEEZOVDBlYc7zCfgnQa7iFem1UAfy6T+spqeGJtsH8RqhW
u8mdkrawuhCjdVjXb7tnk5A5nPL6tdaduvDa/wtsScUjXx+43EU8fqj5CdBOfwbS
s7Qo/yND6ImSOag5ExNT8poAg/2wJFUM195ml512YV3KZ64GWFSKFMBoA5czLQpL
/fVgUNrwbCLfXSqGKXLU5GOL29pvEg==
=o/QI
-----END PGP SIGNATURE-----

--Sig_/u5TFqKa4.yTS2H6ptK9qICs--
