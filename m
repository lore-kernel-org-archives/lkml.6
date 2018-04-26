Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755995AbeDZMHN (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 08:07:13 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:43103 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755405AbeDZMHB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 08:07:01 -0400
X-Google-Smtp-Source: AIpwx4+Me+FscpTCF6Pnv0vjHpaLG4LKeEPcSO6W8Tl9qIZ2h6x8AtuANCsYBiDCriNVZwKQTYYfaw==
Date: Thu, 26 Apr 2018 14:06:57 +0200
From: Thierry Reding <thierry.reding@gmail.com>
To: Vaishali Thakkar <vthakkar1994@gmail.com>
Cc: alexander.deucher@amd.com, christian.koenig@amd.com,
        David1.Zhou@amd.com, airlied@linux.ie, brodkin@synopsys.com,
        linux@armlinux.org.uk, boris.brezillon@bootlin.com,
        nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
        gustavo@padovan.org, maarten.lankhorst@linux.intel.com,
        seanpaul@chromium.org, l.stach@pengutronix.de,
        christian.gmeiner@gmail.com, inki.dae@samsung.com,
        jy0922.shim@samsung.com, sw0312.kim@samsung.com,
        kyungmin.park@samsung.com, kgene@kernel.org, krzk@kernel.org,
        stefan@agner.ch, alison.wang@freescale.com,
        z.liuxinliang@hisilicon.com, zourongrong@gmail.com,
        kong.kongxinwei@hisilicon.com, puck.chen@hisilicon.com,
        jani.nikula@linux.intel.com, joonas.lahtinen@linux.intel.com,
        rodrigo.vivi@intel.com, p.zabel@pengutronix.de, ck.hu@mediatek.com,
        matthias.bgg@gmail.com, robdclark@gmail.com, marex@denx.de,
        bskeggs@redhat.com, tomi.valkeinen@ti.com, eric@anholt.net,
        airlied@redhat.com, kraxel@redhat.com,
        laurent.pinchart@ideasonboard.com, hjc@rock-chips.com, heiko@sntech.de,
        benjamin.gaignard@linaro.org, vincent.abriou@st.com,
        yannick.fertre@st.com, philippe.cornu@st.com,
        maxime.ripard@bootlin.com, wens@csie.org, jonathanh@nvidia.com,
        noralf@tronnes.org, linus.walleij@linaro.org, shawnguo@kernel.org,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        etnaviv@lists.freedesktop.org, linux-samsung-soc@vger.kernel.org,
        intel-gfx@lists.freedesktop.org, linux-mediatek@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
        nouveau@lists.freedesktop.org,
        virtualization@lists.linux-foundation.org,
        linux-renesas-soc@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-tegra@vger.kernel.org
Subject: Re: [PATCH] drm/core: Remove drm_dev_unref() and it's uses
Message-ID: <20180426120657.GB11985@ulmo>
References: <20180426102819.6985-1-vthakkar1994@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="2B/JsCI69OhZNC5r"
Content-Disposition: inline
In-Reply-To: <20180426102819.6985-1-vthakkar1994@gmail.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--2B/JsCI69OhZNC5r
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 26, 2018 at 03:58:19PM +0530, Vaishali Thakkar wrote:
> It's been a while since we introduced drm_dev{get/put} functions
> to replace reference/unreference in drm subsystem for the
> consistency purpose. So, with this patch, let's just replace
> all current use cases of drm_dev_unref() with drm_dev_put and remove
> the function itself.
>=20
> Coccinelle was used for mass-patching.
>=20
> Signed-off-by: Vaishali Thakkar <vthakkar1994@gmail.com>

Yes, please.

Acked-by: Thierry Reding <treding@nvidia.com>

--2B/JsCI69OhZNC5r
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlrhwOAACgkQ3SOs138+
s6EGqg/+JmUt+aqBk15/OXUKzwedusn2nurTmzPRqGoZEK54C7+31kYWTZJrfyn8
0YB/LnpBFLPsv0n2h5NAxTqdrk3XwnZnsh74EFMWWLT0xj05ieLMg/TfbQmwM8p/
keZqR/h1C6MpS5KXblD2tM7Gx7Nsp35RdhchLobvvXR2yUDxZO4afSKCehyeVnuv
57JIN5zMp+bQkuBMwjIEcCIqOxjQv5ISLzifNFdmHWLIJ3RO6W17MyrFYJzzQEqe
x2PLjnaaSashIqtezCM8y3K04QvclybTHT9uQ1SB7YmEj+R4U/ywLLWkDr346hNL
uVsx2P4Rgnj9y0hqaf5f37Z0peThUWU0vcNRcHCfNPrzJhZa1EQDXkeLItACiSNO
+qJFncLsqNYuV/Pq5gcPLaQe3C88Uh//dL3HKN3b/3OfmXmQbVVH7XKRWng2U0Fm
oTxpOG1l/GSEwkr/gjpuebN2VkxmITYLHjKc2QYZtD2j49gB0CPEsK/pPC5vmdso
/OmBBSlkvG6wqmCwW7FfXD+m+rtV5s3pFTL99/37lKE6jLqteXbZB1eXWjCktDSG
SA8grVw8+LiTmKyNAhg+B85bgGm7TVuym+DqkzUaMjkdQlISjMGCX6jMHtjila0+
skm7Hqo/qwKR+I3JOa0TMtFKmKero2xpRcSk8EFI2fnUy1UBwoo=
=nKx9
-----END PGP SIGNATURE-----

--2B/JsCI69OhZNC5r--
