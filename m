Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BA82C6778F
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 21:28:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C24D20843
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 21:28:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="i8P2kKvv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C24D20843
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731470AbeGYWmC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 18:42:02 -0400
Received: from ozlabs.org ([203.11.71.1]:41985 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731279AbeGYWmB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 18:42:01 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 41bSyM2lgSz9s1R;
        Thu, 26 Jul 2018 07:28:27 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1532554107;
        bh=FNZFtjooGOLSLxXzJntzjFMUyxf16pvs2JRejqVsCs0=;
        h=Date:From:To:Cc:Subject:From;
        b=i8P2kKvv6zWOV1M6q6iaJhAyWcW91XP9VYZ0yZrwODwxVmIbNQzIGF0xOTgSFNPI7
         uj6KwAmDUf9twTYB1BBxRiIeqUOZsim4di/lG6DVVehb9n2DN9qJHSkcuACjH3MT7z
         wdYCkjW17zkqpc64QvQXZh5Z0FQ4iVHeax4kiDCjRyd6RpIA9xVGH4k/3GohMPvy6V
         StARGl0e3O+kjESx9PCDDQN5WF7ZD37uw1jQIdF7Q2PEZFG/AXN5tJFAD58zHZluvd
         EQncUQZYLsPJ3xa+PAPFPpDUMxWPRSWtrY0y53DPRjNyBg99dK97fjlqPD6cNI29Xk
         Mz5GLGNiuucrQ==
Date:   Thu, 26 Jul 2018 07:28:14 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commit in the xarray tree
Message-ID: <20180726072814.6c93b595@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/Vm_6vJYZTTbayswZvaOkfr/"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/Vm_6vJYZTTbayswZvaOkfr/
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Matthew,

Commits

  890e537e2b42 ("filesystem-dax: Introduce dax_lock_mapping_entry()")
  aaf149902c79 ("filesystem-dax: Set page->index")

are missing a Signed-off-by from their committers.

--=20
Cheers,
Stephen Rothwell

--Sig_/Vm_6vJYZTTbayswZvaOkfr/
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAltY624ACgkQAVBC80lX
0Gy3wQgAoDOpjXXtT0fQe7X5GJZuSDcVlhJJUEXr+WQPx6lwI2f71RFahRs0qSmf
E1tIsWT4SLL1XSKSf+aLcX4rDeWHh02HSHzVcssxOPDlOgvWthu8Qv1f+v5IcaNH
2EDma2C2vD0l2Zl1QDGBFyHxR/kIaD/qXr6wBQcB05u8oRqsvM6OegTlfXB5mfy0
6O97fKxQgLzE+xkrZMQ4b9HNio+jT7fsL9AGJ94GkGI2BzthgCL4ySpJWXQsi05c
GJLYO1p2QSlzUIxze3EeGq7uLMk6iEoXpbNhJcc8i122LLBZGf9dId8+r8jBdtti
Hdx3C/E99aexCkCTGcaiUdCNkjeoww==
=4p+l
-----END PGP SIGNATURE-----

--Sig_/Vm_6vJYZTTbayswZvaOkfr/--
