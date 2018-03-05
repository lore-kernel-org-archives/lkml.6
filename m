Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752183AbeCEPeZ (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Mar 2018 10:34:25 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:35838 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751462AbeCEPeY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Mar 2018 10:34:24 -0500
Date: Mon, 5 Mar 2018 15:34:17 +0000
From: Mark Brown <broonie@kernel.org>
To: Hans de Goede <hdegoede@redhat.com>
Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 8/9] ASoC: Intel: bytcr_rt5640: Drop unwanted
 ignore_suspend settings
Message-ID: <20180305153417.GH8588@sirena.org.uk>
References: <20180218220146.22485-1-hdegoede@redhat.com>
 <20180218220146.22485-9-hdegoede@redhat.com>
 <20180301162215.GC12864@sirena.org.uk>
 <55819630-6198-6227-63ef-69311b21b255@redhat.com>
 <20180301164819.GD12864@sirena.org.uk>
 <2aa03d98-7f61-0699-98d6-ac3ca3497c41@redhat.com>
 <20180301171744.GE12864@sirena.org.uk>
 <8ed79e1c-0a64-47d5-8076-9febfe896d3d@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="it/zdz3K1bH9Y8/E"
Content-Disposition: inline
In-Reply-To: <8ed79e1c-0a64-47d5-8076-9febfe896d3d@redhat.com>
X-Cookie: Do not write below this line.
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--it/zdz3K1bH9Y8/E
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Mar 04, 2018 at 03:11:09PM +0100, Hans de Goede wrote:
> On 01-03-18 18:17, Mark Brown wrote:

> > Sure, but do such userspaces exist - ChromeOS or something for example?

> ChromeOS has a more or less standard userspace I believe.

No, they've got their own sound server for historical reasons.  There's
Android too of course who definitely do have facilities for compressed
audio offload.

--it/zdz3K1bH9Y8/E
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlqdY3gACgkQJNaLcl1U
h9AIQQf9GGDi/JBjrTaghiksbEuXIM+XUxCvYkIiwhIYqdE+wTJ3dgLYdI9XHcUw
LhS5pSWo8bCr+YiPs+l2vJToZvxTdXxGgyveYbpwgA0F5C2+O5t8UFiwvnHaLoWI
qBRPxBFpg22v0H6QvsmoJJHGRYn/JExc7Ks47+pvNpkWXwm1os7Ci3PISfFUQgWs
yjvtgTfFLf0XMCIjY32InFcl0eaEg3s33un95KFcLC5Ml+pgC583XnltMGxmYp/G
9JlP815Jk1DayvdXQQl+lGd2oY6SAcqY+PNYu9vDUlIwR6Mc/cdrfFSR4KqcXreE
Zdk1fGhJEUyA2ezlP64epObuEbW9wA==
=VbLz
-----END PGP SIGNATURE-----

--it/zdz3K1bH9Y8/E--
