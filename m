Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1085BC43142
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 20:45:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF96720857
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 20:45:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="gFDoZqsf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF96720857
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731606AbeG3WWT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 18:22:19 -0400
Received: from ozlabs.org ([203.11.71.1]:59427 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728746AbeG3WWT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 18:22:19 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 41fWmY03VXz9ryl;
        Tue, 31 Jul 2018 06:45:32 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1532983533;
        bh=iHkQFkrDuqY7fgti/Y3U5sCVLVQbk7TESWlHIzCzDgo=;
        h=Date:From:To:Cc:Subject:From;
        b=gFDoZqsfLJ6bHA3RjmTmIXbtyhi8oWVT9bK/fBUX1TVrGGz0Qj49xd84IjWmu2/Xa
         /XbQ5ewKJPf/ZBtLthRen4dWKK0WcbRSo/j3q8FQjiJltfxafCHEwbTtobjFrxrB7w
         /85W8+Q8vtUx6hJ5ZYIvry9Wzkrgqh6eRzyXp6bUVyGPhW7CWn9AlrF3aca6ba4Zl3
         lOyblh4axqwVbixq4+zRY/ii+onhLSMSGPgGGS8Soax6mht157FwsW83z6irFyFWnT
         QbLMxHM22OgJLF+YAtMjA4REN3bvY93SmErYW8SggyMn5WbRlCrIFdeIsbKmPlMYIv
         4dYZautFZse1Q==
Date:   Tue, 31 Jul 2018 06:45:26 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Christian Borntraeger <borntraeger@de.ibm.com>,
        Cornelia Huck <cohuck@redhat.com>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Janosch Frank <frankja@linux.ibm.com>,
        Dominik Dingel <dingel@linux.vnet.ibm.com>
Subject: linux-next: Signed-off-by missing for commit in the kvms390 tree
Message-ID: <20180731064526.4610e416@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/=pLY+Bs6uWaKtBdewsNVOCs"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/=pLY+Bs6uWaKtBdewsNVOCs
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commit

  47dad49df4db ("s390/mm: hugetlb pages within a gmap can not be freed")

is missing a Signed-off-by from its committer.

--=20
Cheers,
Stephen Rothwell

--Sig_/=pLY+Bs6uWaKtBdewsNVOCs
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAltfeOYACgkQAVBC80lX
0GyJeAf8DzTyV7ZBzUaBmqHBmVuaD1x1Nrz3xoe4KTyDocqqTnROhm9DF8WQeObe
DCsQ2GZggELZzv3b+IL8F96NoXfWk+s7EhhWDQI4ySmRivbLf9+Y9RSWEQ2JQftJ
/MkBDuRPxF6d+NdKjmfub6Wo3u8OYXnxKyMMy3NHfEkvvr06UHYOCywVmcIzeqHC
8RPjwEBIQSZSH9IWSD1NWGBAhkqgvkI5RwOiRYpJhJ1M68eBbVuUBA1OyN3b4V79
nnJeYNN8xQK0TuBslBTSvgE25QBNnBxIcITgbq1jAlj7wXN9Lim5nHTV38BrrONy
VcY1RiCKjC9PJeG7LMVI8CgwP/TPMQ==
=c9uf
-----END PGP SIGNATURE-----

--Sig_/=pLY+Bs6uWaKtBdewsNVOCs--
