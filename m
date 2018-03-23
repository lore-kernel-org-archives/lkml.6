Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753391AbeCWMH3 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Mar 2018 08:07:29 -0400
Received: from ozlabs.org ([103.22.144.67]:54159 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752672AbeCWJ6o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Mar 2018 05:58:44 -0400
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Date: Fri, 23 Mar 2018 20:57:55 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Christoph Hellwig <hch@lst.de>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: build warning after merge of the tip tree
Message-ID: <20180323205755.465b3f9f@canb.auug.org.au>
In-Reply-To: <20180323083134.GB23865@lst.de>
References: <20180323132853.67195c47@canb.auug.org.au>
        <20180323083134.GB23865@lst.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/Ws2TWC89h/wNzzKkjQ3PrHa"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/Ws2TWC89h/wNzzKkjQ3PrHa
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Christoph,

On Fri, 23 Mar 2018 09:31:34 +0100 Christoph Hellwig <hch@lst.de> wrote:
>
> True.  I'll send a fixup.

Thanks.

--=20
Cheers,
Stephen Rothwell

--Sig_/Ws2TWC89h/wNzzKkjQ3PrHa
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlq0z6MACgkQAVBC80lX
0GxV7Af/ZLWTng48hrdXUYnlHtC8t5EPNRyH62cULW3Cs6NsrQUcoxKy1obemRu4
CLGVoUhx8OLfkTurh22N59lCvHhKMn30vt9YZojZL4Uk3stFXgPUcJtauf/ke0qo
93KzoEzzFZ3z5mGc8A/+1fZ1grzecjpdCaLM2fwzNdVw4SZld/tGIffsFKgzm/2/
TW+TfEuv45W8HURcgy2oQMFccxV/kOQAa/g/FU+pu6yQcf9stE3Soq+SDUh8SWKI
10d9qVaYKgjSFKlpWy13ByV0wZ//ah1DGg6LfZeupQUpzgaM22SgsZSBnmP4OJbD
TAcC/9oVpxa2i164f9dug2vIlRzQ1Q==
=/wg8
-----END PGP SIGNATURE-----

--Sig_/Ws2TWC89h/wNzzKkjQ3PrHa--
