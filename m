Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75B3BC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 04:43:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B5F12086D
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 04:43:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="hdbiM2+w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727084AbfAREnF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 23:43:05 -0500
Received: from ozlabs.org ([203.11.71.1]:35743 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726989AbfAREnF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 23:43:05 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 43gpGZ0tlqz9sDX;
        Fri, 18 Jan 2019 15:43:00 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1547786582;
        bh=HOPBaHvlo0pCkNF0M7p1WrECiUQ+k3wNv2UTkSXvla4=;
        h=Date:From:To:Cc:Subject:From;
        b=hdbiM2+wCrIwiY55YpBUo3r8+SdOyvsKuZ/acviCnUmiTz6qfqPI1YOlnd4Zi7lz9
         Je23OQDmI0WBjdpzRTegWH1aIqEAnwfYjU6JcZWXxl+IyNfHPemUi/ylCZF49/stvQ
         QvokE2kTcRZLHxaemebQAnKqhe6b27gOsAP95sUiFNNp4lSpJ9HNTihIXgbj6mtevH
         nmrn7vxTpkOpj1HKetCf3Ns0AYcrOW1yTpLdjkU7CM+/ewNFGX2QNMaXGwVTNs/iKW
         l76VJkc7F9ndtjrRY2NOsRIA43HX8vR+7Zl9KAwojDkLkVFee9muV/8f1WTZkGNoDv
         K+NObP9MhKuSg==
Date:   Fri, 18 Jan 2019 15:42:59 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Dave Airlie <airlied@linux.ie>,
        DRI <dri-devel@lists.freedesktop.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Leo Li <sunpeng.li@amd.com>
Subject: linux-next: Fixes tag needs some work in the drm-fixes tree
Message-ID: <20190118154259.16a7761c@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/C7iIOJ8361rdN+P8fID7TB/"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/C7iIOJ8361rdN+P8fID7TB/
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  dddce8b49005 ("drm/amd/display: Only get the connector state for VRR when=
 toggled")

Fixes tag

  Fixes: 3cc22f281318 ("drm/amdgpu: Set FreeSync state using drm VRR proper=
ties")

has these problem(s):

  - Target SHA1 does not exist

--=20
Cheers,
Stephen Rothwell

--Sig_/C7iIOJ8361rdN+P8fID7TB/
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlxBWVMACgkQAVBC80lX
0GwXAgf+OfFNrTFt7rrvVi61EvmhO0VxYVPrWdNNxAjAo7YbZ8ZI4KoLUhWdcIL4
pGMCmW8Po61nxzyhQmfGD19pMAyqPSxoLYAEEsUogid2zTcDmEHj47YxnA/mOISv
lffPtN5DrtXmsSIlyYobYfGhWCa7UczIAFG0cZ6TwW1OVocmsrW2L39WiRe65nXW
1Kp/7N6m5bhi/QUUgWPTSy70FPVJlXC1dguAu+kE07HVeRA5m3aysA/6P42Bg5Qi
vHrcY5h6Pe4NmF2MZuZg3kCBta8xgzs7vHN3hqzepIB9KrQyyiyeqAQGBlMEjU3R
OKp/f9y/MGAKwIU4G5y28ybJEUosRg==
=nMR1
-----END PGP SIGNATURE-----

--Sig_/C7iIOJ8361rdN+P8fID7TB/--
