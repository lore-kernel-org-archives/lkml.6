Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C1E0C65BAF
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 20:33:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB05620811
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 20:33:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="oY6eyS+u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB05620811
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727277AbeLLUdB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 15:33:01 -0500
Received: from ozlabs.org ([203.11.71.1]:34417 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726247AbeLLUdA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 15:33:00 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 43FT5j40FHz9s6w;
        Thu, 13 Dec 2018 07:32:57 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1544646777;
        bh=yjA+7VlepqO1en/t6TITwuJvYqt6DVsfmtSEUvC6tBU=;
        h=Date:From:To:Cc:Subject:From;
        b=oY6eyS+u7HnIgVW1mbEJYr0g1DT0qccYRsbHiziqpCcp5nMYvoK4hM0Y+MpnP9vhT
         D5x3w5RvG1xJws7/YzyBzg18NiYAPVPhiwgANN6Uk5KahYFOkOFhSAn7Zuy343I29h
         4cS6LqYwNpXkK7g0dUSAOIFIASltnZXPluUjGy7ThDQRDDErg8kFrKihLN9xID8MZQ
         zqjOEZQtyfwGkq4y5vMy+ZqSoJhxMkWRuxmrF1Oaeq+e3UFPYJVY92PMgreWBzwxXv
         IljxpcB2Qdr/gRr6mPDfv10bd4RU16ubgja9kNQikYTTG161KjTstD5XOVAUy7KAdZ
         verEZOnueOdDA==
Date:   Thu, 13 Dec 2018 07:32:45 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Networking <netdev@vger.kernel.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commits in the bpf-next tree
Message-ID: <20181213073245.5b2d2536@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/JF2wAiMkZ1gy6srZ9wd20.V"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/JF2wAiMkZ1gy6srZ9wd20.V
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commits

  3bdc28aa2340 ("selftests/bpf: add btf annotations for cgroup_local_storag=
e maps")
  1dfd1959fed4 ("bpf: add bpffs pretty print for cgroup local storage maps")
  3adc62d9a5be ("bpf: pass struct btf pointer to the map_check_btf() callba=
ck")
  9cf3a785dc4c ("selftests/bpf: use __bpf_constant_htons in test_prog.c")

are missing a Signed-off-by from their committers.

--=20
Cheers,
Stephen Rothwell

--Sig_/JF2wAiMkZ1gy6srZ9wd20.V
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlwRcG0ACgkQAVBC80lX
0Gzmugf/c3PQiufxOJr8T1wO62M8NbddLU0l3CHBWa4LzGt6+K042ZqBUzPfDXJT
jLj8wABpjn7w8SiEsYahmN0hq19tVVtjGft7nQVgsUstlkzzYn+oNZwqoq5v9X6q
A/anE530ejRmHAehZEbIsxRkseZi23yDF3aSEvaVcx/nOnsTBggv4M0cxiBf8/4l
omkNDBg4pvSCb9mPmtbYxWB4N4W8jHK+hQ6zKM4teu6K2a+KZCa3QRDxyNzSzF15
I1R8Wr5K9M4yvrh5Styvqns3VqQc6WF/upks4yiWPN58XjWtdHWq3VAdtbKOLcuR
+mJ8eYD7piR+ce0cB5zjjlFvEMXtQw==
=H2iu
-----END PGP SIGNATURE-----

--Sig_/JF2wAiMkZ1gy6srZ9wd20.V--
