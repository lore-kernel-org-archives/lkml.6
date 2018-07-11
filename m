Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FFD8C5CFEB
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 21:38:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1ADE32146E
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 21:38:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="rlOF4E7w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1ADE32146E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390473AbeGKVod (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 17:44:33 -0400
Received: from ozlabs.org ([203.11.71.1]:40105 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732706AbeGKVod (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 17:44:33 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 41Qsr351tzz9s01;
        Thu, 12 Jul 2018 07:38:09 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1531345092;
        bh=K8xi2EQrH7eMy3cA8SOgV3HAhqoNj4bBIv5OxmQBsAc=;
        h=Date:From:To:Cc:Subject:From;
        b=rlOF4E7wiIUy6PM9itYap9TXrZfcRCmIBpwa4cGDrydLy4+oYujrF+tXeXqYwJUEq
         6t+v9y4NH4oKMN8Ar/dVPl5BCq9m9ejjqDnzY3prf1iQKlBikaxtY5iwGQSDRjI05L
         u44mVao3zNGkGYnr0bpp7bkXYQ7FXfLTVF7vyQyGl9xzqcVYSd6v1bppP6EupZcMM4
         xYgn+594rODdtuYSc1xEYSfHbdCL4nPl1hLCOwn9lMcdotXRVzl5WFCriPVe8dWHpV
         KSJBr1HCtCaNEF9VTLVpMOUJi2lWFHeBm7JBqlf7NSopsRmtXmwmzwvNo+fcwRfaaL
         0Jl8y0Z6HYe4Q==
Date:   Thu, 12 Jul 2018 07:38:03 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Russell King <rmk@armlinux.org.uk>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Stefan Agner <stefan@agner.ch>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>
Subject: linux-next: Signed-off-by missing for commit in the arm-current
 tree
Message-ID: <20180712073803.7bfbbf1a@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/S18ASbJq5AhJJQY+gXEoyhf"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/S18ASbJq5AhJJQY+gXEoyhf
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Russell,

Commit

  6ef09e48c2bc ("ARM: 8780/1: ftrace: Only set kernel memory back to read-o=
nly after boot")

is missing a Signed-off-by from its author.

--=20
Cheers,
Stephen Rothwell

--Sig_/S18ASbJq5AhJJQY+gXEoyhf
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAltGeLsACgkQAVBC80lX
0Gwb0gf8C53qWdofWVadKuo/2cgMEfk/tnIB0yNrBRJiRBSSmQ5F2j19ShOE4jxo
XwOnAzaRA/mD8eBS1p1HluuFalBogBW6KpdjwOcSxVNIBcugOefIfO94aLIC/R/t
JfiKhZjqjJEu7DHINqN7gg+FSm0IwvGVP0Qsl/lA3E3JRWfewxARXYeKbG9sM4xB
n9TujU4KHoF8gQshHEn8Xy/DhxOoQr6nS/roS35uNNvqO3E13FBKFwW1hkJVJ4Dh
hFARUvHx372+A/RDIZdj3gWMyOLWbJ6VLnVvXotB6h4JgOmSaHmvwzUW6iSv8pvD
gDxFudq4E1MTjsHvWm18CJiH9CXmHg==
=+dcl
-----END PGP SIGNATURE-----

--Sig_/S18ASbJq5AhJJQY+gXEoyhf--
