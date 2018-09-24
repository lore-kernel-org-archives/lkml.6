Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1A94C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 02:50:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9830D20676
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 02:50:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="nJvmUHFX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9830D20676
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727351AbeIXIuR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 04:50:17 -0400
Received: from ozlabs.org ([203.11.71.1]:35957 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726134AbeIXIuR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 04:50:17 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 42JTG21jQDz9s8F;
        Mon, 24 Sep 2018 12:50:17 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1537757419;
        bh=xFtG/z2lwMvx+7+JpbLj3ZSkG8aA87FiIiluJ+QlhsE=;
        h=Date:From:To:Cc:Subject:From;
        b=nJvmUHFXdHCvYARVvUJwahCEkoRYJOyLOYo+SWpw96yzd1bphtYjLMiidb/8ZmPOv
         6cTYm5SfZewZJJDr0nuJH3gCuE41QlBz3K7QXm+iGQo2Acjf37SidT2X6e8sbb6/Dn
         n+MY7iBKc5B8Up3KMijrYi7BFGdrUB8kZEb0mZRLoIy40Q9k6gYhDdHtjgXh2jIzip
         7vk64R5D6nDbHiyxMoL7eYm71XWoPtrvY7Ef274JXrpOzt6hEIAIIlAvA9Ji358B5u
         a+Vy5jT7Kif2xqr0a9HzA1rCJbv/VZw/HcZ04DpZ5Un/XhkRUmHSNvfqXWgjdaRL2k
         b8e6MfVUmYuWg==
Date:   Mon, 24 Sep 2018 12:50:16 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Greg KH <greg@kroah.com>, Jonathan Corbet <corbet@lwn.net>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Henrik Austad <henrik@austad.us>,
        Vladimir Zapolskiy <vz@mleia.com>
Subject: linux-next: manual merge of the staging tree with the jc_docs tree
Message-ID: <20180924125016.0f813c15@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/Nax6AogWKQOopVOtT.+TSns"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/Nax6AogWKQOopVOtT.+TSns
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Greg,

Today's linux-next merge of the staging tree got a conflict in:

  Documentation/filesystems/00-INDEX

between commit:

  a7ddcea58ae2 ("Drop all 00-INDEX files from Documentation/")

from the jc_docs tree and commit:

  a779df303b05 ("Documentation: filesystems: remove reminiscences of POHMEL=
FS")

from the staging tree.

I fixed it up (I just removed the file) and can carry the fix as
necessary. This is now fixed as far as linux-next is concerned, but any
non trivial conflicts should be mentioned to your upstream maintainer
when your tree is submitted for merging.  You may also want to consider
cooperating with the maintainer of the conflicting tree to minimise any
particularly complex conflicts.

--=20
Cheers,
Stephen Rothwell

--Sig_/Nax6AogWKQOopVOtT.+TSns
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAluoUOgACgkQAVBC80lX
0GxdwAf/eiDP/hlxrfhd0FbfGjuwZgVwSO1TwW0DEuDGSqzbA6pU5iocXGLVKd0I
66nGn57PSU74y4vVvVzJoISdLg0vKbp0DFzX5+NYhOMit7Q3DehEXPfuyJEUus/a
Z0FYFKR4qazpuxIfZrXEhLDyQGb5fDgLoRGD2Zm5EoBagr7//kU6vScae0MadqgB
WBHzeuK9lGhTikzJz4Zt8WWSZXPmNlB5CstQqfTzFd6OqW+8LyE7sLo4MxEXrudo
QQexcCPbYNWfIA62+/hoPYzSTEGC0ykQy3g76TBYn31+QcdWemOaqAcN4ymnV+BC
SOtyFu2JvIL3YW/l/gIB+aLQEoN2Qg==
=zv56
-----END PGP SIGNATURE-----

--Sig_/Nax6AogWKQOopVOtT.+TSns--
