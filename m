Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4186C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 20:45:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D13021909
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 20:45:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="EQ4sSfTT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388259AbeLTUpc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 15:45:32 -0500
Received: from ozlabs.org ([203.11.71.1]:55037 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730057AbeLTUpc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 15:45:32 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 43LP0S4bf1z9s8J;
        Fri, 21 Dec 2018 07:45:28 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1545338729;
        bh=BwrrPM3X9hZVgHVFTGe/NdzgxrivncUr13rT/FGbtRY=;
        h=Date:From:To:Cc:Subject:From;
        b=EQ4sSfTT/EOvQQFAXYEVWvMsavH7v8jUy79O2uSaC9yMgSDHh+lD/cveKwyV38460
         9dHDdkdZzzr3N7FPFcACE7e4uM4z3AtpUSjjI9q3YFcEAcMCC5apY9oMBvdXO8BkIK
         9lvenYvmCaiMGeePNnxU0iLyDDnpONcFLyR45FhryyCwn4dV8XIQRD+fhIvgWGamW8
         L/tCq8oe/mwUmNl0g59E4P67f15TB0bekmTIVkqNyUf36gqZ2NHHPJsBapph/7MgbM
         uRnY1sHEHNu1n0qVn+PJKWM8EMYbNaCiA7AJl21staKgzjkwsNN3E8/hbIe2zbNmZQ
         SlAjFjoBK8N3w==
Date:   Fri, 21 Dec 2018 07:45:22 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Al Viro <viro@ZenIV.linux.org.uk>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Howells <dhowells@redhat.com>
Subject: linux-next: Signed-off-by missing for commits in the vfs tree
Message-ID: <20181221074522.0b0c986c@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/p6HwAU_tfq9f5bddGFFOrnS"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/p6HwAU_tfq9f5bddGFFOrnS
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Al,

Commits

  e6cf4b0ddae8 ("teach vfs_get_tree() to handle subtype, switch do_new_moun=
t() to it")
  a5df92eef26f ("new helper: vfs_create_mount()")
  84b9446c0cb2 ("mount_fs: suppress MAC on MS_SUBMOUNT as well as MS_KERNMO=
UNT")
  6df9e604628d ("smack: rewrite smack_sb_eat_lsm_opts()")
  a4fdf6490284 ("smack: get rid of match_token()")
  b2130173efae ("smack: take the guts of smack_parse_opts_str() into a new =
helper")
  324240b27f48 ("LSM: new method: ->sb_add_mnt_opt()")
  8a2bfb0f835a ("selinux: rewrite selinux_sb_eat_lsm_opts()")
  3cec2907c913 ("selinux: regularize Opt_... names a bit")
  b0ab2db616c0 ("selinux: switch away from match_token()")
  cbe9d96f42ba ("selinux: new helper - selinux_add_opt()")
  2790a639b456 ("LSM: bury struct security_mnt_opts")
  205b9b7a392a ("smack: switch to private smack_mnt_opts")
  179a64d445e2 ("selinux: switch to private struct selinux_mnt_opts")
  cb662518822e ("LSM: hide struct security_mnt_opts from any generic code")
  6c63bb2d5323 ("selinux: kill selinux_sb_get_mnt_opts()")
  e03db7f5411c ("LSM: turn sb_eat_lsm_opts() into a method")
  dc0dadb3c3d7 ("nfs_remount(): don't leak, don't ignore LSM options quietl=
y")
  363540f775fb ("btrfs: sanitize security_mnt_opts use")
  8f08fcb05ba6 ("selinux; don't open-code a loop in sb_finish_set_opts()")
  144da0858c5e ("LSM: split ->sb_set_mnt_opts() out of ->sb_kern_mount()")
  be917e5b8736 ("new helper: security_sb_eat_lsm_opts()")
  580a8bcb268b ("LSM: lift extracting and parsing LSM options into the call=
er of ->sb_remount()")
  cf891373b60a ("LSM: lift parsing LSM options into the caller of ->sb_kern=
_mount()")
  d02fc3452738 ("smack: make smack_parse_opts_str() clean up on failure")
  17f3b556a3e3 ("selinux: expand superblock_doinit() calls")

are missing a Signed-off-by from their committers.



--=20
Cheers,
Stephen Rothwell

--Sig_/p6HwAU_tfq9f5bddGFFOrnS
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlwb/2IACgkQAVBC80lX
0GxLzgf+K7/8UPnOL5DR52WMIUS8B65SD37helBcAb9H1BZJfCJVb8jD27HLSL9N
Ro/V04nGOxtUuXAQQgI3jhEyRSqKRe4aaXCEmzFyEufLGkUp/i8aR0LZlS2P5lL1
pl1ZW9q4qKQwMpPMhOsoDLtfpUdnNlIY2X26SmzKYMbRBuBtiVLMySO/9J+3Cili
6x3oZf6OR3DrynMQ30F6B+EsGxjZlXl/opi/HaPG4hr65Rx02MeIvMZ7f53IztU5
K7PZNSu+1j5JNH+NSFQIp1cIV9lTztjsz5qcAz0ij73uNJusFEPJ0gLU2XrBpWNO
mh7q6PDIavE55TKz0pzoYF4/F988JQ==
=reGn
-----END PGP SIGNATURE-----

--Sig_/p6HwAU_tfq9f5bddGFFOrnS--
