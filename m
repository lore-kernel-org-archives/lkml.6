Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 694A4C282D7
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 00:05:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 237E020B1F
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 00:05:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="E7hgDPZg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727417AbfAaAFs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 19:05:48 -0500
Received: from ozlabs.org ([203.11.71.1]:52489 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725768AbfAaAFr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 19:05:47 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 43qgVZ26ydz9s3q;
        Thu, 31 Jan 2019 11:05:42 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1548893144;
        bh=DonUQzEEBGDyYwmOCo2p664Zw99a2MZIRS32AnH80DE=;
        h=Date:From:To:Cc:Subject:From;
        b=E7hgDPZgK4HHRM87p11kLaIf7rORCnGBc6qmeVPgQV4ASl3GThCazTEczZ372E2IX
         WbP4Y2JciAqw9mQ1YNCLOoDNznmLllyck3hJT4yPq4utUeJPWl2Z2oyJxLPhbfdxqh
         KGX6A7wbRjVYEBTqdgzU32Er0a0O1+/YBVs9nbwmA0s5ndJF1NVVrhe4hrOmct+7mS
         zeDP//tlJMLElnJdG07upMBLgXCKZHeca9cPmTenNW71y/AVR1GInSOnL37qu5hvAU
         C3zyHgo+Gk6Og324z73HRSSewRYevoFG2cfJCwyXk2iGwsVOHB16y3k/uDCN9AM4sm
         Y9WLFA+xlJzYQ==
Date:   Thu, 31 Jan 2019 11:05:41 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Liviu Dudau <liviu@dudau.co.uk>, Qian Cai <cai@lca.pw>
Subject: linux-next: Fixes tags needs some work in the akpm-current tree
Message-ID: <20190131110541.3f3a808c@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/Bs_.GBX.hqlakDsFwUu5OIW"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/Bs_.GBX.hqlakDsFwUu5OIW
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  86c7502b25ed ("mm/vmalloc.c: don't dereference possible NULL pointer in _=
_vunmap()")

Fixes tag

  Fixes: f3c01d2f3ade ("mm: vmalloc: avoid racy handling of debugobjects

has these problem(s):

  - Subject has leading but no trailing parentheses
  - Subject has leading but no trailing quotes

Please do not split Fixes tags across more than 1 line.

In commit

  6e9ed490d190 ("mm/page_owner: fix for deferred struct page init")

Fixes tag

  Fixes: fe53ca54270 ("mm: use early_pfn_to_nid in page_ext_init")

has these problem(s):

  - SHA1 should be at least 12 digits long
    Can be fixed by setting core.abbrev to 12 (or more) or (for git v2.11
    or later) just making sure it is not set (or set to "auto").

--=20
Cheers,
Stephen Rothwell

--Sig_/Bs_.GBX.hqlakDsFwUu5OIW
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlxSO9UACgkQAVBC80lX
0GxozAgAndA+eQEnyIjF0/CnyNghPTie31FJ5TohhccbNie055brleJjhC02zsjA
IjcHqd37sEdDsJQbkUB6lOpDyQ3fkDHzJZ5nvZ8NUG9/64crxaCFoh4nFjrtuIYI
EHIMV72poXCbXPXbM8ZhrvnG9TTpYtGYy2On3B0Q7awzZGqCa8mSvW4whtblES6a
wDRIbK7GB8qmVAP+d/AXKWHwQM7Ttg0YfeOD4CK/mr8NTRVpzpohKbf+7lyELqcN
Z5GOV0ajzb2jbWiTUHRdwqNxfkXu6n31XojBXrAsrEL253QTkvnFQTPYdH3W/NQ9
hjiJjyeuusohJve8i88q14Vxvd/jIQ==
=ouuW
-----END PGP SIGNATURE-----

--Sig_/Bs_.GBX.hqlakDsFwUu5OIW--
