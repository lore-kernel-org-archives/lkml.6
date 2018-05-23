Return-Path: <broonie@sirena.org.uk>
X-Google-Smtp-Source: AB8JxZq5bvwcqBew8NC0FWKGzjycAY0pQd3cbm3TGxhdWGT8oGjt+6ExuLRkgJ4TmCXusZshDesJ
ARC-Seal: i=1; a=rsa-sha256; t=1527064249; cv=none;
        d=google.com; s=arc-20160816;
        b=AA/+Rlb/O6nhjym9NAT0q9NLAXd1QMp9hl8X8sJPITFpBKK4qg2HuccVdRa6uDodH6
         rCDXVoW8BTWk93ZbEfMVsk5DdRVkAGaJO4AgUVvBdtBUQqAlO3r3IG/n/f0JE5hNcjy8
         eGNIoJWqAOK54f8AtC336To1706cjQQiZ+dulw8H5WGc3rxcE7LP0QbVmZnIByK0wD0r
         OpqQG9MtZLWXuQqeyd/Leh8hd65lFVYc63JhFk3jhR8akw+x5XWyz2H1cjzsaFYyUUtz
         KDS6sXqnglxNKWlVCt56tSHFk9VkNgtcwvsq+6GtQakYbNZ9yHL6xY2u6LtR1U3eeTuI
         AvEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=vqRYa1Q61G6EZqHjU3mD6xrCKfIe5DTdp/ueacqSTmc=;
        b=Tq+O02T5382bXw2fsSAcccoqhcUorP6fkmts2abQdrgtvwiz1anWlVkDfMhcBIDGTz
         N8vJdOkd5boffLRw/SMp11UDxLww7bd8ZmGkri9HqbVA+FNJprKAuudmMkIrDUgCRWt9
         Hkve5yGkPNbBQkzgQcNx/6KLcpw1VItHRFEmW0+jJV7c1OfKquMSjvSP/WZ/ZCRWw6p9
         OiibOQUTQ2zZtJwVMQw95vWUnEB8wOBYjBjX4bXRqokMzFo8h48Oq0NxQIvR9RTpcrQB
         oMuuBx9T0rbBVuf0QIsvzwidX4shFOPgDptiMqfyfQv4Ttr50cU9nZMRUgBRvqmnhsA7
         fPMw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@sirena.org.uk header.s=20170815-heliosphere header.b=RiSS4j/H;
       spf=pass (google.com: domain of broonie@sirena.org.uk designates 2a01:7e01::f03c:91ff:fed4:a3b6 as permitted sender) smtp.mailfrom=broonie@sirena.org.uk;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@sirena.org.uk header.s=20170815-heliosphere header.b=RiSS4j/H;
       spf=pass (google.com: domain of broonie@sirena.org.uk designates 2a01:7e01::f03c:91ff:fed4:a3b6 as permitted sender) smtp.mailfrom=broonie@sirena.org.uk;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=kernel.org
Date: Wed, 23 May 2018 09:30:40 +0100
From: Mark Brown <broonie@kernel.org>
To: Radu Pirea <radu.pirea@microchip.com>
Cc: devicetree@vger.kernel.org, linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-spi@vger.kernel.org, mark.rutland@arm.com, robh+dt@kernel.org,
	lee.jones@linaro.org, gregkh@linuxfoundation.org, jslaby@suse.com,
	richard.genoud@gmail.com, alexandre.belloni@bootlin.com,
	nicolas.ferre@microchip.com
Subject: Re: [PATCH v3 5/6] spi: at91-usart: add driver for at91-usart as spi
Message-ID: <20180523083040.GC4828@sirena.org.uk>
References: <20180511103822.31698-1-radu.pirea@microchip.com>
 <20180511103822.31698-6-radu.pirea@microchip.com>
 <20180517050406.GF20254@sirena.org.uk>
 <6a59e071-3159-4939-8535-6c7a9d491379@microchip.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="/Uq4LBwYP4y1W6pO"
Content-Disposition: inline
In-Reply-To: <6a59e071-3159-4939-8535-6c7a9d491379@microchip.com>
X-Cookie: Excellent day to have a rotten day.
User-Agent: Mutt/1.9.5 (2018-04-13)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600163736740058885?=
X-GMAIL-MSGID: =?utf-8?q?1601242921800740328?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


--/Uq4LBwYP4y1W6pO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, May 23, 2018 at 11:10:28AM +0300, Radu Pirea wrote:
> On 05/17/2018 08:04 AM, Mark Brown wrote:

> > > +// SPDX-License-Identifier: GPL-2.0
> > > +/*
> > > + * Driver for AT91 USART Controllers as SPI
> > > + *
> > > + * Copyright (C) 2018 Microchip Technology Inc.

> > Make the entire block a C++ comment so it looks more intentional rather
> > tha mixing C and C++.

> I know it's ugly, but SPDX license identifier must be in a separate comment
> block.

No, it doesn't - it just needs to be the first line of the file.

--/Uq4LBwYP4y1W6pO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlsFJq8ACgkQJNaLcl1U
h9A5Dwf+IXTaaeH5wemGlp1J1Cqj9ET0B9mUUqYNsQ+BsMbdI314G1a/S3isLCCw
XjOds1vEWxncEZb6kxV4v/3bUuOKKrZ7UVlVsY2nycfzgvLsIaGhBcf7/OAAJWb/
kzfX3gceAsRfmFgbPHXcHMQbT+cWxJMBWUA0hJt2xBdJCVh1EduJ9VNZsbqjJSkU
nyOZffnBU/sIMj0mibun82oVVFtdu71N0DJEfMAP/mf4sajkjFs4IqGqK80Ghfyx
LYoD8hf8RKOvGF/Jr/x3K7T7bjAp1tny7kWtwqwf5zAb44FDgG+e6AEDN1bbzAva
MdFlv1uRTZwcunY5iN+UhKQgi7e4iw==
=+KAd
-----END PGP SIGNATURE-----

--/Uq4LBwYP4y1W6pO--
