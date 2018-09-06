Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BF55C433F5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 12:33:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC3572077C
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 12:33:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC3572077C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=brauner.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728538AbeIFRIv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 13:08:51 -0400
Received: from mx1.mailbox.org ([80.241.60.212]:64234 "EHLO mx1.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727757AbeIFRIv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 13:08:51 -0400
Received: from smtp1.mailbox.org (smtp1.mailbox.org [80.241.60.240])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.mailbox.org (Postfix) with ESMTPS id 41A414982D;
        Thu,  6 Sep 2018 14:33:32 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp1.mailbox.org ([80.241.60.240])
        by spamfilter03.heinlein-hosting.de (spamfilter03.heinlein-hosting.de [80.241.56.117]) (amavisd-new, port 10030)
        with ESMTP id ufJwe_3rw0wZ; Thu,  6 Sep 2018 14:33:30 +0200 (CEST)
Date:   Thu, 6 Sep 2018 14:33:12 +0200
From:   Christian Brauner <christian@brauner.io>
To:     David Miller <davem@davemloft.net>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        kuznet@ms2.inr.ac.ru, yoshfuji@linux-ipv6.org,
        pombredanne@nexb.com, kstewart@linuxfoundation.org,
        gregkh@linuxfoundation.org, dsahern@gmail.com, fw@strlen.de,
        ktkhai@virtuozzo.com, lucien.xin@gmail.com,
        jakub.kicinski@netronome.com, jbenc@redhat.com,
        nicolas.dichtel@6wind.com
Subject: Re: [PATCH net-next v2 0/9] rtnetlink: add IFA_TARGET_NETNSID for
 RTM_GETADDR
Message-ID: <20180906123304.l2b3vftqti3wtf3z@mailbox.org>
References: <20180904195355.4695-1-christian@brauner.io>
 <20180905.222750.249661617396939609.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="qaevyjii3mgfpezm"
Content-Disposition: inline
In-Reply-To: <20180905.222750.249661617396939609.davem@davemloft.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--qaevyjii3mgfpezm
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 05, 2018 at 10:27:50PM -0700, David Miller wrote:
> From: Christian Brauner <christian@brauner.io>
> Date: Tue,  4 Sep 2018 21:53:46 +0200
>=20
> > # v2 introduction:
>  ...
>=20
> This looks good to me, series applied.
>=20
> Thank you!

Thanks you!

Christian

--qaevyjii3mgfpezm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE7btrcuORLb1XUhEwjrBW1T7ssS0FAluRHoAACgkQjrBW1T7s
sS1W8Q/8Dn/TLjxpm6c81QVA6yRMe9CG/vxA+13qlyurVvC0eo1aQuMAugU4CXsh
G3AqJwYg5RBrU+OF3h40zEWcj7w5QfmiplMxsyQtKUqFTJqKu/g2uJmhHYujJ1Yl
XVxGgM1kIXDQc3IrHTOQ2RF09yYbfy0G6Q7wlbD7XxN/LvrwfKKaihqjfWgZjxZm
js86s8cpCjYcD3AJ14YmTC1TCO/YCFHVfOGC0acuV8ItjhaCJ+zvDNwSPIRolEv+
lywWL/n7epGruE0LUTvAI0Tb8Ng/OAZOo68cldLknSPYecjlmIo2EtYlC8tp7mr2
5RPmjR/KO3D5kYXCwko/sMxCQjBjDTbr08R3FyonNz5opsfp/bZ8gFaeS4K+0+GL
9tnZ5ZNuufs8TJTgPyMUuOKFKb6wjFfK97AFJCA2eDII0u6uucrJFaMWwLexd4dj
YIHj9gt3mpMgzQw3eIAw/qdqobbjdYBjMEgeWcoFjF6g0mRb/+sll4infoD+qmFX
QayY3qYOy+r+yFElGGt1BB1jZ+5KD6TEpLZ8IuLfEX0PTHlI3tqi/pClZnfEbA1T
3VJg+0FMiIzxIPGq/9PDCPzCLqVaWQIRzXgysErmFVMKl9KihYp60Fn8a06MuFOU
c4DqoOnKlsMt0/yaXgGFSbUg95cOyj7w+jQUYBZOnbuVXU5bWZE=
=541F
-----END PGP SIGNATURE-----

--qaevyjii3mgfpezm--
