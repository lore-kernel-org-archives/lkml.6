Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933603AbeCGPSF (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 10:18:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:43508 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754628AbeCGPSC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 10:18:02 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0E662172D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=jhogan@kernel.org
Date: Wed, 7 Mar 2018 15:17:56 +0000
From: James Hogan <jhogan@kernel.org>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: Ralf Baechle <ralf@linux-mips.org>,
        Allan Nielsen <Allan.Nielsen@microsemi.com>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v5 2/5] MIPS: mscc: add ocelot dtsi
Message-ID: <20180307151753.GQ4197@saruman>
References: <20180306121607.1567-1-alexandre.belloni@bootlin.com>
 <20180306121607.1567-3-alexandre.belloni@bootlin.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="nSQp8DZZn7gZbDHt"
Content-Disposition: inline
In-Reply-To: <20180306121607.1567-3-alexandre.belloni@bootlin.com>
User-Agent: Mutt/1.7.2 (2016-11-26)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--nSQp8DZZn7gZbDHt
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

On Tue, Mar 06, 2018 at 01:16:04PM +0100, Alexandre Belloni wrote:
> diff --git a/arch/mips/boot/dts/mscc/ocelot.dtsi b/arch/mips/boot/dts/mscc/ocelot.dtsi
> new file mode 100644
> index 000000000000..8c3210577410
> --- /dev/null
> +++ b/arch/mips/boot/dts/mscc/ocelot.dtsi
> @@ -0,0 +1,117 @@
> +//SPDX-License-Identifier: (GPL-2.0 OR MIT)

Niggle: there should be a space after // for consistency with other
files. Same in patch 3.

Cheers
James

--nSQp8DZZn7gZbDHt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEd80NauSabkiESfLYbAtpk944dnoFAlqgAqEACgkQbAtpk944
dnqvNQ//QZzrb3kPRgNFOVF7dhnq0vwq/wgTJG65c+zsdT1f7Q2+KHEWXYLarhYm
oivnHbOYcv5NvDxhgnQZ62mWV0fdY7xKwJT+TIm1H0m3X3ciDmq73njZB2n4lj5z
UuK0LEFvxRT24boK+cYN/cmbgFtB/kGz7qmxoCFYrCkq3RIMABVe0NtadLNE8sCF
eT6GzGxpF9fJmOjDG9Ar+G1E3dY0WaIRyCMX1D2pYUAo7z5UMJvjSzAjEI/rc0qy
k+daTCdCHcHEcBtA2vPRyXAydKWsfgIJUQGE23LmDK7vfXt/LeoDdwWjV1oijj57
bmLIYrqbYMMV+OBTu62uZY3oLTrIlwbkfjo/GqVFjDMEh9CK8TH1QOXXgnShpVdG
q6DFXV+7c3uYvLIV6Lg0OM8v0J4Kx9PT8vAHGRdlZRiE6akwhW9drUlC5y7Hpk2J
fJaFP1aS2lvi7fKGF4kRLROGu/762djDe+c7vWioqoHIbv+bd/W+2Dm24cyAwlWh
3Npc7bog3VIWu4rxF63QupOY3IKP/uQNKLrk0qOVPQFWrbwCrwQqroYDCvhfMnS+
A8IOWuXEOPx5qHO6PJcYJFP2HVtec8hRe2+N3aGWHVMH1QKjgnFCjOKnwvdikZ+S
RcXISMxNjBLfkJf97cqDoBYlnxg1/BTPaPS4MZtSRTW77a3eJXQ=
=dKBS
-----END PGP SIGNATURE-----

--nSQp8DZZn7gZbDHt--
