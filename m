Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751535AbeCLIrY (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 04:47:24 -0400
Received: from mail-qk0-f196.google.com ([209.85.220.196]:36451 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751293AbeCLIrV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 04:47:21 -0400
X-Google-Smtp-Source: AG47ELst5F21C9HjIhwnygGRQQH5iTcjRm+z8eIfDJlzZEmuzzUnCYF+UmoxjDkR+Y6RFbuGhHjPhA==
Date: Mon, 12 Mar 2018 09:47:17 +0100
From: Thierry Reding <thierry.reding@gmail.com>
To: Philippe Cornu <philippe.cornu@st.com>
Cc: David Airlie <airlied@linux.ie>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andrzej Hajda <a.hajda@samsung.com>,
        Yannick Fertre <yannick.fertre@st.com>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Vincent Abriou <vincent.abriou@st.com>,
        Alexandre Torgue <alexandre.torgue@st.com>
Subject: Re: [PATCH v1 0/2] drm/panel: otm8009a: Add support for the optional
 power-supply
Message-ID: <20180312084717.GH23060@ulmo>
References: <20180205094532.23547-1-philippe.cornu@st.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="SdvjNjn6lL3tIsv0"
Content-Disposition: inline
In-Reply-To: <20180205094532.23547-1-philippe.cornu@st.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--SdvjNjn6lL3tIsv0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 05, 2018 at 10:45:30AM +0100, Philippe Cornu wrote:
> Some boards use a dedicated voltage regulator for this panel.
> Add & Document this related optional power-supply property and
> add its support in the driver.
>=20
> Philippe Cornu (2):
>   dt-bindings/display/panel: otm8009a: Add optional power-supply
>     property
>   drm/panel: otm8009a: Add support for the optional power-supply
>=20
>  .../bindings/display/panel/orisetech,otm8009a.txt       |  2 ++
>  drivers/gpu/drm/panel/panel-orisetech-otm8009a.c        | 17 +++++++++++=
++++++
>  2 files changed, 19 insertions(+)

Applied, thanks.

Thierry

--SdvjNjn6lL3tIsv0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlqmPpMACgkQ3SOs138+
s6GJnA/+In1vAI/NArDvL8NF2ylEVkauDjndM/+IxJsM2GUZZZiF6HBrJ3iOH9I0
j2uGLNvDtlMJNZqs4oMs++iunBQQB5WuucxIFDPrpqCyW5oR2HeqijJ6I2TuZWKS
HRLoqTtf9JJO2hJ5thmVY9pue6NpjUvqML26TX0gAi6LGqf/NgkmN1AdJkcF/qpy
7O6BBHVfVDah7oK44G3mGQQ7anr639Jfj/bXzalIqeahBUK22ySLni7yxIC9ZWUY
H5kx9V45dqIxZoFB2Btf3kgHNCqyxJC/NfYQuxRYwnCvZWpoFwHZzCzTsToOk0+x
Z+4Qfrj0KukkAq+WWhe0RDkSls3W0nDE91YVVIpmIZbn0sxVPiq0wyZs2Ra55nob
1TNM2iKXMFcIBNMQxpGeklAHIf9y4K/yAlF+wTSqWWO7A4z08Vx0dn5REGw1TImw
UCzpV6Zb6OGgFPaPcFSRBWjzjAkZiXUF6+cSv/e/AdEcM/qgRrgdzXlsOxRiWYIm
aSAE7HNRetgorHtkb2LjNfO1dBJusj9hpucdjf8NrcALoBO3mC6JhnBktcvIX35N
Dde/TMVHeRsOfcf7TyE8HzTVaCHTzaJV0IXQmFUhQdQ/3yaW5eWwwQZ4me+6Sno6
gwVV0R2cpG7LoXp4AISMSDP1Hc4APZPcsBT2mKEblUGUS+jIwqw=
=J30a
-----END PGP SIGNATURE-----

--SdvjNjn6lL3tIsv0--
