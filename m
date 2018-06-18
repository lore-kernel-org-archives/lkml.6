Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C1B1C5CFC0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 03:49:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5721120836
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 03:49:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="Kx5QaDBA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5721120836
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754686AbeFRDtv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Jun 2018 23:49:51 -0400
Received: from ozlabs.org ([203.11.71.1]:58869 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754659AbeFRDtt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jun 2018 23:49:49 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 418HCw1RMkz9s2t;
        Mon, 18 Jun 2018 13:49:48 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1529293788;
        bh=CLNCwms5MVSzEOmuYy5e2v6wxC6QCo04PoEnY5e0ntQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Kx5QaDBALkoH3OXCeC+NmLFpkIWHbL8hjab3yaL8mNpZn7umjGyXYjxQ3JImQ+xo2
         Bwj35OleKzzfoklHJ5qTg3q262Ly2rCHEbguE4vCTYVoq23mP/9W0STiAsnhWLy4Wh
         L+gOA973vTsaOE5sg+SUalUqFwDEBNblbfdHFwkNJmnaz2O9gS0GWSDYH2l+kORwYi
         Q6vhrMyRqp00OrijtuJw4pIy/iFozQJs1pDTzZDkNi/XADxXoN7GPeoznDltOtNBbB
         k9SJ0qmr6I7qz+o+c7jt0ulPW8RKK4Xl+3THQDFPRxFN1auvp9EeZWIbG8J+3GRhwJ
         yuP87Gkv8fbYQ==
Date:   Mon, 18 Jun 2018 13:49:47 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Joerg Roedel <jroedel@suse.de>
Subject: Re: linux-next: manual merge of the rcu tree with Linus' tree
Message-ID: <20180618134947.477f662e@canb.auug.org.au>
In-Reply-To: <20180618134849.70831fe2@canb.auug.org.au>
References: <20180612104607.69f6f15b@canb.auug.org.au>
        <20180618134849.70831fe2@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/MqWTI.PpNms5ZpCj14pfo5H"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/MqWTI.PpNms5ZpCj14pfo5H
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Paul,

On Mon, 18 Jun 2018 13:48:49 +1000 Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>
> I am still getting this.

Maybe this was a bit premature :-)

--=20
Cheers,
Stephen Rothwell

--Sig_/MqWTI.PpNms5ZpCj14pfo5H
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlsnK9sACgkQAVBC80lX
0GzkNwf/QgokYhvDv6eblWRSege3EeDfobTxYPg9gzh5OfzK1mnylliY39FtPrdO
cgKW07RGLx3jzLlgB/IEBLIiKj26wpaosSlDNHlVSXH8XkM8AoAYRD7xaHSXT8sp
fKTakvslqj8YkePtHWF8/KEYrhcmRbqrNJ854SPRpfZYvfq0NazlvMEykXRvQ7YZ
hU+NyM2BZxJJ6glfN+97xtW4twJxLAzXH4MpeS45+fPPWpEkMt7hsZ9Hi0kVB4gg
RGHCFyRBH9fyInCs2/yQYE/0rsB6ms/xXlxD9WJRReHmCzdcnvorpeFYzegRFxYs
Lhg2GB+VsFY598VeWqMaUubTOZLutQ==
=jUQ+
-----END PGP SIGNATURE-----

--Sig_/MqWTI.PpNms5ZpCj14pfo5H--
