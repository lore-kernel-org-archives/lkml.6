Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D383C0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 05:55:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 007E320819
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 05:55:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="pdFGqVbo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 007E320819
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729292AbeKEPNb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 10:13:31 -0500
Received: from ozlabs.org ([203.11.71.1]:36667 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728985AbeKEPNb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 10:13:31 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 42pMNM2dpgz9rxp;
        Mon,  5 Nov 2018 16:55:31 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1541397331;
        bh=Hw3zJ5DJhNjD6O9pJiFlZCf0BhWtqNIl1I8l+dFTPUw=;
        h=Date:From:To:Cc:Subject:From;
        b=pdFGqVboO9JnYI1161fEgifxU3aGn84S6s29FD5+LtjnrxLroz0NM/VIvwWeX0Zfk
         xoQkEgWfw00lXz/p3aa/2pF0fJgpMnv/I/zz/iwWnNdqQYhtp9+HEEcDE9gdT13unM
         4a63QOWpX3XfZNUj155lOn6ZjU6i4c/J/O1y+HSRTwSth4nXpHzOY+O5szsJVtqW2g
         prj7HiUiRqTfpry5OLd0jMJZU0aY4zIsmyCJej4NxKQiPCuDnOP+2NmdxN+kHX0lHY
         hxPpks6yZardrPsJFUB8XPxfc/mHKfGo3OA27B6xsb7dj5N86ag+kgPeQ5ZoJltsYS
         ZnwoJ1Jq6qSQw==
Date:   Mon, 5 Nov 2018 16:55:30 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Steve French <smfrench@gmail.com>,
        CIFS <linux-cifs@vger.kernel.org>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commit in the cifs tree
Message-ID: <20181105165530.05bb84d4@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/w/k5aj/uCU24D2s9=fA2aZW"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/w/k5aj/uCU24D2s9=fA2aZW
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commit

  bf4d4ba7d970 ("cifs: update internal module version number for cifs.ko")

is missing a Signed-off-by from its author and committer.

--=20
Cheers,
Stephen Rothwell

--Sig_/w/k5aj/uCU24D2s9=fA2aZW
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlvf21IACgkQAVBC80lX
0Gy5bwf9G1zmT+TqSzCknj1YBEs32xjDVOru00NM9YgILWTEo1809WCZxW5CLPrY
3CC1gGWiQvWDrTaRSRN6F/RUdA0UvIITC28vvGevgVjh+qX7QhGGhbbYiSwWQ+He
oqF5dTZaAmKnVkvq0x1YFsp0LRQGUGAISXA04a35gFekPjdozTFXOtvyfLf4LQ7X
scwUC2drM+Mzz6wsbbwZ+HsU+/KMdbGIU33nfUnE2/52lLbos9YpUqpHRwMsE26m
QqvluXq5lLfOKuVwhBaQYP6VkRq0+QfhyUyXOqYUkoHk8Et/z/73aHdQ7QiadsAx
XiKhU+No3W2EicyI2LouhFg6Xzvh+A==
=Z21O
-----END PGP SIGNATURE-----

--Sig_/w/k5aj/uCU24D2s9=fA2aZW--
