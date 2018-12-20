Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63DB8C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 05:15:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C7B220869
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 05:15:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="tQCuwu2P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727767AbeLTFPI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 00:15:08 -0500
Received: from ozlabs.org ([203.11.71.1]:37521 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725550AbeLTFPI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 00:15:08 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 43L0Lw6yKwz9s55;
        Thu, 20 Dec 2018 16:15:04 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1545282905;
        bh=gsvPkWilmOPjvMrm3Hrh2CDhzPnzg8B2CRQQ2nim6dI=;
        h=Date:From:To:Cc:Subject:From;
        b=tQCuwu2PkrXGl00nLjDHLRaEfa9fz9ysCrdLj5cgUFZznTs9qNe6HoELf7iYkWMZN
         HoEUF0cAKX1D0V/BYibET28Ih7mjNbzX8PKGAzzUxu1urbgrsH2BdWbF+Qmv8Eok/S
         kaPCJVhxh7s5hQoIn6ZnO0zvKp91usSESfnQ6q0Z6UWrPCLS5+LLYI4ROCwj35Z34a
         rqL0DJ+PQfk1UszBSDnkVjrRh5vLZwTcUR8Oh8SBMsfp+759ovZUnSMpqT+98ZMsMh
         adVBYDmHdZzrbPQcDb6sWmXoYi0Dlm10U92cCl0XEVGXIsdh4Ame1hrEpKib+NlEzl
         CSbx4OZk39TPw==
Date:   Thu, 20 Dec 2018 16:15:04 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: please clean up the clockevents tree
Message-ID: <20181220161504.5720655d@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/4VGc=Tb_93BTw6nAOYJHflC"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/4VGc=Tb_93BTw6nAOYJHflC
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Daniel,

It looks like all the changes in the clockevents tree appear as other
commits in other tree(s).  Could you please reset your tree to somewhere
in your upstream tree as it is beginning to produce conflicts.

--=20
Cheers,
Stephen Rothwell

--Sig_/4VGc=Tb_93BTw6nAOYJHflC
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlwbJVgACgkQAVBC80lX
0GysJwf+J8nNuww7oF2nE1vVqf8nTxsXJdGwljrzV5y3w+yGVDgatX9zGqVEp6ma
BFzhT6k86jqGCJPoHsUcvD/ay/WY7kK41BEjLC7T3TjJ5tGrKZWo2nDNspz1AJdp
SzH//UVkTpxYbzMF2j4HvQ+cGbHi4vd2/CByeC6LCZK8vvRH8dp2ZfqPOcsq2XES
ps5igdaKgK34qwCKyX91ibzebUSvp3nsxnP4VCFrQr2gbbrjyQOl6p+MyqIFtGjx
3r0GuEI2goNj+hAWwut+n44aKpc2Iyc1vUtMIIRWXbjK/bDYMD0zwsPNdSUiqVoS
MQ5WXiHrGPGJiU8Z5AiqnLy3yR+tww==
=6/8l
-----END PGP SIGNATURE-----

--Sig_/4VGc=Tb_93BTw6nAOYJHflC--
