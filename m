Return-Path: <SRS0=6f18=J7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44F09ECDFB1
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Jul 2018 22:10:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC88120882
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Jul 2018 22:10:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="Cyw+BfKe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC88120882
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727199AbeGOWen (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Jul 2018 18:34:43 -0400
Received: from ozlabs.org ([203.11.71.1]:59911 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726989AbeGOWen (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Jul 2018 18:34:43 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 41TLMH2DKSz9ryt;
        Mon, 16 Jul 2018 08:10:19 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1531692619;
        bh=jmDO8N8gpq19j2O3r/3LdcjuJ25kdN9sJHrqo6rMTg0=;
        h=Date:From:To:Cc:Subject:From;
        b=Cyw+BfKeYlmAxStcEtoo83EEDNGKuFc2jRKlohdtX5Ld2kQvbJC8lBwFn0neUcT1n
         SYIVjiPEE4RxRLW9GfMmvvAVE2N1iC5706bTI0UWOd67bQF0j4PkS96WAvrvvFZcwl
         9vFH/bR5+4b2WRUpf1PxJih4EBc9qTwtqvqCRc5ohBTj4CW4zDas0vhXMdJZ3H5a3r
         7oYmVd6q5QMNFkVtqlFpL7nT0rqHUfr3EtrYveX2uwgT+FJ1bh+fqxTDTG3tDrq/eh
         XyE21uhKrIxaA3WfSF9evJSDClX2U3cOBnV937PM4WfBu2m/oDKNxmUR+YGezpQ+nM
         lGw4b3L/5uSLQ==
Date:   Mon, 16 Jul 2018 08:10:18 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commits in the pinctrl tree
Message-ID: <20180716081018.21bfe495@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/bwbrIm5mTcPdJx3ssUz90Ty"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/bwbrIm5mTcPdJx3ssUz90Ty
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Linus,

Commits

  bc319333c156 ("pinctrl: sh-pfc: r8a77965: Add HSCIF pins, groups, and fun=
ctions")
  99500c6a4836 ("pinctrl: sh-pfc: r8a77990: Revise USB ID pin name")
  3d3c62d3458a ("pinctrl: sh-pfc: r8a77990: Add USB2.0 pins, groups and fun=
ctions")
  1e0f13198edf ("pinctrl: sh-pfc: r8a77990: Add USB3.0 pins, groups and fun=
ctions")

are missing a Signed-off-by from their committer.

--=20
Cheers,
Stephen Rothwell

--Sig_/bwbrIm5mTcPdJx3ssUz90Ty
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAltLxkoACgkQAVBC80lX
0Gzw1ggAluMsF5lyzqhZIKEg1tM6Eu5RwmWMBlRPmtHQavVUCOhV3HLXJHdkBwFK
hDNB9q/x4PcMECWUVfdVyRvByjVYXbQroQenYchvroIqwjk9bwlv46AYd3IDKyVS
6X1J9LevHWOZ1DBou5MkiAXb9pN+ETyyiUP9SIdmThE27KwVbMlXXXmXjUBNc9ad
s8c/pZ5tUPNsEfnvnF4drVJbXHthZgQJIdhenlqA5aUS/TdA/pX6TJKGIE9KXDXx
JEQ2JcsbPuqfjtFZz8NHIT3L1efIOib2WpqUlGkpnJNoDg+wC7ZC3Efjv8xt1PPk
lMcb8NZhWqL/033Zon3oTcCMorVKbw==
=73S9
-----END PGP SIGNATURE-----

--Sig_/bwbrIm5mTcPdJx3ssUz90Ty--
