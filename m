Return-Path: <nipun.gupta@nxp.com>
X-Google-Smtp-Source: AG47ELuoQTWjpR3wqqDITzysYiEcAnVPlqSBV3UfnaSV/BQtp7BNCUYM9UjCLaIbWPvXaI5xKBzE
ARC-Seal: i=1; a=rsa-sha256; t=1521731634; cv=none;
        d=google.com; s=arc-20160816;
        b=DNKJSQQGEyn7TNB1bKD/NuGcX1u3JDizrmjIKiEI528lgB19ivYM2Keiawq+MMxn5C
         GMI4mE5DUePA3K0vTvrJ8MChym/0CDPk5biHzDrCKL6mjRVob48gFDwE7u11uJ7A4Asq
         xbnIVpPbbCZ5ZRYtv3ZhOzMCUYw5U3H5l6AblE87OCIknukd5DtX7SkLihIFe86L35Zz
         vSKECD0PaVbw9t8EIgVCzlqZHB+h/YgPQlHNaRNmTLCkRF2p+zh5PA13o2KFnBPGKLce
         r/QCIUrvkS3Rc8SiVTnu8jGbroudiLJJqn2UbTNz2b50mlLI+nRz03p1lRFxVUnELSlf
         FA7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:content-transfer-encoding:spamdiagnosticmetadata
         :spamdiagnosticoutput:content-language:accept-language:in-reply-to
         :references:message-id:date:thread-index:thread-topic:subject:cc:to
         :from:dkim-signature:arc-authentication-results;
        bh=Mq/TnoISwua9YyNc3RIeHbq7uRq1zs3Gou8vs6bkkSA=;
        b=sGmS2UBh9iLQVsXpii1M/U3jBJ61rWALY+fpHkM1CZN5qcF07lC4ZGl63G8IV8Bz7e
         FDYyieG+lzWM/t6batBqylXsOmqUORxSBnDYxuXVV9LGBvbNe/+1AT8I4737yiZ/EOfl
         y6p3DzdtUCInFDjntr80a6p/i684TkXoqbTtC1146+U/0BrCIcKjKaYqTIjYYnS0sjch
         QGbkb2WuTI+OEngTZdRRo7XwgWsXLMFbshXp65yvBZp7RRADMX0WckeQp7Ut6ukJc1i3
         6uskv9zNflLLa3hdtrDgKskg6k8dLOXukSjnhm6aY1ylrnrnBMvT7oLMGCu8DMQPvHoC
         uGcw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@nxp.com header.s=selector1 header.b=WI/poj+a;
       spf=pass (google.com: domain of nipun.gupta@nxp.com designates 40.107.1.40 as permitted sender) smtp.mailfrom=nipun.gupta@nxp.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=nxp.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@nxp.com header.s=selector1 header.b=WI/poj+a;
       spf=pass (google.com: domain of nipun.gupta@nxp.com designates 40.107.1.40 as permitted sender) smtp.mailfrom=nipun.gupta@nxp.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=nxp.com
From: Nipun Gupta <nipun.gupta@nxp.com>
To: Christoph Hellwig <hch@lst.de>
CC: "robin.murphy@arm.com" <robin.murphy@arm.com>, "linux@armlinux.org.uk"
	<linux@armlinux.org.uk>, "gregkh@linuxfoundation.org"
	<gregkh@linuxfoundation.org>, "m.szyprowski@samsung.com"
	<m.szyprowski@samsung.com>, "bhelgaas@google.com" <bhelgaas@google.com>,
	"zajec5@gmail.com" <zajec5@gmail.com>, "andy.gross@linaro.org"
	<andy.gross@linaro.org>, "david.brown@linaro.org" <david.brown@linaro.org>,
	"dan.j.williams@intel.com" <dan.j.williams@intel.com>, "vinod.koul@intel.com"
	<vinod.koul@intel.com>, "thierry.reding@gmail.com"
	<thierry.reding@gmail.com>, "robh+dt@kernel.org" <robh+dt@kernel.org>,
	"frowand.list@gmail.com" <frowand.list@gmail.com>,
	"jarkko.sakkinen@linux.intel.com" <jarkko.sakkinen@linux.intel.com>,
	"rafael.j.wysocki@intel.com" <rafael.j.wysocki@intel.com>,
	"dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>, "johan@kernel.org"
	<johan@kernel.org>, "msuchanek@suse.de" <msuchanek@suse.de>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
	"linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
	"linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
	"linux-soc@vger.kernel.org" <linux-soc@vger.kernel.org>,
	"dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
	"linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, Bharat Bhushan
	<bharat.bhushan@nxp.com>, Leo Li <leoyang.li@nxp.com>
Subject: RE: [PATCH v2 2/2] drivers: remove force dma flag from buses
Thread-Topic: [PATCH v2 2/2] drivers: remove force dma flag from buses
Thread-Index: AQHTwOG3hQPpJrn9E0mo0AF6KOaafqPb6zcAgABxZHA=
Date: Thu, 22 Mar 2018 15:13:49 +0000
Message-ID: <HE1PR0401MB2425407DADB19FCF6E016456E6A90@HE1PR0401MB2425.eurprd04.prod.outlook.com>
References: <1520868292-2479-1-git-send-email-nipun.gupta@nxp.com>
 <1521615323-4752-1-git-send-email-nipun.gupta@nxp.com>
 <1521615323-4752-2-git-send-email-nipun.gupta@nxp.com>
 <20180322081926.GC29444@lst.de>
In-Reply-To: <20180322081926.GC29444@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=nipun.gupta@nxp.com;
x-originating-ip: [14.142.187.166]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;HE1PR0401MB2441;7:WzIft1UdiAjvV3EA9DzburRoyPQPWIWB6zfyiVPXfjlvfMolVsSFAEMDcSGY3WdAiqQYbYLbGl7cUxXvAlZ79eNd77SbIJDP+gJYb1z4RpXahOXE1rSTOtjAALwMYQan1qZGtUHpmQFdllDcZ0HQeRtL0OjFRMAo3siJOYJ7iZZCkKZkIi3dUxPDeua0fcy9lQAOJRnAeEFTZdU2f2JAloG2A6W41PFVW7zJYpB8KstHqg0s8YAnmH85dgMTPCLl
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 719ea7d6-4ed2-449a-8355-08d5900783e6
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:HE1PR0401MB2441;
x-ms-traffictypediagnostic: HE1PR0401MB2441:
x-microsoft-antispam-prvs: <HE1PR0401MB244140A284D5F3701E5AAD58E6A90@HE1PR0401MB2441.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(185117386973197);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231221)(944501327)(52105095)(3002001)(10201501046)(6055026)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(6072148)(201708071742011);SRVR:HE1PR0401MB2441;BCL:0;PCL:0;RULEID:;SRVR:HE1PR0401MB2441;
x-forefront-prvs: 0619D53754
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(39380400002)(376002)(39860400002)(346002)(366004)(189003)(199004)(13464003)(6436002)(105586002)(229853002)(6116002)(8936002)(54906003)(86362001)(3846002)(53546011)(102836004)(55236004)(2950100002)(6916009)(81166006)(81156014)(68736007)(33656002)(2900100001)(8676002)(446003)(26005)(7416002)(97736004)(14454004)(5250100002)(478600001)(106356001)(3280700002)(66066001)(6246003)(2906002)(4326008)(9686003)(305945005)(186003)(25786009)(5660300001)(74316002)(3660700001)(53936002)(99286004)(316002)(76176011)(55016002)(39060400002)(7736002)(7696005)(6506007)(93886005);DIR:OUT;SFP:1101;SCL:1;SRVR:HE1PR0401MB2441;H:HE1PR0401MB2425.eurprd04.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: LOtxYv3dCLSEP+FOgqmG99dIqbVtHN4bbBlCPEF99+mR3JCHcYXHp2AghGY0MvUKx9H5zCUlSpVI4tGLv2TXlZ4PedHPiwPTCU9r0Cm31Ayp6p0gTzxjqny+Z5WvgxJhCgtN5KX7oUSgPd58gUo74tfJbamxThdg/uICU/AoazN6P46uw7oUekNdG3ADN8LvG2Tt7rVG6PPDjVIC7RHFUEfUMp22DUdY8v4KW6fY14RnfZ1AuTwXAwrNhpX5IksotGMdZUB0kt7mbz/SlGLe9Kw86FpRILBNVNpwBz6FxQRkHLk6fCHhtjC8pucm4G794c4DePq1OAGtZ0MSwHXV/Q==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 719ea7d6-4ed2-449a-8355-08d5900783e6
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Mar 2018 15:13:49.2386
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0401MB2441
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595529373186786387?=
X-GMAIL-MSGID: =?utf-8?q?1595651271051095267?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



> -----Original Message-----
> From: Christoph Hellwig [mailto:hch@lst.de]
> Sent: Thursday, March 22, 2018 13:49
> To: Nipun Gupta <nipun.gupta@nxp.com>
>=20
> > --- a/drivers/dma/qcom/hidma_mgmt.c
> > +++ b/drivers/dma/qcom/hidma_mgmt.c
> > @@ -398,7 +398,7 @@ static int __init
> hidma_mgmt_of_populate_channels(struct device_node *np)
> >  		}
> >  		of_node_get(child);
> >  		new_pdev->dev.of_node =3D child;
> > -		of_dma_configure(&new_pdev->dev, child);
> > +		of_dma_configure(&new_pdev->dev, child, true);
> >  		/*
> >  		 * It is assumed that calling of_msi_configure is safe on
> >  		 * platforms with or without MSI support.
>=20
> Where did we mark this bus as force_dma before?

I thought these devices to be on the platform bus as the device is of type
'struct platform_device', though I am not sure then why 'of_dma_configure()=
'
is called here. Is this not on platform bus?

>=20
> > diff --git a/drivers/of/of_reserved_mem.c b/drivers/of/of_reserved_mem.=
c
> > index 9a4f4246..895c83e 100644
> > --- a/drivers/of/of_reserved_mem.c
> > +++ b/drivers/of/of_reserved_mem.c
> > @@ -353,7 +353,7 @@ int of_reserved_mem_device_init_by_idx(struct devic=
e
> *dev,
> >  		/* ensure that dma_ops is set for virtual devices
> >  		 * using reserved memory
> >  		 */
> > -		of_dma_configure(dev, np);
> > +		of_dma_configure(dev, np, true);
>=20
> Did all the callers of this one really force dma?  I have a hard time
> untangling the call stacks unfortunately.

I see this API being called indirectly from NXP DPAA device driver which
is for platform bus devices. So I marked 'true' out here. There are more pl=
aces
from where it is being called.

Thanks,
Nipun
