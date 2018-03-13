Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753138AbeCMQ0y (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 12:26:54 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:58656 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753117AbeCMQ0w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 12:26:52 -0400
Date: Tue, 13 Mar 2018 09:26:42 -0700
From: Mark Brown <broonie@kernel.org>
To: Chris Obbard <chris@64studio.com>
Cc: alsa-devel@alsa-project.org, be17068@iperbole.bo.it,
        linux-kernel@vger.kernel.org, Chen-Yu Tsai <wens@csie.org>,
        lgirdwood@gmail.com, Code Kipper <codekipper@gmail.com>,
        linux-sunxi <linux-sunxi@googlegroups.com>,
        Maxime Ripard <maxime.ripard@free-electrons.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Subject: Re: [alsa-devel] [linux-sunxi] Re: [PATCH v2 6/6] ASoC: sun4i-i2s:
 Add support for loopback
Message-ID: <20180313162642.GR2186@sirena.org.uk>
References: <20180312155753.9478-1-codekipper@gmail.com>
 <20180312155753.9478-7-codekipper@gmail.com>
 <20180312183521.GP2186@sirena.org.uk>
 <CAP03XeoaYcMrzv3+K83wGUaDn6ZcCDzePdVNcjAqJ4QrF-WLSA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="19HmC3QOnaNVzKTI"
Content-Disposition: inline
In-Reply-To: <CAP03XeoaYcMrzv3+K83wGUaDn6ZcCDzePdVNcjAqJ4QrF-WLSA@mail.gmail.com>
X-Cookie: Am I SHOPLIFTING?
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--19HmC3QOnaNVzKTI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Mar 13, 2018 at 01:39:44PM +0000, Chris Obbard wrote:
> >> +- loopback:  if this property is present then the dai is configured in
> >> +             loopback mode where the output fifo is redirected to the input
> >> +             fifo.

> > This really doesn't seem like something that ought to go into the DT
> > and hence ABI given that there's obviously no reason to use this in
> > production.  Just make it be a #define in the code or something.

> It would be nice to have this as an optional devicetree property so
> when testing JACK latency etc I don't have to manually re-compile a
> kernel...

You'll have to rebuild your DT anyway, I'm not sure the kernel is that
much of a difference...  For your use case you'd want a regular runtime
ALSA control, not a DT property anyway.  That would be fine.

--19HmC3QOnaNVzKTI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlqn+8EACgkQJNaLcl1U
h9CsWwf/aZ5n+PDY6I4YPxSGCMLvlVViob04VH3UODkQUCRdUIpJJ/R4ot1p8Tpp
MqyoqIdJ0xogmXHNGGKFhmolD2xk8YEsi+Zi7k4SPRo8xXkMiy/O2lX+QwedaosL
wzkPRfhz/M5ql2zz5sNdLZoqsMbQUaoJLvjx6kAs0J90bSibV64/2NpnYe0Mp33F
6/kSJfwPYsB8pYGgtnHZn/7QJDy/Gve1iz6DDrE8y24oB6gNSKbrZAezt8uM8FUX
dXBBET3QLm9jcfqYOgyMRIX3NFlyfCj27j+8IHAMNpc3DS2DGA3KTvti4v06Bois
1AZ4IONrfSpjRRXtotyhhrijCbRvjg==
=PdOe
-----END PGP SIGNATURE-----

--19HmC3QOnaNVzKTI--
