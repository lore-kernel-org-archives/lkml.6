Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932574AbeD0Jf5 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 27 Apr 2018 05:35:57 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:51964 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757251AbeD0Jfz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Apr 2018 05:35:55 -0400
X-Google-Smtp-Source: AB8JxZqb2/QsUFvIXThFKH89mO5Fps4syOOiBPBOJ7TbS57s1qhncCA5oSvkfwvzbvQowdUP56GlDA==
Date: Fri, 27 Apr 2018 11:35:51 +0200
From: Thierry Reding <thierry.reding@gmail.com>
To: Dmitry Osipenko <digetx@gmail.com>
Cc: Jonathan Hunter <jonathanh@nvidia.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 03/15] dt-bindings: arm: tegra: Document #reset-cells
 property of the Tegra20 MC
Message-ID: <20180427093551.GE30388@ulmo>
References: <cover.1523301400.git.digetx@gmail.com>
 <57c08ef0d2e3dbc6ad0e91f426c5db5b181b0ab9.1523301400.git.digetx@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="9l24NVCWtSuIVIod"
Content-Disposition: inline
In-Reply-To: <57c08ef0d2e3dbc6ad0e91f426c5db5b181b0ab9.1523301400.git.digetx@gmail.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--9l24NVCWtSuIVIod
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 09, 2018 at 10:28:25PM +0300, Dmitry Osipenko wrote:
> Memory Controller has a memory client "hot reset" functionality, which
> resets the DMA interface of a memory client, so MC is a reset controller.
>=20
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
> ---
>  .../devicetree/bindings/arm/tegra/nvidia,tegra20-mc.txt      | 12 ++++++=
+++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)

Applied, thanks.

Thierry

--9l24NVCWtSuIVIod
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlri7vcACgkQ3SOs138+
s6FFzg//VbGfA34eRjRnxNLCNMPq1olcNcM3iZP1AYukwz44LAQammCrriTVw36C
xRBLWkj52snduN+HJzTNnIdXp8ioW5SZhraBrJQ3SZLJ2tW2R2Cx1LAvkZsxTDQ/
7yj4uKZG1mi/7R1JDH//Gdgkd6WSTe8A1EdBqXksUs52EHpkggcBSnL5rrCqW+Bf
v6GDDCpiMFkmwxzk85eBTP/m3MtSGl6vdfe/IP+9maC/7THP4ITx8Oy40BIIFpGk
7saofaivkxegp/k5wfWcHUNwwajRM+6GKhuv8JbHVw9KDKmulNRmc72U0wqmQGM2
GpKOlTONCtySmEEut0biYBWwwnC5LEEHhOG5kkuuiNNXgm4tHARa97kyvDIP15cg
2BBqapv+EfxvBZc4yC2iWME0MR6en5Ujlxl3FOyGwgni54mC3Ys9FVWO5pjd41Vq
QZZQHHWS3iJOM2rXQ1hbzmWjsxiDtni5TnzR/ravAJaRKiiwMFh8ZlxKgUTx3GVr
3KBTc6KIoJh+ITP0TFvVPg7NdDN2CnIOt/RleTuVB1aE//g/wuAnmXWo9lNhgwE+
evj0yEDlNjBbtYOz9WsUbRUYnRfONM/rZ575+UFLD+oz3gv7MKu+ypD9DTuEBU1P
7e+Z83hcNPKbHpMzvGdUKejhF1rWIaD5LBad2iscAANsameiZAk=
=3lhz
-----END PGP SIGNATURE-----

--9l24NVCWtSuIVIod--
