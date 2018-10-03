Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 672D3C00449
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 23:25:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17BD72147C
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 23:25:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="JA1XSa12"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17BD72147C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727143AbeJDGQF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 02:16:05 -0400
Received: from ozlabs.org ([203.11.71.1]:35365 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726182AbeJDGQF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 02:16:05 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 42QXF83G82z9s7W;
        Thu,  4 Oct 2018 09:25:32 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1538609132;
        bh=Gofh3JhTAnjEAyrA7kvxaQ3jIeXiBH3WHc2CJxzf5Pc=;
        h=Date:From:To:Cc:Subject:From;
        b=JA1XSa12IE1W+gm4gysgqhas1w381iGyofDRC9ivVWh22BpqN/DzZNn1edUcbUCDx
         L7vl2VK5sM0k+PXABoi7gZRuvbp5I/RQbLDk/Pu7g93PGz0s+KqBEeNXplk1qb5Zgx
         TnIe/tQ+ScoarYDQijlGWs4c+0CihBv8sYkVYas688PQhut6QSi6KSK259QHwj13HF
         s6xYbf1+6ZAINaqqRA1zzKQ9M9x/PACgC3YKbBP7Lm/4/HNXzGwSH434EKNYw4x6En
         U3FGM6VWC21erSHY/vDWkvqn1GPbuNuynUIaATDOgVxR7LnG8TH09nUGnEE/bJnr1Z
         +W5BYEA1In3pg==
Date:   Thu, 4 Oct 2018 09:25:16 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Rob Clark <robdclark@gmail.com>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commits in the drm-msm tree
Message-ID: <20181004092516.26cec1d0@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/Iy6JZCzjlE_esM9f2AHtbXk"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/Iy6JZCzjlE_esM9f2AHtbXk
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Rob,

Commits

  ef02ae3a2f88 ("drm/msm: dpu: Don't reset dpu_enc->cur_master on .disable(=
)")
  9875f4b6da02 ("drm/msm/dpu: Revise _dpu_plane_get_aspace")
  99e1ced69212 ("drm/msm/dpu: Make dpu_plane_danger_signal_ctrl void")
  8fb336bd301e ("drm/msm/dpu: Change _dpu_crtc_vblank_enable_no_lock to voi=
d")
  0bacddff8ed8 ("drm/msm/dpu: Remove _dpu_crtc_power_enable")
  ac8b29aba68f ("drm/msm/dpu: Remove unneeded checks in dpu_crtc.c")
  e015a6e97a02 ("drm/msm/dpu: Clean up plane atomic disable/update")
  3a6bf2a3dc52 ("drm/msm/dpu: Remove unneeded checks in dpu_plane.c")
  9eb37b95bfd6 ("drm/msm: dpu: Don't store/deref pointers in trace ringbuff=
er")
  2626c1cdfa49 ("drm/msm: dpu: Add extra_flush_bits to trigger_flush trace")
  f5a342cb8682 ("drm/msm: dpu: Clear frame_busy_mask bit after trace")
  8dce281b6126 ("drm/msm: dpu: Don't continue after error in atomic_check")
  0dafdcb87483 ("drm/msm: dpu: Make dpu_plane_sspp_atomic_update() void")
  659d33c4c63a ("drm/msm: dpu: Remove dpu_plane_enabled()")
  9f7583b89d7a ("drm/msm: dpu: Remove dpu_plane_sspp_enabled()")
  976a4564ecdb ("drm/msm: dpu: Consolidate atomic_check functions()")
  46439c6c78f5 ("drm/msm: dpu: Move atomic_check_plane_state() call to atom=
ic_check")
  b52a9f40d7cf ("drm/msm: dpu: Remove impossible checks")
  b34cfea1a6ed ("drm/msm/dpu: Remove an unused enum")
  b9c621e8dff1 ("drm/msm/dpu: remove RM topology definition")
  82891245fbe2 ("drm/msm/dpu: relax parameter validation in encoders")
  fe5f47bad04b ("drm/msm/dpu: remove RM dependency on connector state")
  e515ad4369ae ("drm/msm/dpu: remove display H_TILE from encoder")
  63090272ac43 ("drm/msm/dpu: remove LOCK/CLEAR support in RM")
  c9159537711a ("drm/msm/dpu: remove cdm block support from resource manage=
r")
  8b8b91fd3576 ("drm/msm/dpu: clean up destination scaler residue")
  f76a527a0a2b ("drm/msm/dpu: rename hw_ctl to lm_ctl")
  caf53d6ea3f0 ("drm/msm/dpu: move hw resource tracking to crtc state")
  26496d7f55cf ("drm/msm/dpu: make crtc get_mixer_width helper static")
  116a0ac329c5 ("drm/msm/dpu: avoid querying for hw intf before assignment")
  a87b3b4f0918 ("drm/msm/dpu: iterate for assigned hw ctl in virtual encode=
r")
  efd334265679 ("drm/msm/dpu: use kms stored hw mdp block")
  46fc79c15e1f ("drm/msm/dpu: enable master-slave encoders explicitly")
  3c0c8c2540cc ("drm/msm/dpu: remove ping pong split topology variables")
  d1087d10ca8e ("drm/msm/dpu: remove resource pool manager")
  9650e04c19a1 ("drm/msm/dpu: remove scalar config definitions")
  1fe0d3a930c6 ("drm/msm/dpu: squash power handle event types")
  46f69a1b9533 ("drm/msm/dpu: remove debugfs support for misr")
  ab9cd436139b ("drm/msm/dpu: Remove dpu_mdss_isr when dpu_mdss_destroy is =
called")
  3d80625e00aa ("drm/msm: dpu: Allow planes to extend past active display")
  463f3aea2323 ("drm/msm/dpu: use encoder type to identify display type")
  774cb941cf3c ("drm/msm/dpu: remove unwanted encoder type mapping")
  766b821ebb1b ("drm/msm/dpu: remove stale display port programming")
  a1195d221097 ("drm/msm/dpu: fix for cursor blend issue")
  ab3e67ffd5cd ("drm/msm/dpu: enable cursor plane on dpu")
  32ce4e8c1d94 ("drm/msm/disp/dpu: Use proper define for drm_encoder_init()=
 'encoder_type'")
  450bf8df3d37 ("drm/msm: Don't fail bind if nothing connected to dsi")
  8073c1a86310 ("drm/msm: dsi: Return errors whan dt parsing fails")
  a0ce66f844ce ("drm/msm: dsi: Initialize msm_dsi->id to -1")

are missing a Signed-off-by from their committer.
(I didn't check all of them by hand, but I did some.)

Presumably caused by rebasing?

--=20
Cheers,
Stephen Rothwell

--Sig_/Iy6JZCzjlE_esM9f2AHtbXk
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlu1T9wACgkQAVBC80lX
0GybZgf/ZyDT0AxgNgJ6+QTHXCeK66B+cTRchPM9IKskfGkpjZkp8bL1TAWenirI
maLlKwLXg8DWkuc43YzerEA/mg/xw1GG/7fq7B/Awq17UOL56LK7sUMFIKbRpdxs
QhEvuEi9BxKFDefmJw6/6XC9a20CFowraxKuw07Kr98dNu3Jy6BQGuPeceFquoGO
ch4tDFaOr3G1TR+UcyrZTqjZ2zCSWTl/Yv4u2QzByYLSDWi6u7WcAfvbuvyEX6yf
QTjOakTbcaO/+cPMX+vrbEkCjiwYNK+S/BikD9mpefQQTfBtQ0tC0fCgKWaYTwK+
g1v2NEanM8dA0MB0M8T/DClM49PiFg==
=waia
-----END PGP SIGNATURE-----

--Sig_/Iy6JZCzjlE_esM9f2AHtbXk--
