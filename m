Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751984AbeEQAqy (ORCPT <rfc822;w@1wt.eu>);
        Wed, 16 May 2018 20:46:54 -0400
Received: from ozlabs.org ([203.11.71.1]:58969 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751163AbeEQAqx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 May 2018 20:46:53 -0400
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Date: Thu, 17 May 2018 10:46:51 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Rodrigo Rivas Costa <rodrigorivascosta@gmail.com>
Cc: Jiri Kosina <jikos@kernel.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: Signed-off-by missing for commit in the hid tree
Message-ID: <20180517104651.074567e8@canb.auug.org.au>
In-Reply-To: <20180516142131.GA12325@casa>
References: <20180516071731.59cf5d23@canb.auug.org.au>
        <20180516142131.GA12325@casa>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/FSnlpfK4Pq8B+oD3l12NPXs"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/FSnlpfK4Pq8B+oD3l12NPXs
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Rodrigo,

On Wed, 16 May 2018 16:21:31 +0200 Rodrigo Rivas Costa <rodrigorivascosta@g=
mail.com> wrote:
>
> I'm the author of this commit. Sorry for that, but I'm unsure about what
> is to be done now. Should I resubmit the patch? Or can it be amended any
> other way? Or it is not a big deal anyway?

Its up to Jiri (the tree owner).  Some rebase the tree to add the SOB,
some prefer to just use it as a learning experience :-)
--=20
Cheers,
Stephen Rothwell

--Sig_/FSnlpfK4Pq8B+oD3l12NPXs
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlr80PsACgkQAVBC80lX
0GxEAggAgeI+BoWlzurqivSMYhPUSeWXTjqDEYWkkSFDADPjtzO8nwYZH1HilgKc
Xrk5nQgc2OEZFKS/X6gINvrHnwlc7QViPD7GoaJ7PwJ8HVoWvNUndDEc35Czz4LC
xUeCwD7XkzYera7zmzI002N9gUspM4nbbZgwG+SBnxyqA4ztdYFdTmBHcKLjPRtN
2PXdHKguXuuI0fbXIDScnXaMO9Xs/G+J4/yNXYJlfbwNObxq/J4Mkh0950vl4R2C
nUFmvdMXuP54ExnQetCPQ+dCpRGD8ydhN8FX6Rov3CaMIN6+ff12vZvx0Xkg+O0d
drBTR3Ot6ifEfqoZG7tpS2XBUtdP+Q==
=oor0
-----END PGP SIGNATURE-----

--Sig_/FSnlpfK4Pq8B+oD3l12NPXs--
