Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id E802CC433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 16:27:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FC26208C3
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 16:27:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9FC26208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964810AbeFNQ1R (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 12:27:17 -0400
Received: from mga09.intel.com ([134.134.136.24]:4901 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755220AbeFNQ1M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 12:27:12 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Jun 2018 09:27:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,222,1526367600"; 
   d="asc'?scan'208";a="47778123"
Received: from jtkirshe-nuc.jf.intel.com ([134.134.177.59])
  by fmsmga008.fm.intel.com with ESMTP; 14 Jun 2018 09:27:10 -0700
Message-ID: <fe2520d95598838cb4fcfca93b635de002cbf68a.camel@intel.com>
Subject: Re: [Intel-wired-lan] [PATCH v3 16/27] docs: Fix more broken
 references
From:   Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Reply-To: jeffrey.t.kirsher@intel.com
To:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-samsung-soc@vger.kernel.org,
        Jonathan Corbet <corbet@lwn.net>, netdev@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-rockchip@lists.infradead.org, linux-usb@vger.kernel.org,
        intel-wired-lan@lists.osuosl.org, linux-fsdevel@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Date:   Thu, 14 Jun 2018 09:28:52 -0700
In-Reply-To: <e1bf52a721005b2017434acc54ec5ddc152d6fe4.1528990947.git.mchehab+samsung@kernel.org>
References: <cover.1528990947.git.mchehab+samsung@kernel.org>
         <e1bf52a721005b2017434acc54ec5ddc152d6fe4.1528990947.git.mchehab+samsung@kernel.org>
Organization: Intel
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-EsPVn4RCUwsrPVEmUoPX"
X-Mailer: Evolution 3.28.2 (3.28.2-1.fc28) 
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-EsPVn4RCUwsrPVEmUoPX
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2018-06-14 at 13:09 -0300, Mauro Carvalho Chehab wrote:
> As we move stuff around, some doc references are broken. Fix some of
> them via this script:
>         ./scripts/documentation-file-ref-check --fix
>=20
> Manually checked that produced results are valid.
>=20
> Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>

Acked-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>

For the Intel networking Kconfig changes.

> ---
>  .../devicetree/bindings/clock/st/st,clkgen.txt |  8 ++++----
>  .../devicetree/bindings/clock/ti/gate.txt      |  2 +-
>  .../devicetree/bindings/clock/ti/interface.txt |  2 +-
>  .../bindings/cpufreq/cpufreq-mediatek.txt      |  2 +-
>  .../devicetree/bindings/devfreq/rk3399_dmc.txt |  2 +-
>  .../bindings/gpu/arm,mali-midgard.txt          |  2 +-
>  .../bindings/gpu/arm,mali-utgard.txt           |  2 +-
>  .../devicetree/bindings/mfd/mt6397.txt         |  2 +-
>  .../devicetree/bindings/mfd/sun6i-prcm.txt     |  2 +-
>  .../devicetree/bindings/mmc/exynos-dw-mshc.txt |  2 +-
>  .../devicetree/bindings/net/dsa/ksz.txt        |  2 +-
>  .../devicetree/bindings/net/dsa/mt7530.txt     |  2 +-
>  .../devicetree/bindings/power/fsl,imx-gpc.txt  |  2 +-
>  .../bindings/power/wakeup-source.txt           |  2 +-
>  .../devicetree/bindings/usb/rockchip,dwc3.txt  |  2 +-
>  Documentation/hwmon/ina2xx                     |  2 +-
>  Documentation/maintainer/pull-requests.rst     |  2 +-
>  Documentation/translations/ko_KR/howto.rst     |  2 +-
>  MAINTAINERS                                    | 18 +++++++++-------
> --
>  drivers/net/ethernet/intel/Kconfig             |  8 ++++----
>  drivers/soundwire/stream.c                     |  8 ++++----
>  fs/Kconfig.binfmt                              |  2 +-
>  fs/binfmt_misc.c                               |  2 +-
>  23 files changed, 40 insertions(+), 40 deletions(-)

--=-EsPVn4RCUwsrPVEmUoPX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiTyZWz+nnTrOJ1LZ5W/vlVpL7c4FAlsil8QACgkQ5W/vlVpL
7c6fBg//Y8A7h4cFk1ok818ypCr+83eIxdf+QFGtiW+7F5i5tuBtttRUgDfEQ2cH
4kYMLgAlHBNirmCkS4sw3RPLY6nx2JOZRoPcqltIpDNDB6adZafoGEC9RCEsLoGD
OcQqMFzLcZbJYZDpNmJO1HmEVoLoc2tS98wCKadC7bTrYYO0awKCiJePSXKLo+lh
tkzN5W227SqWEQ9CW782vEFo3x9nT7UZR2OBU+7aXUJaf8JH/7gBW1pm+wsdYsmY
rmoOYzZoDHJMY8JKz0baukbezWQIBpJV7BGw2qFhOmmDyWigWaAedrhfOng/oSRa
FZjM3WcOso5cucYQ5Xx4n/d5hxQw8S+0nEUfE+fByGofPBZAKmwpOr5kgdsjfKhh
leOB1/eeCl3jLOJ0LFcl2H2XR1uvzDZtkXRt2/LUu/tpn5RgK8LtZaMNmBzWCLHi
/1KniV2BAXuBA3jphpRoxGgSpiIqeVKPvK0cvLBIfryv3R4LsKDmROgBHVrQ7O6D
Kkcs3RFl1eTjX/RCLQUPW1wy6AaPJ0999Cob5arUlbWQZuF0FANdzC71yfs1d1c0
u190osB7AEq14iMmV+5XzUpRzcGW+k96ywye8jmJP/liFw0KOPq6qDg0BkT3Bt57
zxmHQtzIkg6rNMNANeBoW6WxRQt+KcmMyAEvdQ+mEY1vMcNs0w8=
=PJNP
-----END PGP SIGNATURE-----

--=-EsPVn4RCUwsrPVEmUoPX--

