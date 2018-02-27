Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752559AbeB0JFM (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Feb 2018 04:05:12 -0500
Received: from www.zeus03.de ([194.117.254.33]:42934 "EHLO mail.zeus03.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752539AbeB0JFJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Feb 2018 04:05:09 -0500
Date: Tue, 27 Feb 2018 10:05:08 +0100
From: Wolfram Sang <wsa@the-dreams.de>
To: George Cherian <gcherian@caviumnetworks.com>
Cc: George Cherian <george.cherian@cavium.com>,
        linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org
Subject: Re: [PATCH 4/4] i2c: xlp9xx: Check for Bus state after every transfer
Message-ID: <20180227090507.bke37b7loz3vlh5e@katana>
References: <1516253964-4615-1-git-send-email-george.cherian@cavium.com>
 <1516253964-4615-4-git-send-email-george.cherian@cavium.com>
 <20180226202248.ej3bt5o7sam6qljv@ninjato>
 <a96c4bb2-fbc5-3e21-f6b5-4da75fac3c01@caviumnetworks.com>
 <a2016717-82b1-2802-877b-f947f349f792@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="4oawlbmlsduao4fe"
Content-Disposition: inline
In-Reply-To: <a2016717-82b1-2802-877b-f947f349f792@caviumnetworks.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--4oawlbmlsduao4fe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> Since you raised concern on the patch I thought of reworking this patch.
> But I can see that this patch is already applied for i2c/for-next.
> Kindly let me know whether I should be sending follow-up patches on top
> of i2c/for-next ?

Oops, that was a mistake on my side. I'll revert that patch. Please
think of the patch as not-applied-yet.

Thanks!


--4oawlbmlsduao4fe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlqVH0MACgkQFA3kzBSg
Kbbe8A//XNNoHEtcS6Oitp/gKDjMxhnrPQwu4s1ZjgJnBi99EAslKtae8d4+vZ4f
m3rYsPfxiAsRNm8Q0PgWp31Jrd6bWDBlyiiwA9MLYgbS9FrRRhWBSP/TP4RLHS2k
qnt41Qqj5yZr42T137VByUZ7Tw1AUU3firOwutR+KUYCeziUPQJA0Ou8u3bcDhSt
7X/95SO+Y5zgC5XA/Qoc0f47ufjf6wJZGIZQNj9HerxUJ9UE4z7CDTE/izQ5zMnZ
4MTmVuOEqFCokkwlc8sZmZxf5kxyv0N7j1pRIeba7H57FkJ9OCDeIhwQcejgnUQY
Vtvx3oZPRBhRxgeBxPNgeXadxCJtMT6FyQavTY4dXNm2K6SaFVJO0oKeLSZnzOns
WYPLatcGGsTkrefIqrw8wwQ1VJKem3z4A0rdw5xagTyHlC+SIAzbMb2/rmpvZUZR
7xgrYrMkLnaPQHu879mNdtHgqDbl8o94e3Yk0tD5GlzWZJRhdZLBzb4kwRS5uA9l
p77RzHSEIfQTIRgZk98UvdP/nQeFZfSS8zegkw0vziuxU3zDg2XCRHEBNYCoS55e
qx6f9YX6U52ceE4HO8C2/SurCwFBfWNdbNFNjXt0oGFIY37nbgIe3H96f6MWn2ao
NfQHmY3MQIbd2jcOKvOZFDUYvLsleCrxeFUIvkuvLE5NQrIRkRI=
=yTFl
-----END PGP SIGNATURE-----

--4oawlbmlsduao4fe--
