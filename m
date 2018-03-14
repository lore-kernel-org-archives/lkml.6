Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752333AbeCNVAe (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 17:00:34 -0400
Received: from ozlabs.org ([103.22.144.67]:35005 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752302AbeCNVAb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 17:00:31 -0400
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Date: Thu, 15 Mar 2018 08:00:01 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Michal Hocko <mhocko@kernel.org>
Cc: linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        mm-commits@vger.kernel.org, rdunlap@infradead.org
Subject: Re: + headers-untangle-kmemleakh-from-mmh-fix.patch added to -mm
 tree
Message-ID: <20180315080001.3737e5c8@canb.auug.org.au>
In-Reply-To: <20180314121704.GA23036@dhcp22.suse.cz>
References: <20180306234907.8-AwjmNNh%akpm@linux-foundation.org>
        <20180314121704.GA23036@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/aPoZaRBhb+olkSoxQqL4hOl"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/aPoZaRBhb+olkSoxQqL4hOl
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Michal,

On Wed, 14 Mar 2018 13:17:04 +0100 Michal Hocko <mhocko@kernel.org> wrote:
>
> My build test battery says we need also this one, m32r complains
> otherwise for allmodconfig.

Note that the m32r architecture is being removed (the removal will be
in linux-next today) so you might want to remove it from your testing.

Also cris, metag, mn10300, frv, score, blackfin and tile.

--=20
Cheers,
Stephen Rothwell

--Sig_/aPoZaRBhb+olkSoxQqL4hOl
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlqpjVEACgkQAVBC80lX
0Gzx3Af+Inlyl/xzF9D5EbtA+aPow8LnTCsD4gJ4Mwy9HejNQ4c8d71f26KpWPBJ
59/CNGcbcpe/ZbEsW+W+jbMzucRfkdWPoVJK0EGIzUsw+9frrta0KvCUdh0/BDhy
rJRf0ONiX4+jB5xw45MnRewECQrJgHKqjg77TdO45UC4ZUs7JHFCC/40RDIHILxJ
dHhEc7Vk+G+H8YJF3iLtFvr09mmHo6Nvqcl7oOhjCKASNlAg5SiE3W0iibSezBYQ
U3Cs5PIEifiv6FnIlbGTLqj8Ni/sFFJ6w+/KAV3tSwvdzSmVXKS8hLGUTLTEgVM3
yjobWLrjivTa5dfTvfEL6p1IgvGoXw==
=GVzB
-----END PGP SIGNATURE-----

--Sig_/aPoZaRBhb+olkSoxQqL4hOl--
