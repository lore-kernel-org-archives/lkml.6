Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70612C6778F
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 22:08:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 257C7206B7
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 22:08:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="jyhQSc9V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 257C7206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731790AbeGZX10 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 19:27:26 -0400
Received: from ozlabs.org ([203.11.71.1]:32899 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730989AbeGZX1Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 19:27:25 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 41c5pD4rhDz9s0n;
        Fri, 27 Jul 2018 08:08:36 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1532642916;
        bh=U2Pdcgctq0DYX03ymQX7j0GyczNwoHpjkk4VaA9aV+s=;
        h=Date:From:To:Cc:Subject:From;
        b=jyhQSc9VzsqNCXH2XLtRqZBiYcN/DFmvqtykRuHMTAeAOHni9yYrMdgF6hOUI3SqE
         ABnrh/BTyeaW+za+oEfv7pNWAVa+9zGj7vOK5ZKt1mYk+/Z4TMoB2S88mzUfDGXjg+
         fhkLkS1q2d6uRrTgaBxEEW/TYx5eZ/s7dAqLWPGKbj6VgMcpJzdDSW2LvQdJWv2OuS
         NTHU449oHT/qENvLxqjezI18VOVsoU2Ge4qEyZlVao1PZuEqJOpL1lRr8Lr2IEMlXx
         ze8ocC5sOfTACebr4Nr0fUYfkeLtbBeGpCYICs/KKqc7hH/I41O2m/hyoGbcswKHdE
         UycVCROJj5emw==
Date:   Fri, 27 Jul 2018 08:08:21 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Rob Clark <robdclark@gmail.com>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Sean Paul <seanpaul@chromium.org>
Subject: linux-next: Signed-off-by missing for commit in the drm-msm tree
Message-ID: <20180727080821.3f277eb6@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/hLSTXTZjtA37Kq.INSGfP_0"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/hLSTXTZjtA37Kq.INSGfP_0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Rob,

Commits

  746e4fe9c852 ("drm/msm/gpu: Add the buffer objects from the submit to the=
 crash dump")
  f757c7aa9f52 ("drm/msm/adreno: Add a5xx specific registers for the GPU st=
ate")
  8ab75ab4f1a7 ("drm/msm/adreno: Add ringbuffer data to the GPU state")
  db71c98cb23c ("drm/msm/adreno: Convert the show/crash file format")
  abd069d0e0d8 ("drm/msm/gpu: Capture the GPU state on a GPU hang")
  2426bf25885c ("drm/msm/gpu: Rearrange the code that collects the task dur=
ing a hang")
  34ee9abb541d ("drm/msm/gpu: Convert the GPU show function to use the GPU =
state")
  e0283c3c191a ("drm/msm/gpu: Capture the state of the GPU")
  fb72cf6167a3 ("drm: Add puts callback for the coredump printer")
  e0624c7467b3 ("drm: Add a -puts() function for the seq_file printer")
  3f7719f78570 ("drm: Add drm_puts() to complement drm_printf()")
  c7cec5d9fa96 ("drm: drm_printer: Add printer for devcoredump")
  bdf6119e70d8 ("include: Move ascii85 functions from i915 to linux/ascii85=
.h")

are missing a Signed-off-by from their committers.

--=20
Cheers,
Stephen Rothwell

--Sig_/hLSTXTZjtA37Kq.INSGfP_0
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAltaRlUACgkQAVBC80lX
0GyIDgf8C8xINg8t0D1erYzli9CShyMdT/DA5aHiTrtkUXjRq9N5347iGbloTmUE
gLKzVAsJ45wYlugEXGE38JBrz5xFuhvK2qwzaTkjlllW9kn+JN11aEwIe2XsfRec
gIEn0tVKRa1RZWE6OYW6mw9jCuUL1XF4j7eZ/Yw584h5m2IZpIzwuN+c5wKdeml3
zYLhV607vP9/Z6sAEn1s01RXpyiIhlwPcjDSP6jE2abU51nNzGYimzn1VHb6kc2B
EXGPvc0MpzNle0C4E9HT4xwAkriK8/zrMoyI0d06fDtVjpWtRyto2tLXH1tp46m7
fIn+0jQEhIprNH6jSqmle5MM60LVCQ==
=xMGE
-----END PGP SIGNATURE-----

--Sig_/hLSTXTZjtA37Kq.INSGfP_0--
