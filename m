Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755724AbeDXMLw (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 08:11:52 -0400
Received: from relmlor3.renesas.com ([210.160.252.173]:30366 "EHLO
        relmlie2.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752350AbeDXMLv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 08:11:51 -0400
X-IronPort-AV: E=Sophos;i="5.49,322,1520866800";
   d="scan'208";a="277733237"
From: Ramesh Shanmugasundaram <ramesh.shanmugasundaram@bp.renesas.com>
To: Masanari Iida <standby24x7@gmail.com>,
        "mchehab@kernel.org" <mchehab@kernel.org>,
        "trivial@kernel.org" <trivial@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] [trivial] media:platform: Fix a typo in Kconfig
Thread-Topic: [PATCH] [trivial] media:platform: Fix a typo in Kconfig
Thread-Index: AQHT28IqIx8bYJBHDUafgqBCPZBjhqQP0q7Q
Date: Tue, 24 Apr 2018 12:11:46 +0000
Message-ID: <TY2PR01MB19622A699FEB2A4E94699D53C3880@TY2PR01MB1962.jpnprd01.prod.outlook.com>
References: <20180424114813.19015-1-standby24x7@gmail.com>
In-Reply-To: <20180424114813.19015-1-standby24x7@gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=ramesh.shanmugasundaram@bp.renesas.com;
x-originating-ip: [193.141.220.21]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;TY2PR01MB1899;7:hWszkeem41bgPsseGN9Xc6f4dm5bf7SF8P4OQLW4UdGpCYl5x4mSgiKJJU2XoDfpATINEtoF5qi3mcQWDycaUK3GzH7Fgsm67j+MU43dskvMMadQLmJ+bluzEMBNL0js657olUrQqPPSndEHJ654sT0dhwVcOazl4ajAkFGh5uaeJbYSo7f6OKUPPQ9evxNZ+4k1TseUCxrlHJ6/eKLW+YO3xxDweNNLEQJ2eYboXvqQ9RUUtpVQbJmnPP/L3fs6;20:V0V7ADU/ie7m8KexoTScnqHvli1lbUtX4lkVbtZp7ZhotClIZ/QuA9L5vpxwZ83/G8FUCN0Ia328+a+D+SKy5BIiDbpys8JU4+RxXZNkpyOv/6dpLXq+wyWvs2QwvaASkRl6g3Nrxcul14lfiTY2XgEMwXCaNiuLR1v4hC+Q9b0=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:TY2PR01MB1899;
x-ms-traffictypediagnostic: TY2PR01MB1899:
x-microsoft-antispam-prvs: <TY2PR01MB1899E0427F23E7E5D8344014C3880@TY2PR01MB1899.jpnprd01.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(85827821059158);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(93006095)(93001095)(3231232)(944501410)(52105095)(3002001)(6055026)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:TY2PR01MB1899;BCL:0;PCL:0;RULEID:;SRVR:TY2PR01MB1899;
x-forefront-prvs: 0652EA5565
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(396003)(376002)(346002)(39380400002)(366004)(189003)(199004)(13464003)(9686003)(2900100001)(76176011)(55016002)(186003)(110136005)(5660300001)(66066001)(345774005)(3846002)(44832011)(26005)(476003)(11346002)(14454004)(53936002)(74316002)(316002)(7696005)(305945005)(102836004)(53546011)(6506007)(59450400001)(486006)(7736002)(446003)(6116002)(97736004)(478600001)(575784001)(6246003)(2201001)(81166006)(68736007)(8936002)(81156014)(86362001)(105586002)(6436002)(106356001)(25786009)(2906002)(33656002)(3660700001)(99286004)(2501003)(39060400002)(8676002)(229853002)(5250100002)(3280700002);DIR:OUT;SFP:1102;SCL:1;SRVR:TY2PR01MB1899;H:TY2PR01MB1962.jpnprd01.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:0;
x-microsoft-antispam-message-info: 6pzrINbAbYAfskUO9+l/RYBmvy15pub/m/eSauege8JDFJvim/STTJVw1nsZiPBZcSPzR0U12U2odqElttadNiiC+2np6thQ+fe+AXHMIsAqg4KaRDkORk2rS0mm7+mHJp+ogfPXSpgYKQeJq5N3iBUargx0xgiwKBVIk96ufbvZqL8fxPL16KIx++6c+qqt
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="Windows-1252"
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 89b7b674-c8df-48f7-1f74-08d5a9dc8cf3
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 89b7b674-c8df-48f7-1f74-08d5a9dc8cf3
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Apr 2018 12:11:46.4029
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PR01MB1899
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w3OCBxgL031585

Hello Masanari,

Thank you for fixing the typo.

> -----Original Message-----
> From: Masanari Iida [mailto:standby24x7@gmail.com]
> Sent: Tuesday, April 24, 2018 12:48 PM
> To: mchehab@kernel.org; trivial@kernel.org; linux-kernel@vger.kernel.org;
> Ramesh Shanmugasundaram <ramesh.shanmugasundaram@bp.renesas.com>
> Cc: Masanari Iida <standby24x7@gmail.com>
> Subject: [PATCH] [trivial] media:platform: Fix a typo in Kconfig
> 
> This patch fix a spelling typo found in media/platform/Kconfig
> 
> Signed-off-by: Masanari Iida <standby24x7@gmail.com>

Acked-by: Ramesh Shanmugasundaram <ramesh.shanmugasundaram@bp.renesas.com>

Thanks,
Ramesh

> ---
>  drivers/media/platform/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/media/platform/Kconfig
> b/drivers/media/platform/Kconfig
> index c7a1cf8a1b01..0a031bbb0f31 100644
> --- a/drivers/media/platform/Kconfig
> +++ b/drivers/media/platform/Kconfig
> @@ -624,7 +624,7 @@ menuconfig SDR_PLATFORM_DRIVERS
>  if SDR_PLATFORM_DRIVERS
> 
>  config VIDEO_RCAR_DRIF
> -	tristate "Renesas Digitial Radio Interface (DRIF)"
> +	tristate "Renesas Digital Radio Interface (DRIF)"
>  	depends on VIDEO_V4L2 && HAS_DMA
>  	depends on ARCH_RENESAS || COMPILE_TEST
>  	select VIDEOBUF2_VMALLOC
> --
> 2.17.0.140.g0b0cc9f86731
