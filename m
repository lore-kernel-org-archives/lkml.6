Return-Path: <SRS0=4jry=KT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A588C4646F
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 11:11:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A91E4217CC
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 11:11:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A91E4217CC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hauke-m.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728279AbeHDNLk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Aug 2018 09:11:40 -0400
Received: from mx1.mailbox.org ([80.241.60.212]:17854 "EHLO mx1.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726550AbeHDNLk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Aug 2018 09:11:40 -0400
Received: from smtp1.mailbox.org (smtp1.mailbox.org [80.241.60.240])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.mailbox.org (Postfix) with ESMTPS id CBC6F48A66;
        Sat,  4 Aug 2018 13:11:15 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp1.mailbox.org ([80.241.60.240])
        by spamfilter01.heinlein-hosting.de (spamfilter01.heinlein-hosting.de [80.241.56.115]) (amavisd-new, port 10030)
        with ESMTP id Y5N9gQU_QThB; Sat,  4 Aug 2018 13:11:13 +0200 (CEST)
Subject: Re: [PATCH v2 04/18] MIPS: dts: Add initial support for Intel MIPS
 SoCs
To:     Songjun Wu <songjun.wu@linux.intel.com>, hua.ma@linux.intel.com,
        yixin.zhu@linux.intel.com, chuanhua.lei@linux.intel.com,
        qi-ming.wu@intel.com
Cc:     linux-mips@linux-mips.org, linux-clk@vger.kernel.org,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        James Hogan <jhogan@kernel.org>, linux-kernel@vger.kernel.org,
        Paul Burton <paul.burton@mips.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>
References: <20180803030237.3366-1-songjun.wu@linux.intel.com>
 <20180803030237.3366-5-songjun.wu@linux.intel.com>
From:   Hauke Mehrtens <hauke@hauke-m.de>
Message-ID: <4f58b5ee-1e3c-7d39-258e-e4525d78db0b@hauke-m.de>
Date:   Sat, 4 Aug 2018 13:11:07 +0200
MIME-Version: 1.0
In-Reply-To: <20180803030237.3366-5-songjun.wu@linux.intel.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="X0b2gHnRoDWWhZa0XmgbmDwsF2zwlMDFd"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--X0b2gHnRoDWWhZa0XmgbmDwsF2zwlMDFd
Content-Type: multipart/mixed; boundary="kTYbZNGrF8dpzU7F9ObS8ZoN8nmGoFTOF";
 protected-headers="v1"
From: Hauke Mehrtens <hauke@hauke-m.de>
To: Songjun Wu <songjun.wu@linux.intel.com>, hua.ma@linux.intel.com,
 yixin.zhu@linux.intel.com, chuanhua.lei@linux.intel.com, qi-ming.wu@intel.com
Cc: linux-mips@linux-mips.org, linux-clk@vger.kernel.org,
 linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
 James Hogan <jhogan@kernel.org>, linux-kernel@vger.kernel.org,
 Paul Burton <paul.burton@mips.com>, Rob Herring <robh+dt@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>, Ralf Baechle <ralf@linux-mips.org>
Message-ID: <4f58b5ee-1e3c-7d39-258e-e4525d78db0b@hauke-m.de>
Subject: Re: [PATCH v2 04/18] MIPS: dts: Add initial support for Intel MIPS
 SoCs
References: <20180803030237.3366-1-songjun.wu@linux.intel.com>
 <20180803030237.3366-5-songjun.wu@linux.intel.com>
In-Reply-To: <20180803030237.3366-5-songjun.wu@linux.intel.com>

--kTYbZNGrF8dpzU7F9ObS8ZoN8nmGoFTOF
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 08/03/2018 05:02 AM, Songjun Wu wrote:
> From: Hua Ma <hua.ma@linux.intel.com>
>=20
> Add dts files to support Intel MIPS SoCs:
> - xrx500.dtsi is the chip dts
> - easy350_anywan.dts is the board dts
>=20
> Signed-off-by: Hua Ma <hua.ma@linux.intel.com>
> Signed-off-by: Songjun Wu <songjun.wu@linux.intel.com>
> ---
>=20
> Changes in v2:
> - New patch split from previous patch
> - The memory address is changed to @20000000
> - Update to obj-$(CONFIG_BUILTIN_DTB) as per commit fca3aa166422
>=20
>  arch/mips/boot/dts/Makefile                      |  1 +
>  arch/mips/boot/dts/intel-mips/Makefile           |  4 ++
>  arch/mips/boot/dts/intel-mips/easy350_anywan.dts | 26 ++++++++++
>  arch/mips/boot/dts/intel-mips/xrx500.dtsi        | 66 ++++++++++++++++=
++++++++
>  4 files changed, 97 insertions(+)
>  create mode 100644 arch/mips/boot/dts/intel-mips/Makefile
>  create mode 100644 arch/mips/boot/dts/intel-mips/easy350_anywan.dts
>  create mode 100644 arch/mips/boot/dts/intel-mips/xrx500.dtsi
>=20
> diff --git a/arch/mips/boot/dts/Makefile b/arch/mips/boot/dts/Makefile
> index 1e79cab8e269..05f52f279047 100644
> --- a/arch/mips/boot/dts/Makefile
> +++ b/arch/mips/boot/dts/Makefile
> @@ -3,6 +3,7 @@ subdir-y	+=3D brcm
>  subdir-y	+=3D cavium-octeon
>  subdir-y	+=3D img
>  subdir-y	+=3D ingenic
> +subdir-y	+=3D intel-mips
>  subdir-y	+=3D lantiq
>  subdir-y	+=3D mscc
>  subdir-y	+=3D mti
> diff --git a/arch/mips/boot/dts/intel-mips/Makefile b/arch/mips/boot/dt=
s/intel-mips/Makefile
> new file mode 100644
> index 000000000000..adfaabbbb07c
> --- /dev/null
> +++ b/arch/mips/boot/dts/intel-mips/Makefile
> @@ -0,0 +1,4 @@
> +# SPDX-License-Identifier: GPL-2.0
> +dtb-$(CONFIG_DTB_INTEL_MIPS_GRX500)	+=3D easy350_anywan.dtb
> +
> +obj-$(CONFIG_BUILTIN_DTB)		+=3D $(addsuffix .o, $(dtb-y))
> diff --git a/arch/mips/boot/dts/intel-mips/easy350_anywan.dts b/arch/mi=
ps/boot/dts/intel-mips/easy350_anywan.dts
> new file mode 100644
> index 000000000000..e5e95f90c5e7
> --- /dev/null
> +++ b/arch/mips/boot/dts/intel-mips/easy350_anywan.dts
> @@ -0,0 +1,26 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/dts-v1/;
> +
> +#include <dt-bindings/interrupt-controller/mips-gic.h>
> +#include <dt-bindings/clock/intel,grx500-clk.h>
> +
> +#include "xrx500.dtsi"
> +
> +/ {
> +	model =3D "EASY350 ANYWAN (GRX350) Main model";

Main model can be removed, it does not identify the board.

> +	compatible =3D "intel,easy350-anywan";

I think this should be
	compatible =3D "intel,easy350-anywan", "intel,xrx500";

Are there different revisions of the EASY350 Anywan board or only of the
EASY550 board?There are at least some differences in the power supply on
the EASY550 V1 and EASY550 V2 board. I would suggest to be here very
specific to make it easier when adding more boards.

> +
> +	aliases {
> +		serial0 =3D &asc0;
> +	};
> +
> +	chosen {
> +		bootargs =3D "earlycon=3Dlantiq,0x16600000 clk_ignore_unused";

What happens when you remove clk_ignore_unused?
If it crashes we should probably define some of the clock to be always
active.

> +		stdout-path =3D "serial0";
> +	};
> +
> +	memory@20000000 {
> +		device_type =3D "memory";
> +		reg =3D <0x20000000 0x0e000000>;
> +	};
> +};
> diff --git a/arch/mips/boot/dts/intel-mips/xrx500.dtsi b/arch/mips/boot=
/dts/intel-mips/xrx500.dtsi
> new file mode 100644
> index 000000000000..54c5f8f8b604
> --- /dev/null
> +++ b/arch/mips/boot/dts/intel-mips/xrx500.dtsi
> @@ -0,0 +1,66 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +/ {
> +	#address-cells =3D <1>;
> +	#size-cells =3D <1>;
> +	compatible =3D "intel,xrx500";
> +
> +	cpus {
> +		#address-cells =3D <1>;
> +		#size-cells =3D <0>;
> +
> +		cpu0: cpu@0 {
> +			device_type =3D "cpu";
> +			compatible =3D "mti,interaptiv";
> +			clocks =3D <&cgu CLK_CPU>;
> +			reg =3D <0>;
> +		};
> +
> +		cpu1: cpu@1 {
> +			device_type =3D "cpu";
> +			compatible =3D "mti,interaptiv";
> +			reg =3D <1>;
> +		};
> +	};
> +
> +	cpu_intc: interrupt-controller {
> +		compatible =3D "mti,cpu-interrupt-controller";
> +
> +		interrupt-controller;
> +		#interrupt-cells =3D <1>;
> +	};
> +
> +	gic: gic@12320000 {
> +		compatible =3D "mti,gic";
> +		reg =3D <0x12320000 0x20000>;
> +
> +		interrupt-controller;
> +		#interrupt-cells =3D <3>;
> +		/*
> +		 * Declare the interrupt-parent even though the mti,gic
> +		 * binding doesn't require it, such that the kernel can
> +		 * figure out that cpu_intc is the root interrupt
> +		 * controller & should be probed first.
> +		 */
> +		interrupt-parent =3D <&cpu_intc>;
> +		mti,reserved-ipi-vectors =3D <56 8>;
> +	};
> +
> +	cgu: cgu@16200000 {
> +		compatible =3D "intel,grx500-cgu", "syscon";
> +		reg =3D <0x16200000 0x200>;
> +		#clock-cells =3D <1>;
> +	};
> +
> +	asc0: serial@16600000 {
> +		compatible =3D "lantiq,asc";
> +		reg =3D <0x16600000 0x100000>;
> +
> +		interrupt-parent =3D <&gic>;
> +		interrupts =3D <GIC_SHARED 103 IRQ_TYPE_LEVEL_HIGH>,
> +			<GIC_SHARED 105 IRQ_TYPE_LEVEL_HIGH>,
> +			<GIC_SHARED 106 IRQ_TYPE_LEVEL_HIGH>;
> +		clocks =3D <&cgu CLK_SSX4>, <&cgu GCLK_UART>;
> +		clock-names =3D "freq", "asc";
> +	};
> +};
>=20



--kTYbZNGrF8dpzU7F9ObS8ZoN8nmGoFTOF--

--X0b2gHnRoDWWhZa0XmgbmDwsF2zwlMDFd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEyz0/uAcd+JwXmwtD8bdnhZyy68cFAltlicsACgkQ8bdnhZyy
68fF3Qf+MUOxtnxWC/uB7FeRDczLlhwmZSY6lm1xguQ9SzeFRm0Nq+rScWLYqoO7
KEeMILOplCoo67uHvZ5LElWiobLI3g3PFF/pAVhAVAAcgYsI5VO4rmBKK43UQrSP
PFehXjDZd8Dn4+QFKAs9cvCImQOjzhW91TBFRJfBsk6jxz7FMXeFfolZTfBpiPex
RmXKk9jZndztrF5gbcx9W+NueVUl6EKReamn18/snleNF6JIb9TnnChIlDMo/XxX
Dc59MD6k4d65np44Onx73iWsT/gxdR0PjpEr8hZDH2XCbuHjSrVLoKs/AnBN40Ra
x30Z27Zn2p5QHN4OmbG8hLd/JeqVgg==
=jV+X
-----END PGP SIGNATURE-----

--X0b2gHnRoDWWhZa0XmgbmDwsF2zwlMDFd--
