Return-Path: <laurentiu.tudor@nxp.com>
X-Google-Smtp-Source: AB8JxZoCfo+M+/AMjcslPYd7tO0ncTszg1fcYJA49MX5aRJMaMpW81Ss7ckuyucx1+Z2dlvX9OtP
ARC-Seal: i=1; a=rsa-sha256; t=1525252464; cv=none;
        d=google.com; s=arc-20160816;
        b=A9qqRQvROrHnFlD16Gd6Qi2gaeF0Wuy/hHRb/U+qFtLPCmv4opH9a2wBC3zPri78Oi
         7l1+44og2MuQKBX0iG0vKnA8Wd6AOikvELtI3o1SoGgJnDHUJDKfCiI0BTyvl3koLrDB
         Ovs+TqJuXw8f6n9iFsS120X9+sBmYgUfbatvLBTUAOZ5vWRVAuobprLdMro30X8/+A8j
         wyqdJu9Q+41NhZ3fMX6ZhknFfWSaFRsBDGhuIPnixOC6CcZ/uf/2a/GhE0cv8t2QkNr1
         NY/9MFyVOJZEN0WE9MlXeAW5W6Rc8xcp6I/EWaqtkGMdVno9uJ28NfXQt0cRqNuDkXSE
         QUnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:content-transfer-encoding:content-id
         :spamdiagnosticmetadata:spamdiagnosticoutput:content-language
         :accept-language:in-reply-to:references:message-id:date:thread-index
         :thread-topic:subject:cc:to:from:dkim-signature
         :arc-authentication-results;
        bh=iS32p6EvMjTqOAPuEHkz1k2thnMnHPToOmK4JkF2k3g=;
        b=g2Evfn7ZlNoflMiLsVNsuTimrbWEitWqxs2Z94mdeH6rh9m9P8KNPlqRpXSNT9zvHV
         dpJcemIzHVv+KtrXpe4AGhvn+XD8GfbhDL1lTXI+GoxdBrhtVTe/IWONKcUQNjbafgwz
         9WyY+6xqzVIFSi5be+yavhzaKW+weONXu9ECCWbXMEIJ+wK2Z5rvDa5QOx371a2K9PtJ
         TVVafM+m3ZC5fc9kqtH4l6A1EanrcxDuuNKyDAaDzCNOVyTjNBH8eZpw5kvPuD22FONN
         K4WlX2r69AxjeysyyTi2tEzQdPg8A+CkOojKg798g3fV8pqg6WdbRa9meAZms6QTEPLq
         Cdqw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@nxp.com header.s=selector1 header.b=osPC0hMR;
       spf=pass (google.com: domain of laurentiu.tudor@nxp.com designates 104.47.2.46 as permitted sender) smtp.mailfrom=laurentiu.tudor@nxp.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=nxp.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@nxp.com header.s=selector1 header.b=osPC0hMR;
       spf=pass (google.com: domain of laurentiu.tudor@nxp.com designates 104.47.2.46 as permitted sender) smtp.mailfrom=laurentiu.tudor@nxp.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=nxp.com
From: Laurentiu Tudor <laurentiu.tudor@nxp.com>
To: Nipun Gupta <nipun.gupta@nxp.com>, "robin.murphy@arm.com"
	<robin.murphy@arm.com>, "will.deacon@arm.com" <will.deacon@arm.com>,
	"robh+dt@kernel.org" <robh+dt@kernel.org>, "robh@kernel.org"
	<robh@kernel.org>, "mark.rutland@arm.com" <mark.rutland@arm.com>,
	"catalin.marinas@arm.com" <catalin.marinas@arm.com>,
	"gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC: "hch@lst.de" <hch@lst.de>, "joro@8bytes.org" <joro@8bytes.org>,
	"m.szyprowski@samsung.com" <m.szyprowski@samsung.com>, "shawnguo@kernel.org"
	<shawnguo@kernel.org>, "frowand.list@gmail.com" <frowand.list@gmail.com>,
	"bhelgaas@google.com" <bhelgaas@google.com>,
	"iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linuxppc-dev@lists.ozlabs.org"
	<linuxppc-dev@lists.ozlabs.org>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, Bharat Bhushan <bharat.bhushan@nxp.com>,
	"stuyoder@gmail.com" <stuyoder@gmail.com>, Leo Li <leoyang.li@nxp.com>
Subject: Re: [PATCH v4 6/6] arm64: dts: ls208xa: comply with the iommu map
 binding for fsl_mc
Thread-Topic: [PATCH v4 6/6] arm64: dts: ls208xa: comply with the iommu map
 binding for fsl_mc
Thread-Index: AQHT4EyDA+QNJiz5nkabAPEYeRfScaQcK0uA
Date: Wed, 2 May 2018 09:14:18 +0000
Message-ID: <5AE98169.7060102@nxp.com>
References: <1524824826-29473-1-git-send-email-nipun.gupta@nxp.com>
 <1525069641-8523-1-git-send-email-nipun.gupta@nxp.com>
 <1525069641-8523-7-git-send-email-nipun.gupta@nxp.com>
In-Reply-To: <1525069641-8523-7-git-send-email-nipun.gupta@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=laurentiu.tudor@nxp.com;
x-originating-ip: [86.34.165.90]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR0401MB1712;7:7EwvkipwXpWFfCOSdYgERVcrSpxr0v0RTGRWNqOn7NnmP+UUzVxBDx6G0Wp0AxgZ6ytFTYdhJdF3fDhJd8DBr0lbXw/VK9qBG4P1xS3ii3i8cU0H/OzZ9mXMa7Q8PNNs6ydkBT3Nt2hCIF4MPnJg5I9+SzA7AEgi3oGcilnn0DzQsy4pa3O0nSmgUyZj9IGA/axareuD/+jJ+S30zQ578e7fDDkbjm0cWtESfr2g7H2OnmqneWL8r9yZ7nlo56PS
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(2017052603328)(7153060)(7193020);SRVR:VI1PR0401MB1712;
x-ms-traffictypediagnostic: VI1PR0401MB1712:
x-microsoft-antispam-prvs: <VI1PR0401MB17129493DD1FE361C77BCCBDEC800@VI1PR0401MB1712.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(185117386973197)(275809806118684);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231254)(944501410)(52105095)(3002001)(10201501046)(6055026)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(20161123562045)(6072148)(201708071742011);SRVR:VI1PR0401MB1712;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0401MB1712;
x-forefront-prvs: 06607E485E
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39380400002)(376002)(39860400002)(366004)(396003)(346002)(199004)(189003)(105586002)(446003)(11346002)(25786009)(80316001)(106356001)(87266011)(97736004)(3280700002)(478600001)(2616005)(4326008)(76176011)(65816011)(26005)(5660300001)(3846002)(6246003)(6116002)(575784001)(6512007)(53936002)(2201001)(86362001)(2900100001)(316002)(2501003)(102836004)(6436002)(39060400002)(54906003)(110136005)(66066001)(5250100002)(229853002)(6506007)(53546011)(6486002)(486006)(99286004)(2906002)(7736002)(8936002)(68736007)(59450400001)(44832011)(33656002)(8676002)(81166006)(36756003)(81156014)(59896002)(305945005)(7416002)(14454004)(476003)(3660700001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0401MB1712;H:VI1PR0401MB1856.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: ONy/WKiWPl9TshjODbqEyzdLPhHUkSpQUcUe+YVL/jQGMtMUnnWiGPMDRNzT+cywvz4RWsi5h1u2M02VpNkXPCryqXeiNSWrg+fuFOHMgH5g2X6GVrqiihTKhWPkoHezvVguNVe2orvjxszOVZ+864abSYmZBQfRuedp8vlXzR+LJ0LgUoyfMVbayoN1LVxc
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="Windows-1252"
Content-ID: <0CEE781F71EAB84AA64ED4307E463E0C@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 37a3716b-98fa-4695-4dcd-08d5b00d1604
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37a3716b-98fa-4695-4dcd-08d5b00d1604
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 May 2018 09:14:18.6987
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0401MB1712
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598894790375923530?=
X-GMAIL-MSGID: =?utf-8?q?1599343128713113778?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Nipun,

On 04/30/2018 09:27 AM, Nipun Gupta wrote:
> fsl-mc bus support the new iommu-map property. Comply to this binding
> for fsl_mc bus.
>
> Signed-off-by: Nipun Gupta <nipun.gupta@nxp.com>

This looks good to me, so:

Reviewed-By: Laurentiu Tudor <laurentiu.tudor@nxp.com>

---
Best Regards, Laurentiu

> ---
>   arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi | 6 +++++-
>   1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi b/arch/arm64/=
boot/dts/freescale/fsl-ls208xa.dtsi
> index 137ef4d..6010505 100644
> --- a/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi
> +++ b/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi
> @@ -184,6 +184,7 @@
>   		#address-cells =3D <2>;
>   		#size-cells =3D <2>;
>   		ranges;
> +		dma-ranges =3D <0x0 0x0 0x0 0x0 0x10000 0x00000000>;
>
>   		clockgen: clocking@1300000 {
>   			compatible =3D "fsl,ls2080a-clockgen";
> @@ -357,6 +358,8 @@
>   			reg =3D <0x00000008 0x0c000000 0 0x40>,	 /* MC portal base */
>   			      <0x00000000 0x08340000 0 0x40000>; /* MC control reg */
>   			msi-parent =3D <&its>;
> +			iommu-map =3D <0 &smmu 0 0>;	/* This is fixed-up by u-boot */
> +			dma-coherent;
>   			#address-cells =3D <3>;
>   			#size-cells =3D <1>;
>
> @@ -460,6 +463,8 @@
>   			compatible =3D "arm,mmu-500";
>   			reg =3D <0 0x5000000 0 0x800000>;
>   			#global-interrupts =3D <12>;
> +			#iommu-cells =3D <1>;
> +			stream-match-mask =3D <0x7C00>;
>   			interrupts =3D <0 13 4>, /* global secure fault */
>   				     <0 14 4>, /* combined secure interrupt */
>   				     <0 15 4>, /* global non-secure fault */
> @@ -502,7 +507,6 @@
>   				     <0 204 4>, <0 205 4>,
>   				     <0 206 4>, <0 207 4>,
>   				     <0 208 4>, <0 209 4>;
> -			mmu-masters =3D <&fsl_mc 0x300 0>;
>   		};
>
>   		dspi: dspi@2100000 {
>=
