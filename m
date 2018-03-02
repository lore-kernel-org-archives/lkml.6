Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1947275AbeCBSfH (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Mar 2018 13:35:07 -0500
Received: from mail-wr0-f193.google.com ([209.85.128.193]:35683 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1423170AbeCBSfE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Mar 2018 13:35:04 -0500
X-Google-Smtp-Source: AG47ELtGgrxSKtTu7CsQeeyd7t14t6qYKGGGrUmnyKau9mjSd+H8Fo2u1VIyUXQuEIVxeY7Gq2/EFw==
Reply-To: monstr@monstr.eu
Subject: Re: [PATCH v2 2/8] arm64: zynqmp: Add support for Xilinx zcu100-revC
To: Rob Herring <robh@kernel.org>, Michal Simek <michal.simek@xilinx.com>
Cc: devicetree@vger.kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org
References: <cover.1519396753.git.michal.simek@xilinx.com>
 <26229dbbeb0ced5db870a8cf636f6d3d5855199e.1519396753.git.michal.simek@xilinx.com>
 <20180302164037.5mzzc4ixxvph46bf@rob-hp-laptop>
From: Michal Simek <monstr@monstr.eu>
Message-ID: <c9d4bc3a-888e-3faf-4b1d-6ad309048078@monstr.eu>
Date: Fri, 2 Mar 2018 19:34:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180302164037.5mzzc4ixxvph46bf@rob-hp-laptop>
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="kbsh59HFKHPzad0hn73OVIEn68oZPEiM5"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--kbsh59HFKHPzad0hn73OVIEn68oZPEiM5
Content-Type: multipart/mixed; boundary="6Oy8QFoVwyWDeAe1eQ0NcJQZDrVDJmbWi";
 protected-headers="v1"
From: Michal Simek <monstr@monstr.eu>
Reply-To: monstr@monstr.eu
To: Rob Herring <robh@kernel.org>, Michal Simek <michal.simek@xilinx.com>
Cc: devicetree@vger.kernel.org,
 Masahiro Yamada <yamada.masahiro@socionext.com>,
 linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
 Will Deacon <will.deacon@arm.com>, Catalin Marinas
 <catalin.marinas@arm.com>, Mark Rutland <mark.rutland@arm.com>,
 linux-arm-kernel@lists.infradead.org
Message-ID: <c9d4bc3a-888e-3faf-4b1d-6ad309048078@monstr.eu>
Subject: Re: [PATCH v2 2/8] arm64: zynqmp: Add support for Xilinx zcu100-revC
References: <cover.1519396753.git.michal.simek@xilinx.com>
 <26229dbbeb0ced5db870a8cf636f6d3d5855199e.1519396753.git.michal.simek@xilinx.com>
 <20180302164037.5mzzc4ixxvph46bf@rob-hp-laptop>
In-Reply-To: <20180302164037.5mzzc4ixxvph46bf@rob-hp-laptop>

--6Oy8QFoVwyWDeAe1eQ0NcJQZDrVDJmbWi
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 2.3.2018 17:40, Rob Herring wrote:
> On Fri, Feb 23, 2018 at 03:40:24PM +0100, Michal Simek wrote:
>> This board has 2GB of memory, i2c, sd, wifi sdio, spis, uarts, display=

>> port and usbs.
>> Board is using fixed clocks because clock driver hasn't been merged ye=
t.
>=20
> Please get rid of the separate clocks dts file when it is merged.

Will do.

Thanks,
Michal


--=20
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Xilinx Microblaze
Maintainer of Linux kernel - Xilinx Zynq ARM and ZynqMP ARM64 SoCs
U-Boot custodian - Xilinx Microblaze/Zynq/ZynqMP SoCs



--6Oy8QFoVwyWDeAe1eQ0NcJQZDrVDJmbWi--

--kbsh59HFKHPzad0hn73OVIEn68oZPEiM5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlqZmU8ACgkQykllyylKDCE1gQCggOmXIasnpUKolKc8n59HowKj
qCYAniFgkaKjktrG3i4pRLEzj1Hv3Ln0
=XM8W
-----END PGP SIGNATURE-----

--kbsh59HFKHPzad0hn73OVIEn68oZPEiM5--
