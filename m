Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751890AbeEMV1g (ORCPT <rfc822;w@1wt.eu>);
        Sun, 13 May 2018 17:27:36 -0400
Received: from ozlabs.org ([203.11.71.1]:43669 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751153AbeEMV1f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 May 2018 17:27:35 -0400
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Date: Mon, 14 May 2018 07:27:22 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: another branch for linux-next
Message-ID: <20180514072647.24ea383b@canb.auug.org.au>
In-Reply-To: <20180513070359.GA25669@lst.de>
References: <20180513070359.GA25669@lst.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/rDbnTC=vvAP=wInwvoB6kTU"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/rDbnTC=vvAP=wInwvoB6kTU
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Christoph,

On Sun, 13 May 2018 09:03:59 +0200 Christoph Hellwig <hch@lst.de> wrote:
>
> can you please add the for-linus branch of
>=20
>    git://git.infradead.org/users/hch/dma-mapping.git
>=20
> to linux-next?  You already carry the for-next branch, but it turns
> out I'll need another branch for late fixes so that for-next can
> remain unmerged and unrebased.

Added from today.

Thanks for adding your subsystem tree as a participant of linux-next.  As
you may know, this is not a judgement of your code.  The purpose of
linux-next is for integration testing and to lower the impact of
conflicts between subsystems in the next merge window.=20

You will need to ensure that the patches/commits in your tree/series have
been:
     * submitted under GPL v2 (or later) and include the Contributor's
        Signed-off-by,
     * posted to the relevant mailing list,
     * reviewed by you (or another maintainer of your subsystem tree),
     * successfully unit tested, and=20
     * destined for the current or next Linux merge window.

Basically, this should be just what you would send to Linus (or ask him
to fetch).  It is allowed to be rebased if you deem it necessary.

--=20
Cheers,
Stephen Rothwell=20
sfr@canb.auug.org.au

--Sig_/rDbnTC=vvAP=wInwvoB6kTU
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlr4rboACgkQAVBC80lX
0GzbDgf+N2q6CEXj24QIutHkZmjtZxFARUqvhLMEY0UZ8EFMttFKg5e2uSz7UArm
rZgl68rDxIpjDLcRkuZfb3wwzvIRxXgyFitiY37Uui4+6Byn1qqg6ZpIreZoLO1y
zKV9ixM4AhCPBMrA6StoEcIkVoaSJkt9KYgCQh3llqg5ze1GsMe7ftUGdNtY6N34
6CZUG/ix4MWF5X+rjeYpquj2DDEa9blzshPB1gAWBjaNVCdjuZUw7EF8vjtCtl0F
6iSBYd4r7bqsgnBj9Ox1jEarcRDGfVfSftiqOjMB2mSlgsy16fU9PfyoyTfuRaRu
m3AQwDi20ZH2JJe0UuJAsh7CycTHjw==
=iroy
-----END PGP SIGNATURE-----

--Sig_/rDbnTC=vvAP=wInwvoB6kTU--
