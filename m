Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81960C282CE
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 09:24:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B0AF21773
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 09:24:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728806AbfBLJYZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 04:24:25 -0500
Received: from relay8-d.mail.gandi.net ([217.70.183.201]:48183 "EHLO
        relay8-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726325AbfBLJYW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 04:24:22 -0500
X-Originating-IP: 90.88.22.177
Received: from localhost (aaubervilliers-681-1-80-177.w90-88.abo.wanadoo.fr [90.88.22.177])
        (Authenticated sender: maxime.ripard@bootlin.com)
        by relay8-d.mail.gandi.net (Postfix) with ESMTPSA id 253871BF214;
        Tue, 12 Feb 2019 09:24:17 +0000 (UTC)
Date:   Tue, 12 Feb 2019 10:24:17 +0100
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Daniel Vetter <daniel.vetter@ffwll.ch>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Takashi Iwai <tiwai@suse.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <sean@poorly.run>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Dave Airlie <airlied@gmail.com>,
        intel-gfx <intel-gfx@lists.freedesktop.org>,
        "DRM maintainer tools announcements, discussion, and development" 
        <dim-tools@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PULL] topic/component-typed
Message-ID: <20190212092417.rs4alnres4he5nvx@flea>
References: <CAKMK7uHU37VLbe4RBZ3GOow+=pupYAHotkVrpqJeiUcpSfjX8Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ztdhkjxio6fuso4d"
Content-Disposition: inline
In-Reply-To: <CAKMK7uHU37VLbe4RBZ3GOow+=pupYAHotkVrpqJeiUcpSfjX8Q@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ztdhkjxio6fuso4d
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 11, 2019 at 06:15:20PM +0100, Daniel Vetter wrote:
> Hi all,
>=20
> Here's the typed component topic branch.
>=20
> drm-intel maintainers: Please pull, I need this for the mei hdcp work fro=
m Ram.
>=20
> drm-misc maintainers: Please pull, there's a drm doc patch follow-up
> that I want to stuff into drm-misc-next.
>=20
> Greg: The drm side missed our feature cutoff, so will only land in 5.2.
> Probably good if you pull this into drivers-core so it lands a bit
> quicker. You&Arnd will also get a topic pull later on with the MEI bits
> for char-misc tree, which needs to be based on top of this tree here.
>=20
> Takashi: Since the drm side only lands in 5.2 might be good if you
> pull this in too to avoid conflicts.
>=20
> Cheers, Daniel

Pulled into drm-misc, thanks!
Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--ztdhkjxio6fuso4d
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXGKQwQAKCRDj7w1vZxhR
xRfCAP9VKwUcNbutCiVYkTXmxBPqAyGOTRSxZPAvSPgZlOzesQEA9lNqeDNoGquO
Aon6fIZBEb7Iyuoj3ZQBu4r9iHM0fgQ=
=P9ZW
-----END PGP SIGNATURE-----

--ztdhkjxio6fuso4d--
