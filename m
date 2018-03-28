Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753486AbeC1NYP (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Mar 2018 09:24:15 -0400
Received: from mail-sn1nam01on0073.outbound.protection.outlook.com ([104.47.32.73]:50048
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751072AbeC1NYN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Mar 2018 09:24:13 -0400
From: Alan Douglas <adouglas@cadence.com>
To: Niklas Cassel <niklas.cassel@axis.com>,
        "kishon@ti.com" <kishon@ti.com>,
        "cyrille.pitchen@free-electrons.com"
        <cyrille.pitchen@free-electrons.com>,
        Bjorn Helgaas <bhelgaas@google.com>
CC: Niklas Cassel <niklass@axis.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v5 07/12] PCI: cadence: Set PCI_BASE_ADDRESS_MEM_TYPE_64
 if a 64-bit BAR was set-up
Thread-Topic: [PATCH v5 07/12] PCI: cadence: Set PCI_BASE_ADDRESS_MEM_TYPE_64
 if a 64-bit BAR was set-up
Thread-Index: AQHTxosQ1pBWmSR6xEK26yNat+laXKPloajw
Date: Wed, 28 Mar 2018 13:24:10 +0000
Message-ID: <CO2PR07MB97221CD6D90F81C2D81D65BD8A30@CO2PR07MB972.namprd07.prod.outlook.com>
References: <20180328115018.31921-1-niklas.cassel@axis.com>
 <20180328115018.31921-8-niklas.cassel@axis.com>
In-Reply-To: <20180328115018.31921-8-niklas.cassel@axis.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcYWRvdWdsYXNcYXBwZGF0YVxyb2FtaW5nXDA5ZDg0OWI2LTMyZDMtNGE0MC04NWVlLTZiODRiYTI5ZTM1Ylxtc2dzXG1zZy01YTMyNjNmZi0zMjhiLTExZTgtODZlMi1mNDk2MzQ4NmY0ZWNcYW1lLXRlc3RcNWEzMjY0MDAtMzI4Yi0xMWU4LTg2ZTItZjQ5NjM0ODZmNGVjYm9keS50eHQiIHN6PSIxNTYyIiB0PSIxMzE2NjcxNzA3NDAyNjY2MzEiIGg9ImN6RlVvZTk5ZDN2YkRaVFZkL1gxcTM0UTduST0iIGlkPSIiIGJsPSIwIiBibz0iMSIvPjwvbWV0YT4=
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=adouglas@cadence.com;
x-originating-ip: [185.217.253.59]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CO2PR07MB2728;7:6swUFlCXPlRra8KuXUHowmSjdX65wnXXBIbBqGyjhMIb5Ay/ivgLmMyRTn/YFfmPu5uF+oSCJY/c5aRjJpFjTRDYuS9muCKdqTRv2qFvRgPFJPCvR7X/2B9D7Ux9VtIcxWMj6hxJHOp+ptFFExltypigjpYV/26fxgnLob4ZL4bRvshTR12QTlddIq9b72zU+chJ9LXCi/PtEPXpCNbeiYmL3ZSRzhTkOQhteAbr/+g+tzA+lDW51DOmPZFJX+aH;20:aFHmaqrFsMekUE09llR2otiyUR1SV0YKWJl3dfSR15Kzect/D5NAciwxWPpGQ5YzfK5Urgaq4GAOvlYapYIoZhLww+RSyws/ewsis7lyytM1/5AqiUY+SsCw1RnRK7CI6L8BO5dcM3+ibmdWjHP/kpbwUofYUuw9xEp39zuY92OGzCCv+rLgb0kUqnUxm+z4i56fyMmcu9MhjqXUOcJFRyercsDb6L/JI5RD1Qc8itWg6HiC4GPz7bsLzSTvQfng
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: b2c8c10c-ff74-4e76-2f1e-08d594af3143
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:CO2PR07MB2728;
x-ms-traffictypediagnostic: CO2PR07MB2728:
x-microsoft-antispam-prvs: <CO2PR07MB2728F1E17898E262DA9AC91AD8A30@CO2PR07MB2728.namprd07.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231221)(944501327)(52105095)(3002001)(93006095)(93001095)(10201501046)(6041310)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:CO2PR07MB2728;BCL:0;PCL:0;RULEID:;SRVR:CO2PR07MB2728;
x-forefront-prvs: 06259BA5A2
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(396003)(346002)(376002)(39380400002)(39860400002)(189003)(36092001)(199004)(33656002)(6506007)(106356001)(8936002)(478600001)(6436002)(2201001)(81156014)(2900100001)(316002)(97736004)(486005)(476003)(86362001)(7736002)(81166006)(5660300001)(305945005)(66066001)(486005)(8676002)(14454004)(55016002)(25786009)(3660700001)(11346002)(15760500003)(6116002)(3280700002)(229853002)(4326008)(3846002)(9686003)(76176011)(2501003)(105586002)(7696005)(2906002)(68736007)(186003)(102836004)(5250100002)(99286004)(53936002)(26005)(53546011)(6246003)(446003)(54906003)(110136005)(74316002);DIR:OUT;SFP:1101;SCL:1;SRVR:CO2PR07MB2728;H:CO2PR07MB972.namprd07.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: wPB+CY1VlmKP03UmTHYB1Elc0KSUSi+HhsMbPaGNCeURiMF7aVGiaUFe1dHeLwPfPzb3Ov36FOlEN3kb2OcOAbaJbmHVKYqGOXhhAeL3+sM3dAlxlqZjr9abb96J8EVZb2k056dU6bjw7UJPCv1hqDYEjHUfxEPGsMePFtLK9BmsI/80NIFwONjbGWttAZ8DPnGD9PTD6iGVGTLVeOR1JB7zivRjmnmfmFrhQrv5EjoazrC3+w3vY6ZbRKkVS1cq8xgOMaxPWTbux7FO9huS9VJDGihoXS2b7nxY8euvtCvnZxZ9x/7W3ru6Mqs8KDXpYAzRLNADgOMLB0M0VJQWVg==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2c8c10c-ff74-4e76-2f1e-08d594af3143
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Mar 2018 13:24:10.7904
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO2PR07MB2728
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w2SDOJ6G017713

> On 28/03/2018 12:51, Niklas Cassel wrote:
> cdns_pcie_ep_set_bar() does some round-up of the BAR size, which means that a 64-bit BAR can be set-up, even when the flag
> PCI_BASE_ADDRESS_MEM_TYPE_64 isn't set.

> If a 64-bit BAR was set-up, set the flag PCI_BASE_ADDRESS_MEM_TYPE_64, so that the calling function can know what BAR width that was actually set-up.

> I'm not sure why cdns_pcie_ep_set_bar() doesn't obey the flag PCI_BASE_ADDRESS_MEM_TYPE_64, but I leave this for the MAINTAINER to fix, since there might be a reason why > this flag is ignored.
Will investigate and fix this in future patch

> Signed-off-by: Niklas Cassel <niklas.cassel@axis.com>
> ---
>  drivers/pci/cadence/pcie-cadence-ep.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/pci/cadence/pcie-cadence-ep.c b/drivers/pci/cadence/pcie-cadence-ep.c
> index cef36cd6b710..2905e098678c 100644
> --- a/drivers/pci/cadence/pcie-cadence-ep.c
> +++ b/drivers/pci/cadence/pcie-cadence-ep.c
> @@ -106,6 +106,9 @@ static int cdns_pcie_ep_set_bar(struct pci_epc *epc, u8 fn,
>  		if (is_64bits && (bar & 1))
>  			return -EINVAL;
>  
> +		if (is_64bits && !(flags & PCI_BASE_ADDRESS_MEM_TYPE_64))
> +			epf_bar->flags |= PCI_BASE_ADDRESS_MEM_TYPE_64;
> +
>  		if (is_64bits && is_prefetch)
>  			ctrl = CDNS_PCIE_LM_BAR_CFG_CTRL_PREFETCH_MEM_64BITS;
>  		else if (is_prefetch)
> --
> 2.14.2
Change looks good to me.
