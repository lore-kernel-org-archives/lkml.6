Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S970504AbeEXSQh (ORCPT <rfc822;w@1wt.eu>);
        Thu, 24 May 2018 14:16:37 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:43998 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965842AbeEXSQd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 May 2018 14:16:33 -0400
Date: Thu, 24 May 2018 19:16:28 +0100
From: Mark Brown <broonie@kernel.org>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: Radu Pirea <radu.pirea@microchip.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        devicetree <devicetree@vger.kernel.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh+dt@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Richard Genoud <richard.genoud@gmail.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>
Subject: Re: [PATCH v3 5/6] spi: at91-usart: add driver for at91-usart as spi
Message-ID: <20180524181628.GE4828@sirena.org.uk>
References: <20180511103822.31698-1-radu.pirea@microchip.com>
 <20180511103822.31698-6-radu.pirea@microchip.com>
 <CAHp75Ve3Ugnjjm8EZkPQTZSvH1qad1e5SqjOn8zz5syHSQea_g@mail.gmail.com>
 <5a3930b867cf8c279953d08c5d5dd1d93113a43b.camel@microchip.com>
 <CAHp75VdRrL25Jgnbk64Qqc5RY3uJdcntJ3xwRdp3F+rRFeTHBA@mail.gmail.com>
 <c23cdde58b9f724f51787c6c38478df983be6efa.camel@microchip.com>
 <20180517045437.GE20254@sirena.org.uk>
 <0e6e71e2-f8ac-7889-0d81-8d8a4c15223d@microchip.com>
 <20180524175620.GB12093@piout.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="fzZfjcV6kaBgkq89"
Content-Disposition: inline
In-Reply-To: <20180524175620.GB12093@piout.net>
X-Cookie: Excellent day to have a rotten day.
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--fzZfjcV6kaBgkq89
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, May 24, 2018 at 07:56:20PM +0200, Alexandre Belloni wrote:

> Back in 2014, I was suggesting using devm_gpio_request_one() in
> of_spi_register_master(). That would take care of setting the direction
> of the GPIO:

> https://www.spinics.net/lists/arm-kernel/msg351251.html

> I never took the time to create the patch and test though.

Right, this'd be ideal but unfortunately it does mean we'd have to
transition all the existing users that open code their requests which is
a pain.  It'd be really nice if someone had the time/enthusiam to do it
though.

--fzZfjcV6kaBgkq89
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlsHAXwACgkQJNaLcl1U
h9ByOQgAhs9RFeiFQSgUep94tUUdJU85bZVBQRkfQiidVevSbmmgtz05neQXGEIW
UxyKwshNRVCqV2cnNMKLrLCjLOMS46TdgEfUnkzWegJQ0vhwj+XJ+AWJtCPwFZaT
CdROhNgbhE6zNCNJGNEc8kUNrAscKV/bllQh6M6SceLpddXqcnbtgdPF6+iOKAKh
LDWT7nzUeX49b0zEmMfnoSHLBdpQjrQui4an3bllPpZ3XB0IipIHKX+gU0lqpYSw
qzN8auPOdD1Wqk70KfWi/+PK1flmqlQ4d9eJEOf02/zLSG7p/BjjVBKmT60DkN9+
sM0kLWPGAOrqz+msZG7H3CegweQ9Hw==
=dq7H
-----END PGP SIGNATURE-----

--fzZfjcV6kaBgkq89--
