Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24C3EC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 01:03:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE96C21773
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 01:03:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="JCxIdsxh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729314AbfBTBDK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 20:03:10 -0500
Received: from ozlabs.org ([203.11.71.1]:33337 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725616AbfBTBDK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 20:03:10 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 443zqZ4G3Gz9sDL;
        Wed, 20 Feb 2019 12:03:06 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1550624587;
        bh=pYgF2ugoyKdsMfPwa6mIyaEapstayKkh2plBRQ0CNnU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=JCxIdsxhuiWXm60cZs6XcGoJRRaXBunZa9ZvzEgBG66i9RwTI3J81wzFaJaIMHIg9
         68wRLaswj3N3rxfy+Rfbs38SErWHk8LifldLR/CYS4eqZNvBps23uvgpsHvl+cU+kN
         TRvpK+O3erg1VQWyNBftI8FgGQ+YlFyCveyY6/BFN+G4w0tW+cIFYJkQ0qJxWYJTGY
         GTnAhafkPcsboNouBCf2F8GpUqyCkc6sWbgbh6ukzqmSbFFR/9J8dI3FV8hGF5cz03
         u/buPRRLjnI6t2XzKBYoqLBUXHMgcaKeW6CXImuSkS/8NGaKvd2okYJnhMWlXuYlPZ
         HBz2riaC8S3dw==
Date:   Wed, 20 Feb 2019 12:03:05 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Stanislav Fomichev <sdf@google.com>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        David Miller <davem@davemloft.net>,
        Networking <netdev@vger.kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: manual merge of the net-next tree with the bpf tree
Message-ID: <20190220120305.3c22596e@canb.auug.org.au>
In-Reply-To: <CAKH8qBuoYKPMhHn6Xzo=nEBevBt93c4+9cAVW7BZZwpNj46SCA@mail.gmail.com>
References: <20190220113729.49f28f73@canb.auug.org.au>
        <CAADnVQK3qg2k67LRiOqDmFnELrFOD1dLkrNbAvbMyu6xGpjBLw@mail.gmail.com>
        <CAKH8qBuoYKPMhHn6Xzo=nEBevBt93c4+9cAVW7BZZwpNj46SCA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/RTVdESC3lpdA4KPdqx2fHd9"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/RTVdESC3lpdA4KPdqx2fHd9
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Stanislav,

On Tue, 19 Feb 2019 16:45:46 -0800 Stanislav Fomichev <sdf@google.com> wrot=
e:
>
> OTOH, I don't understand why is there a conflict? bpf and bpf-next
> adding tests in the same place/file? Those can be trivially resolved
> when bpf and bpf-next are merged in the next window.

Yes, and yes :-)

--=20
Cheers,
Stephen Rothwell

--Sig_/RTVdESC3lpdA4KPdqx2fHd9
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlxsp0kACgkQAVBC80lX
0Gz2rAf6Av4sWZUHyBHAV1e84+jXQzEnf5E0p2RShtk2H6Rj03n3BbfULRDvHi0H
vSuRh4rvkruNLBKSMcJZrL49MhqgXFUJLziuwag5NL77pnlDky7oMe6UYU/Os41l
Y7jpK4KfHNhGQxgKZL4La1FdEmbWcCw6EfB8RnHXggGaXuqKlJDhxbECd6x4pUgT
hkrUE5SNOihrVFPbw4a+V8iX1EqXVpLrX7nLfiYsMH7IaJKYxgVzgp2/qnTKXs9M
MEVliOho+9Ejy+WiTTbdYDPLVSZg8V/CKRzcpD4aec3PSy9oXryCUAwI/BVT0kUv
VB8mGov04T3qkoSzFcP0B0ZBIjrgLw==
=23Cb
-----END PGP SIGNATURE-----

--Sig_/RTVdESC3lpdA4KPdqx2fHd9--
