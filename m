Return-Path: <SRS0=A0hX=MM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56544C43143
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Sep 2018 01:24:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05171206B7
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Sep 2018 01:24:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="DhDV3HLU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05171206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727510AbeI3HzH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Sep 2018 03:55:07 -0400
Received: from ozlabs.org ([203.11.71.1]:38793 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726494AbeI3HzG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Sep 2018 03:55:06 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 42N7450Lbdz9s4Z;
        Sun, 30 Sep 2018 11:24:20 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1538270661;
        bh=srAdO7QBnLw/EqKnFzjDaVjJ0xnfptiltRsgR0OQA3A=;
        h=Date:From:To:Cc:Subject:From;
        b=DhDV3HLUkmk6jbkJDQAGerVygwteWsSvutsI/NxpN9n5rFT3HmIQFUW9DiJX5PcrX
         czSQ5S3HWrWZfQsnsJq/+KUot/ViUwYvkVINi8sKcpEDJ/Pflez2CXCqfe7Y4oCf49
         KPvLNAX/r0GU63znx7S8vHNfdtJa5Bv/0AgOvZK44oaK4wI29YqNatZCMmNPJp5G0e
         T6xkqGrdb7ksTpK+dtN6g1kx6G6JIM2VbROeOMdZntNgE9RVRec4MJZiurei+KvwXs
         umVG0SRa1h/PgceHzCF46lBZQyJovQ1VkvEXqJRqYUANaJrK37mxw8vvEbqMSACepl
         ElCetZk9TJRBA==
Date:   Sun, 30 Sep 2018 11:24:19 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Daniel Walker <dwalker@fifo99.com>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: commits in the cisco tree
Message-ID: <20180930112419.6f880e46@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_//qGmaqsFQ5PMLlsRT=QHVJ8"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_//qGmaqsFQ5PMLlsRT=QHVJ8
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Daniel,

I noticed that you have added some commits to the cisco tree today.  Just a=
 couple of comments:

Fristly, commits

  734245aec283 ("This code allows architectures to use a generic builtin co=
mmand line."

and

  b17f223f16f2 ("This code allows architectures to use a generic builtin co=
mmand line.")

are identical (though in different branches).

Secondly, commits

  2c070709ea75 ("his updates the x86 code to use the CONFIG_GENERIC_CMDLINE=
")
  a5c4647c26da ("This updates the powerpc code to use the CONFIG_GENERIC_CM=
DLINE")

have no Acked-by or Reviewed-by from the repspective architecture
maintainers/developers.

--=20
Cheers,
Stephen Rothwell

--Sig_//qGmaqsFQ5PMLlsRT=QHVJ8
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAluwJcMACgkQAVBC80lX
0GzQ5wf/XmpLoVLGS+Fg31oFfgiUGBilsDrDifnKe9krSvv0JaA8GuXhOzNdW/a6
gMOYFLE2xz7inMOr7D5sokjGZR2hHYANscl002qXzeyIwnO7jNthsLPsUQppK66j
sGuP0iD53c7sdo55AoEOfvK7FcRw0syr/ZAJgwV+NUedRi8d5dbMkyLhKFPsdbsm
+nb3FL1h3ly2aWaK1psUo3RRQM0ZIHQoz75jD5+VLFcECNwzndYeg6PCMXOQ+fFX
s59VsPSubOa0pKEHqJULFPEm09cR0dXVDHh32cnFUDiQKF9tt/Uy9gcjV3ZHKQ+l
ivgHXJegY1bq4GR5X9lpCLpjYU6Kmw==
=88q2
-----END PGP SIGNATURE-----

--Sig_//qGmaqsFQ5PMLlsRT=QHVJ8--
