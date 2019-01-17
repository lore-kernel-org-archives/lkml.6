Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8789C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 20:56:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4EE520851
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 20:56:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="kdMGlsYg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729140AbfAQU4d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 15:56:33 -0500
Received: from ozlabs.org ([203.11.71.1]:34783 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726913AbfAQU4c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 15:56:32 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 43gbwG4Krpz9sDr;
        Fri, 18 Jan 2019 07:56:30 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1547758590;
        bh=yKKFbZAcO3/kjpRjdJJQkz1QwZaz3IXw+auYlwTVwH8=;
        h=Date:From:To:Cc:Subject:From;
        b=kdMGlsYgu8WfMY8IT7WgR37wzQ8842UcL5g1gSZOfQGdT0Xv4nrTG1qDw5Qrg+0df
         lDvd0+LDWRJNf/o17lluRmuYFaOXjTLNwnzrgsUf2weWhLplfwNkWbW8h4xIHsyHdF
         tF09lUPPms6e2o215xzxAxaxuHkedNFXjIpqoM6ypo//u1KlCRy/Ct3WBnZUM777Oj
         bbkY7qtiIZN1zfwHo3AkWlBpozwlD47jpHvfpR7H6ueR341ak+1E/PviI5aMYcgaFS
         k8S2x5jERY7lE5PNoRhEpk6ZNXnxDL9C+3ikIp4ZaDCbVXL9UIQY8e8hWydKMw9AOx
         4mu9Nv7xeakxA==
Date:   Fri, 18 Jan 2019 07:56:30 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Vineet Gupta <Vineet.Gupta1@synopsys.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
Subject: linux-next: Fixes tag needs some work in the arc-current tree
Message-ID: <20190118075630.472a57b6@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/Xcrnq_RottRplPsistdvTPw"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/Xcrnq_RottRplPsistdvTPw
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Vineet,

Commit

  8bfa90f936b3 ("ARC: adjust memblock_reserve of kernel memory")

Fixes tag

  Fixes: 9ed68785f7f2b2b ("ARC: mm: Decouple RAM base address from kernel l=
ink addr")

has these problem:

  - Target SHA1 does not exist

Looks like the "2b" on the end was repeasted accidentally.
--=20
Cheers,
Stephen Rothwell

--Sig_/Xcrnq_RottRplPsistdvTPw
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlxA6/4ACgkQAVBC80lX
0Gyl5Af+OoG4Cmj5LzinT0rIHCnkSZ2OKkhYnrGwFsW2AqJfOrxH+QgwoKbhNKk9
HWBcgw5Cx9rMN3CeIaFAXlqeLRlB0ha9P6LFifVw5b6Y6Wxr0qi6Yf2+px2TLe48
GlGDfdyhDQjWzl4BmCyJs8KexkMw/clY2ri/KEzmpUziG7MxI1BEkovAq+qTxjsO
AkDPLLx+YY61MVcL1SnLuqBP7OARtL3MqiPP91yNvXCeGc3xBsw6G5uerllMbFSQ
EJkqK9cwbDu3K+DCyEl5dbcyRT21R08G/X50goB2lLkjCnaeTVEJ0Kv1WRsXHohj
shx5PZ/zdYbq5HYpMuLyH2dk4FKtXg==
=uFi/
-----END PGP SIGNATURE-----

--Sig_/Xcrnq_RottRplPsistdvTPw--
