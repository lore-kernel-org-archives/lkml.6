Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751076AbeCGGku (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 01:40:50 -0500
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:31944 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750984AbeCGGkr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 01:40:47 -0500
X-IronPort-AV: E=Sophos;i="5.47,434,1515427200";
   d="scan'208";a="73612130"
From: Avri Altman <Avri.Altman@wdc.com>
To: Harish Jenny K N <harish_kandiga@mentor.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
        "shawn.lin@rock-chips.com" <shawn.lin@rock-chips.com>,
        "andriy.shevchenko@linux.intel.com"
        <andriy.shevchenko@linux.intel.com>
CC: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Vladimir_Zapolskiy@mentor.com" <Vladimir_Zapolskiy@mentor.com>
Subject: RE: [PATCH v6] mmc: Export host capabilities to debugfs.
Thread-Topic: [PATCH v6] mmc: Export host capabilities to debugfs.
Thread-Index: AQHTtdZuKkHx5ynt6kqgcWhh3VT3raPET4/w
Date: Wed, 7 Mar 2018 06:40:44 +0000
Message-ID: <DM5PR04MB10857D9F0177C760047100D1FCD80@DM5PR04MB1085.namprd04.prod.outlook.com>
References: <1520401051-11135-1-git-send-email-harish_kandiga@mentor.com>
In-Reply-To: <1520401051-11135-1-git-send-email-harish_kandiga@mentor.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Avri.Altman@wdc.com;
x-originating-ip: [212.25.79.133]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR04MB1147;7:KjpOcjpo7sncwlIkO2dGlQeEexK0qCHCxUtAMAEP58FEPp0m2MDeWNdS7lLb81agsHvP6Qo39pwlC8Zehx2b++R95gREdx7rYfl3yBnmaRZKp9COlJSLu3A30NoSy6QcAgIlJVxZA+ieSXTbFY196xwVZdx3AqULOSs1CdiB5RMfQc1TLzXkJQXX+BSMJtBRRy1nB4NVJ1wX/yo2rrtAp8/+MXxjdOjdpwwotA+NrJueNI8QY9WpKf+50H3/vI0C;20:s9VwUWwyKHRmLCu8GuJQMKVH373Eq96G0vzMKt2tjskwK5OKRSuIkQ7Dv4MeXrog/1PCrIV/mREODI8Iv9zDd+y7Snnt8WhaVt8h06086naIHT07x37e3P0pmSgj5HuNodzsQ72yOQ1mubuo0V76bVug/vJ1H3e1O5Hp7KcKM/M=
x-ms-exchange-antispam-srfa-diagnostics: SSOS;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: c6073ed3-1066-425e-87d3-08d583f65a54
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:DM5PR04MB1147;
x-ms-traffictypediagnostic: DM5PR04MB1147:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <DM5PR04MB1147D2071035C8533945259EFCD80@DM5PR04MB1147.namprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040501)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3231220)(944501244)(52105095)(3002001)(6055026)(6041288)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR04MB1147;BCL:0;PCL:0;RULEID:;SRVR:DM5PR04MB1147;
x-forefront-prvs: 0604AFA86B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(366004)(39860400002)(39380400002)(396003)(376002)(13464003)(199004)(189003)(26005)(3280700002)(316002)(2201001)(2900100001)(110136005)(54906003)(229853002)(14454004)(25786009)(2950100002)(86362001)(99286004)(186003)(76176011)(7696005)(106356001)(5250100002)(2501003)(72206003)(3846002)(6116002)(478600001)(2906002)(68736007)(8936002)(5660300001)(33656002)(305945005)(7736002)(81166006)(81156014)(8676002)(74316002)(105586002)(53546011)(9686003)(966005)(6506007)(6306002)(66066001)(6246003)(53936002)(6436002)(97736004)(102836004)(55016002)(4326008)(3660700001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR04MB1147;H:DM5PR04MB1085.namprd04.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: 5mlTz2k4bwfYbTMPA1rfygog+Gs+N4vKBXcQs7dIivugh2W80ICevGFYqMRK0BGfuFxe7fcLtvcRlznKC6injQwVnSXh/Zdj4yazYuy7yRHvkCiQIbCzGa1hcXrNm0t/jgebEfbDXUK9Ya6OdvEz73AnDKH2CTN5eYEDhNtLLhAc19jOcTivZZkkshWxgAKEJCZAe5RN4Zn9oMHygQdDBtbmi/IvX4qTb3XZHM30s9MZkllvARQPOvMGToTgCzc1RJOpsLwghfHoZUCq+ZNtNW52wOlfV9udfKeB13AYGRTytVFaVSdWx77+USt9KuZxS5T8r0f+zFBf45jmCRq9iA==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6073ed3-1066-425e-87d3-08d583f65a54
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Mar 2018 06:40:44.2069
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR04MB1147
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w276etUF019391



> -----Original Message-----
> From: Harish Jenny K N [mailto:harish_kandiga@mentor.com]
> Sent: Wednesday, March 07, 2018 7:38 AM
> To: ulf.hansson@linaro.org; linus.walleij@linaro.org;
> adrian.hunter@intel.com; shawn.lin@rock-chips.com; Avri Altman
> <Avri.Altman@wdc.com>; andriy.shevchenko@linux.intel.com
> Cc: linux-mmc@vger.kernel.org; linux-kernel@vger.kernel.org;
> harish_kandiga@mentor.com; Vladimir_Zapolskiy@mentor.com
> Subject: [PATCH v6] mmc: Export host capabilities to debugfs.
> 
> This patch exports the host capabilities to debugfs
> 
> This idea of sharing host capabilities over debugfs came up from Abbas Raza
> <Abbas_Raza@mentor.com> Earlier discussions:
> https://lkml.org/lkml/2018/3/5/357
> https://www.spinics.net/lists/linux-mmc/msg48219.html
> 
> Signed-off-by: Harish Jenny K N <harish_kandiga@mentor.com>
> ---
> 
> 
> +static int mmc_caps_show(struct seq_file *s, void *unused) {
> +	struct mmc_host *host = s->private;
> +	u32 caps = host->caps;
> +
> +	seq_puts(s, "\nMMC Host capabilities are:\n");
> +	seq_puts(s,
> "=============================================\n");
> +	seq_printf(s, "Can the host do 4 bit transfers :\t%s\n",
> +		   ((caps & MMC_CAP_4_BIT_DATA) ? "Yes" : "No"));

Maybe use a more compact form, and just call a macro with the applicable (stringified) bit?


Thanks,
Avri
