Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751462AbeCLLcg (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 07:32:36 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:51380 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750967AbeCLLcd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 07:32:33 -0400
X-IronPort-AV: E=Sophos;i="5.47,461,1515427200";
   d="scan'208";a="73969084"
From: Avri Altman <Avri.Altman@wdc.com>
To: Harish Jenny K N <harish_kandiga@mentor.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
        "shawn.lin@rock-chips.com" <shawn.lin@rock-chips.com>
CC: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Vladimir_Zapolskiy@mentor.com" <Vladimir_Zapolskiy@mentor.com>
Subject: RE: [PATCH v9] mmc: Export host capabilities to debugfs.
Thread-Topic: [PATCH v9] mmc: Export host capabilities to debugfs.
Thread-Index: AQHTubsGYD25STNRbUa+dM7TicfsWKPMYHQAgAAKQECAAAkRAIAAA/ow
Date: Mon, 12 Mar 2018 11:32:08 +0000
Message-ID: <DM5PR04MB10859F389CA2D1F2370C02CFFCD30@DM5PR04MB1085.namprd04.prod.outlook.com>
References: <1520829090-3567-1-git-send-email-harish_kandiga@mentor.com>
 <1520849262.10722.582.camel@linux.intel.com>
 <DM5PR04MB10854C79897A80023EF37F76FCD30@DM5PR04MB1085.namprd04.prod.outlook.com>
 <540fef96-aa2f-e6c3-467d-bc1d021dd55b@mentor.com>
In-Reply-To: <540fef96-aa2f-e6c3-467d-bc1d021dd55b@mentor.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Avri.Altman@wdc.com;
x-originating-ip: [212.25.79.133]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR04MB0938;20:gus/7cR9Sc2RIrQBgYGjwsJe3DCrjMyAWTBGVyRkqbzf3hycomOLrwloV+FMMxAdlJ7Ev9Pi9j2E4dU/02VNbUJX8VzfbH6cz6zvDrGEGZufLuEu+FrPuQt1NkjKlNNvNpvxSxy82ddMuu6JtUO1IzGhl5r2PBENyv6LCzXm/9Q=
x-ms-exchange-antispam-srfa-diagnostics: SSOS;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: a1258d58-6907-44cc-87ba-08d5880ce3e5
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:DM5PR04MB0938;
x-ms-traffictypediagnostic: DM5PR04MB0938:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <DM5PR04MB093807F299FAB40FA7D2877AFCD30@DM5PR04MB0938.namprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3002001)(3231220)(944501244)(52105095)(10201501046)(6055026)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR04MB0938;BCL:0;PCL:0;RULEID:;SRVR:DM5PR04MB0938;
x-forefront-prvs: 06098A2863
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(39860400002)(376002)(366004)(396003)(346002)(377424004)(189003)(199004)(13464003)(316002)(110136005)(3280700002)(25786009)(6246003)(2501003)(5250100002)(6436002)(9686003)(6306002)(4326008)(55016002)(53936002)(2906002)(33656002)(97736004)(105586002)(2900100001)(229853002)(54906003)(72206003)(3660700001)(106356001)(966005)(2950100002)(102836004)(53546011)(6506007)(26005)(305945005)(7736002)(66066001)(2201001)(478600001)(7696005)(68736007)(8676002)(99286004)(81156014)(74316002)(81166006)(3846002)(6116002)(86362001)(76176011)(186003)(8936002)(93886005)(14454004)(5660300001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR04MB0938;H:DM5PR04MB1085.namprd04.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: Wu7tAngsID+YxAiFhpSVaSgK5tYml0wbpxh7NFqG+0UJyadc2JWCymVzXrp7fnBL+xSkoKivatfjvEBlGNpo3kq8CR16UsCFbzyOEYJFW69I0LnLdJoEXsV6d9Wa60aEFRC1NbiO212BIqP1No59mgQrlN6pBm5dnFWxG8JcaNFpHKMuIFYAJ4+3vcFgRA/3j6J+FtjmCOYvC3d6CQm+IcaMABWv/wtgliWkpcB+CoCujRDb0dniyGrUKsfnA2QQkDW/cPuzl0fl33/wN/D/9u5SSEkDB5NK6a+8pnqDWzwDkYfiu5jFOQb+zYs+HqVGH+ydpIzLRBCw7O/IvpAvvA==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1258d58-6907-44cc-87ba-08d5880ce3e5
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Mar 2018 11:32:08.6155
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR04MB0938
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w2CBWgOs024213



> -----Original Message-----
> From: Harish Jenny K N [mailto:harish_kandiga@mentor.com]
> Sent: Monday, March 12, 2018 1:17 PM
> To: Avri Altman <Avri.Altman@wdc.com>; Andy Shevchenko
> <andriy.shevchenko@linux.intel.com>; ulf.hansson@linaro.org;
> linus.walleij@linaro.org; adrian.hunter@intel.com; shawn.lin@rock-chips.com
> Cc: linux-mmc@vger.kernel.org; linux-kernel@vger.kernel.org;
> Vladimir_Zapolskiy@mentor.com
> Subject: Re: [PATCH v9] mmc: Export host capabilities to debugfs.
> 
> 
> 
> On Monday 12 March 2018 04:15 PM, Avri Altman wrote:
> >
> >> -----Original Message-----
> >> From: Andy Shevchenko [mailto:andriy.shevchenko@linux.intel.com]
> >> Sent: Monday, March 12, 2018 12:08 PM
> >> To: Harish Jenny K N <harish_kandiga@mentor.com>;
> >> ulf.hansson@linaro.org; linus.walleij@linaro.org;
> >> adrian.hunter@intel.com; shawn.lin@rock- chips.com; Avri Altman
> >> <Avri.Altman@wdc.com>
> >> Cc: linux-mmc@vger.kernel.org; linux-kernel@vger.kernel.org;
> >> Vladimir_Zapolskiy@mentor.com
> >> Subject: Re: [PATCH v9] mmc: Export host capabilities to debugfs.
> >>
> >> On Mon, 2018-03-12 at 10:01 +0530, Harish Jenny K N wrote:
> >>> This patch exports the host capabilities to debugfs
> >>>
> >>> This idea of sharing host capabilities over debugfs came up from
> >>> Abbas Raza <Abbas_Raza@mentor.com> Earlier discussions:
> >>> https://lkml.org/lkml/2018/3/5/357
> >>> https://www.spinics.net/lists/linux-mmc/msg48219.html
> >>>
> >> Address below minors and, FWIW, take mine
> >>
> >> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> >>
> >>> +	for_each_set_bit(bit, (const unsigned long *)&caps,
> >>> BITS_PER_LONG)
> >>> +	for_each_set_bit(bit, (const unsigned long *)&caps2,
> >>> BITS_PER_LONG)
> >> Explicit casting is not needed anymore in both cases.
> > Also maybe use sizeof(mmc_host_capabilities) instead of BITS_PER_LONG?
> 
> You mean sizeof(caps) and not sizeof(mmc_host_capabilities) . Right ?
meant ARRAY_SIZE(mmc_host_capabilities)

Thanks,
Avri

> 
> 
> Thanks,
> Harish Jenny K N
