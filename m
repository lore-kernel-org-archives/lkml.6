Return-Path: <SRS0=xGmI=KM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21CF8C6778F
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Jul 2018 04:22:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8B7220873
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Jul 2018 04:22:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="XTu3WnCc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8B7220873
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726327AbeG1FrF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Jul 2018 01:47:05 -0400
Received: from ozlabs.org ([203.11.71.1]:50761 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726004AbeG1FrE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Jul 2018 01:47:04 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 41ct2h5f3Nz9ryt;
        Sat, 28 Jul 2018 14:22:04 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1532751725;
        bh=4biLvVzXZVQ+zaCJEbSRHAtXuYViTFExAVrLRj/2r98=;
        h=Date:From:To:Cc:Subject:From;
        b=XTu3WnCc3Xw183fJPONzMWY7py6k0eax4v5eWn9XY3U3UKhmlu6Fh+Rt1GgEA0Kfe
         qLJGr+XSv/Rsca9nmDBHmQGWXanoYGvCgvy0dHYBeKeWcyWRES/L+Q7VcBbbb2dia+
         Fz41Qvj61Guu5jImZ8wo7RnmRdzYBYoBjTio3rBV+cAqKAfxfTF5RyqGB8PHDSce6Z
         QEpyBa8WSTbGYJejEtZoGjLm9tqIxl4GnXnvT//x8M5551thuxH8MqOTLkqyNw0HAE
         juUSZSBph2fSCOt2Ul+5vSLtbZw2kJeM5/0QTb3nnS17elmHTaxD0C/KvCEWupKceZ
         3qjU75tNLIrWA==
Date:   Sat, 28 Jul 2018 14:21:58 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     David Miller <davem@davemloft.net>,
        Networking <netdev@vger.kernel.org>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Dave Taht <dave.taht@gmail.com>
Subject: linux-next: Signed-off-by missing for commit in the net-next tree
Message-ID: <20180728142158.43c4ff0a@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/jjxPZDkflDqeMO+HWVUJ39t"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/jjxPZDkflDqeMO+HWVUJ39t
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,
Commit

  2db6dc2662ba ("sch_cake: Make gso-splitting configurable from userspace")

is missing a Signed-off-by from its author.

--=20
Cheers,
Stephen Rothwell

--Sig_/jjxPZDkflDqeMO+HWVUJ39t
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAltb72YACgkQAVBC80lX
0Gy+bQf+Iz9UtZMOK/YQTUsrQZKvEuKGzXYg5PQ9venxJbUp7L5yooA/aF+Q54tJ
+c0QE2SVVwzqFCmu6zHwVkm1MoS+qDtX1bhomLtSje5fdwoT3qyypQGdJJFi/J4k
emt4F7GS1nWa9Btif6NVcSpvKNM78BkkPUm1TL1k+8JxBEkX3nNF4dnqJDl3AaGK
gH6ojrcFJrJEcFTQkZioaKWhUK1k6e+O+8VJuEhUuNAEzXToKudjbuD1XhNQanz3
fJO4JrXKDCGGXFqGR9OhiOAvQO9sWl2LoUEuTwZmbWkQ3hOV5dJKJJb8y85pFMYC
igJrO/E1xgSXy2iYXj7ouDAOIolrbA==
=5UN6
-----END PGP SIGNATURE-----

--Sig_/jjxPZDkflDqeMO+HWVUJ39t--
