Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0C33C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 22:35:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A4BF20851
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 22:35:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="hIaJ2mem"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726185AbfAQWfU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 17:35:20 -0500
Received: from ozlabs.org ([203.11.71.1]:51699 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725921AbfAQWfT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 17:35:19 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 43gf6D18dRz9sBZ;
        Fri, 18 Jan 2019 09:35:16 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1547764516;
        bh=F2S5jDDTdCarvNekM7BlhBgIbuZRzpjmX2HpBt9yW2g=;
        h=Date:From:To:Cc:Subject:From;
        b=hIaJ2mem0ziPxYZwEYrzChRchsSmvKWBul/Dpe2KCnVSX7xp5i4H/EzFhBMQve3br
         47KkoiL8w8866lm5PPZfR1+LKF/g8GqZ1Rk+00BeEpDoT/hiD5Choyx0AkXBriOr5H
         W4dkzPEEjElz55kzPbExt2yIzy8FEpy+xBiFn4u7IUkxqpLzP557FCf9t0uccGbwTN
         XTLFdEuzASrMIhr34neoPOxt1FTQ6lBYJrTilVO/3o+6vvdVzWkj2m1Jw0XQjs+IWu
         qBiHfHlh29HlXtQtGNlU+WdXrLpwcL7oUzJ4LGKIL0NcwoKvSPEHr22LmjOz2u8mz/
         CIw2tfMvkZ1vg==
Date:   Fri, 18 Jan 2019 09:35:15 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Subject: linux-next: Fixes tag needs some work in the tip tree
Message-ID: <20190118093515.4bee6eb3@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/5PiD/2NNvmxyX0sF9CD35_k"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/5PiD/2NNvmxyX0sF9CD35_k
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commit

  f0ca26ca4f36 ("genirq: Fix the kerneldoc comment for struct irq_affinity_=
desc")

Fixes tag

  Fixes: Commit c410abbbacb9 ("genirq/affinity: Add is_managed to struct ir=
q_affinity_desc")

has these problems:

  - No SHA1 recognised

The word "Commit" is unexpected in the Fixes tag line.

--=20
Cheers,
Stephen Rothwell

--Sig_/5PiD/2NNvmxyX0sF9CD35_k
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlxBAyMACgkQAVBC80lX
0GxbLAf/VieyF6p6fTQBYXT/primhzrOqVllyMUpwak9ySL1UXP9Qe1O1HSGAIkT
irlg0BH6utD/J/l6iyVRKRy9NhKTGsbcLbVKfFs0Fk6RwvAqO7CmlAONzaCDrOvX
aTkHKSq6CQ8xLDvcdvsu3ECof9xjPR6O3iKk2onb5JsMDv2Tc+p5oFBWLxnwvJFH
8ymoVlIxJzuAs5OLSwSdmgeW5VVldhx+1bcKJHP9Tdb5DJ8r5WeztJkCryQkMLUO
vD4GlG3G/Eg1za2dFGW345BUolyvkyw2OMkgHUtXnw8xeUFNofDD0F4eD3dgBhTB
w20QRiGhu00Wla/WmVpPW7HNosdHaQ==
=j5pL
-----END PGP SIGNATURE-----

--Sig_/5PiD/2NNvmxyX0sF9CD35_k--
