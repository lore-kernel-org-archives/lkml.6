Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751402AbeFCMsI (ORCPT <rfc822;w@1wt.eu>);
        Sun, 3 Jun 2018 08:48:08 -0400
Received: from mail-ve1eur01on0048.outbound.protection.outlook.com ([104.47.1.48]:60398
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751057AbeFCMsG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jun 2018 08:48:06 -0400
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
Subject: Re: [PATCH 1/4] clk: imx6q: remove clks_init_on array
Thread-Topic: [PATCH 1/4] clk: imx6q: remove clks_init_on array
Thread-Index: AQHT+ueX6hYt01LFM028YAG/S2bHiKROe18AgAABC1s=
Date: Sun, 3 Jun 2018 12:48:03 +0000
Message-ID: <2D554312-36F2-4781-899C-8D9F5BD20B46@nxp.com>
References: <1527994847-2363-1-git-send-email-Anson.Huang@nxp.com>,<CAOMZO5CmgBsaaegVV9OjdyXv5_O0V9iTS2qYbtuH26qkG2_zrA@mail.gmail.com>
In-Reply-To: <CAOMZO5CmgBsaaegVV9OjdyXv5_O0V9iTS2qYbtuH26qkG2_zrA@mail.gmail.com>
Accept-Language: en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com;
x-originating-ip: [183.192.19.79]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM3PR04MB1139;7:AgIUWo4CT2jTjHYActIgyh2e2Z7qsGJSL4/gl6ELge5pkFxQPdhzY4EzFuvY2T7xSZAld6xq0uGokjwAqMTgk7Mt3g7CswztS/F6+qXbI1CVjUbYA++z/iygdFNzB46qSki4MgXy8jkM1CEtD0KYDRtcwtwlrKtrT4ONY7FBqAZYKRGPZAFIwQLuJeQxX7T5yf6SQxPrODYCx9iHuE6TbDlW8brgmY0rqz037jAp29eFs0X2vg872V1vaO6q9Ymn
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:AM3PR04MB1139;
x-ms-traffictypediagnostic: AM3PR04MB1139:
x-microsoft-antispam-prvs: <AM3PR04MB113930E332F8EB567A552D52F5600@AM3PR04MB1139.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(185117386973197)(85827821059158);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(3231254)(944501410)(52105095)(93006095)(93001095)(10201501046)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123558120)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:AM3PR04MB1139;BCL:0;PCL:0;RULEID:;SRVR:AM3PR04MB1139;
x-forefront-prvs: 069255B8B8
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(346002)(366004)(396003)(39860400002)(39380400002)(189003)(199004)(229853002)(53546011)(6486002)(102836004)(66066001)(76176011)(97736004)(3846002)(2900100001)(26005)(186003)(478600001)(99286004)(86362001)(82746002)(83716003)(6506007)(6436002)(2616005)(446003)(476003)(11346002)(486006)(44832011)(81156014)(105586002)(81166006)(14454004)(5250100002)(8936002)(8676002)(3280700002)(3660700001)(68736007)(6116002)(2906002)(53936002)(4326008)(6512007)(39060400002)(5660300001)(25786009)(6246003)(36756003)(316002)(6916009)(33656002)(7736002)(305945005)(54906003)(1411001)(106356001)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM3PR04MB1139;H:AM3PR04MB1315.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: 2yRojYFoRCugvIBcy7nufvDnHrLtDdWzhmeNbMtVeXm+FoJwDkX181UU+40Bpx30eYC3EaWxjiwGEuapQBhaXVnhhYCBAbIzjxX3PW3aFHpfiufW0Gdsb7EHCQS95z5RAQwDLwHiHTy98vCyAhUw/6HVYi44zVeXcCnacddIszlEHDG5K4No9ztYyGbDsB9G
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 2c89be88-3309-4960-49f1-08d5c9503f37
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c89be88-3309-4960-49f1-08d5c9503f37
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jun 2018 12:48:03.7479
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM3PR04MB1139
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w53CmEPx022058

Hi, Fabio

>From Anson's iPhone 6


> 在 2018年6月3日，20:44，Fabio Estevam <festevam@gmail.com> 写道：
> 
>> On Sun, Jun 3, 2018 at 12:00 AM, Anson Huang <Anson.Huang@nxp.com> wrote:
>> Clock framework will enable those clocks registered
>> with CLK_IS_CRITICAL flag, so no need to have
>> clks_init_on array during clock initialization now.
>> 
>> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
>> ---
>> drivers/clk/imx/clk-imx6q.c | 14 ++------------
>> 1 file changed, 2 insertions(+), 12 deletions(-)
>> 
>> diff --git a/drivers/clk/imx/clk-imx6q.c b/drivers/clk/imx/clk-imx6q.c
>> index b9ea703..8754c61 100644
>> --- a/drivers/clk/imx/clk-imx6q.c
>> +++ b/drivers/clk/imx/clk-imx6q.c
>> @@ -96,12 +96,6 @@ static const char *pll7_bypass_sels[] = { "pll7", "pll7_bypass_src", };
>> static struct clk *clk[IMX6QDL_CLK_END];
>> static struct clk_onecell_data clk_data;
>> 
>> -static unsigned int const clks_init_on[] __initconst = {
>> -       IMX6QDL_CLK_MMDC_CH0_AXI,
>> -       IMX6QDL_CLK_ROM,
>> -       IMX6QDL_CLK_ARM,
> 
> IMX6QDL_CLK_ARM does not have the CLK_IS_CRITICAL flag.
> 
> Is this intended? If so, please mention in the commit log.

As I explain in previous mail, busy divider clk type already include the flag when registered.

Anson.
