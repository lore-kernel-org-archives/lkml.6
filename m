Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754224AbeCGKUO (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 05:20:14 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:50592 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751142AbeCGKUK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 05:20:10 -0500
Date: Wed, 7 Mar 2018 10:20:06 +0000
From: Mark Brown <broonie@kernel.org>
To: JeffyChen <jeffy.chen@rock-chips.com>
Cc: linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v2 1/3] mfd: syscon: Set name of regmap_config
Message-ID: <20180307102006.GA7290@sirena.org.uk>
References: <20180306110403.14438-1-jeffy.chen@rock-chips.com>
 <5A9EAC92.4050702@rock-chips.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ew6BAiZeqk4r7MaW"
Content-Disposition: inline
In-Reply-To: <5A9EAC92.4050702@rock-chips.com>
X-Cookie: If you can read this, you're too close.
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ew6BAiZeqk4r7MaW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Mar 06, 2018 at 10:58:26PM +0800, JeffyChen wrote:

> even this is already fixed by a430ab205d29 ("regmap: debugfs: Disambiguate
> dummy debugfs file name")

> but maybe we can still have this for a better debugfs name?

That's why the facility is there.

Please don't top post, reply in line with needed context.  This allows
readers to readily follow the flow of conversation and understand what
you are talking about and also helps ensure that everything in the
discussion is being addressed.

--ew6BAiZeqk4r7MaW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlqfvNMACgkQJNaLcl1U
h9BBDwf8DEZNN6COtY6IycQsZrEbxVlJ8szzxM1ld1rrr1MhMGTW52Mh5wBOfm2Y
3vsWos+t4wQ3PTF8POXvFuEQl2Z8H3f/h2K/BGky2dEqbGNMzK0sD2g3NNm3JXkY
lbKdQsw0eRExTfrG27zmlMQL02t3F5J5PJ0uL1tHl+15Qy+oVx0XAhRhtxBi6uVo
czHZglobMd62foKp27dYZrdNz9XEsZQmIyJqyqgUaMfQkxkk+HttdlJ1kDjL1XUf
agsCgypIOuYR9D05Re0WItl09EGcLdlDzrvG22vRArPDaPIZ4XuDDY/3vBBhOqy9
Augp0LD6ZZi0JFmS0O5UuqtQC6WcCg==
=u68Y
-----END PGP SIGNATURE-----

--ew6BAiZeqk4r7MaW--
