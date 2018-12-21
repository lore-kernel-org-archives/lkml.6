Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2455BC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 13:57:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 813A121920
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 13:57:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="FduMHEV5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390807AbeLUN5u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 08:57:50 -0500
Received: from ozlabs.org ([203.11.71.1]:44657 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390790AbeLUN5u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 08:57:50 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 43Lqvb3dbyz9sDL;
        Sat, 22 Dec 2018 00:57:47 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1545400667;
        bh=igQbMZ8d9Ju900fhzwMe7unnnnDBNmRCyYZ/yVmi1Gc=;
        h=Date:From:To:Cc:Subject:From;
        b=FduMHEV5sw5XM28263vxvZvOkaPP4iHzyTQLk/FtyS6JGOKv5yVFMYiyIdVtcsihK
         xSfg+RMm9gS9yLSCSUyVYCemKrwX2vMe4/KsQugZ1fumF1iZGqzKwolXAIkRclmvb2
         zymoCImCCWBfSBQdf2Eqq0i6naCXhdsgnwnB2QMhOx66DAnAy+DerEllpPDQiFnjRz
         Pr1636zY14ADFd7WSKkOmqnAhOh9apsyd8yj57HWHuNHq5ub4/2g2O9g1qQ8pU7iWX
         /4to1j4RuMeJJnQSJqlmb6PyCtq/Lw0NOOCae89SGFS0sYLi8dzHaBarhQKet2W3zi
         yspbtaW7Ie/rA==
Date:   Sat, 22 Dec 2018 00:57:46 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?UTF-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        KVM <kvm@vger.kernel.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commit in the kvm tree
Message-ID: <20181222005746.4bdd1553@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/MqaFIW.=CR6_b+Abyrdj..V"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/MqaFIW.=CR6_b+Abyrdj..V
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commits

  8cee58161eff ("kvm: selftests: aarch64: dirty_log_test: support greater t=
han 40-bit IPAs")
  cdbd24284824 ("kvm: selftests: add pa-48/va-48 VM modes")
  696ade770f08 ("kvm: selftests: dirty_log_test: improve mode param managem=
ent")
  fd3f6f813976 ("kvm: selftests: dirty_log_test: reset guest test phys offs=
et")
  6498e1da84da ("kvm: selftests: dirty_log_test: always use -t")
  d4df5a15602e ("kvm: selftests: dirty_log_test: don't identity map the tes=
t mem")
  b442324b5815 ("kvm: selftests: x86_64: dirty_log_test: fix -t")
  bdd303cb1bdb ("KVM: fix some typos")
  649472a1694f ("x86/kvmclock: convert to SPDX identifiers")
  9b7ebff23cb8 ("KVM: x86: Remove KF() macro placeholder")
  788fc1e9ad8e ("kvm: vmx: Allow guest read access to IA32_TSC")
  9ebdfe5230f2 ("kvm: nVMX: NMI-window and interrupt-window exiting should =
wake L2 from HLT")
  e081354d6aa7 ("KVM: nSVM: Fix nested guest support for PAUSE filtering.")
  7a86dab8cf2f ("kvm: Change offset in kvm_write_guest_offset_cached to uns=
igned")
  f1b9dd5eb86c ("kvm: Disallow wraparound in kvm_gfn_to_hva_cache_init")
  ba7424b200d3 ("KVM: VMX: Remove duplicated include from vmx.c")
  b85c32dd2749 ("selftests: kvm: report failed stage when exit reason is un=
expected")
  e87555e550ce ("KVM: x86: svm: report MSR_IA32_MCG_EXT_CTL as unsupported")

are missing a Signed-off-by from their committer.

--=20
Cheers,
Stephen Rothwell

--Sig_/MqaFIW.=CR6_b+Abyrdj..V
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlwc8VoACgkQAVBC80lX
0GzPrgf+IouKYZMUp4e3N+rt8u2edrS4E9vH3RYktELFMwlGPm56bOkTlqwU/fwd
LZ92N3wni6UwcSm2snuJ8GySZhwCOC/8WduAKG9L1Bx0KmL/vlAYA5S0HK8mr4s+
BaFAEbVO5ZyyTLiP0YOVoqvPK+kgE4D/B1Y+nxEBsVFNLAQArpBfJtHPZIIZcXl0
SAKHAc3FcEMmA6ng0xRY2Tan3dvZMtvjywebBXd/ymL/C6r72SueB30IL86Ff4TN
B8EateHu2z7fqzg1A93T3BP/VSGPTBCo1UeMWn6MeXJZLDB+MMzHJ0gnaCTiyoit
BFENbajY5IHHydVBI6sc9NFvbH6cdw==
=onlo
-----END PGP SIGNATURE-----

--Sig_/MqaFIW.=CR6_b+Abyrdj..V--
