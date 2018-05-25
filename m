Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966380AbeEYJvZ (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 05:51:25 -0400
Received: from mail-eopbgr10071.outbound.protection.outlook.com ([40.107.1.71]:5656
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S966346AbeEYJvT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 05:51:19 -0400
From: "A.s. Dong" <aisheng.dong@nxp.com>
To: kbuild test robot <lkp@intel.com>
CC: "kbuild-all@01.org" <kbuild-all@01.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "hdegoede@redhat.com" <hdegoede@redhat.com>,
        "b.zolnierkie@samsung.com" <b.zolnierkie@samsung.com>,
        "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
        "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        Stephen Boyd <sboyd@codeaurora.org>
Subject: RE: [PATCH V2 3/4] clk: add managed version of clk_bulk_get_all
Thread-Topic: [PATCH V2 3/4] clk: add managed version of clk_bulk_get_all
Thread-Index: AQHTwMOXEAXyRBca3U6WNlUuStUBU6PdZKEAgGM1SWA=
Date: Fri, 25 May 2018 09:51:16 +0000
Message-ID: <AM0PR04MB4211BF66D1C5E025C264687080690@AM0PR04MB4211.eurprd04.prod.outlook.com>
References: <1521602391-30356-4-git-send-email-aisheng.dong@nxp.com>
 <201803231452.YBWTInPr%fengguang.wu@intel.com>
In-Reply-To: <201803231452.YBWTInPr%fengguang.wu@intel.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=aisheng.dong@nxp.com;
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM0PR04MB4836;7:4t4yNyLO8EyDE9NmoIzh7dliY/b1JZ/ZOtONazf0XUopYSs2L/eOoO50ytlAXNabuXANS3o7Mounp7lUrDzWe6c2WfKHbJZuWzaih6SNmibX110ttJtOdreRuyY27YQ19vnfBBtrflzcpYSm7yj9+sM2iGjJVgNxAQAoMH789eJz5nxNWmgxfTkv3umScIxyh7irh2hXEWVCWZGbChG5F8L003ZlwmkAB0VdhpSZcTFANaZRE0jK19Uo7LxUNp43
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:AM0PR04MB4836;
x-ms-traffictypediagnostic: AM0PR04MB4836:
x-microsoft-antispam-prvs: <AM0PR04MB48368E2361B3A535CF96418D80690@AM0PR04MB4836.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(189930954265078)(185117386973197)(258649278758335)(45079756050767)(7411616537696)(228905959029699);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231254)(944501410)(52105095)(10201501046)(93006095)(93001095)(3002001)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:AM0PR04MB4836;BCL:0;PCL:0;RULEID:;SRVR:AM0PR04MB4836;
x-forefront-prvs: 06833C6A67
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(346002)(376002)(396003)(39380400002)(39860400002)(199004)(189003)(13464003)(51914003)(86362001)(6116002)(102836004)(7696005)(3846002)(55016002)(54906003)(6506007)(2900100001)(14454004)(53546011)(8936002)(8676002)(6436002)(186003)(26005)(81156014)(81166006)(25786009)(478600001)(105586002)(45080400002)(106356001)(316002)(5660300001)(6916009)(53936002)(5250100002)(97736004)(9686003)(99286004)(476003)(3660700001)(33656002)(486006)(3280700002)(66066001)(229853002)(305945005)(2906002)(11346002)(6306002)(7416002)(68736007)(74316002)(6246003)(446003)(4326008)(76176011)(966005)(7736002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4836;H:AM0PR04MB4211.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: n21FoNdyS0KkeeOiIoJQ3cf+gRvohGrNkkmY34RhGaQcmzwkddFEVEKaBbVvW2XoI3I8+Oe/iD7IXGEltBmPIOCtCfYgiaq7DoWlJUnKvnJtuXttFSeSGISPdr2UKDBaZuq4LmP2C+vcNW85Sur/ZyFWe0GQLEUeMQQbZAvbqZFsqKeZa0nNkqTG2IWxyi/d
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 1a4191d3-9919-4380-8888-08d5c2250ede
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a4191d3-9919-4380-8888-08d5c2250ede
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 May 2018 09:51:16.0742
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4836
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w4P9pbeO010583

> -----Original Message-----
> From: kbuild test robot [mailto:lkp@intel.com]
> Sent: Friday, March 23, 2018 2:49 PM
> To: A.s. Dong <aisheng.dong@nxp.com>
> Cc: kbuild-all@01.org; linux-clk@vger.kernel.org; linux-
> kernel@vger.kernel.org; linux-arm-kernel@lists.infradead.org;
> mturquette@baylibre.com; hdegoede@redhat.com;
> b.zolnierkie@samsung.com; linux@armlinux.org.uk; linux-
> fbdev@vger.kernel.org; dl-linux-imx <linux-imx@nxp.com>;
> sboyd@kernel.org; A.s. Dong <aisheng.dong@nxp.com>; Stephen Boyd
> <sboyd@codeaurora.org>
> Subject: Re: [PATCH V2 3/4] clk: add managed version of clk_bulk_get_all
> 

[...]

> All errors (new ones prefixed by >>):
> 
>    In file included from include/linux/cpufreq.h:14:0,
>                     from arch/powerpc/platforms/cell/cpufreq_spudemand.c:23:
>    include/linux/clk.h:679:1: error: expected identifier or '(' before '{' token
>     {
>     ^
> >> include/linux/clk.h:677:32: error: 'devm_clk_bulk_get_all' declared
> >> 'static' but never defined [-Werror=unused-function]
>     static inline int __must_check devm_clk_bulk_get_all(struct device *dev,
>                                    ^~~~~~~~~~~~~~~~~~~~~
>    cc1: all warnings being treated as errors
> 
> vim +677 include/linux/clk.h
> 
>    676
>  > 677	static inline int __must_check devm_clk_bulk_get_all(struct device
> *dev,
>    678							     struct
> clk_bulk_data **clks);

Thanks for the reporting.
Caused by the extra unneeded ';' at the end of the line.
Will fix.

Regards
Dong Aisheng

>  > 679	{
>    680
>    681		return 0;
>    682	}
>    683
> 
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Center
> https://emea01.safelinks.protection.outlook.com/?url=https%3A%2F%2Flist
> s.01.org%2Fpipermail%2Fkbuild-
> all&data=02%7C01%7Caisheng.dong%40nxp.com%7Ce9e35f96c61a4c46d1790
> 8d5908a4d46%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C6365738
> 46071200287&sdata=yIWEjcpE2tyJP%2BmsMPqn%2F83TCsxw64J%2Ba5ue73
> qGnN0%3D&reserved=0                   Intel Corporation
