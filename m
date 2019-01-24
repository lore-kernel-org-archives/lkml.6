Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4DE6C282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 11:20:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B8FE21872
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 11:20:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="tHmgSV4w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727772AbfAXLTz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 06:19:55 -0500
Received: from ozlabs.org ([203.11.71.1]:43575 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727386AbfAXLTy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 06:19:54 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 43lfng0X7xz9s9G;
        Thu, 24 Jan 2019 22:19:50 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1548328791;
        bh=DYIXxSIGhe5izgD5MVu+M16tegJWxPp7ZVRN8xmm6ts=;
        h=Date:From:To:Cc:Subject:From;
        b=tHmgSV4wFFfsnd3egdk8XWbkdsYAqteZJsSJ7caadGmQ+IAZ0sLNesZY0r2zJd7pa
         RAFx5tnj+eCfFtYiUlhLCPWAcO1VnRLmRTnrWuCWm7P/CjsNy1H07JUCByh0DzI3OK
         Rbi7IcHntLE04fIjW7M2moGq4Z2zbRjrCIcucAb3HNYxRAf82p0ewT/Go7JF3wuCeX
         T/QyhRiFZ6dL+z3S0ogvNQGEaPt53r7X3//6z+k+zeWe6GN3vEw79Zpn7pQCDNjQ+k
         Ob4J/baY090pta2/W6Btkrsp/da5m0GTTWr3JnYT/9DwFb8NlBjHHBhUSeidCMioA8
         8ZW85I4tsxGFA==
Date:   Thu, 24 Jan 2019 22:19:49 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Intel Graphics <intel-gfx@lists.freedesktop.org>,
        DRI <dri-devel@lists.freedesktop.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Weinan Li <weinan.z.li@intel.com>
Subject: linux-next: Fixes tag needs some work in the drm-intel-fixes tree
Message-ID: <20190124221949.4c89542a@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/7qoanAhA0ZHpgGlz=eH3LyR"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/7qoanAhA0ZHpgGlz=eH3LyR
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  0f7555121609 ("drm/i915/gvt: release shadow batch buffer and wa_ctx befor=
e destroy one workload")

Fixes tag

  Fixes: 0cce2823ed37 ("drm/i915/gvt/kvmgt:Refine error handling for prepar=
e_execlist_workload")

has these problem(s):

  - Subject does not match target commit subject

Just some whitespace.

--=20
Cheers,
Stephen Rothwell

--Sig_/7qoanAhA0ZHpgGlz=eH3LyR
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlxJn1UACgkQAVBC80lX
0Gw1Ogf9Gh2sv35SuCnhKYg+w/8FnMOvWbfSFu3gmWsmah0PTbKLnpcfPfhoCW75
uTuD+ET7KEWT2SeXQIm+Xa6WCSGIAl3eyq8MucF+ZUAcmlGSVdEW+KI+4ND8OlaR
3/gyp0NWtSWY/FRVsDnSCBuLRIhD9fNDrs9vU54UeDbsKnMUrbfILlj3chskiEeo
kawthx0UC6DIaZuIajEUV2FM2Mm0Jwf1meFcMwhblkCsxy/flwNGOEse8FQjrYQb
mozEZfHlP6oVyNGTOXHqFlYTFxLRp1TxrTQdTfoorWuw6tKmMvkeE5ruqzkCxWoe
QAEeRK0GliNme3UIq9gmZxNi4quL8g==
=AIv0
-----END PGP SIGNATURE-----

--Sig_/7qoanAhA0ZHpgGlz=eH3LyR--
