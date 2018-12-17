Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16D2AC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 23:38:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9D3321473
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 23:38:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="PhFrmywC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726386AbeLQXiP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 18:38:15 -0500
Received: from ozlabs.org ([203.11.71.1]:38943 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726255AbeLQXiO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 18:38:14 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 43Jcz71YDLz9s2P;
        Tue, 18 Dec 2018 10:38:11 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1545089891;
        bh=Z6v1fw6zmqbFHlhOpgDqfqrVZR3HT06aRl0FHqQ8l3k=;
        h=Date:From:To:Cc:Subject:From;
        b=PhFrmywCAI1jG9F/iP1WFc85Jh5UjcGmV98KqJ5LsvZTY9VDOQN2Izjz1SeN5srXg
         Ym5Xj5h8JqOM1x1UzSwrpa+Ap+yZQo6ySMACIPOVbZgs/FKqrwCESriY5EzfZneBEA
         vc1T4HxMI1+VjU4uLoYEuaPtv+tqEyq4G18yQ8L3gahZkIzLUax7jz3lw4fMr/Ze3B
         hoxoZWWku/q8+0JQkIS8yDTRu8EWZGwk92sTUIMbZcvvU34lIMKZHdgE3xhYxAAQw0
         WZUmElDe2ldiqBuPduFoknULC4bFthoIp2nCtZfEKnepEuc2qsgyuIANn40gNjdq8q
         2AfB8F1adF2ow==
Date:   Tue, 18 Dec 2018 10:38:10 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Al Viro <viro@ZenIV.linux.org.uk>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commits in the vfs tree
Message-ID: <20181218103810.11687f68@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/NtkgW1+nRoCK.YKjRv.S9xP"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/NtkgW1+nRoCK.YKjRv.S9xP
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Al,

Commits

  c1cae12e6b4a ("vfs: Add a sample program for the new mount API")
  d101a34a2c79 ("vfs: syscall: Add fspick() to select a superblock for reco=
nfiguration")
  1fcae4c630e3 ("vfs: syscall: Add fsmount() to create a mount for a superb=
lock")
  ec4256de39c3 ("vfs: syscall: Add fsconfig() for configuring and managing =
a context")
  0cba0050bcbe ("vfs: Implement logging through fs_context")
  4552c960ff40 ("vfs: syscall: Add fsopen() to prepare for superblock creat=
ion")
  03ca430a2648 ("Make anon_inodes unconditional")
  96298884c8b4 ("vfs: syscall: Add move_mount(2) to move mounts around")
  6c606fff6c91 ("afs: Use fs_context to pass parameters over automount")
  10424811186f ("afs: Add fs_context support")
  8fa5366945d8 ("vfs: Add some logging to the core users of the fs_context =
log")
  8907f3967fbc ("vfs: Implement logging through fs_context")
  bed15a150f44 ("vfs: Provide documentation for new mount API")
  460375e70621 ("vfs: Remove kern_mount_data()")
  e88bea43b477 ("hugetlbfs: Convert to fs_context")
  d48db7fb30db ("kernfs, sysfs, cgroup, intel_rdt: Support fs_context")
  35822336b482 ("cpuset: Use fs_context")
  b97c89323b7b ("ipc: Convert mqueue fs to fs_context")
  e1f97a645981 ("proc: Add fs_context support to procfs")
  5aed868ddf7f ("procfs: Move proc_fill_super() to fs/proc/root.c")
  013c7af575e5 ("vfs: Implement a filesystem superblock creation/configurat=
ion context")
  47173883ff4d ("tomoyo: Implement security hooks for the new mount API")
  c36d02347290 ("apparmor: Implement security hooks for the new mount API")
  18ee890db905 ("vfs: Put security flags into the fs_context struct")
  18ef962eeec1 ("vfs: Add LSM hooks for the new mount API")
  1bff8b546644 ("vfs: Add configuration parser helpers")
  57fb096cd685 ("vfs: Introduce logging functions")
  23ac0033ae3c ("vfs: Introduce the basic header for the new mount API's fi=
lesystem context")
  0a8054c863b8 ("vfs: Separate changing mount flags full remount")
  e322b9267880 ("vfs: Suppress MS_* flag defs within the kernel unless expl=
icitly enabled")

are missing a Signed-off-by from their committer.

--=20
Cheers,
Stephen Rothwell

--Sig_/NtkgW1+nRoCK.YKjRv.S9xP
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlwYM2IACgkQAVBC80lX
0Gzcywf+JAGWAjUM0QAfyEBgD+a1rX97iANjWiwSWIaavUekLrNdt44yCgC1sN2M
4ExYjFWy3jU5UhKfF7IAE5sh7LC8qEyQDBuvWqCLPxUc0ISGpAgZ8O7/aB5OCnC6
OTGKBoh5FXU2fQGdcnC1STSlKIFEPtQyeNm+wNnMGqVbESQfJrLIAPJiKJfM9/Df
klfa586JUvUyH12ctU6frdqIIPtfV0lYHXSxlOJ474XfLgaP2tcbo87VFq9BeMOD
xFC+nUDaAMHLlAMilnSpWMKJ2Qc/AbCuEDdPqjtf0dX69U4LQz+XeZDpBMX1zGEg
+HtgKUz+tMpHIFPKVI3N/vXGi6Kj1Q==
=dhHA
-----END PGP SIGNATURE-----

--Sig_/NtkgW1+nRoCK.YKjRv.S9xP--
