Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1032926AbeCAQWV (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 11:22:21 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:49068 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1032704AbeCAQWT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 11:22:19 -0500
Date: Thu, 1 Mar 2018 16:22:15 +0000
From: Mark Brown <broonie@kernel.org>
To: Hans de Goede <hdegoede@redhat.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 8/9] ASoC: Intel: bytcr_rt5640: Drop unwanted
 ignore_suspend settings
Message-ID: <20180301162215.GC12864@sirena.org.uk>
References: <20180218220146.22485-1-hdegoede@redhat.com>
 <20180218220146.22485-9-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="bKyqfOwhbdpXa4YI"
Content-Disposition: inline
In-Reply-To: <20180218220146.22485-9-hdegoede@redhat.com>
X-Cookie: Real Users hate Real Programmers.
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--bKyqfOwhbdpXa4YI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Feb 18, 2018 at 11:01:45PM +0100, Hans de Goede wrote:
> The ignore_suspend settings were added in an attempt to try and fix
> suspend / resume issues. But they never fully fixed these and now we've
> a proper fix, so lets remove these.

Do these systems not have the ability to continue to play audio through
suspend using the DSP?  That's the sort of thing that ignore_suspend is
normally used for.

--bKyqfOwhbdpXa4YI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlqYKLYACgkQJNaLcl1U
h9DwhQf/We2rIbUMGpgg4Wx57JMl54AKX/s7aAr45yKhpLtCwLZ/eDeAtCIlp7mY
j5+/dWY92HNYTGvRz/7jMVENRAEriBP++hiK/cYWXKUIOSmTHqZVmjZ33Bk+8K5j
7NEGypbtIPwTnOuu1cwrDvCghCiQTtH9iBaB+C/wkiIdfcRsDGyTpQRYSPtjNq9F
EzHSngDUUtc0VhcTf4r5NnlLznc0FyCupHqaJYIIH37bfJfMZQwJSplSz1bsM5yx
xpfcSeiQYW1qxkhSn0NkkKzG/wlc1SK1CmeulV32cg2WNUpj1uMATjdaZyQfzJ90
20oDGgkHg6C8ssBm847vjuGMres/Uw==
=XN1j
-----END PGP SIGNATURE-----

--bKyqfOwhbdpXa4YI--
