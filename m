Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965146AbeCTAIc (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Mar 2018 20:08:32 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:39484 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933323AbeCTAIb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Mar 2018 20:08:31 -0400
X-Google-Smtp-Source: AG47ELvy5ImNpmN++90zJOcUwVdN79rEWwPIRZfYUHvurUcR0R6Z6kp//IedoVdLw3V/G9wY82fCAg==
Date: Mon, 19 Mar 2018 17:08:27 -0700
From: Benson Leung <bleung@google.com>
To: Wenkai Du <wenkai.du@intel.com>
Cc: Benson Leung <bleung@chromium.org>, Olof Johansson <olof@lixom.net>,
        linux-kernel@vger.kernel.org,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, bleung@google.com
Subject: Re: [PATCH] platform/chrome: cros_ec_lpc: wake up from s2idle on
 Chrome EC
Message-ID: <20180320000827.GA57573@decatoncale.mtv.corp.google.com>
References: <20180222212117.122560-1-wenkai.du@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="fUYQa+Pmc3FrFX/N"
Content-Disposition: inline
In-Reply-To: <20180222212117.122560-1-wenkai.du@intel.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--fUYQa+Pmc3FrFX/N
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Wenkai,

Thanks for providing the patch.

On Thu, Feb 22, 2018 at 01:21:17PM -0800, Wenkai Du wrote:
> Chrome platform installed a Chrome EC notify handler which prevents
> default EC GPE handler getting called. Add pm_system_wakeup to the
> Chrome EC notify handler so wake up from s2idle can happen.
>=20
> Suggested-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Signed-off-by: Wenkai Du <wenkai.du@intel.com>

LGTM. Applied to my for v4.17 branch.

Thank you!
Benson
--=20
Benson Leung
Staff Software Engineer
Chrome OS Kernel
Google Inc.
bleung@google.com
Chromium OS Project
bleung@chromium.org

--fUYQa+Pmc3FrFX/N
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE6gYDF28Li+nEiKLaHwn1ewov5lgFAlqwUPgACgkQHwn1ewov
5lgpNQ//cm8gGzKlsAsCddRJCiXXHa0YPQ/Ctc1OimDiRaiQYmYgei1LYmm+ThYJ
eWTZLz4/JO19Mltqd5J9ajqTJL9DaASEMRgkBwMdrQZASj1+Euj4iHtaV4OLvL+o
AkaSs58Cj7rYCuk8gr0kDwzRXNyVbejlyMc7cbs4Wp1r0G5b5AXzbK7/uUoYCR6N
HC9EWEu5xYmjgF0xcd0RdCO7IDc+xu7s2g4/dLlRFavasx4mb3XIpbVdxt+YmHaI
2EJvE6o5+vPlNzP8L4l6CruIxE8HGio98Mtwwmrj2C8BW/joErKXPaIZ/Sj8PXKa
uflZui+UO2Kpxjo0Wd0YDd+GJKilvRkfvL4t2W4tFqSXelUU+q2PafXABWPqy0jq
f3q9/P/ghCjFqZZbWgigD9+WxipQS4vlnlxxuJdJMbNlWMo4pe7ONzhqtzDkvKmB
Pv6fxdSr7b3K01ka3Yi+RUD44BUw2fQ6WwJ0QaM37gv6eUW9epdIsn9GE2iDUqM/
jNRpRkfl5b7EWIHyQO6LFlVSOGtD6XliBXq5XncG4n0gUIQKSR4jZI9/JtfvtPN2
eHCgYAvYE1Mpy4CF90cEYT/x69wb9zFFZ6wf8ABhDPFgqyv7gELq41TV8l0s8H51
XeABAk9jpp7y8jVmcpXScRHjnq2iRV/7xCDouGKrNtM67BbWH0I=
=skzc
-----END PGP SIGNATURE-----

--fUYQa+Pmc3FrFX/N--
