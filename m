Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752027AbeCXM5d (ORCPT <rfc822;w@1wt.eu>);
        Sat, 24 Mar 2018 08:57:33 -0400
Received: from sessmg23.ericsson.net ([193.180.251.45]:58676 "EHLO
        sessmg23.ericsson.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751891AbeCXM5b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Mar 2018 08:57:31 -0400
X-AuditID: c1b4fb2d-4b1ff70000005540-bd-5ab64b397152
From: Jon Maloy <jon.maloy@ericsson.com>
To: kbuild test robot <fengguang.wu@intel.com>
CC: "kbuild-all@01.org" <kbuild-all@01.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        Ying Xue <ying.xue@windriver.com>,
        "tipc-discussion@lists.sourceforge.net"
        <tipc-discussion@lists.sourceforge.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [RFC PATCH net-next] tipc: tipc_disc_addr_trial_msg() can be
 static
Thread-Topic: [RFC PATCH net-next] tipc: tipc_disc_addr_trial_msg() can be
 static
Thread-Index: AQHTwuAAJ5RavaOC0E+4kQgFiPqvlKPfWTjw
Date: Sat, 24 Mar 2018 12:57:25 +0000
Message-ID: <BN6PR15MB1553A26B07E45C59B7BDC58D9AAF0@BN6PR15MB1553.namprd15.prod.outlook.com>
References: <201803240317.PGXU57zT%fengguang.wu@intel.com>
 <20180323194742.GA68339@athens>
In-Reply-To: <20180323194742.GA68339@athens>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jon.maloy@ericsson.com;
x-originating-ip: [24.225.233.31]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BN6PR15MB1329;7:NoCpYMXJsPfayfh6h1kvoBIBxpcR9fRzp857sUxIMLC3v/VESsECAR2H22ZTwCbUFq6oD8ZnJfDDSd5aR51T13aYErAkhEn90XLT1seNAdh1/p8OEcilqgKgqt/D2rGzIZB1Fg79nZF5O7GRqKopHmtNE2+hPKm5/YrcLK8BaM9m08nDp73A172Wl66LQSt4kp7IW+04EnorPJfJfa1R4l7xc2rdqMqr2+keDxpdHFvgtFimUOV2vzrIJNop9f48
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: c6481a1c-0e7e-46ce-19a0-08d59186cb35
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:BN6PR15MB1329;
x-ms-traffictypediagnostic: BN6PR15MB1329:
x-microsoft-antispam-prvs: <BN6PR15MB13292E687CC58E322A48501D9AAF0@BN6PR15MB1329.namprd15.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(37575265505322)(143289334528602)(9452136761055)(42262312472803)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501327)(52105095)(93006095)(93001095)(10201501046)(3002001)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(20161123562045)(6072148)(201708071742011);SRVR:BN6PR15MB1329;BCL:0;PCL:0;RULEID:;SRVR:BN6PR15MB1329;
x-forefront-prvs: 0621E7E436
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39380400002)(346002)(366004)(376002)(39860400002)(396003)(13464003)(189003)(199004)(2906002)(86362001)(55016002)(6916009)(6246003)(66066001)(53936002)(9686003)(4326008)(6116002)(25786009)(8676002)(68736007)(81156014)(3660700001)(575784001)(5660300001)(81166006)(2900100001)(3280700002)(305945005)(74316002)(7736002)(229853002)(3846002)(6436002)(8936002)(77096007)(316002)(6506007)(53546011)(54906003)(102836004)(186003)(106356001)(97736004)(7696005)(26005)(76176011)(11346002)(446003)(478600001)(33656002)(105586002)(14454004)(99286004)(217873001);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR15MB1329;H:BN6PR15MB1553.namprd15.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: T6uoK9Cwd2nDtc7Y087vw9oNjioBDrMVjSTxl/DcR2UiMR6jUccnz+GW5dMqyGLTm+IsAieFnS4ttIcPeJ79eYGsTR7MxrubkdYRPDdN27LoIQrvIQSPa/1EV1OyJQHsyzeOyg4k0W1j6hRz5xW0TACVSGIXqMRp7Xpt59NP7AyUNNJP9u+WY9+6cu1MCu+5BYCpe6qSimH4AtmxR6E0G9WEIKrk5qWhUyNhQFDd+AmaWBjowVkqr7Vp1GTkv53U3Bu33lXPpQtbBeFL19HBKopvYTKYDUPkS/2CUlXTH5O6PhRXAA2gx330s5xZ5SYh8SLdufnsnj7f0QfCjVM7jg==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: c6481a1c-0e7e-46ce-19a0-08d59186cb35
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Mar 2018 12:57:26.1401
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 92e84ceb-fbfd-47ab-be52-080c6b87953f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR15MB1329
X-OriginatorOrg: ericsson.com
X-Brightmail-Tracker: H4sIAAAAAAAAA02SbUhTYRTHee69m9fh6nG+HbSSRkKYrrQXh0immExDFBXKZdjSi2/zhV0T
        rS9CKaL7kJXVrNBlE7XCGFOXOskJlhYphQwtjXJhsnxBRRMrc/ca9O13zv//nPM/8NCkpFng
        S+cWljCaQpVaKhRRunPdB4LDz3Qpj7RVuMgXZztI+ZCtjpR/6HkglA81ectNo3nyGZuNPCVU
        fLa4KJr75ghFb9MKoVgx7lN0mDqJJIFSFJHFqHNLGc3hkxdFOT/Mv1Bxt7hM97YXVSCLqAa5
        0oCPQeXyJnKyBA8iGDfvqkGibTYhGKgzuPDFOoK25jmSLwwEdBm+cAqFlwlo3xjZUW4RMG80
        I74YQtDc00o6JwvxQZi7U81t8cQyaNVXcSYS6wjo0E0IahBNe+BkqG0JdKInTgH9TTVvD4XF
        6lmBkykcAKbf/dwYMU6HiflJgg+eDh9fOCgnu+IgWLdZubUIe8P6yFPOQ2IfmLQ3EvzRGB73
        jZI8e8HczB8uAcJp8OZbGt/eD6PPH+1Y9sL7xlouMWATAdNjdiEvBMNSfT3pfAs4AfTvknnP
        awSvFrYEvCcQ1haNO/58qJg0I56vQp32J3kDhTT8F4/nIGjqXRbyfAha9A6ygTvZHYZ1dqoJ
        Ue3Ii2VYtiA79KiM0eRmsmxRoayQKTGi7a8zYNoMNqMnjigrwjSSuokjo7uUEoGqlC0vsCKg
        SamnuMxtuyXOUpVfYTRFGZrLaoa1Ij+akvqIh+PESgnOVpUw+QxTzGj+qQTt6luB7sdM1Sa3
        3ctMsTwbvqZcPSuzhKWtLV2It3TMCyajq2Kn74ZbDava0jHP0fGZCL+vASeGIvURVOTDTCUR
        x+R6bET7a78nFinjvffYPw1eSpzKuF7l0IaXBG6lKrQiqSkxyr8zeeFlnyI74bwtLP94TNJp
        a57S/ba+sqs/NnX3uJRic1QhgaSGVf0FJFYWpjYDAAA=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w2OCvedP029992

Acked-by: Jon Maloy jon.maloy@ericsson.com

Thanks, Fengguang

> -----Original Message-----
> From: netdev-owner@vger.kernel.org [mailto:netdev-
> owner@vger.kernel.org] On Behalf Of kbuild test robot
> Sent: Friday, March 23, 2018 15:48
> To: Jon Maloy <jon.maloy@ericsson.com>
> Cc: kbuild-all@01.org; netdev@vger.kernel.org; Ying Xue
> <ying.xue@windriver.com>; tipc-discussion@lists.sourceforge.net; linux-
> kernel@vger.kernel.org
> Subject: [RFC PATCH net-next] tipc: tipc_disc_addr_trial_msg() can be static
> 
> 
> Fixes: 25b0b9c4e835 ("tipc: handle collisions of 32-bit node address hash
> values")
> Signed-off-by: Fengguang Wu <fengguang.wu@intel.com>
> ---
>  discover.c |   14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/net/tipc/discover.c b/net/tipc/discover.c index e765573..9f666e0
> 100644
> --- a/net/tipc/discover.c
> +++ b/net/tipc/discover.c
> @@ -134,13 +134,13 @@ static void disc_dupl_alert(struct tipc_bearer *b,
> u32 node_addr,
> 
>  /* tipc_disc_addr_trial(): - handle an address uniqueness trial from peer
>   */
> -bool tipc_disc_addr_trial_msg(struct tipc_discoverer *d,
> -			      struct tipc_media_addr *maddr,
> -			      struct tipc_bearer *b,
> -			      u32 dst, u32 src,
> -			      u32 sugg_addr,
> -			      u8 *peer_id,
> -			      int mtyp)
> +static bool tipc_disc_addr_trial_msg(struct tipc_discoverer *d,
> +				     struct tipc_media_addr *maddr,
> +				     struct tipc_bearer *b,
> +				     u32 dst, u32 src,
> +				     u32 sugg_addr,
> +				     u8 *peer_id,
> +				     int mtyp)
>  {
>  	struct net *net = d->net;
>  	struct tipc_net *tn = tipc_net(net);
