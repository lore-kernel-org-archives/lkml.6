Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1946623AbeCBTQl (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Mar 2018 14:16:41 -0500
Received: from mail-wr0-f193.google.com ([209.85.128.193]:40115 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1423640AbeCBTQj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Mar 2018 14:16:39 -0500
X-Google-Smtp-Source: AG47ELvR6WxpkL1D2oeVpXNA0b0HQht9a7xouT0wtS0rKGRII8xqI+cAf+HhZSJzNEf46/nrikBS1Q==
Reply-To: monstr@monstr.eu
Subject: Re: [PATCH v2 2/5] arm: zynq: Add support for Xilinx zc770 xm010 dc1
 board
To: Rob Herring <robh@kernel.org>, Michal Simek <michal.simek@xilinx.com>
Cc: devicetree@vger.kernel.org,
        Steffen Trumtrar <s.trumtrar@pengutronix.de>,
        linux-kernel@vger.kernel.org,
        Peter Crosthwaite <peter.crosthwaite@xilinx.com>,
        Rob Herring <robherring2@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Josh Cartwright <josh.cartwright@ni.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org
References: <cover.1519398009.git.michal.simek@xilinx.com>
 <f049c5121edab27227337ccd607db4f38f8d76f3.1519398009.git.michal.simek@xilinx.com>
 <20180302185006.yciyjcchsx4aa7lu@rob-hp-laptop>
From: Michal Simek <monstr@monstr.eu>
Message-ID: <1ec3a67e-92b3-0453-44a2-24b23ffc9ac2@monstr.eu>
Date: Fri, 2 Mar 2018 20:16:27 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180302185006.yciyjcchsx4aa7lu@rob-hp-laptop>
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="n7k205uWTnJROWKfP9is9FORQovKuwKlP"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--n7k205uWTnJROWKfP9is9FORQovKuwKlP
Content-Type: multipart/mixed; boundary="AbgkejVHAhXsanA6AHv46YmervkS7jiyg";
 protected-headers="v1"
From: Michal Simek <monstr@monstr.eu>
Reply-To: monstr@monstr.eu
To: Rob Herring <robh@kernel.org>, Michal Simek <michal.simek@xilinx.com>
Cc: devicetree@vger.kernel.org, Steffen Trumtrar <s.trumtrar@pengutronix.de>,
 linux-kernel@vger.kernel.org,
 Peter Crosthwaite <peter.crosthwaite@xilinx.com>,
 Rob Herring <robherring2@gmail.com>, Mark Rutland <mark.rutland@arm.com>,
 Josh Cartwright <josh.cartwright@ni.com>,
 Russell King <linux@armlinux.org.uk>, linux-arm-kernel@lists.infradead.org
Message-ID: <1ec3a67e-92b3-0453-44a2-24b23ffc9ac2@monstr.eu>
Subject: Re: [PATCH v2 2/5] arm: zynq: Add support for Xilinx zc770 xm010 dc1
 board
References: <cover.1519398009.git.michal.simek@xilinx.com>
 <f049c5121edab27227337ccd607db4f38f8d76f3.1519398009.git.michal.simek@xilinx.com>
 <20180302185006.yciyjcchsx4aa7lu@rob-hp-laptop>
In-Reply-To: <20180302185006.yciyjcchsx4aa7lu@rob-hp-laptop>

--AbgkejVHAhXsanA6AHv46YmervkS7jiyg
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 2.3.2018 19:50, Rob Herring wrote:
> On Fri, Feb 23, 2018 at 04:00:20PM +0100, Michal Simek wrote:
>> zc770 is based board which is extended by FMC/DC cards for SoC
>> validation. FMCs/DCs are supposed to cover all SoC configurations.
>> FMC/DC contains ethernet port, can, i2c, sd, qspi, spi, uart and usb.
>>
>> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
>> ---
>>
>> Changes in v2:
>> - Record compatible string to xilinx.txt
>>
>>  Documentation/devicetree/bindings/arm/xilinx.txt |  3 +
>>  arch/arm/boot/dts/Makefile                       |  1 +
>>  arch/arm/boot/dts/zynq-zc770-xm010.dts           | 92 +++++++++++++++=
+++++++++
>>  3 files changed, 96 insertions(+)
>>  create mode 100644 arch/arm/boot/dts/zynq-zc770-xm010.dts
>>
>> diff --git a/Documentation/devicetree/bindings/arm/xilinx.txt b/Docume=
ntation/devicetree/bindings/arm/xilinx.txt
>> index 425c74fcc560..019e69037d42 100644
>> --- a/Documentation/devicetree/bindings/arm/xilinx.txt
>> +++ b/Documentation/devicetree/bindings/arm/xilinx.txt
>> @@ -11,6 +11,9 @@ Additional compatible strings:
>>  - Xilinx internal board cc108
>>    "xlnx,zynq-cc108"
>> =20
>> +- Xilinx internal board zc770 with different FMC cards
>> +  "xlnx,zynq-zc770-xm010"
>> +
>>  ---------------------------------------------------------------
>> =20
>>  Xilinx Zynq UltraScale+ MPSoC Platforms Device Tree Bindings
>> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
>> index c6810e84d4d7..be9ffae2a1ec 100644
>> --- a/arch/arm/boot/dts/Makefile
>> +++ b/arch/arm/boot/dts/Makefile
>> @@ -1067,6 +1067,7 @@ dtb-$(CONFIG_ARCH_ZYNQ) +=3D \
>>  	zynq-parallella.dtb \
>>  	zynq-zc702.dtb \
>>  	zynq-zc706.dtb \
>> +	zynq-zc770-xm010.dtb \
>>  	zynq-zed.dtb \
>>  	zynq-zybo.dtb
>>  dtb-$(CONFIG_MACH_ARMADA_370) +=3D \
>> diff --git a/arch/arm/boot/dts/zynq-zc770-xm010.dts b/arch/arm/boot/dt=
s/zynq-zc770-xm010.dts
>> new file mode 100644
>> index 000000000000..b1cfb4ede434
>> --- /dev/null
>> +++ b/arch/arm/boot/dts/zynq-zc770-xm010.dts
>> @@ -0,0 +1,92 @@
>> +// SPDX-License-Identifier: GPL-2.0+
>> +/*
>> + * Xilinx ZC770 XM010 board DTS
>> + *
>> + * Copyright (C) 2013-2018 Xilinx, Inc.
>> + */
>> +/dts-v1/;
>> +#include "zynq-7000.dtsi"
>> +
>> +/ {
>> +	compatible =3D "xlnx,zynq-zc770-xm010", "xlnx,zynq-7000";
>> +	model =3D "Xilinx Zynq";
>> +
>> +	aliases {
>> +		ethernet0 =3D &gem0;
>> +		i2c0 =3D &i2c0;
>> +		serial0 =3D &uart1;
>> +		spi1 =3D &spi1;
>> +	};
>> +
>> +	chosen {
>> +		bootargs =3D "";
>> +		stdout-path =3D "serial0:115200n8";
>> +	};
>> +
>> +	memory@0 {
>> +		device_type =3D "memory";
>> +		reg =3D <0x0 0x40000000>;
>> +	};
>> +
>> +	usb_phy0: phy0 {
>> +		compatible =3D "usb-nop-xceiv";
>> +		#phy-cells =3D <0>;
>> +	};
>> +};
>> +
>> +&can0 {
>> +	status =3D "okay";
>> +};
>> +
>> +&gem0 {
>> +	status =3D "okay";
>> +	phy-mode =3D "rgmii-id";
>> +	phy-handle =3D <&ethernet_phy>;
>> +
>> +	ethernet_phy: ethernet-phy@7 {
>> +		reg =3D <7>;
>> +		device_type =3D "ethernet-phy";
>> +	};
>> +};
>> +
>> +&i2c0 {
>> +	status =3D "okay";
>> +	clock-frequency =3D <400000>;
>> +
>> +	eeprom: eeprom@52 {
>> +		compatible =3D "atmel,24c02";
>> +		reg =3D <0x52>;
>> +	};
>> +
>> +};
>> +
>> +&sdhci0 {
>> +	status =3D "okay";
>> +};
>> +
>> +&spi1 {
>> +	status =3D "okay";
>> +	num-cs =3D <4>;
>> +	is-decoded-cs =3D <0>;
>> +	flash@0 {
>> +		compatible =3D "sst25wf080", "jedec,spi-nor";
>> +		reg =3D <1>;
>> +		spi-max-frequency =3D <1000000>;
>> +		#address-cells =3D <1>;
>> +		#size-cells =3D <1>;
>> +		partition@test {
>=20
> @test?
>=20
> Use a partitions node too.

ok done.

>=20
>> +			label =3D "spi-flash";
>=20
> Should be what the partition contains.


I have fixed this to data.

Thanks,
M

--=20
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Xilinx Microblaze
Maintainer of Linux kernel - Xilinx Zynq ARM and ZynqMP ARM64 SoCs
U-Boot custodian - Xilinx Microblaze/Zynq/ZynqMP SoCs



--AbgkejVHAhXsanA6AHv46YmervkS7jiyg--

--n7k205uWTnJROWKfP9is9FORQovKuwKlP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlqZowsACgkQykllyylKDCG4igCbBgUNePpMOTFkiehMJ1Y9Kqcc
iA8AniwvFudHYy3+qjdsWhvenerK2YfE
=YVS8
-----END PGP SIGNATURE-----

--n7k205uWTnJROWKfP9is9FORQovKuwKlP--
