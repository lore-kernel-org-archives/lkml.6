Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 579CAC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 06:46:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28D8C2176F
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 06:46:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725785AbeLTGqh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 01:46:37 -0500
Received: from mga05.intel.com ([192.55.52.43]:13873 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725300AbeLTGqg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 01:46:36 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Dec 2018 22:46:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,376,1539673200"; 
   d="asc'?scan'208";a="102080677"
Received: from pipin.fi.intel.com (HELO localhost) ([10.237.72.175])
  by orsmga006.jf.intel.com with ESMTP; 19 Dec 2018 22:46:32 -0800
From:   Felipe Balbi <felipe.balbi@linux.intel.com>
To:     Rob Herring <robh@kernel.org>, Chen Yu <chenyu56@huawei.com>
Cc:     Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, wangbinghui@hisilicon.com,
        suzhuangluan@hisilicon.com, kongfei@hisilicon.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Rutland <mark.rutland@arm.com>,
        John Stultz <john.stultz@linaro.org>
Subject: Re: [PATCH v1 01/12] dt-bindings: usb: add support for dwc3 controller on HiSilicon SoCs
In-Reply-To: <20181219140953.GA9910@bogus>
References: <20181203034515.91412-1-chenyu56@huawei.com> <20181203034515.91412-2-chenyu56@huawei.com> <fde4d37b-0c4d-055b-a0ba-4e9fe87717ad@cogentembedded.com> <33cda716-d09c-28e7-d4b4-26f246786f5e@huawei.com> <680c5b9f-e2c7-926d-7d10-4ce2cd091282@cogentembedded.com> <bbe390f0-2fa6-515b-42c5-ede620b2b8c7@huawei.com> <20181219140953.GA9910@bogus>
Date:   Thu, 20 Dec 2018 08:46:28 +0200
Message-ID: <87y38ku24b.fsf@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable


Hi,

Rob Herring <robh@kernel.org> writes:
>> >>>> +Example:
>> >>>> +=C2=A0=C2=A0=C2=A0 usb3: hisi_dwc3 {
>> >>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 compatible =3D "hisilic=
on,hi3660-dwc3";
>> >>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 #address-cells =3D <2>;
>> >>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 #size-cells =3D <2>;
>> >>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ranges;
>> >>>> +
>> >>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 clocks =3D <&crg_ctrl H=
I3660_CLK_ABB_USB>,
>> >>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 <&crg_ctrl HI3660_ACLK_GATE_USB3OTG>;
>> >>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 clock-names =3D "clk_us=
b3phy_ref", "aclk_usb3otg";
>> >>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 assigned-clocks =3D <&c=
rg_ctrl HI3660_ACLK_GATE_USB3OTG>;
>> >>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 assigned-clock-rates =
=3D <229000000>;
>> >>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 resets =3D <&crg_rst 0x=
90 8>,
>> >>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 <&crg_rst 0x90 7>,
>> >>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 <&crg_rst 0x90 6>,
>> >>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 <&crg_rst 0x90 5>;
>> >>>> +
>> >>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dwc3: dwc3@ff100000 {
>
> Please combine these into a single node. Unless you have a wrapper with=20
> registers, you don't need these 2 nodes. Clocks and reset can go in the=20
> dwc3 node.
>
>> >>>
>> >>> =C2=A0=C2=A0=C2=A0=C2=A0 According to the DT spec, the node names sh=
ould be generic, not chip specific, i.e. usb@ff100000 in this case.
>> >>>
>> >>
>> >> Do you mean it should be usb@ff100000: dwc3@ff100000 ?
>> >=20
>> > =C2=A0=C2=A0=C2=A0=C2=A0dwc3: usb@ff100000
>> >=20
>> > =C2=A0=C2=A0 "dwc3:" is a label, not name.
>>=20
>> I use the node name "dwc3@ff100000" according to Documentation/devicetre=
e/bindings/usb/dwc3.txt
>> and documentations of vendor drivers, i.e. qcom,dwc3.txt, rockchip,dwc3.=
txt.
>>=20
>> In these documentations, the dwc3 sub-node name uses "dwc3@xxxxxxxx".
>>=20
>> I think it is better to be same as the other vendor's dwc3 drivers.
>
> It's not. The other bindings are wrong. Follow the DT Spec.

what's wrong about them? They clearly describe the HW:

1) a company-specific glue/adaptation/integration IP
2) a generic licensed IP inside it

dwc3.ko is compatible with Synopsys' documentation and there's only one
incarnation of dwc3. Everything that can be detected in runtime, we do
so. Everything that can't, we use quirk flags. Keep in mind dwc3.ko is
also used as is by non-DT systems where we can't simply change a
compatible flag.

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEElLzh7wn96CXwjh2IzL64meEamQYFAlwbOsQACgkQzL64meEa
mQZqzA/+ITNgTBpmza3VxnL5gCiMChBdxoeu1WVEtels+3jSFqLvfB3rBXu3/FaE
kXEXQinzNrtD/oUXVamxaXfxY0cZA5Ohzy+rLQgv+MCP6hr3s2Pd8uHZjKE1asQB
UbI1+CMinSyRl++xHVyaeThWM+nAUUnx8OqZBN0ZTss2uoZZvIZEeFTAASKUfPBo
kAgHvF7pX5kOysREmTi0NaqA8N7IYCZ1lg4jQwv/KGmAHzVbHnMFoldB7Iyppo4k
WIZ1qvfWav2/uYO+LbpMPcMLTr9oCV2YIgTfA8MH4NXe8PTl/KniauZA/HoI98/6
8hCWvwhvVJMqQCe4vk53E890sqedpFWGMFbizN54PwoQ4jNhtqDAua3beohH512i
uY+cubq5VRUjw6MQ7fMWQhzItZx7nUQeUWrpe+xU83tGvweF8ru4r0D9BvNVJMGh
MZ4h5ay+ee/bC3oFv1zI/Pw/1UongcOYAZuTpL6Q7WkO36oZr6wvQ4pFBNwCUVte
qRZrCDVpAbQBvdoQgLZd7TeDr78IgDkNpRQI+ylWhR4u2MOEEuYhcrp4wUL3faZV
zRyeMK5E+9wFNxBmiwtMt7wT0ooYIdoNM0IU7CAC2jAtUG/zRJxgMAt7jzpNZYq6
yrC5QBfYMGkZFPLK8iLMfuW80LFyOAtOxG9JcT3rT1vRNj84v5A=
=QiRC
-----END PGP SIGNATURE-----
--=-=-=--
