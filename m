Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26421C28CF6
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 22:02:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A63420852
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 22:02:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="XCl8K6FN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A63420852
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388686AbeGXXKb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 19:10:31 -0400
Received: from ozlabs.org ([203.11.71.1]:32847 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727673AbeGXXKa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 19:10:30 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 41ZslV16LMz9s2g;
        Wed, 25 Jul 2018 08:01:58 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1532469718;
        bh=FQqpnEtDGC+R20fcXGCidVACetkEMARx2RrqckUnLYQ=;
        h=Date:From:To:Cc:Subject:From;
        b=XCl8K6FNWrWUZZqwMt2oLb+kkWIEMhedLFtEHzmqxnellj/LAHpZEhI2L25POQPIz
         umF0kZ3AVQPCag41sF24gEsipoRn5aynRpqQzkW0YkCN/r2xFMAEBXqHfkZh9SpjNM
         EHc89wRmYCKbz+GuitGIRsEjPS8kFSlT7YUYa+wjDTlnm8P+HjmwD6B8Jhpa3+7OsQ
         cX8fnIVy4f+g+ZgIKV7YL74ORDSahsDQajoaiRaKVNbTlqLY8OaTxC7RNuDUycyYRl
         WzaTmaj13I5GCwWEEt+G6/c6QGDYI5oIVdsKSHZPPahtK1RJmAn3PGc2kBV4X9KAuu
         XJzX52UNOffRg==
Date:   Wed, 25 Jul 2018 08:01:48 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Steven Whitehouse <swhiteho@redhat.com>,
        Bob Peterson <rpeterso@redhat.com>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andreas Gruenbacher <agruenba@redhat.com>
Subject: linux-next: Signed-off-by missing for commit in the gfs2 tree
Message-ID: <20180725080130.314f62bb@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/TChpm2LENT3iuU=bFJQ2Pto"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/TChpm2LENT3iuU=bFJQ2Pto
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commit

  b6fbc2f6a686 ("GFS2: Fix recovery issues for spectators")

is missing a Signed-off-by from its committer.  It was rebased.

--=20
Cheers,
Stephen Rothwell

--Sig_/TChpm2LENT3iuU=bFJQ2Pto
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAltXocwACgkQAVBC80lX
0Gz2egf+OGZHpGo6wSjW18zdjZvhVrOlbUtwx63q1wqeT0EdBiBBfOo+vtdbhsu4
+jKEift45lgJcQS7f+3qHooJAw88RZibxJnMSeexWBJfHkLlOUWVFQ75XAeH+AMe
y1bcxOBt3QZ3QBqdK8apIPH+K136/erpNyHMTYEylTqwJx5Hh79JsUmA5iV6cKcz
1lLFcDxkgt3202FzJ9z50C7R475X+97ZTyjJG9/b4o7jwDY9nFcRzFORfFpBo1Rz
BoxLikn/vCenAK2Yt6GaN9d+D8j3ltzRUmxMsWXsVS68+nywq2y/yJK1tzzNrAQz
eF7KMBWJn6S5FFDl5p9/qTFb2rIgFw==
=By1M
-----END PGP SIGNATURE-----

--Sig_/TChpm2LENT3iuU=bFJQ2Pto--
