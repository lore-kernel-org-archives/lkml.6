Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965162AbeE3JDL (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 05:03:11 -0400
Received: from mail1.bemta12.messagelabs.com ([216.82.251.4]:45844 "EHLO
        mail1.bemta12.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S964790AbeE3JDF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 05:03:05 -0400
X-Brightmail-Tracker: H4sIAAAAAAAAA1WTf0wbZRjH+95dr8ePY+/KkMc6WNJo3HAwWZZ
  4xsTofxdjdBo12Vg2r9vRa9YWcldMdWaymapjA1mZGzCYdbLJ2iaQwgiKUGVQQbah1Cyy4bZu
  OJQhcSDMgHPe7crU/z7P832e9/t9k/dlSPN+k4URvR5RdgtOK51KSb8kiPyYlFH0+PRMAdfQE
  qa54z0Sd2TPsIl799MWmjsV6ie4QPQp7kDDXsSNXG82cfEvGmjucviukes80UNwN+dPktzRPV
  WIW/xTFW631xDPLOPbmvP4SHAfzUdm/CZ+oHaR4qONYRNf8+NniD/z+w8U3zVaTvNnA30mvm1
  oF3964WnedzuLn43kbmQ3Gx1uW4n3daN06+gcKg2neYff+4guR00pFSiVMeMJBN3tMaNexBBc
  O32O0AoKN5MQa51PKlUEfHc5RFegFLW4guB856sa03gNDE5dIDVegR+Glqoxk7ZA4q9o8N24Q
  WlCJt4Ii30+Sh96CaYGmtWDGJVfgIVZi4YUfgQmh3I1ZPEWuDvr1W2vEtB9rIPQNlPwBqjsqL
  1nhXAOHL525V6fxNnQeLjeqDFgDE1fDpM6Z8Gv1/9O9lfBh6FKSuccGPl4P9IMAFcbYSTkSy4
  Uwjenokl+n4ZYZXKoA8H8hTNJIQ8G2z6ntKQIvwzT7Vv19k64dMRHL4180FdP6JwLwcpE0jhC
  ws/dbm0V8Eqo6N9ajdbV/+cKOq+FQNcMrfNjcPKTm6TGLF4Og3XjVABRQbRaEeU3RDl/A1dgk
  x12yeMSHM78wsL1BS5RUQS76BRsSsH2ElcEqQ/zHYMBdaKZaFEvepAhrFnsi6kZReYMW8mONy
  VBkbbJZU5R6UUrGcYKrGxXteWyaBe9xQ6n+rqXZGDSrSvY6WJVZpVSwaU47Lr0Lcpnwu3+A6S
  Zcpe4RUs2S6ifwIy1IanMff+IpT8ygnIsmSwyGAzm9FJRdjk8/9cnUTaDrJnsLi1JusPtue80
  qYYg1BDjB9O0EB7hX8lSjvhL/u9H47Phc0+WBhPBiQFsM272V5yYi+89K2b/8dqmsTVpz9NP3
  HqrbtnBhrLemre3SM8db93hy2pbP95YvK1nom719qbW3w4duphYxdVOeX8a3e1qnHd9Xf7XHG
  tY6F/rv/Ps1fO5j4aGJh7omq47lghEX6ledzG+846y+6F9oU1jcSulSEJhHikrwj+/4r52HgQ
  AAA==
X-Env-Sender: yehs1@lenovo.com
X-Msg-Ref: server-11.tower-47.messagelabs.com!1527670977!45214483!1
X-Originating-IP: [104.232.225.2]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.9.15; banners=-,-,-
X-VirusChecked: Checked
From: Huaisheng HS1 Ye <yehs1@lenovo.com>
To: Michal Hocko <mhocko@kernel.org>
CC: "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "willy@infradead.org" <willy@infradead.org>,
        "vbabka@suse.cz" <vbabka@suse.cz>,
        "mgorman@techsingularity.net" <mgorman@techsingularity.net>,
        "kstewart@linuxfoundation.org" <kstewart@linuxfoundation.org>,
        "alexander.levin@verizon.com" <alexander.levin@verizon.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "colyli@suse.de" <colyli@suse.de>, NingTing Cheng <chengnt@lenovo.com>,
        Ocean HY1 He <hehy1@lenovo.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>
Subject: RE: [External]  Re: [RFC PATCH v2 00/12] get rid of
 GFP_ZONE_TABLE/BAD
Thread-Topic: [External]  Re: [RFC PATCH v2 00/12] get rid of
 GFP_ZONE_TABLE/BAD
Thread-Index: AQHT8fwDC41BG7Nw7kKYsFRFURgRZqQ9b40ggAFfPYCAAVqTEIAFBLuAgALTGQA=
Date: Wed, 30 May 2018 09:02:13 +0000
Message-ID: <HK2PR03MB1684C44F2408F3927B1A21BC926C0@HK2PR03MB1684.apcprd03.prod.outlook.com>
References: <1526916033-4877-1-git-send-email-yehs2007@gmail.com>
 <20180522183728.GB20441@dhcp22.suse.cz>
 <HK2PR03MB16847646E90A10E2D48CEA8E926B0@HK2PR03MB1684.apcprd03.prod.outlook.com>
 <20180524121853.GG20441@dhcp22.suse.cz>
 <HK2PR03MB1684ED6EC6859A88A196DC0C92690@HK2PR03MB1684.apcprd03.prod.outlook.com>
 <20180528133733.GF27180@dhcp22.suse.cz>
In-Reply-To: <20180528133733.GF27180@dhcp22.suse.cz>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [57.197.58.2]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;HK2PR03MB1380;7:etNb/MuoEho/1xdIvK+Tk/KFuGazp8u7S9JY+GIWYDHJFWFnbGIc9e+pVWML+tBcgGnDReMlv6Hid8akG9VHsVENiMbZ6+wlNQR0jk8jIHGKCasoxKaRnir0txfBB2mFY6iy6OAmFsEF4DNuk6wNZ0Tn67Wq0XBU3D6Q242auOXcuVQOKEw5wXRLb+mVPN0yIuFYnirQQrWswEXFDXPrkfJF3orDNMmCLz8dAw5Sm+g+yxcquN+AJ1uiHNxYL3X+;20:m1ydhHQn6rlYjRWF5t2Y6li99UhW8bR26YQMWNsm+os+B3mu/H1qKpRCMx8mJKowZVtWJcq9WSLnlHNJxjwKKoaY1f3/XQ3/o6nlfplWAdpM8WYlEhn0EeEVfcmdBRHbCIDxxS6cJ9RdszoJLRCyM7O6UEmty7BRW+z5bMtjQSH9URgrkDiZZlAo9zsOjbnFJL/XooK6mhEdkOZwGgI4xzIEnxhXfZtAarGKs2EyzW+42htWv71SIDby9r0jT88XsBY7FqRkgKO3TgguTOhvw2x7E2iuHuNS0ZNe72aTek4PekW/uF0iV9PSuzhRLckcK4AwTLyWHMeqzaZ30y1ZdQ==
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10019020)(39380400002)(396003)(39850400004)(366004)(346002)(376002)(54534003)(199004)(189003)(6116002)(7736002)(14454004)(3846002)(305945005)(6436002)(55016002)(186003)(3280700002)(9686003)(6506007)(316002)(99286004)(54906003)(2900100001)(2906002)(53936002)(76176011)(86362001)(5250100002)(7696005)(93886005)(106356001)(229853002)(6916009)(74316002)(81156014)(81166006)(66066001)(478600001)(7416002)(486006)(5660300001)(4326008)(105586002)(446003)(8936002)(476003)(102836004)(3660700001)(6246003)(11346002)(26005)(97736004)(25786009)(33656002)(68736007)(8676002)(26583001)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:HK2PR03MB1380;H:HK2PR03MB1684.apcprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:3;MX:3;
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:HK2PR03MB1380;
x-ms-traffictypediagnostic: HK2PR03MB1380:
x-microsoft-antispam-prvs: <HK2PR03MB1380F3C82D9479A772C9FC60926C0@HK2PR03MB1380.apcprd03.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(10201501046)(3231254)(944501410)(52105095)(93006095)(93001095)(3002001)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(20161123562045)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:HK2PR03MB1380;BCL:0;PCL:0;RULEID:;SRVR:HK2PR03MB1380;
x-forefront-prvs: 0688BF9B46
x-microsoft-antispam-message-info: 5wf94NWUwyrdjv1ByRWw+SCPEL5skkuyDuybdDgFrDU8pTrG9AkavJajdBUCco0XXQZqaCuc422qIzHm/ifmMQTtJgN0rS/ZKgsvBzdHDaxgNP/+9R6j6IYLiZzTuDhJNGH7PLOIx7joFJkaC8ONUFaIBLXHrqAWRnNCpvl3OVChmCL/WKO7aXQJDX3Yxd3Y
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 800f9205-e3fb-4059-6837-08d5c60c092a
X-MS-Exchange-CrossTenant-Network-Message-Id: 800f9205-e3fb-4059-6837-08d5c60c092a
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 May 2018 09:02:13.6522
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5c7d0b28-bdf8-410c-aa93-4df372b16203
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK2PR03MB1380
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w4U93lEh003315

From: owner-linux-mm@kvack.org [mailto:owner-linux-mm@kvack.org] On Behalf Of Michal Hocko
Sent: Monday, May 28, 2018 9:38 PM
> > In my opinion, originally there shouldn't be such many wrong
> > combinations of these bottom 3 bits. For any user, whether or
> > driver and fs, they should make a decision that which zone is they
> > preferred. Matthew's idea is great, because with it the user must
> > offer an unambiguous flag to gfp zone bits.
> 
> Well, I would argue that those shouldn't really care about any zones at
> all. All they should carea bout is whether they really need a low mem
> zone (aka directly accessible to the kernel), highmem or they are the
> allocation is generally movable. Mixing zones into the picture just
> makes the whole thing more complicated and error prone.

Dear Michal,

I don't quite understand that. I think those, mostly drivers, need to
get the correct zone they want. ZONE_DMA32 is an example, if drivers can be
satisfied with a low mem zone, why they mark the gfp flags as
'GFP_KERNEL|__GFP_DMA32'?
GFP_KERNEL is enough to make sure a directly accessible low mem, but it is
obvious that they want to get a DMA accessible zone below 4G.

> This should be a part of the changelog. Please note that you should
> provide some number if you claim performance benefits. The complexity
> will always be subjective.

Sure, I will post them to changelog with next version of patches.

Sincerely,
Huaisheng Ye
