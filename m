Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B06E1C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 02:23:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7845A218CD
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 02:23:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="p8SoeXK/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729763AbfB0CXS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 21:23:18 -0500
Received: from ozlabs.org ([203.11.71.1]:40853 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729527AbfB0CXS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 21:23:18 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 448KGq2rDYz9s21;
        Wed, 27 Feb 2019 13:23:15 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1551234196;
        bh=FlH4HojZU0i6A723nCkBETUQRZi22KQCHn0/1+dTfKw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=p8SoeXK/sme50tE4YuYL/CaXqWLlErp4vk+i+RJcGec9VOs+eIaF09kRvd9vs6E7n
         siAW1Th+ln7c1QxFc6G5UggFKUQZnparwOF+L//StMYaMZ+RXJ7aNMFE8cmKqdMFzQ
         3Qor2EFAjdaj8NWNRcHdOy0ipEVzVf/MwtFiplCeN/fIGAVWnNTZaP1k3MBMoIcCFm
         +pSpRSAQPzJIYx1rmIy5qIEGNzCiNNUCtddeTiS1JXS9YUwH28HUZpncL/c8q6ODkn
         OsXFrM0El4ZNIil6DTbY1MojbXgy4HqXVkIWut9Ot6k526Dih2EI4Xl+qT/bVJgCSY
         rL502AU/if/xw==
Date:   Wed, 27 Feb 2019 13:23:14 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     tanhuazhong <tanhuazhong@huawei.com>
Cc:     David Miller <davem@davemloft.net>,
        Networking <netdev@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        Jian Shen <shenjian15@huawei.com>,
        "Peng Li" <lipeng321@huawei.com>
Subject: Re: linux-next: Fixes tag needs some work in the net-next tree
Message-ID: <20190227132314.16dd9257@canb.auug.org.au>
In-Reply-To: <0788736a-dfba-edd1-f62d-2205d6702f4b@huawei.com>
References: <20190225190034.0cad4e3d@canb.auug.org.au>
        <0788736a-dfba-edd1-f62d-2205d6702f4b@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/v5Gv7/8/PvwYbgq2qPELyxu"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/v5Gv7/8/PvwYbgq2qPELyxu
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, 27 Feb 2019 09:12:57 +0800 tanhuazhong <tanhuazhong@huawei.com> wro=
te:
>
> It is my mistake, so sorry about this. There is a redundant "net: hns3:=20
> " in the fixes tag.
>=20
> How could I fix it?

Since Dave doesn't rebase his tree, there is no way to fix it (and it
is not that important any in this case), just use this as a learning
experience for next time :-)

--=20
Cheers,
Stephen Rothwell

--Sig_/v5Gv7/8/PvwYbgq2qPELyxu
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlx19JIACgkQAVBC80lX
0GymYwf/WnsyKFMcu0U5ZauVBV5cU51Tmv1UVIhWPZfKsG9U9pl/FkEYSB1Srnwx
JIdTRT+1B1weSJmVdoqGrby7T5OJY0u094Nrv2X2O3z8kVItWT4Xqk4u3+dxlkNI
c3cQEJA8waAzLwos4d9BZjcv8JKhTYYOtZ6e0yiok6h2+/Cqqku6oNQB6YvAX32i
RlsKqQz+MFX+X+uWI2YUZEuZ/E4762bHkF9AtuuGwWNASn9D39w7YfyZQane6dxY
AKpDPSByAKY9W/ctofwy0/IvbGEN850xZ5iItKMJ455KcjNcN/fHVz2/uxg9F1+o
zuuyblSK4Hl/2TBWzQsLlyW45hH0sg==
=HzPf
-----END PGP SIGNATURE-----

--Sig_/v5Gv7/8/PvwYbgq2qPELyxu--
