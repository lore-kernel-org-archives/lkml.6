Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7218BC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 06:44:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CE1420842
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 06:44:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="S5Tnu+8S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728620AbfBYGoE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 01:44:04 -0500
Received: from ozlabs.org ([203.11.71.1]:55765 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726707AbfBYGoD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 01:44:03 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 447C8d0GJmz9s9T;
        Mon, 25 Feb 2019 17:44:01 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1551077041;
        bh=lmVs1hT0QQWLsvKg/U6KhyGLPlbJl1E6/182Q7hmkYs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=S5Tnu+8SBbht4e7A0TFxOhNs8TxiSPWx5pZrBfObNP1lBb9G8bPWPIs3G6uRgLfOq
         DI7H0/xjcWrpF/2lfWufMS+WeNHLZ7VoZL1r7CzlJaEglgkN5RNuG1Js6/OqNWgNwg
         zZzxzKcqn/v2cX5AQK/0aIiM/7PlO3cXeFFBqLENq5x3vOpuWaqMZ5cpwUEuaD3FTG
         WBBOOa12SNAB2svEf6N/NJszFl2u8LdYh1vpQE3IxOuhP031ReGZCteZp34ViN22q4
         7Cpgg4lLkyMj/S+edQD7DCovKNafIw4wp4Hm8j7doNMpZY4enRltq9+SkWoF4g4imv
         9jXCDQzfji9iw==
Date:   Mon, 25 Feb 2019 17:44:00 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        PowerPC <linuxppc-dev@lists.ozlabs.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Christophe Leroy <christophe.leroy@c-s.fr>
Subject: Re: linux-next: manual merge of the akpm-current tree with the
 powerpc tree
Message-ID: <20190225174400.5bdafa10@canb.auug.org.au>
In-Reply-To: <20190225174248.54aceebd@canb.auug.org.au>
References: <20190225174248.54aceebd@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/GqQvoPQHf6A=dm3VZXg1K90"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/GqQvoPQHf6A=dm3VZXg1K90
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Mon, 25 Feb 2019 17:42:48 +1100 Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>
> Today's linux-next merge of the akpm-current tree got a conflict in:

This was actually the akpm tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/GqQvoPQHf6A=dm3VZXg1K90
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlxzjrAACgkQAVBC80lX
0Gxb1Qf8C4i23ZrR8/vEGRDTU4flKaWN2Z5qbCqEHaVZg8oZe072WIkAaRVyfbqb
w1fafTTNAjFTdRMyt+WQFhhwqU7O4uhIsISWmONiBQv5OEX2LEGgSZkqsMJAX0ZS
04Y+bU4B80fUWo0TfBkPc5csbhXvQECsHGicewMtjUbomS7rZt9VnvN94+n3BNKR
BBCzUTI0Vnu6Yaqk8OJooYfODof8TBU6d3Oft/vV7qMCiw/dmrXn5q12HJ/XBpr9
brIlZmXL/TecAzlErGep+/bl9w001n8dkoKxxWU4d0Vj5nwAeTWLiec8EPfsfdEZ
UbRuK4Exnj2YXL7apMqjGQ4Q3aqhBw==
=DUpk
-----END PGP SIGNATURE-----

--Sig_/GqQvoPQHf6A=dm3VZXg1K90--
