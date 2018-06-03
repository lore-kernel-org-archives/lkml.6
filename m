Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751425AbeFCMps (ORCPT <rfc822;w@1wt.eu>);
        Sun, 3 Jun 2018 08:45:48 -0400
Received: from mail-ve1eur01on0046.outbound.protection.outlook.com ([104.47.1.46]:6385
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751048AbeFCMpq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jun 2018 08:45:46 -0400
From: Anson Huang <anson.huang@nxp.com>
To: Fabio Estevam <festevam@gmail.com>
CC: Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, dl-linux-imx <linux-imx@nxp.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
        <linux-arm-kernel@lists.infradead.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/4] clk: imx6sl: remove clks_init_on array
Thread-Topic: [PATCH 2/4] clk: imx6sl: remove clks_init_on array
Thread-Index: AQHT+ueYLHRDJjWGWUqWxV9Maeu/OKROc8eAgAAH9ts=
Date: Sun, 3 Jun 2018 12:45:38 +0000
Message-ID: <682824A6-C55E-4680-9FD5-E5E7E37F27A0@nxp.com>
References: <1527994847-2363-1-git-send-email-Anson.Huang@nxp.com>
 <1527994847-2363-2-git-send-email-Anson.Huang@nxp.com>,<CAOMZO5Af_Wdp=MNR28v3ALiguxQSQv4x2Zf224FXSiEGtP68Bw@mail.gmail.com>
In-Reply-To: <CAOMZO5Af_Wdp=MNR28v3ALiguxQSQv4x2Zf224FXSiEGtP68Bw@mail.gmail.com>
Accept-Language: en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com;
x-originating-ip: [183.192.19.79]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM3PR04MB1139;7:Otomm8TGUYRSbAPcxQw6Ro8Pd7OMl+cKmxQU2eqwLYOW57VpB8GkPe7G+4xzNKog4Aj4Eb+VElAZn4lglivWFOK87DyCJIzVyR7eCMXkjFkcwS19QGzptTN9QHOYdFXA6Vtsx0CO/6W/W74pXx6XLk++OSMFOrwvcU1XOnZRhDLklQ9HDzTqUPbeBcs9/M5ArxTKtYVQWzPAyX+VKobHbbbD8muJa/sKB1NNahkK+ydDf0SLYM2+uD4qsIWrEoSX
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:AM3PR04MB1139;
x-ms-traffictypediagnostic: AM3PR04MB1139:
x-microsoft-antispam-prvs: <AM3PR04MB113927479A2FE97DB9E1FB8CF5600@AM3PR04MB1139.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(185117386973197)(85827821059158);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(3231254)(944501410)(52105095)(93006095)(93001095)(10201501046)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123558120)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:AM3PR04MB1139;BCL:0;PCL:0;RULEID:;SRVR:AM3PR04MB1139;
x-forefront-prvs: 069255B8B8
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(39860400002)(366004)(39380400002)(346002)(376002)(199004)(189003)(68736007)(6116002)(3660700001)(3280700002)(2906002)(11346002)(476003)(446003)(486006)(44832011)(2616005)(5250100002)(14454004)(8676002)(8936002)(81166006)(81156014)(105586002)(305945005)(54906003)(33656002)(7736002)(1411001)(106356001)(39060400002)(5660300001)(25786009)(4326008)(53936002)(6512007)(6246003)(316002)(6916009)(36756003)(76176011)(97736004)(6486002)(229853002)(53546011)(66066001)(102836004)(186003)(478600001)(2900100001)(26005)(82746002)(6436002)(83716003)(6506007)(86362001)(99286004)(3846002)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM3PR04MB1139;H:AM3PR04MB1315.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: 4oChVwPBDsuiwSWAiQxM1Obja8Dh4vSnQFO4yILLYGmJ20Btz8mkpb5YY6Xvae0KaraxTn8YmQFpXVP/frW0cd5+kmx3RJ3aSK2LEMsZLQt/6SknCeAC9VlUhCf2KC3rnL+uIouao5T/9R+UAid2L2p9ZsLbMALWclXOXbTnaLhX7NUQZiJjNGTVo46L0CPa
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 654538ed-7e9c-4b54-3dfa-08d5c94fe8d0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 654538ed-7e9c-4b54-3dfa-08d5c94fe8d0
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jun 2018 12:45:38.7260
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM3PR04MB1139
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w53CjuwX018682

Hi, Fabio

>From Anson's iPhone 6


> 在 2018年6月3日，20:17，Fabio Estevam <festevam@gmail.com> 写道：
> 
> Hi Anson,
> 
>> On Sun, Jun 3, 2018 at 12:00 AM, Anson Huang <Anson.Huang@nxp.com> wrote:
>> Clock framework will enable those clocks registered
>> with CLK_IS_CRITICAL flag, so no need to have
>> clks_init_on array during clock initialization now.
>> 
>> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
>> ---
>> drivers/clk/imx/clk-imx6sl.c | 12 ------------
>> 1 file changed, 12 deletions(-)
>> 
>> diff --git a/drivers/clk/imx/clk-imx6sl.c b/drivers/clk/imx/clk-imx6sl.c
>> index 66b1dd1..eb6bcbf 100644
>> --- a/drivers/clk/imx/clk-imx6sl.c
>> +++ b/drivers/clk/imx/clk-imx6sl.c
>> @@ -104,10 +104,6 @@ static struct clk_onecell_data clk_data;
>> static void __iomem *ccm_base;
>> static void __iomem *anatop_base;
>> 
>> -static const u32 clks_init_on[] __initconst = {
>> -       IMX6SL_CLK_IPG, IMX6SL_CLK_ARM, IMX6SL_CLK_MMDC_ROOT,
>> -};
> 
> It looks like you missed to pass the CLK_IS_CRITICAL flag to these clocks.

The ARM and mmdc root are busy divider, the CLK_IS_CRITICAL flag is included by default when busy divider is registered. IPG’parent is AHB which is also a busy divider. And IPG itself has no gate, no need to add flag.

Anson.
