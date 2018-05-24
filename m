Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1032397AbeEXSSo (ORCPT <rfc822;w@1wt.eu>);
        Thu, 24 May 2018 14:18:44 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:47614 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030439AbeEXSSm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 May 2018 14:18:42 -0400
Date: Thu, 24 May 2018 19:18:34 +0100
From: Mark Brown <broonie@kernel.org>
To: Rob Herring <robh@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Alexander Graf <agraf@suse.de>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>, Joerg Roedel <joro@8bytes.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Frank Rowand <frowand.list@gmail.com>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, boot-architecture@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 1/8] driver core: make deferring probe after init
 optional
Message-ID: <20180524181834.GF4828@sirena.org.uk>
References: <20180524175024.19874-1-robh@kernel.org>
 <20180524175024.19874-2-robh@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="27KoNqt0fmcl1zj/"
Content-Disposition: inline
In-Reply-To: <20180524175024.19874-2-robh@kernel.org>
X-Cookie: Excellent day to have a rotten day.
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--27KoNqt0fmcl1zj/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, May 24, 2018 at 12:50:17PM -0500, Rob Herring wrote:

> Subsystems or drivers may opt-in to this behavior by calling
> driver_deferred_probe_check_init_done() instead of just returning
> -EPROBE_DEFER. They may use additional information from DT or kernel's
> config to decide whether to continue to defer probe or not.

Should userspace have some involvement in this decision?  It knows if
it's got any intention of loading modules for example.  Kernel config
checks might be good enough, though it's going to be a pain to work out
if the relevant driver is built as a module for example.

--27KoNqt0fmcl1zj/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlsHAfkACgkQJNaLcl1U
h9DOLgf9HKYqvzG7WS+j0s6svb/ahcIJabCWBi7iW7mF8DoFBL23J9ZAz2s4f6oq
3HLOOmJUX7Wb4FXg88m/wScvuwHaLlOceSF32LCzajnDOrGDIXD+fXQVd+u4WlF5
/tUYOwdzrEBF0YXZ+6uZx/5mUnDxOTanTMrxC0dvMVhfR1JZC17DUmUStv/WrCN6
/gNyHoiqLQZCaxcPOyE6KcKSsbOKSu9KdUj/ZrITgwGZ/4fYO5lRY3NurNLqwmis
Yrxvh6DKIyvLtd7m4ws5YV1RtrgvB9M6OJlXaUqhBEB/EBlQT3t8mGFR+Ho2OZU2
ChA7CiU8Y6j/ZfC2tBt97Bp6j+qhPg==
=IvVb
-----END PGP SIGNATURE-----

--27KoNqt0fmcl1zj/--
