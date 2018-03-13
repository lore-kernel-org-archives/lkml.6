Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753187AbeCMWuR (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 18:50:17 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:37905 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751300AbeCMWuQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 18:50:16 -0400
X-Google-Smtp-Source: AG47ELs2PYZ6BOZCxQkKsycElZoR6s+PSniYxaUWs/qEbxqWJd+174QcPOA+qqbEGvEmuwAdcqfVXQ==
Date: Tue, 13 Mar 2018 23:50:14 +0100
From: Thierry Reding <thierry.reding@gmail.com>
To: yannick fertre <yannick.fertre@st.com>,
        Vikas Manocha <vikas.manocha@st.com>, Tom Rini <trini@konsulko.com>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Philippe Cornu <philippe.cornu@st.com>,
        Patrice Chotard <patrice.chotard@st.com>,
        Patrick DELAUNAY <patrick.delaunay@st.com>,
        Christophe KERELLO <christophe.kerello@st.com>,
        Archit Taneja <architt@codeaurora.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        David Airlie <airlied@linux.ie>,
        Brian Norris <briannorris@chromium.org>,
        Bhumika Goyal <bhumirks@gmail.com>,
        Gustavo Padovan <gustavo@padovan.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <seanpaul@chromium.org>,
        Albert Aribaud <albert.u.boot@aribaud.net>,
        Simon Glass <sjg@chromium.org>, Anatolij Gustschin <agust@denx.de>,
        u-boot@lists.denx.de, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v3 00/10] splash screen on the stm32f769 disco board
Message-ID: <20180313225013.GB23414@mithrandir>
References: <1520949014-21468-1-git-send-email-yannick.fertre@st.com>
 <20180313152310.GJ4788@phenom.ffwll.local>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="EuxKj2iCbKjpUGkD"
Content-Disposition: inline
In-Reply-To: <20180313152310.GJ4788@phenom.ffwll.local>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--EuxKj2iCbKjpUGkD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 13, 2018 at 04:23:10PM +0100, Daniel Vetter wrote:
> On Tue, Mar 13, 2018 at 02:49:59PM +0100, yannick fertre wrote:
> > Version 3:
> > - Replace some pr_error, pr_warn or pr_info by dev_error, dev_warn & de=
v_info.
> > - Refresh stm32f769-disco_defconfig with last modification done on v201=
8.3-rc4.
> > - rework include files ordering.
> >=20
> > Version 2:
> > - Replace debug log by pr_error, pr_warn or pr_info.
> > - Rework bridge between ltdc & dsi panel
> > - Rework backligh management (with or witout gpio)
> > - Rework panel otm8009a
> > - Add new panel raydium rm68200
> >=20
> > Version 1:
> > - Initial commit
> >=20
> > This serie contains all patchsets needed for displaying a splash screen=
=20
> > on the stm32f769 disco board.
> > A new config has been created configs/stm32f769-disco_defconfig.
> > This is necessary due to the difference of panels between stm32f769-dis=
co &
> > stm32f746-disco boards.
>=20
> Shouldn't we patch the drivers/gpu/drm/stm driver instead of the
> drivers/video one? fbdev is kinda a dead end and not for adding new hw
> support ...

This is confusing, but by the looks of it this is code for U-Boot
display support and has nothing to do with the Linux kernel. I don't
know why dri-devel was on Cc.

Yannick, it's not customary to cross-post U-Boot display drivers to
Linux mailing lists, unless there's some need to coordinate or discuss
across the boundaries (for example if you were proposing a way to do
seamless handover from U-Boot to kernel). If you do cross-post, perhaps
make sure to mark these patches as targetting U-Boot to avoid confusion.

Thierry

--EuxKj2iCbKjpUGkD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlqoVaQACgkQ3SOs138+
s6ER8xAAgbhmPbQgCLSocTxn6syHSGGwKPmLszMuod6paihH6PHMzt9QuP8HVyFR
edIleFJ+c+wdadG+zF3VJXTkgqJ+bP4RTs7jAGjHB0TrpGyHUBq05w2yAWS2k2XJ
YXF58JI78Ms8E4I4Qg4HU8X+imrfGEwXAfdsBM76o2oGaeyZkdugrRAHCCWoBHX+
XO8szUUJ0sxTCnygWqnv+KIRsM/tAixENAWMsywlon0FgnCnnpwwsOwLk2gR/ana
WNN8bjTD58M8WT8J8Gl+gu7h2y46rc8rpRHtS4ppxJrVmDfNat/w1SCOE3j6YTAx
7qjltWwEhfU6kpOqg5DThB5I0KvkWG06cbMKHstkqIp4oGXzvQoV0mpp155+G0n7
EDTkNrNpJGCrdfk1ekOZU2W0ec3ILxFfsMGZ4lemB5/D4xBgll8GfSfmm6AYKJw6
PzwaziqT6O4IPRTWj6cvwONdM55I66XyQ7WLn6mNQ2rkES3xzEBp0D97PuXPaWbk
OwJxmW7i57Lgv62GgUhOaewVN4yyElrTvQIfpr9nq3OqL/ghKnC/sU3KHtUSqSA+
adne53bmUhR2XzjoZZHd7JwDed+rVoQqt+wSuj0U8km6dVFR1uedcfu+XRyTYpvh
gSABixzbFZJEO3gmTAP5KBzVDoBKQlWSLoB70ADpvF6Ns+Bxax8=
=ap0J
-----END PGP SIGNATURE-----

--EuxKj2iCbKjpUGkD--
