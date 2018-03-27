Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751973AbeC0V3j (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 17:29:39 -0400
Received: from mail-wm0-f54.google.com ([74.125.82.54]:56038 "EHLO
        mail-wm0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750966AbeC0V3h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 17:29:37 -0400
X-Google-Smtp-Source: AIpwx4+TRQhJNbGnC0dDZSKCRQ8fDf7IIFIYn7yD6mLfrX8xYVB6dB6TIDa4+wlbvmisoYbowo8+Fw==
Date: Tue, 27 Mar 2018 23:29:34 +0200
From: Thierry Reding <thierry.reding@gmail.com>
To: SF Markus Elfring <elfring@users.sourceforge.net>
Cc: linux-pwm@vger.kernel.org,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] pwm: atmel-tcb: Delete an error message for a failed
 memory allocation in atmel_tcb_pwm_probe()
Message-ID: <20180327212933.GC28058@mithrandir>
References: <8274c498-1d1b-2ece-365c-98ded714a53c@users.sourceforge.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="UPT3ojh+0CqEDtpF"
Content-Disposition: inline
In-Reply-To: <8274c498-1d1b-2ece-365c-98ded714a53c@users.sourceforge.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--UPT3ojh+0CqEDtpF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 15, 2017 at 07:00:46PM +0100, SF Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Fri, 15 Dec 2017 18:55:11 +0100
>=20
> Omit an extra message for a memory allocation failure in this function.
>=20
> This issue was detected by using the Coccinelle software.
>=20
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> ---
>  drivers/pwm/pwm-atmel-tcb.c | 1 -
>  1 file changed, 1 deletion(-)

Applied, thanks.

Thierry

--UPT3ojh+0CqEDtpF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlq6t70ACgkQ3SOs138+
s6EYthAAqpm2v1uDdRs/8YnXECLx3IcjduNSPvg0BXG9jzfNC2tdNZJhlrt0z5Y4
HpHPnZlf6xJVAtNA3S8bXesKffSViEGGTCxrNNBSYRCdeBy9n/Ud7AOf3omNv8Bm
Gy/sjIezzrcHcCc1foamaeJt1c0nevpkzn3/Oxe60yhsrffhgpTno4S8tDPpmwEi
lCZ5QeQmSDvv8/GYLCzIEzS2PczCu5JFuEQcdC6VYUw/V14QltK64m+Hic9M9oaw
r7AiruTbGxFHq1A82DVxlyC1QIhBTBsu8ulSUBCp3dNHNSIMOF34rRyy1LEH9EtK
6e8Jx6zrHBZtshtR3GYo8YchYcnZ0NLfDxaUAXO2xWoHgnr2llcU3MN4DdAEO4dB
3tXfNkl9HzFF92RmYnlSJTAIcVHSRgdNHqYLBDySN+XIAvmdLbTT+6xxc+8B3JsF
IzednF9QDQg88jDxmFYe9kRMC5azmdxv9tsbEvulw43a6PUZjREprhaKENhLVaaf
CMpv65VQog5FnfVg0MXhF+gnKfw7T0Y2Ld8lJ1Y9Is3T66CmfzO13dN7zhIOJwZI
yu4N6Xal7YtngHxH3jjEhCLlxG2d17Xtxj9k83bMz9j7EgjBBKSL5iMPOa7OxIyV
rX7sCmWSV4AoRw2rFq2ML/FIuWumx0KFS8eaVYZKRl9RIi9ToXA=
=U3k1
-----END PGP SIGNATURE-----

--UPT3ojh+0CqEDtpF--
