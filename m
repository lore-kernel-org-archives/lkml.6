Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752521AbeBZVEJ (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 16:04:09 -0500
Received: from sauhun.de ([88.99.104.3]:38399 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752241AbeBZUVR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 15:21:17 -0500
Date: Mon, 26 Feb 2018 21:21:15 +0100
From: Wolfram Sang <wsa@the-dreams.de>
To: George Cherian <george.cherian@cavium.com>
Cc: linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org,
        Dmitry Bazhenov <dmitry.bazhenov@auriga.com>
Subject: Re: [PATCH 3/4] i2c: xlp9xx: report SMBus block read functionality
Message-ID: <20180226202115.2imhdxo3p2q5amgq@ninjato>
References: <1516253964-4615-1-git-send-email-george.cherian@cavium.com>
 <1516253964-4615-3-git-send-email-george.cherian@cavium.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ykxogx732rnljfuf"
Content-Disposition: inline
In-Reply-To: <1516253964-4615-3-git-send-email-george.cherian@cavium.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ykxogx732rnljfuf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 18, 2018 at 05:39:23AM +0000, George Cherian wrote:
> From: Dmitry Bazhenov <dmitry.bazhenov@auriga.com>
>=20
> Report SMBus block read functionality which is actually supported.
>=20
> Signed-off-by: Dmitry Bazhenov <dmitry.bazhenov@auriga.com>

Applied to for-next but squashed it with patch 2 because I'd think you
also want that fix before enabling it in 'functionality'. Let me know if
you disagree.


--ykxogx732rnljfuf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlqUbDsACgkQFA3kzBSg
KbYCNw/8Ci4sV8otTQkJvGY/EAtKFLXkIRtCiFvgm2AH1V7tVZ/qdRzuThmHvcOc
ilBrFbsR3hO6B6s/H7O62jTQEErnbRzcSmAN2+zsq0DoDCsh/Saz95riF3S4lMi9
lrBKh9yYXPHgWX3ljY4yO77YidxZsMdJdLh46rst1RW871V+du5Mm7rXG7lVayfq
lvhlORcOnKQ9SD+iQO4I184sm3jN46Rah8DM4PCVXENd/vzquCU7/S8zUucG1pNI
fWYH554DHxtBWiso2ovpKWBzXdoeSrrsZA2KjJZRJAGVT6zZ1w2MOedYeWOWgxFC
v996SCGUr4jSBWcp0dHxBBJdMj5YfZxmMh9S6wU+d3LGvmXv01As8k/NxefCIF1K
n7LTmso5slLY0xK7u01HnKU7P3bqSqLgO0NExJtQ4hNmkHqjoFb5sNJskF1hXTDq
KiclFQ/KKN6jWRo5L5nOihLIl7fWBXXPpTpNBWqNvdw2hMJWf7pdwQDkGAtLHmzx
wgZMOQFApLKXwLzNfvOXJ43CqJAx9nGPE1fKY5vzlTXoW2hn3VAW6S5jq6RZQ84u
oGV9ZK0dvq4SWfTpjqNyry8etBpRX4rCsh9DsxARzGBYeb+nvn6LvF9GkrBSHgPE
HHIJ9Y8Ci7HvTteccG0bGwh9mKCJTBUDQ1aMzlj3GmOY8viiY6M=
=npub
-----END PGP SIGNATURE-----

--ykxogx732rnljfuf--
