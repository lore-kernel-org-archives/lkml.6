Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751216AbeEAUnA (ORCPT <rfc822;w@1wt.eu>);
        Tue, 1 May 2018 16:43:00 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:34626 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750769AbeEAUm7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 May 2018 16:42:59 -0400
Date: Wed, 2 May 2018 05:42:40 +0900
From: Mark Brown <broonie@kernel.org>
To: Jean-Jacques Hiblot <jjhiblot@ti.com>
Cc: robh+dt@kernel.org, mark.rutland@arm.com, perex@perex.cz,
        tiwai@suse.com, dannenberg@ti.com, afd@ti.com,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/3] ASoc: TAS6424: Add support for mute, standby, and
 faster power on
Message-ID: <20180501204239.GC2714@sirena.org.uk>
References: <1525077018-15863-1-git-send-email-jjhiblot@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="QRj9sO5tAVLaXnSD"
Content-Disposition: inline
In-Reply-To: <1525077018-15863-1-git-send-email-jjhiblot@ti.com>
X-Cookie: Rubber bands have snappy endings!
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--QRj9sO5tAVLaXnSD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Apr 30, 2018 at 10:30:15AM +0200, Jean-Jacques Hiblot wrote:
> mute and standby pins are available on the codec. If they are connected, they
> should be managed by the driver, instead of relying on gpio hogs or on the
> initial state of the GPIOs.

Please do not submit new versions of already applied patches, please
submit incremental updates to the existing code.  Modifying existing
commits creates problems for other users building on top of those
commits so it's best practice to only change pubished git commits if
absolutely essential.

--QRj9sO5tAVLaXnSD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlro0T8ACgkQJNaLcl1U
h9Ad/Qf/emHR5/nYvWAYhMpBMTXLXgR75j75hZWawgl1qYSox9lMkg7whJUj1aEr
tclFJY8ur33dFsJf5qoozovVfA3ZahUDQ87uniegKZ1bWnHR5DSJl23ioF5yRCjP
+xPZOvtrm13GUzUQWzbcfajnrY77HhHiNJmf7xrRdsyQfk0Chb8/VyQqe0NQ5lgw
gvg/F4eEBHhK1PSbKGmzHfInaN+56bxujDHaXwqJirOq+NuziCdx1CNgQOobvs8h
2cG08PsgGCIa88kYHhQq/dBDLd4qOoyYV65VtlCRtN4xuD7kjW1+SmF61ZDySF1K
b+vBQsu7xFGtXRpqrIusLJHVPYVQCQ==
=Yom0
-----END PGP SIGNATURE-----

--QRj9sO5tAVLaXnSD--
