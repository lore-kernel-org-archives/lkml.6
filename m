Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B48E2C433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 03:13:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A1C92082C
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 03:13:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="FHmg9NnN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A1C92082C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727245AbeHaHTB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 03:19:01 -0400
Received: from ozlabs.org ([203.11.71.1]:45233 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726037AbeHaHTB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 03:19:01 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 421kw71CVhz9s1c;
        Fri, 31 Aug 2018 13:13:42 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1535685223;
        bh=lep/d28ZMSRTQKxXMvigkvLPTjd1R0+HEApee+kJ3wo=;
        h=Date:From:To:Cc:Subject:From;
        b=FHmg9NnNYaJFGkelehkdcNyCoXiPPiDEZhpQjIfsIcZnMG9lF8zmyoViPwdjGVLN5
         wBSMg3IC/cxmZnUHhbpaZJ7mKat0MMAJ0GwW+nsx163+QufiEcAjjBq/apyWMofGr2
         YfSWSnFWlTHaLITImf3Dl9UQXr/8hAK2QpV3n7utkNolHdpZ2zsidD6Ef9v7OsVqtb
         +t3DRBr4Gyhq3V6wYjXWpjecVQ7akcw+/0tyw4FavDBFgUbx4sWzL5Q7Kpr/NreAQk
         DAqcXRS1oKFFKb4qaPzqbGGBTqKc+YyA397jT1pDXRIgU+imD7lAwn89dXPxqEdXcF
         22tYag4ZZYnRw==
Date:   Fri, 31 Aug 2018 13:13:42 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Vineet Gupta <Vineet.Gupta1@synopsys.com>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Will Deacon <will.deacon@arm.com>
Subject: linux-next: Signed-off-by missing for commit in the arc-current
 tree
Message-ID: <20180831131342.6c14a702@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/50F=bgE0DXSb2=PO=B_JsJ."; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/50F=bgE0DXSb2=PO=B_JsJ.
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Vineet,

Commit

  c0a7bc6e5585 ("ARC: atomics: unbork atomic_fetch_##op()")

is missing a Signed-off-by from its author.

--=20
Cheers,
Stephen Rothwell

--Sig_/50F=bgE0DXSb2=PO=B_JsJ.
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAluIsmYACgkQAVBC80lX
0GybXAf9EV2HAoMGvHq12kGroe/eCoMdUHOxyOxl8oVFsyoHW1+Itq++g1nQzuDy
7BYHGcgK4t0uSkj0qIom8N8SYLVyEFiQBBa+QKMlGGLVOUbMVakOJbPOONqwikzz
CBudPw5T8F+TPr9dv/LVl8Ysn1Svi0/O5xBC5uBM/1RNzuWonTSB3AfIoReCHXI+
+TezfyKof1OO4HyewOKECnrX5eknLOyA2L8CGe+XY+zQgfz6t5P+7j3UW/vUg2Oz
ITsIMMPsvs/VfoQP02kUuAsbTQ0yH0V45AXc2NTR7yH4D8lc6PVprq9InoaNaOYJ
xQLb4BZRue45BoTe6V7Ll4wVqYt7wg==
=PVkN
-----END PGP SIGNATURE-----

--Sig_/50F=bgE0DXSb2=PO=B_JsJ.--
