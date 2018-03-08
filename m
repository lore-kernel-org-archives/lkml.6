Return-Path: <nipun.gupta@nxp.com>
X-Google-Smtp-Source: AG47ELvQ0beo+nMyu9c9DRUf5vXYaG/2EvV3CCDzz+SvGhKDjbQ9Dj2Fl6saPcGokXBD6mppg65g
ARC-Seal: i=1; a=rsa-sha256; t=1520512356; cv=none;
        d=google.com; s=arc-20160816;
        b=NZ5Rjoq9X1c5Rlty8lUxBQGavN5Ltv0v1fY0iiwCD8XHsAF8e+lICVm4Zx26/l7z3J
         tfbixXGyRvXcuMiyHIaB5IvjLjLwDurAixELrHKtOoPyktl4OPkzbZZTxZoRj767LPBm
         1kKReIMU02HUHLCjqIfGENFKmaAU2OpwkVBgk1Fc/SnjaHfQvhVEH+QjN5QjUUD+bGqp
         zYn/ULcOTL3PMYREJrI3RG9w7PVe37cXiMVfYB7/SA+ccz90AuFicHVm9upXC1853nVP
         aYLLgalJbis8zkKr6AHNBeLOmpgLYOY3FEpXEfWNJIGKcNy0pIkoL+H1XjDUbTO+YGXj
         isRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:content-transfer-encoding:spamdiagnosticmetadata
         :spamdiagnosticoutput:content-language:accept-language:in-reply-to
         :references:message-id:date:thread-index:thread-topic:subject:cc:to
         :from:dkim-signature:arc-authentication-results;
        bh=Bwr9EBjQ/JBCVZdjbNSxUEU594uVVUEuZ4xOJHj2FQk=;
        b=lyODJyd9vMcObcTTLzGRSO8Y2DLGY/5yteFjmy/uTrqX4+F7NekdiT/1Kg0XuZ7tO+
         XuM5lA3+m1PKwSSe7VkXo0xSH5Mf1aZA+c86LiJHjCyW2+vwQYzayo2ON8j5Ab/WAqD7
         xmY4T5/ed8GvIuGE7r1RshFSePaznLbb4WKL4Tev3GZcAHSNgAAJIjL7ge2yP0BIL+Wd
         L8zEcKk7MgiF1qCYZ3sU0jaKN1XzExC7VuiBNLRDYuuZeAR/XUVPW3wfxWZwHNzTLggT
         iwVJeKiLRr5dIl2V3iak9KVMGZC5SHxkHihX668Mr8Cl5F+QFGZuCkGOBOT8U7Q2WzOl
         3njg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@nxp.com header.s=selector1 header.b=P2DpUr2b;
       spf=pass (google.com: domain of nipun.gupta@nxp.com designates 40.107.2.55 as permitted sender) smtp.mailfrom=nipun.gupta@nxp.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=nxp.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@nxp.com header.s=selector1 header.b=P2DpUr2b;
       spf=pass (google.com: domain of nipun.gupta@nxp.com designates 40.107.2.55 as permitted sender) smtp.mailfrom=nipun.gupta@nxp.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=nxp.com
From: Nipun Gupta <nipun.gupta@nxp.com>
To: Rob Herring <robh@kernel.org>
CC: "will.deacon@arm.com" <will.deacon@arm.com>, "robin.murphy@arm.com"
	<robin.murphy@arm.com>, "mark.rutland@arm.com" <mark.rutland@arm.com>,
	"catalin.marinas@arm.com" <catalin.marinas@arm.com>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"stuyoder@gmail.com" <stuyoder@gmail.com>, Bharat Bhushan
	<bharat.bhushan@nxp.com>, "gregkh@linuxfoundation.org"
	<gregkh@linuxfoundation.org>, "joro@8bytes.org" <joro@8bytes.org>,
	"linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Leo Li
	<leoyang.li@nxp.com>, "iommu@lists.linux-foundation.org"
	<iommu@lists.linux-foundation.org>, Laurentiu Tudor
	<laurentiu.tudor@nxp.com>, "shawnguo@kernel.org" <shawnguo@kernel.org>,
	"hch@lst.de" <hch@lst.de>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "m.szyprowski@samsung.com"
	<m.szyprowski@samsung.com>
Subject: RE: [PATCH 1/6] Docs: dt: add fsl-mc iommu-parent device-tree binding
Thread-Topic: [PATCH 1/6] Docs: dt: add fsl-mc iommu-parent device-tree
 binding
Thread-Index: AQHTtI51S/QE8Lhu2k6Y+QLep+bwVKPFYW2AgADh/eA=
Date: Thu, 8 Mar 2018 12:32:28 +0000
Message-ID: <HE1PR0401MB24257DC948C69C7A9080ED66E6DF0@HE1PR0401MB2425.eurprd04.prod.outlook.com>
References: <1520260166-29387-1-git-send-email-nipun.gupta@nxp.com>
 <1520260166-29387-2-git-send-email-nipun.gupta@nxp.com>
 <20180307224019.oowh74pkbi5izuft@rob-hp-laptop>
In-Reply-To: <20180307224019.oowh74pkbi5izuft@rob-hp-laptop>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=nipun.gupta@nxp.com;
x-originating-ip: [49.248.225.93]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;HE1PR0401MB2249;6:2yjRY9cjEzDhS78zYXRF0LWJWnkKKaDq1tUXSVvZ98tfsH+Z6ptAuoGvgnjmaZLd61+gm1xIBIeoPhkOdRNr7ABC7ePK2hHKQKNQlWSKSx2hR06tmyNgHuIchfBpmVO0UPYJr8bLxC+r37kfwdjtLEluFQD9bazfmGZOo1wRn5tFKni9E/supWwQDwqo4SXP0h/R/XaRAnFJJwsF0TjGfpIow1yCV7y57h1nxPDGemJ2Ac4NKIX1wYXkYLTXcaIyJOVy5LN6fmX8kLWozzAW6/Yl1wnnow5EGoOdQy8ufXXleBn6jLtRRWxmImHEACUpecNAKC6On7Gt2Bsnjf6Jm6DQfGswLWgk3HEeysgvUULJdMqX8tm0YdBaJqKQTHBo;5:Kp86gXITCVzIva/FiUfmhEjcTgDM0QNi0E7jXVFAyKGwRtninDAYSVCOb4B4GtcJuGtKGzN13LyLRSh5io9Td+a/s4rFLYtk+0/UKHmhyfUwsHYinWrlWQ2XWwkwPKej25eE4Hf9arBL4NfRVBEgGmvMcHIqwKRLOb8hjF6h/TA=;24:6OfxB7DjSjI//Y8fUyzOjUezRNefxfW4NbXsi2oe3s3kz1WoRvkeSD8Jxlm0elEi30eK3rktsUOYeoN57L7p1Lel+b8pglWTScwOu58PJqo=;7:NEv9p+TxODRdupzbUt+FwAucFgzQl9i3rOE5I1J1ACQEkau1KsG39296ZUiTx4oce19lHhQgs1tJpk0qLcJ7FLZk9M2PZnDfFNfbOlV5JbvQ3AUvHxahpSwEjnIZNr9h5k7qEi4ljT/IORhnK0w3JduIpb1/+n2ExPL565N5V6Pzn018DEKdoP7z2y1Q4SFkXtE3YmFxY9IBZno4pBgmdZQdP+V/wRNbtMhMY+IoSRabPiTPNOaDLHBrwn7GFaIg
x-ms-exchange-antispam-srfa-diagnostics: SSOS;SSOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10009020)(39860400002)(396003)(376002)(39380400002)(366004)(346002)(13464003)(199004)(189003)(54906003)(4326008)(3660700001)(68736007)(59450400001)(2906002)(105586002)(97736004)(55016002)(81166006)(316002)(5660300001)(14454004)(81156014)(76176011)(3280700002)(478600001)(5250100002)(6436002)(345774005)(53936002)(53546011)(6506007)(966005)(99286004)(106356001)(45080400002)(6116002)(186003)(33656002)(6916009)(102836004)(39060400002)(26005)(7696005)(2900100001)(2950100002)(8676002)(229853002)(6306002)(25786009)(305945005)(8936002)(9686003)(74316002)(7736002)(6246003)(86362001)(3846002)(7416002)(66066001)(575784001);DIR:OUT;SFP:1101;SCL:1;SRVR:HE1PR0401MB2249;H:HE1PR0401MB2425.eurprd04.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 386e6adb-81c3-447e-59dc-08d584f0a82f
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:HE1PR0401MB2249;
x-ms-traffictypediagnostic: HE1PR0401MB2249:
x-microsoft-antispam-prvs: <HE1PR0401MB224980E391C02AAA509E9403E6DF0@HE1PR0401MB2249.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(180628864354917)(20558992708506)(9452136761055)(189930954265078)(65623756079841)(185117386973197)(85827821059158)(258649278758335)(45079756050767)(275809806118684);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040501)(2401047)(8121501046)(5005006)(3002001)(3231220)(944501244)(52105095)(93006095)(93001095)(10201501046)(6055026)(6041288)(20161123562045)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(6072148)(201708071742011);SRVR:HE1PR0401MB2249;BCL:0;PCL:0;RULEID:;SRVR:HE1PR0401MB2249;
x-forefront-prvs: 060503E79B
x-microsoft-antispam-message-info: Jzhm57h0ahl9YwnoQbjJq2noys4mj/BdOBVm39eS2rfPFaKEX1tb8W7/zwm8A/I1SZT/rER5wf/cB33WJf+6dLX1gY1rP3k5g6JIzoncXsjs/vgEVQMfwkt/JJOb7RyBUCNFRZE+jwSGe4W6NAHcdxki0d3PN+Rz7er9uMEtHxyU1Z+0RvnHNm0FSymEbafzW2t8C0DHK8XFNy0KJ7ZU4CVoNIhXT5lz2KtNM3631b/4LSsBsq9IM0rYj9/uP9E9AYgtTzLqBp1pR1RLA6b+Z82xQ0yEIokxuCyn4Lg4xKA5qq3Ny1rY1IYjAca92sBWjpVWXHRv99t+BthTi0CIQw==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 386e6adb-81c3-447e-59dc-08d584f0a82f
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 12:32:29.0079
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0401MB2249
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594108370915742934?=
X-GMAIL-MSGID: =?utf-8?q?1594372765633328916?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Rob,

> -----Original Message-----
> From: Rob Herring [mailto:robh@kernel.org]
> Sent: Thursday, March 08, 2018 4:10
> To: Nipun Gupta <nipun.gupta@nxp.com>
> Cc: will.deacon@arm.com; robin.murphy@arm.com; mark.rutland@arm.com;
> catalin.marinas@arm.com; devicetree@vger.kernel.org; stuyoder@gmail.com;
> Bharat Bhushan <bharat.bhushan@nxp.com>; gregkh@linuxfoundation.org;
> joro@8bytes.org; linuxppc-dev@lists.ozlabs.org; linux-kernel@vger.kernel.=
org;
> Leo Li <leoyang.li@nxp.com>; iommu@lists.linux-foundation.org; Laurentiu
> Tudor <laurentiu.tudor@nxp.com>; shawnguo@kernel.org; hch@lst.de; linux-
> arm-kernel@lists.infradead.org; m.szyprowski@samsung.com
> Subject: Re: [PATCH 1/6] Docs: dt: add fsl-mc iommu-parent device-tree bi=
nding
>=20
> On Mon, Mar 05, 2018 at 07:59:21PM +0530, Nipun Gupta wrote:
> > The existing IOMMU bindings cannot be used to specify the relationship
> > between fsl-mc devices and IOMMUs. This patch adds a binding for
> > mapping fsl-mc devices to IOMMUs, using a new iommu-parent property.
> >
> > Signed-off-by: Nipun Gupta <nipun.gupta@nxp.com>
> > ---
> >  .../devicetree/bindings/misc/fsl,qoriq-mc.txt      | 31
> ++++++++++++++++++++++
> >  1 file changed, 31 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/misc/fsl,qoriq-mc.txt
> b/Documentation/devicetree/bindings/misc/fsl,qoriq-mc.txt
> > index 6611a7c..011c7d6 100644
> > --- a/Documentation/devicetree/bindings/misc/fsl,qoriq-mc.txt
> > +++ b/Documentation/devicetree/bindings/misc/fsl,qoriq-mc.txt
> > @@ -9,6 +9,24 @@ blocks that can be used to create functional hardware
> objects/devices
> >  such as network interfaces, crypto accelerator instances, L2 switches,
> >  etc.
> >
> > +For an overview of the DPAA2 architecture and fsl-mc bus see:
> > +drivers/staging/fsl-mc/README.txt
> > +
> > +As described in the above overview, all DPAA2 objects in a DPRC share =
the
> > +same hardware "isolation context" and a 10-bit value called an ICID
> > +(isolation context id) is expressed by the hardware to identify
> > +the requester.
> > +
> > +The generic 'iommus' property is cannot be used to describe the relati=
onship
> > +between fsl-mc and IOMMUs, so an iommu-parent property is used to defi=
ne
> > +the same.
>=20
> Why not? It is just a link between 2 nodes.

We have #iommu-cells as '1' i.e. iommu will have one stream ID configured f=
or a device.
Once USB and other devices start to use IOMMU we will also need this iommu-=
cells.

When #iommu-cells is defined as '1' and we have 'iommus=3D<&smmu>' compilat=
ion
reports warning about the mismatch.
In fsl-mc bus case we do not have any stream id associated with the bus.

As suggested by Robin, we can simply use the iommu-map property.

>=20
> > +
> > +For generic IOMMU bindings, see
> > +Documentation/devicetree/bindings/iommu/iommu.txt.
> > +
> > +For arm-smmu binding, see:
> > +Documentation/devicetree/bindings/iommu/arm,smmu.txt.
> > +
> >  Required properties:
> >
> >      - compatible
> > @@ -88,14 +106,27 @@ Sub-nodes:
> >                Value type: <phandle>
> >                Definition: Specifies the phandle to the PHY device node=
 associated
> >                            with the this dpmac.
> > +Optional properties:
> > +
> > +- iommu-parent: Maps the devices on fsl-mc bus to an IOMMU.
> > +  The property specifies the IOMMU behind which the devices on
> > +  fsl-mc bus are residing.
>=20
> If you want a generic property, this should be documented in the common
> binding.

We can use the iommu-map property which is already documented.

>=20
> Couldn't you have more than 1 IOMMU upstream of a MC?

There is no such device currently with which fsl-mc bus uses more than one =
iommu.
Infact, our current systems have only single IOMMU :).

Even in future if such devices are there then we can use iommu-map to speci=
fy
more than one iommu with separate requester ID's (RID's).

Thank you for review...

Regards,
Nipun

>=20
> >
> >  Example:
> >
> > +        smmu: iommu@5000000 {
> > +               compatible =3D "arm,mmu-500";
> > +               #iommu-cells =3D <1>;
> > +               stream-match-mask =3D <0x7C00>;
> > +               ...
> > +        };
> > +
> >          fsl_mc: fsl-mc@80c000000 {
> >                  compatible =3D "fsl,qoriq-mc";
> >                  reg =3D <0x00000008 0x0c000000 0 0x40>,    /* MC porta=
l base */
> >                        <0x00000000 0x08340000 0 0x40000>; /* MC control=
 reg */
> >                  msi-parent =3D <&its>;
> > +                iommu-parent =3D <&smmu>;
> >                  #address-cells =3D <3>;
> >                  #size-cells =3D <1>;
> >
> > --
> > 1.9.1
> >
> >
> > _______________________________________________
> > linux-arm-kernel mailing list
> > linux-arm-kernel@lists.infradead.org
> >
> https://emea01.safelinks.protection.outlook.com/?url=3Dhttp%3A%2F%2Flists=
.infr
> adead.org%2Fmailman%2Flistinfo%2Flinux-arm-
> kernel&data=3D02%7C01%7Cnipun.gupta%40nxp.com%7Cf64b4fe9c5cf45ce8a9a
> 08d5847c6919%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C636560
> 592302736942&sdata=3DiOwv%2Fzd8UTLm7YCapDOWzrtd48VQeYY2vlufck7eYZI
> %3D&reserved=3D0
