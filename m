Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752648AbeCEFT0 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Mar 2018 00:19:26 -0500
Received: from relmlor4.renesas.com ([210.160.252.174]:23420 "EHLO
        relmlie3.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751543AbeCEFTV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Mar 2018 00:19:21 -0500
X-IronPort-AV: E=Sophos;i="5.47,426,1515423600";
   d="scan'208";a="272850929"
From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To: Kishon Vijay Abraham I <kishon@ti.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org"
        <linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH 2/2] phy: rcar-gen3-usb3: Add binding for r8a77965
Thread-Topic: [PATCH 2/2] phy: rcar-gen3-usb3: Add binding for r8a77965
Thread-Index: AQHTr4/ZoUHnB3uTbkaigzWVwBywmaO8neKAgASF2cA=
Date: Mon, 5 Mar 2018 05:19:17 +0000
Message-ID: <TY1PR06MB0992BB23EF4B56F1D7719D2CD8DA0@TY1PR06MB0992.apcprd06.prod.outlook.com>
References: <1519710747-26435-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
 <1519710747-26435-3-git-send-email-yoshihiro.shimoda.uh@renesas.com>
 <6df55c1d-8855-7aff-af13-cf0f43cc5f8b@ti.com>
In-Reply-To: <6df55c1d-8855-7aff-af13-cf0f43cc5f8b@ti.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yoshihiro.shimoda.uh@renesas.com;
x-originating-ip: [211.11.155.139]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;TY1PR06MB0765;7:aPhmhFBM7kF41FeZiu3KJXH5AHZkwj3uCt+h+prxO1q+I3SM5dZZwUSnkhx6m8vnxAKTYtjRmJrv7poKznacbgf3SgNQ+xGYyQ6qOFMWQlJD0p9kcE/oKfzbtzknP6/51fRx6PUnYb6S9N0rkXKJjbkvNtqAtBNFX5h7lXGetDMDUm/vW9p6fZdWmGAlQE5Ipug/54DP4zj69MoWtvUpuk6lrlX//vzQSbxA8AjGNHnWxc5RhoM4t1bRTXFQP+8U;20:c8X9JorJLFGevjWkFmFrSgPZD5r287ceicHG8FSfBpk2Yk98wj1emI6OZnu+cPO7fe4hTuEG6Q/tVisKxFH21PzPC1jqGCfP4vkuHtoo2ZNtpRcbBurbOQEa0CfXEKIFFeTX2FRxFIVts0Nh+Op+d3WuZuJSY8/Speq8pYsreJA=
x-ms-exchange-antispam-srfa-diagnostics: SSOS;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: f7f5c1fe-fd54-49cb-e538-08d58258a4db
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603307)(7153060)(7193020);SRVR:TY1PR06MB0765;
x-ms-traffictypediagnostic: TY1PR06MB0765:
x-microsoft-antispam-prvs: <TY1PR06MB07651CC43DD127365AB4386AD8DA0@TY1PR06MB0765.apcprd06.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040501)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231220)(944501244)(52105095)(10201501046)(3002001)(6055026)(6041288)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:TY1PR06MB0765;BCL:0;PCL:0;RULEID:;SRVR:TY1PR06MB0765;
x-forefront-prvs: 06022AA85F
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(39860400002)(346002)(396003)(366004)(376002)(199004)(189003)(2906002)(2900100001)(9686003)(102836004)(2950100002)(26005)(5660300001)(305945005)(7736002)(77096007)(3846002)(6116002)(74316002)(229853002)(7696005)(66066001)(76176011)(99286004)(33656002)(2501003)(6506007)(14454004)(478600001)(3280700002)(105586002)(110136005)(54906003)(55016002)(6436002)(6246003)(53936002)(8936002)(81166006)(8676002)(81156014)(316002)(106356001)(186003)(68736007)(97736004)(86362001)(3660700001)(4326008)(25786009);DIR:OUT;SFP:1102;SCL:1;SRVR:TY1PR06MB0765;H:TY1PR06MB0992.apcprd06.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: yxxA2D1X5fPLP2s8MCjthbOBMd93UJQLuKerW8OlE+EhXENXpAPgw1i9RPkGtc2MtfqjqaR5y2XABZufnagLKq+/yVdntzqeQPLL1A4hO+xz0zuHcgDi6YMIZY0jCdKiOnbfyGovqcwWrligeyJNp1u18hGUyvvL83VzWjDn27vS40z3wbl8XZ9IczcMmi2AcsJbxMZxeU+juRYVP6dL9Xl7b/DCBvSHrkzoS4WpEJI20PI718/Cmqacn2VRCBLtacIB/ChQ4k9Siu75TVbfuK2JvgXPq555MM6icaXfJUL9gzIGItNYxE81tao0HUI5Va9kOLYd69ra1nstGXdByA==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7f5c1fe-fd54-49cb-e538-08d58258a4db
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Mar 2018 05:19:17.5838
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY1PR06MB0765
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w255JWTs010044

Hi,

> From: Kishon Vijay Abraham I, Sent: Friday, March 2, 2018 5:15 PM
> 
> On Tuesday 27 February 2018 11:22 AM, Yoshihiro Shimoda wrote:
> > This patch adds binding for r8a77965 (R-Car M3-N).
> 
> $subject should be  dt-bindings: rcar-gen3-phy-usb3: Add binding for r8a77965

I will revise this in v2.

Best regards,
Yoshihiro Shimoda

> Thanks
> Kishon
