Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933833AbeEJDxy (ORCPT <rfc822;w@1wt.eu>);
        Wed, 9 May 2018 23:53:54 -0400
Received: from mail1.bemta12.messagelabs.com ([216.82.251.11]:34903 "EHLO
        mail1.bemta12.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1756118AbeEJDxw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 May 2018 23:53:52 -0400
X-Brightmail-Tracker: H4sIAAAAAAAAA1WTbUxbVRjHe3rObS+ESy5lyEOFmjTbMtlAWcx
  yDZvOD5qb6ZaFGGOYcVzGXVttC+ktBmPM2jAS3WAFTLbxYmQEcLQs01IV9tJthWXjRYmIZuFF
  3RhOYQNGE1DJwHt7Yeq33/P8/8/LOTmHxoZKvZEWy9yiyynYzbp4YjFNb8vaF4nmP7tUznKN5
  zt0XHPYyp3yDum5QHAv98OFRh33c8cqxZXXjOm5rtawlptZbMNcRU834RqOzlLcg/FTMnlPIG
  75z0bd7kS+5/4c5rvP+bV859lMPuj/WMcHF2r1/M3Ty4Q/3rBC+IdTo4QfbOrV850DH/Bf/f0
  CX7GUwkeDpv1MPmVzFhaXFVDWB4shXDKZUNZz/XPiQZH4YyieNrD3EFw+epaowXUEvtNDSAkI
  W4mh7TvvmlKtBd/KQ6wGEwiC4VZZiaN17NPQd/8nrPAGdiOcPzGuV0yYjVIwEvoWKUIya4GKg
  UG9arLChUflROV9MD3colWYsJvg+6pgLM+wb0FgohOp0xYx3A7PxIQ49jkY++IqpTBiM+DknV
  9ixZhNhU9P1sfywLLQcmkIq5wCf0yuyHla9ufBbOhtNf0U+AJVROUMGP7seGwWsNUUNEXvrtX
  mwI32K1gVVijw1TRSavA1gqUxj1Z1ZcLMrXNI5XdhfihE1vMf9daveUzgr7pN1OJ2DIFbozpl
  JWDT4feBJ6rRM/X/OYTK26Dp4oJO5a3QdmYG18duJgn66u6SJkT8aIskut4TXVnbd2QXumwWq
  9sh2OxZOTnbsx2iJAkW0S4UStmHih1BJL/MIxoN6kJ+754ISqO15hSmbmQh35BYWFz0vlWQrA
  ddpXZRiqB0mjYD8+a1aL4hySVaxLLDNrv8vNdloBPMG5j2q7LMSCWCQ7JZVKkfZdEdodpKbCD
  OYqdoTGWKlB6sYrKWOh+3WP8kwyjDmMwgjUZjSCgRXQ6b+//6NEqlkTmZyVW6JNic7seTpuUl
  tPISSb/OKUu4hX8lowftLvhyp7F2c9z8pgP3ru0N/didsjB8aLThr9dX8ybfeKX35f3HpnKbu
  3y7bn6DPymq2XMkHY8c7J4KmBJDrX0H0kxSv/6ld+iN457mrb8xs6bVcWHZPRHOfXXL5iuPLr
  bE3wlr+nvrdhTw1JO7Khue/zBvpwWlzQ16I82elhcr8kpfmzcTySrkZGKXJPwD1GB+lB8EAAA
  =
X-Env-Sender: yehs1@lenovo.com
X-Msg-Ref: server-16.tower-143.messagelabs.com!1525924422!53579639!1
X-Originating-IP: [103.30.234.44]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.9.15; banners=-,-,-
X-VirusChecked: Checked
From: Huaisheng HS1 Ye <yehs1@lenovo.com>
To: Michal Hocko <mhocko@kernel.org>
CC: Randy Dunlap <rdunlap@infradead.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "willy@infradead.org" <willy@infradead.org>,
        "vbabka@suse.cz" <vbabka@suse.cz>,
        "mgorman@techsingularity.net" <mgorman@techsingularity.net>,
        "pasha.tatashin@oracle.com" <pasha.tatashin@oracle.com>,
        "alexander.levin@verizon.com" <alexander.levin@verizon.com>,
        "hannes@cmpxchg.org" <hannes@cmpxchg.org>,
        "penguin-kernel@I-love.SAKURA.ne.jp"
        <penguin-kernel@I-love.SAKURA.ne.jp>,
        "colyli@suse.de" <colyli@suse.de>, NingTing Cheng <chengnt@lenovo.com>,
        "Ocean HY1 He" <hehy1@lenovo.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>
Subject: RE: [External] [RFC PATCH v1 3/6] mm, zone_type: create ZONE_NVM and
 fill into GFP_ZONE_TABLE
Thread-Topic: [External] [RFC PATCH v1 3/6] mm, zone_type: create ZONE_NVM and
 fill into GFP_ZONE_TABLE
Thread-Index: AQHT5oc89K0fVKx8vE2XYGyeMTEHcaQmvz4wgACKowCAABddoIAAggOAgABx1uA=
Date: Thu, 10 May 2018 03:53:34 +0000
Message-ID: <HK2PR03MB16847C0C5F1D9DB6FCF09F9692980@HK2PR03MB1684.apcprd03.prod.outlook.com>
References: <1525746628-114136-1-git-send-email-yehs1@lenovo.com>
 <1525746628-114136-4-git-send-email-yehs1@lenovo.com>
 <HK2PR03MB1684653383FFEDAE9B41A548929A0@HK2PR03MB1684.apcprd03.prod.outlook.com>
 <ce3a6f37-3b13-0c35-6895-35156c7a290c@infradead.org>
 <HK2PR03MB16847B78265A033C7310DDCB92990@HK2PR03MB1684.apcprd03.prod.outlook.com>
 <20180509114712.GP32366@dhcp22.suse.cz>
 <HK2PR03MB168425F6D00C30918169C77C92990@HK2PR03MB1684.apcprd03.prod.outlook.com>
 <20180509205609.GV32366@dhcp22.suse.cz>
In-Reply-To: <20180509205609.GV32366@dhcp22.suse.cz>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [57.197.58.2]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;HK2PR03MB0835;7:rggjJ8zRqfAkd4egCPrkV3FD1vRA0n2VSb7d36SaiUzRnDmzFP086ZPER3cEkZKu15dK3yq/I6gfvhJiS6LT5TtA9IrIfE0dW08+1dwXT0+oIl1nbhVVfbdOfl5G+KjxYDRZzjWjvu0sHzC3Zour0cIq5lNMW4mJokX8BZnaRiC2D8ZcqCgJHJMy8s8Oc28hTTZDjFfDgopJTOLOOryVGYYLBzm3SHmD1gBoR+2B1HHbSKLyVqQ2kgFAVKgzcad6;20:tSdrNLz6S39L9lYZM3ifw7k29mADSIIpeGL7Kf8GYB09xbdV1SAN1Clg0f2L3Fa/ci+sL90tctJQFB4THMRZfZMWzBF5BVvwm+E0NSHs8OGHS+pb6SLrOV8DQgMO7wP9oHcsH7trqoFseuim68rP3SBAZP3UabQDqxiiIGzQHz1CJ2+wTTh9rk1J7EwMXIfDdny93PA1IZAONl5e6AEQ44vm/Ny8mAEbDrVu52CE7liuE3IhAFizdrYtKItIgfnyEtpEFN/V3hGK1FG0QSjFyYLkaMb+UQCQ16b//8n77pgcPYA7RU7rlq67OfWtBjl5DSo++tgNZCIA1P/vK/xang==
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10019020)(366004)(376002)(346002)(396003)(39850400004)(39380400002)(377424004)(199004)(189003)(8936002)(478600001)(186003)(6116002)(11346002)(3846002)(66066001)(6916009)(446003)(81156014)(14454004)(476003)(81166006)(486006)(26005)(97736004)(229853002)(102836004)(4326008)(305945005)(8676002)(6506007)(6436002)(7736002)(93886005)(5250100002)(6246003)(7696005)(68736007)(2906002)(99286004)(316002)(2900100001)(9686003)(5660300001)(54906003)(53936002)(55016002)(25786009)(3280700002)(105586002)(33656002)(86362001)(106356001)(74316002)(76176011)(3660700001)(7416002)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:HK2PR03MB0835;H:HK2PR03MB1684.apcprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:HK2PR03MB0835;
x-ms-traffictypediagnostic: HK2PR03MB0835:
x-microsoft-antispam-prvs: <HK2PR03MB0835C20E0CD2BF0B1DCFCF0B92980@HK2PR03MB0835.apcprd03.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3231254)(944501410)(52105095)(3002001)(93006095)(93001095)(10201501046)(149027)(150027)(6041310)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:HK2PR03MB0835;BCL:0;PCL:0;RULEID:;SRVR:HK2PR03MB0835;
x-forefront-prvs: 066898046A
x-microsoft-antispam-message-info: uP7f7ouj7bgqlzy690h1j9pYmgrHVLwFOBU3ljordjfVS0RGDtQLSCFURvNqlxv4s16NIVcbxetEj09zmIMIZQju1f6dnld5AJUXXqAfkXfvMC5D5ywXJlM7VIYMs44rjzVomYGSPAql83OAKh5/25ShKNwwiB7WR3Y1TpWFskVKGg0TnsqPfpCjynJB2z/o
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 7d66ac66-3740-4281-3c5a-08d5b6299a8e
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d66ac66-3740-4281-3c5a-08d5b6299a8e
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 May 2018 03:53:34.3748
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5c7d0b28-bdf8-410c-aa93-4df372b16203
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK2PR03MB0835
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w4A3s2fi031754

> 
> On Wed 09-05-18 14:04:21, Huaisheng HS1 Ye wrote:
> > > From: owner-linux-mm@kvack.org [mailto:owner-linux-mm@kvack.org] On Behalf Of
> Michal Hocko
> > >
> > > On Wed 09-05-18 04:22:10, Huaisheng HS1 Ye wrote:
> [...]
> > > > Current mm treats all memory regions equally, it divides zones just by size,
> like
> > > 16M for DMA, 4G for DMA32, and others above for Normal.
> > > > The spanned range of all zones couldn't be overlapped.
> > >
> > > No, this is not correct. Zones can overlap.
> >
> > Hi Michal,
> >
> > Thanks for pointing it out.
> > But function zone_sizes_init decides
> > arch_zone_lowest/highest_possible_pfn's size by max_low_pfn, then
> > free_area_init_nodes/node are responsible for calculating the spanned
> > size of zones from memblock memory regions.  So, ZONE_DMA and
> > ZONE_DMA32 and ZONE_NORMAL have separate address scope. How can they
> > be overlapped with each other?
> 
> Sorry, I could have been a bit more specific. DMA, DMA32 and Normal
> zones are exclusive. They are mapped to a specific physical range of
> memory so they cannot overlap. I was referring to a general property
> that zones might interleave. Especially zone Normal, Movable and Device.

Exactly, here ZONE_NVM is a real physical range same as ZONE_DMA, ZONE_DMA32 and ZONE_Normal. So, it couldn't overlap with other zones.
Just like you mentioned, ZONE_MOVABLE is virtual zone, which comes ZONE_Normal.
The way of virtual zone is another implementation compared with current patch for ZONE_NVM.
It has advantages but also disadvantages, which need to be clarified and discussed.

Sincerely,
Huaisheng Ye
