Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752084AbeB1IV0 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 03:21:26 -0500
Received: from mail-bl2nam02on0083.outbound.protection.outlook.com ([104.47.38.83]:47210
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751823AbeB1IVY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 03:21:24 -0500
From: "Kalderon, Michal" <Michal.Kalderon@cavium.com>
To: =?utf-8?B?SGVybsOhbiBHb256YWxleg==?= <hernan@vanguardiasur.com.ar>,
        "Elior, Ariel" <Ariel.Elior@cavium.com>,
        Dept-Eng Everest Linux L2 <Dept-EngEverestLinuxL2@cavium.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] qlogic/qed: Constify *pkt_type_str[]
Thread-Topic: [PATCH] qlogic/qed: Constify *pkt_type_str[]
Thread-Index: AQHTsBrCKQ1760i790WcPWAZZy6zhqO5eZgA
Date: Wed, 28 Feb 2018 08:21:20 +0000
Message-ID: <CY1PR0701MB20124ACD2CFD87EF9E1EFD6988C70@CY1PR0701MB2012.namprd07.prod.outlook.com>
References: <1519770694-20678-1-git-send-email-hernan@vanguardiasur.com.ar>
In-Reply-To: <1519770694-20678-1-git-send-email-hernan@vanguardiasur.com.ar>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Michal.Kalderon@cavium.com;
x-originating-ip: [31.168.140.228]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY1PR0701MB1801;7:3Nf6U8rE5/G11vJiiwTKsYU0oFOWzZzpDsp3gLt7ziXzKaiEm/ZHT+wv+6TbqwNZZqd64O8MD4IbbykU+EF+1moGEuBaM7ymZPk+qmkNTKPabAF+eJICon2bCw5SWiK2mLK3gg3NMHkHTeaOjen4B0nOb8NDlr8QLlKOntAIUgwCfTeRIfFSATCuO1gnU2hML9aO1UWSTMmbXeovcbaOwDEPqxTI+ZUCosbF5tk1LhpXRbuhRcwg21CcZin26agR
x-ms-exchange-antispam-srfa-diagnostics: SSOS;SSOR;
x-ms-office365-filtering-correlation-id: 8a5fa344-b18c-4ff0-df10-08d57e843f47
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(2017052603307)(7153060)(7193020);SRVR:CY1PR0701MB1801;
x-ms-traffictypediagnostic: CY1PR0701MB1801:
x-microsoft-antispam-prvs: <CY1PR0701MB18017D15AFBD0B96A86F2F0688C70@CY1PR0701MB1801.namprd07.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040501)(2401047)(5005006)(8121501046)(3002001)(10201501046)(93006095)(93001095)(3231220)(944501217)(52105095)(6041288)(20161123560045)(20161123558120)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:CY1PR0701MB1801;BCL:0;PCL:0;RULEID:;SRVR:CY1PR0701MB1801;
x-forefront-prvs: 0597911EE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39380400002)(39860400002)(346002)(396003)(376002)(366004)(189003)(199004)(97736004)(2906002)(33656002)(6246003)(106356001)(186003)(53936002)(2950100002)(3660700001)(2501003)(229853002)(316002)(6436002)(478600001)(14454004)(72206003)(110136005)(68736007)(3280700002)(7696005)(25786009)(55016002)(7736002)(9686003)(74316002)(6116002)(105586002)(81166006)(81156014)(66066001)(305945005)(102836004)(3846002)(2900100001)(8676002)(86362001)(6506007)(26005)(99286004)(2201001)(59450400001)(8936002)(77096007)(5660300001)(76176011);DIR:OUT;SFP:1101;SCL:1;SRVR:CY1PR0701MB1801;H:CY1PR0701MB2012.namprd07.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: YSoAYsrJrefO00EifWqByLYt2QeNqQ3/fmcggfpfS5qB/Z1+SkurF581tAys1kFCtp2c/tItA+hZZL971D6Jhr7m6dTXtdQLJ4IHzrxwiun9kGkRUR2Jh8mJXelZ4yRSxOUvZCILzqLoz39xgy27i7+jJXNKZYhPY3RXqJD5jW0=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
X-OriginatorOrg: cavium.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a5fa344-b18c-4ff0-df10-08d57e843f47
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Feb 2018 08:21:20.3688
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR0701MB1801
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w1S8LXiB016193

> From: Hernán Gonzalez [mailto:hernan@vanguardiasur.com.ar]
> Sent: Wednesday, February 28, 2018 12:32 AM
> 
> Note: This is compile only tested as I have no access to the hw.
> Constifying and declaring as static saves 24 bytes.
> 
> add/remove: 0/1 grow/shrink: 0/0 up/down: 0/-24 (-24)
> Function                                     old     new   delta
> pkt_type_str                                  24       -     -24
> Total: Before=3599256, After=3599232, chg -0.00%
> 
> Signed-off-by: Hernán Gonzalez <hernan@vanguardiasur.com.ar>
> ---
>  drivers/net/ethernet/qlogic/qed/qed_iwarp.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/qlogic/qed/qed_iwarp.c
> b/drivers/net/ethernet/qlogic/qed/qed_iwarp.c
> index ca4a81d..03ad4ee 100644
> --- a/drivers/net/ethernet/qlogic/qed/qed_iwarp.c
> +++ b/drivers/net/ethernet/qlogic/qed/qed_iwarp.c
> @@ -1784,7 +1784,7 @@ enum qed_iwarp_mpa_pkt_type {
>  /* fpdu can be fragmented over maximum 3 bds: header, partial mpa,
> unaligned */  #define QED_IWARP_MAX_BDS_PER_FPDU 3
> 
> -char *pkt_type_str[] = {
> +static const char * const pkt_type_str[] = {
>  	"QED_IWARP_MPA_PKT_PACKED",
>  	"QED_IWARP_MPA_PKT_PARTIAL",
>  	"QED_IWARP_MPA_PKT_UNALIGNED"
> --
> 2.7.4

Thanks

Acked-by: Michal Kalderon <michal.kalderon@cavium.com>
