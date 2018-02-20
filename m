Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751497AbeBTVBR (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Feb 2018 16:01:17 -0500
Received: from mail-eopbgr30088.outbound.protection.outlook.com ([40.107.3.88]:57888
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750799AbeBTVBP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Feb 2018 16:01:15 -0500
From: York Sun <york.sun@nxp.com>
To: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
CC: Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Alexander Stein <alexander.stein@systec-electronic.com>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] EDAC, layerscape: allow building for LS1021A
Thread-Topic: [PATCH] EDAC, layerscape: allow building for LS1021A
Thread-Index: AQHTqlzMp+s6+nVFsUO1f+4zS65Fo6OtxyaN
Date: Tue, 20 Feb 2018 21:01:11 +0000
Message-ID: <BCC182D6-3CC0-40F1-B17A-0E410A20ACC4@nxp.com>
References: <20180220150912.2954-1-rasmus.villemoes@prevas.dk>
In-Reply-To: <20180220150912.2954-1-rasmus.villemoes@prevas.dk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=york.sun@nxp.com;
x-originating-ip: [61.186.37.198]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR04MB3117;7:j8a4R7tycSAsgVCDHo71O87qrTv0gXU88pbqGaus0FLsjFrf4w74y+yESDlh4NGIv6/ChlcJ2YAs2hBs6BHsOajSPzpSuf97kgrt+1RCK+uw9m+HVYGWGyzVujvanB3iue+Mj0f7UJWDzIxF+3ESxy+UL9Yqx7CbAAqL3SZ8OCiviU7nqM0LEfdqZmBA8oDQSJQ7HDKpqW0YGTv6SIIgs4Xn1xY5tuHK4BSytovI0Gm5vXjluuQqybJo7tJt9mRB
x-ms-exchange-antispam-srfa-diagnostics: SSOS;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: aff41666-f785-43b7-f889-08d578a512ac
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(3008032)(2017052603307)(7153060)(7193020);SRVR:VI1PR04MB3117;
x-ms-traffictypediagnostic: VI1PR04MB3117:
x-microsoft-antispam-prvs: <VI1PR04MB311701001A186B950DBA99859ACF0@VI1PR04MB3117.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(189930954265078)(45079756050767);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001059)(6040501)(2401047)(5005006)(8121501046)(3002001)(3231101)(944501161)(93006095)(93001095)(10201501046)(6055026)(6041288)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(6072148)(201708071742011);SRVR:VI1PR04MB3117;BCL:0;PCL:0;RULEID:;SRVR:VI1PR04MB3117;
x-forefront-prvs: 05891FB07F
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(39380400002)(39860400002)(346002)(396003)(376002)(199004)(189003)(2900100001)(36756003)(2950100002)(6916009)(478600001)(25786009)(966005)(82746002)(8936002)(81156014)(106356001)(316002)(2906002)(6486002)(54906003)(3280700002)(4326008)(6436002)(81166006)(8676002)(97736004)(53936002)(33656002)(5660300001)(3660700001)(66066001)(5003630100001)(6246003)(7736002)(86362001)(6306002)(45080400002)(68736007)(83716003)(305945005)(105586002)(26005)(76176011)(6116002)(102836004)(14454004)(3846002)(5250100002)(6506007)(59450400001)(229853002)(186003)(6512007)(53546011)(99286004);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB3117;H:VI1PR04MB2078.eurprd04.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: Ph9BZrsyPyDRiWXcpdGRpivLcV3Til+361rD+R1Ybk07EKaMNasCMG4zVw1y0fT/LhBGsfF4w2qBDfZfLa04IgsTKVUo69ZOt3qEDPcMjdJjHhJih2DmJ0cwXnqNGoPt0Ar/1CPdXNf2sp0u3j9lF6zilRr5FrmmoV48JZcFSjY=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aff41666-f785-43b7-f889-08d578a512ac
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Feb 2018 21:01:11.9649
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB3117
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w1KL1Lwe013162

Sorry for top posting. I am on vacation and replying from my phone.

The controller is compatible and the driver should work. Please double check to make sure you can inject errors and receive interrupt. After that you are good to go.

York

Sent from my iPhone

> On Feb 20, 2018, at 23:09, Rasmus Villemoes <rasmus.villemoes@prevas.dk> wrote:
> 
> The LS1021A has a memory controller supported by this driver. It builds
> just fine, and I've done some rudimentary testing using the error
> injection facility, which suggests that it is indeed working.
> 
> Signed-off-by: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
> ---
> Hi York
> 
> In https://emea01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fpatchwork.kernel.org%2Fpatch%2F9264623%2F&data=02%7C01%7Cyork.sun%40nxp.com%7C08fea717f1ca406b5db608d57873ed51%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C636547361667697520&sdata=j%2Ff9myWudDTi38NQCBVv5yX5h%2F2TqcO10yTvcg%2FPWVM%3D&reserved=0, you wrote that LS1021A
> support is "just one step away". I'm wondering if this is simply that
> step, or there is a little more to it. As I write, it seems to work
> just fine, but I may be missing something.
> 
> drivers/edac/Kconfig | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/edac/Kconfig b/drivers/edac/Kconfig
> index 96afb2aeed18..23f619afe31d 100644
> --- a/drivers/edac/Kconfig
> +++ b/drivers/edac/Kconfig
> @@ -254,7 +254,7 @@ config EDAC_MPC85XX
> 
> config EDAC_LAYERSCAPE
>    tristate "Freescale Layerscape DDR"
> -    depends on ARCH_LAYERSCAPE
> +    depends on ARCH_LAYERSCAPE || SOC_LS1021A
>    help
>      Support for error detection and correction on Freescale memory
>      controllers on Layerscape SoCs.
> -- 
> 2.15.1
> 
