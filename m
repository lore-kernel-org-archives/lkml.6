Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D12EC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 00:09:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 177FD20854
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 00:09:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="c4NIhNdY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726651AbfANAJM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 13 Jan 2019 19:09:12 -0500
Received: from ozlabs.org ([203.11.71.1]:48833 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726614AbfANAJM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Jan 2019 19:09:12 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 43dDNP6B47z9s7T;
        Mon, 14 Jan 2019 11:09:09 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1547424549;
        bh=wGcG3XM8McY1UEAEFdP9rli9cRIP98C9ZUV4OdPbhX0=;
        h=Date:From:To:Cc:Subject:From;
        b=c4NIhNdYoxlyvDn69wUKrOR3tOnddtB/pW8vahYNABdiqXpjYgGP/fgTj7hlqgLuc
         rAKrThIgelt/IMYubafs01FSXDrGfE4iHVtmg1ACaVeV4ue6nZGRhiwHoK3y9c6RZ4
         /pCRz7CGLkRdcRgvdimeJAeoJDsa0ajZrMqEgb+xY0l4nnsBEHo6atw7e9me+fZAMB
         yBaE3z459Ui367kgMcwLT6o8BUrYmNIiJm3WRIydbzFWxHeUj+mIzGDkaYwhO1OuN+
         U5ranNQS8qJ9U7qQKzXF8p86lUAWsE0w9wYnoR3uvqImoMyM9T9845jhlhhkPruzk9
         sSyNsnPFqsQAg==
Date:   Mon, 14 Jan 2019 11:09:09 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Liviu Dudau <Liviu.Dudau@arm.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commit in the mali-dp tree
Message-ID: <20190114110909.39a7285c@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/8P9dyVUn11f1UixO=d9m17d"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/8P9dyVUn11f1UixO=d9m17d
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Liviu,

Commits

  31849148cb41 ("drm/komeda: Add komeda_framebuffer")
  b347a024e10b ("drm/komeda: Add komeda_format_caps for format handling")
  274d16527e45 ("drm/komeda: Add DT parsing")
  f20978344694 ("drm/komeda: Build komeda to be a platform module")
  f8eff4b21a16 ("drm/arm: Delete redundant CONFIG_DRM_ARM")

are missing a Signed-off-by from their committer.

--=20
Cheers,
Stephen Rothwell

--Sig_/8P9dyVUn11f1UixO=d9m17d
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlw70yUACgkQAVBC80lX
0GwKkgf/XkfHhBTs6F3eGMF3xF4DjCITJB1A/UDH6o2r8hjM4+AZrinqkFlI3Z+k
M9CwfiDPjt7PkMlvGinglbR1TfvVijlyx4VCJqk7t0hoKvwlFF/L0o386H4VSIeB
TB/xTwZQISENygp9PQW0xkuRvcdq7Cgzy2U593WueChjgXQWEAkt9cCoOcXuZJ5F
cvu7LwZceSbwemmopRz4dh3LQ6mBOQ0I2xEd68kk3kEK6PjHk9JDZT4y3Ktvw7oV
bBf5/dePzvstH8M/VTHwZI2sT1hFACPJQcnKo8HhRdqJkgusLM93KrWSoVqMRmPI
hh9vjjD8FDYohuyuS+ooE0YxGQ4AIg==
=JcTV
-----END PGP SIGNATURE-----

--Sig_/8P9dyVUn11f1UixO=d9m17d--
