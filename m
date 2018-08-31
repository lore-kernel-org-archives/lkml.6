Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA274C433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 19:08:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DF992083B
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 19:08:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="ZHDCItZi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6DF992083B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727389AbeHaXQu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 19:16:50 -0400
Received: from ozlabs.org ([203.11.71.1]:50123 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726704AbeHaXQu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 19:16:50 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 42285960fTz9s0n;
        Sat,  1 Sep 2018 05:07:57 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1535742478;
        bh=s1ID63hbcPX+Mo+Au1h7kcBpsl2U3YX+0kPvLU4Lprk=;
        h=Date:From:To:Cc:Subject:From;
        b=ZHDCItZiXpF7NzhoDz3/J0Q2uyUUaNnfHQNQxKVR3rdGJavC89FOU+uMiPmlwvxs/
         UKFhtZ7XPTUphiERpFlKeEKtQZQpgK9w7PJm1FFoBPI2pI6qxKfpoxpZfojj30ES6K
         sbDnrjc7Q3ers714zkEANzKYciuDisLgqwiaWz9VtOXF1QuDqB0r3P56cXyIY7D2Wf
         5V0TeYOz522P75N1RAnz1vA42PxcMgYEWunZqEKTRXjQsmhnxCV/l/JfIG/tHeNxvu
         9pphXYEvjgykijwDwNDBOT5Ev1VQsYpebDi4FlZJVd2FxBP0K0CsDPxsR1uywcWCl+
         G+uezAbK/avQw==
Date:   Sat, 1 Sep 2018 05:07:51 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Networking <netdev@vger.kernel.org>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commit in the bpf-next tree
Message-ID: <20180901050751.3714fc63@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/F9cPL1urc81lZiOWy+5JsAQ"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/F9cPL1urc81lZiOWy+5JsAQ
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commits

  0f93c3995c93 ("bpf: add TCP_SAVE_SYN/TCP_SAVED_SYN sample program")
  9452048c7940 ("bpf: add TCP_SAVE_SYN/TCP_SAVED_SYN options for bpf_(set|g=
et)sockopt")
  175eba5962b4 ("xdp: remove redundant variable 'headroom'")

are missing a Signed-off-by from their committers.

--=20
Cheers,
Stephen Rothwell

--Sig_/F9cPL1urc81lZiOWy+5JsAQ
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAluJkgcACgkQAVBC80lX
0GzncwgAhyqs4LlNWeLLMxSbNv6XTZZ+ls3ne/1g5cSze2vthwLoibDerx6QJfDw
9ljAbM3gWVKMduW1wzllNooLNB2CtUaFMXQHOahj0UxqCqsCMUcW2AhuK3iazts+
A7VvybUqqN1ilkumK6QQjdp0zyBm/KClco2meD+IOYENKTcsTD6AkDHTF6C/hM2J
9vLV8uNkPVuwjxRcDJn649jGeJFk9xbKjb08BqTKo1iKU/+8Thn4WxBLqzR5oKlI
GBAVp8bqYB8+cJEqj5+20ysleGrHT6qlSVBuwIKOaWQEIMjXQMcuGt0/r+x9CpGl
O1UqqBZzrW+k7TinsNTUgwgXfddJKw==
=RWQq
-----END PGP SIGNATURE-----

--Sig_/F9cPL1urc81lZiOWy+5JsAQ--
