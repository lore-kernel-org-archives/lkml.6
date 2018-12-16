Return-Path: <SRS0=hDTa=OZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C82AC43387
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Dec 2018 23:42:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E76C621839
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Dec 2018 23:42:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="WU8pudIb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731155AbeLPXmw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Dec 2018 18:42:52 -0500
Received: from ozlabs.org ([203.11.71.1]:36989 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730780AbeLPXmw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Dec 2018 18:42:52 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 43J16w23YQz9sD4;
        Mon, 17 Dec 2018 10:42:48 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1545003769;
        bh=pCUSTxGzf9OwR7jcJxD2nLtL8SjoTREq4yB/dxfkSsI=;
        h=Date:From:To:Cc:Subject:From;
        b=WU8pudIb1Do4EKQwPcPql2WpfikCXVyn/CuF0ra8vbiX7xZU7aWOm1bqk+da897Dn
         b/EHkhSF+VnKS6d5+Dq8I3tIlMgriKqjY3v74Y3AsPJD0J+ZFq9O7SmM7TG9wGkOBx
         F47f/9reW6pEHwwgD+hfzqLScMrNPUG9KofbtSDvnlBBTYJiA24S4btm5SDP+RaDmI
         1/xo8CWUWjRItjnjV+g9mWwnslb9w/VFJVNDsifauRPIIStPK6B51YckNCGZ/HCc88
         x8wVoawdV9ZZWfOW0omX+/kh2VqSozVEM0N7IgpXmHH727Nhhd64xHDBsMMq+T2RjY
         /z5KorWisa/5Q==
Date:   Mon, 17 Dec 2018 10:42:47 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Jiri Olsa <jolsa@kernel.org>
Subject: linux-next: Signed-off-by missing for commits in the tip tree
Message-ID: <20181217104247.26549a16@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/XCS2Nje.p44kZ2wwKL5rGSJ"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/XCS2Nje.p44kZ2wwKL5rGSJ
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commit

  5a0cb2ffce06 ("perf ordered_events: Add first_time() method")

is missing a Signed-off-by from its author.

Commits

  a1dcb76e592a ("perf top: Move perf_top__reset_sample_counters() to after =
counts display")
  ffec48b73449 ("perf top: Display slow reader warning when droping samples=
")
  30eacd0f6c56 ("perf top: Save and display the drop count stats")
  bdbc7bcf0f9a ("perf top: Drop samples which are behind the refresh rate")
  2e86f646dd68 ("perf top: Set the 'session_done' volatile variable when ex=
iting")
  bc67057cab13 ("perf top: Use cond variable instead of a lock")
  73df315a5120 ("perf top: Add processing thread")
  f0a93bdc13e4 ("perf top: Move lost events warning to helpline")
  f03b87dd0b44 ("perf top: Save and display the lost count stats")
  4bc8acb7e06b ("perf ordered_events: Add private data member")
  52ea6a5168fb ("perf ordered_events: Rework show_progress for __ordered_ev=
ents__flush")

are missing a Signed-off-by from their committer.

--=20
Cheers,
Stephen Rothwell

--Sig_/XCS2Nje.p44kZ2wwKL5rGSJ
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlwW4vcACgkQAVBC80lX
0GwD3Qf+IWmywzDEtcSTYYRRQjkJtfpz/WxgN5Kv1rBUx+BR43o6IDkHUiWl77D/
6Cpz9MivIYu8wJ6JxrX9njXiI3oHcGXNjpCItwpM7L5J6mdYY3l1idD6P6FRvg6b
K6k8ZVvIOaBKiNN4dl7sBq1RggAudn2jiiAv1SOE0uYBxUXGtAJ0eUBiBXuWj+Um
kmt5W32qR7I11zoODQVMmlDQ2UYGVdSkeLi85JODp9YBmgqXGeUfachG83uyJI1G
G+AbRccI4K1gMy4WGuzobXQRQbzYPzqZWxb4EHNCQQ9TCZTdK/AxR75u7eUxHrcR
Oayh+Ffp9cxH5F67Zc9PWPFeHV15uA==
=3/nj
-----END PGP SIGNATURE-----

--Sig_/XCS2Nje.p44kZ2wwKL5rGSJ--
