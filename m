Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751786AbeBWH1R (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Feb 2018 02:27:17 -0500
Received: from mail-bn3nam01on0088.outbound.protection.outlook.com ([104.47.33.88]:45376
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751719AbeBWH1I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Feb 2018 02:27:08 -0500
From: Manish Narani <MNARANI@xilinx.com>
To: Adrian Hunter <adrian.hunter@intel.com>,
        "michal.simek@xilinx.com" <michal.simek@xilinx.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>
CC: Anirudha Sarangi <anirudh@xilinx.com>,
        Srinivas Goud <sgoud@xilinx.com>
Subject: RE: [RFC PATCH] mmc: sdhci-of-arasan: Add auto tuning support for
 ZynqMP Platform
Thread-Topic: [RFC PATCH] mmc: sdhci-of-arasan: Add auto tuning support for
 ZynqMP Platform
Thread-Index: AQHTmfZbHcgatUAMk0Kw/6gGGMV5dKOnKs4AgAdTQuCAAI+lgIABKkOAgAGBQGA=
Date: Fri, 23 Feb 2018 07:27:01 +0000
Message-ID: <SN1PR0201MB17913D8B20DD68ECD39C1164C1CC0@SN1PR0201MB1791.namprd02.prod.outlook.com>
References: <1517336073-18142-1-git-send-email-mnarani@xilinx.com>
 <608309c3-fc4d-25a2-f0a9-21c0f3e2db46@intel.com>
 <SN1PR0201MB1791863A71475E3F0D896DD0C1CE0@SN1PR0201MB1791.namprd02.prod.outlook.com>
 <ce9efad6-b007-4cd9-18e7-a7932835846c@intel.com>
In-Reply-To: <ce9efad6-b007-4cd9-18e7-a7932835846c@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=MNARANI@xilinx.com;
x-originating-ip: [182.72.145.30]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;SN1PR0201MB1839;7:UKLEmbdpg3wX+8J+qPs8S8KXTHKA0DDXKutc7MdulS6W2zCcrsaNFuFQiqn2JQR0erz/fHx99/0XdnVmW7UnwCqX+Ss5GKWfvZAn13/zAA4kPxdM+g3dQx+0Jvh8y6GAZ6uabzrWWI/XKDFf378r2qokRLJVj8pOtTDfZ4gAW+7Pk5OZwQ7bYYn2fz8RgUxmx5vBP9UJn2pQ9w99cK271WgwPeClr//q07t2vmeetQ/2X0QgRPQcB3GDWncOcn6v
x-ms-exchange-antispam-srfa-diagnostics: SSOS;SSOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10009020)(979002)(366004)(376002)(396003)(39860400002)(39380400002)(346002)(199004)(189003)(13464003)(305945005)(76176011)(68736007)(26005)(7736002)(102836004)(6506007)(25786009)(4326008)(59450400001)(2906002)(66066001)(107886003)(93886005)(97736004)(53546011)(8936002)(229853002)(110136005)(55236004)(316002)(54906003)(3280700002)(3660700001)(74316002)(6116002)(2201001)(86362001)(3846002)(5250100002)(2501003)(7696005)(478600001)(81156014)(81166006)(8676002)(2950100002)(53936002)(186003)(6246003)(99286004)(55016002)(2900100001)(72206003)(105586002)(5660300001)(6436002)(106356001)(33656002)(14454004)(9686003)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:SN1PR0201MB1839;H:SN1PR0201MB1791.namprd02.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 1ba64464-eecc-459a-41f6-08d57a8ed51c
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(2017052603307)(7153060)(7193020);SRVR:SN1PR0201MB1839;
x-ms-traffictypediagnostic: SN1PR0201MB1839:
x-microsoft-antispam-prvs: <SN1PR0201MB18390B78F3DD79617CA5A1D6C1CC0@SN1PR0201MB1839.namprd02.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(180628864354917)(9452136761055)(258649278758335)(192813158149592)(228905959029699)(17755550239193);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001082)(6040501)(2401047)(5005006)(8121501046)(3231101)(944501161)(10201501046)(93006095)(93001095)(3002001)(6055026)(6041288)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:SN1PR0201MB1839;BCL:0;PCL:0;RULEID:;SRVR:SN1PR0201MB1839;
x-forefront-prvs: 0592A9FDE6
x-microsoft-antispam-message-info: eHY/KzuJZInZ7tnoErq1t7gJO8nh3d5FuHXSe+PrisN4igIe+fIuG9IW//a081FhjTtJ9ECkoc+BtfwdXvmEatGR2stbRxTLufa9azmldm+r300YiSy68FXd7S8xilXtlP3VrEaVixsUXZg1sZwwfsISyOjrweSSO00evrojsnU=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ba64464-eecc-459a-41f6-08d57a8ed51c
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Feb 2018 07:27:01.8855
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR0201MB1839
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w1N7RLFm026007

Hi Adrian,

> -----Original Message-----
> From: Adrian Hunter [mailto:adrian.hunter@intel.com]
> Sent: Thursday, February 22, 2018 1:50 PM
> To: Manish Narani <MNARANI@xilinx.com>; michal.simek@xilinx.com;
> ulf.hansson@linaro.org; linux-arm-kernel@lists.infradead.org; linux-
> mmc@vger.kernel.org; linux-kernel@vger.kernel.org;
> devicetree@vger.kernel.org; mark.rutland@arm.com; robh+dt@kernel.org
> Cc: Anirudha Sarangi <anirudh@xilinx.com>; Srinivas Goud
> <sgoud@xilinx.com>
> Subject: Re: [RFC PATCH] mmc: sdhci-of-arasan: Add auto tuning support for
> ZynqMP Platform
> 
> On 21/02/18 17:00, Manish Narani wrote:
> > Hi Adrian,
> >
> >> -----Original Message-----
> >> From: Manish Narani
> >> Sent: Wednesday, February 21, 2018 11:39 AM
> >> To: Adrian Hunter <adrian.hunter@intel.com>; michal.simek@xilinx.com;
> >> ulf.hansson@linaro.org; linux-arm-kernel@lists.infradead.org; linux-
> >> mmc@vger.kernel.org; linux-kernel@vger.kernel.org;
> >> devicetree@vger.kernel.org; mark.rutland@arm.com;
> robh+dt@kernel.org
> >> Cc: Anirudha Sarangi <anirudh@xilinx.com>; Srinivas Goud
> >> <sgoud@xilinx.com>
> >> Subject: RE: [RFC PATCH] mmc: sdhci-of-arasan: Add auto tuning
> >> support for ZynqMP Platform
> >>
> >> Hi Adrian,
> >>
> >>
> >>> -----Original Message-----
> >>> From: Adrian Hunter [mailto:adrian.hunter@intel.com]
> >>> Sent: Friday, February 16, 2018 7:37 PM
> >>> To: Manish Narani <MNARANI@xilinx.com>; michal.simek@xilinx.com;
> >>> ulf.hansson@linaro.org; linux-arm-kernel@lists.infradead.org; linux-
> >>> mmc@vger.kernel.org; linux-kernel@vger.kernel.org;
> >>> devicetree@vger.kernel.org; mark.rutland@arm.com;
> robh+dt@kernel.org
> >>> Cc: Anirudha Sarangi <anirudh@xilinx.com>; Srinivas Goud
> >>> <sgoud@xilinx.com>; Manish Narani <MNARANI@xilinx.com>
> >>> Subject: Re: [RFC PATCH] mmc: sdhci-of-arasan: Add auto tuning
> >>> support for ZynqMP Platform
> >>>
> >>> On 30/01/18 20:14, Manish Narani wrote:
> >>>> This patch adds support of SD auto tuning for ZynqMP platform. Auto
> >>>> tuning sequence sends tuning block to card when operating in UHS-1
> >>>> modes. This resets the DLL and sends CMD19/CMD21 as a part of the
> >>>> auto tuning process. Once the auto tuning process gets completed,
> >>>> reset the DLL to load the newly obtained SDHC tuned tap value.
> >>>
> >>> How is this different from:
> >>> 	1. reset the dll
> >>> 	2. call sdhci_execute_tuning
> >>> 	3. reset the dll
> >>>
> > Below is my take on your above comments:
> > - 'Reset the dll' is a platform specific call inside
> > 'arasan_zynqmp_execute_tuning' which is implemented in
> > sdhci-of-arasan.c
> > - 'arasan_zynqmp_execute_tuning' is called from 'sdhci_execute_tuning'
> > as a platform_execute_tuning routine
> > - So to keep 'DLL reset' routine called from sdhci-of-arasan.c, I have
> > implemented the execute_tuning in sdhci-of-arasan.c
> 
> I meant something like:
> 
> 	if (of_device_is_compatible(pdev->dev.of_node, "xlnx,zynqmp-
> 8.9a"))
> 		host->mmc_host_ops.execute_tuning =
> arasan_zynqmp_execute_tuning;
> 
This will need the removal of 'const' from 
static const struct mmc_host_ops sdhci_ops = {}
in sdhci.c file. Please confirm.

Thanks,
Manish

> 
> static int arasan_zynqmp_execute_tuning(struct mmc_host *mmc, u32
> opcode) {
> 	struct sdhci_host *host = mmc_priv(mmc);
> 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> 	struct sdhci_arasan_data *sdhci_arasan =
> sdhci_pltfm_priv(pltfm_host);
> 	int err;
> 
> 	arasan_zynqmp_dll_reset(host, sdhci_arasan->device_id);
> 
> 	err = sdhci_execute_tuning(mmc, opcode);
> 	if (err)
> 		return err;
> 
> 	arasan_zynqmp_dll_reset(host, sdhci_arasan->device_id);
> 
> 	return 0;
> }
> 
> >
> > Alternative way (Please review):
> > - Define a host->quirk2 bit (SDHCI_QUIRK2_DLL_RESET_NEEDED) in
> > sdhci-of-arasan.c indicating DLL reset needed while tuning operation
> > - Call 'dll reset' routine before and after __sdhci_execute_tuning()
> > in sdhci.c when a host->quirk2 bit (SDHCI_QUIRK2_DLL_RESET_NEEDED) is
> > set
> 
> We should try to avoid quirks.
