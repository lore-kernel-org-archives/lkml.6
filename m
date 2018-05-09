Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753234AbeEIEsS (ORCPT <rfc822;w@1wt.eu>);
        Wed, 9 May 2018 00:48:18 -0400
Received: from mail1.bemta12.messagelabs.com ([216.82.251.7]:37458 "EHLO
        mail1.bemta12.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753183AbeEIEsN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 May 2018 00:48:13 -0400
X-Brightmail-Tracker: H4sIAAAAAAAAA1VTf0wTZxj2u7venYYbH6WEd0Qg6/aHMmUry5L
  Lsi0uy5ZLcGZzGg1ZdK2ebbe2sF5xZb8CE41SZM5NpAUVRUxFDBvgD5hgAs6JVktwkGnJEMS4
  MialsumKwO44cNv99bzP89z3PPfmO5bUVjMprOh2iU6H0aanF1GW3waJ5Z7PoznPx74h+KqGe
  po/0m7h9xcFGX7/vm7ER8O3EH+i8S3+aqyX4q+3VtH8r/UzGn7b1yGGP1vbTvADZSv47Z0tFF
  9ZfE/DVxaVIX7yYRW9Agudo2Ok0HKyjhCa/BlCzbkwITRG9zLCpYpJSvBUTlPC+J2blDDW3ks
  LDc29lBCovsAITVc+FU7FXhW2P0gS7jemvR2fo7E6TLnu9zWWHWfYPA92X/T7iEIUiS9Bi1gt
  HkbgrfFQ6tCB4NhUhTwsZClcSkLg2ioFa3EZAT80paumfgR3H7YQikDjpdA12keWIJbV4SUw2
  pyleEjs1cD0zxFG4RPxGii9LSh2HV4LbYE/kIpXQcmffbSa9QxEdoUYBXP4PYjUTmjUrHsEnO
  +/MZu1EL8Mj6a+nC2HcCqUDw3M8iROhgPlPo2CAWM4ei5IqjgJwren5/h0+OrEbkrFqdBzyIO
  UAMB7NBD6fhtSBQP8dPw8qQq7aLizz8+ow2kEXVWTc64MuN/cTaj4Q5hp8xLz/M4LvjmcBnW7
  Byn15eMkHPjuGKMKiyFccYZW9qLFJjg5ad2DMn3/+QqfrJDyVhtan1Ppp+BbzyDjm91MAnR5h
  6lqRNWhJZLo3Co6lxsMmSan1Wxx2Y1WmzxlZdpFSTKaRZvRJGVuyrU3IvmeLpCfs+ia//UO9C
  RL6JO4lZHxHO0TptzNBRajZNnozLeJUgdazLJ64C59Fs3RJjhFs+jeYrXJl31eBjZOr+M4Rea
  kPKNdsppV6TJ6ga1v3ltKssPXy0tJLeXIdYgpyVytYsWK1ZLveHzQ/I/Tg1JTEjkkV9PG5YlO
  u9X1f30EJbNIn8j9opwSZ3W4HueNyFUIuUrCrTGlisv4r5RSiNKuHs56d1P5Ef8A8fRrGz4pL
  H6zZwd/+G72XzeXjUdHHnRf1vV9vHSKXxdYO6Ndj4tODW0J/r7OkH8luHnC5O155QspqT1+/b
  NvdDpCrVz4xfBRJnixL/bR1lA/tBmGLBOxmg9W73wUyc4uiH/pnYN/uwNrCnQ32sy1C4rHo+k
  /ruwY1lOSxWjIIJ2S8R9aYkEBMwQAAA==
X-Env-Sender: yehs1@lenovo.com
X-Msg-Ref: server-12.tower-143.messagelabs.com!1525841287!53517859!1
X-Originating-IP: [104.232.225.2]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.9.15; banners=-,-,-
X-VirusChecked: Checked
From: Huaisheng HS1 Ye <yehs1@lenovo.com>
To: Matthew Wilcox <willy@infradead.org>
CC: Jeff Moyer <jmoyer@redhat.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Michal Hocko <mhocko@suse.com>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        NingTing Cheng <chengnt@lenovo.com>,
        Dave Hansen <dave.hansen@intel.com>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        "pasha.tatashin@oracle.com" <pasha.tatashin@oracle.com>,
        Linux MM <linux-mm@kvack.org>, "colyli@suse.de" <colyli@suse.de>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Sasha Levin <alexander.levin@verizon.com>,
        "Mel Gorman" <mgorman@techsingularity.net>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: RE: [External]  Re: [RFC PATCH v1 0/6] use mm to manage NVDIMM (pmem)
 zone
Thread-Topic: [External]  Re: [RFC PATCH v1 0/6] use mm to manage NVDIMM
 (pmem) zone
Thread-Index: AQHT5jPWfBz2tzl9Xk+fNx5ZDx4cXqQknf8AgAADSZKAAIHYsIAABJCAgAGpooA=
Date: Wed, 9 May 2018 04:47:54 +0000
Message-ID: <HK2PR03MB16841CBB549F40F86BB8D35C92990@HK2PR03MB1684.apcprd03.prod.outlook.com>
References: <1525704627-30114-1-git-send-email-yehs1@lenovo.com>
 <20180507184622.GB12361@bombadil.infradead.org>
 <CAPcyv4hBJN3npXwg3Ur32JSWtKvBUZh7F8W+Exx3BB-uKWwPag@mail.gmail.com>
 <x49a7tbi8r3.fsf@segfault.boston.devel.redhat.com>
 <HK2PR03MB1684659175EB0A11E75E9B61929A0@HK2PR03MB1684.apcprd03.prod.outlook.com>
 <20180508030959.GB16338@bombadil.infradead.org>
In-Reply-To: <20180508030959.GB16338@bombadil.infradead.org>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [57.197.58.2]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;HK2PR03MB1683;7:2rLNuUUi0KACk1T5sG2mFjHjAtPYsWjqffdIWATuSQvPoZnwzgqGm3cgV+aNtLRYey0+mTeRHx1FHySxrsd5RU9UsKpJ243avOOcCfgmOmG2tSccIU8ElnkzIJa3/CATaqHH3/VeGj5Dn7QuNY9d8R+BTUqneubKHh5KBuZeSQua0jX/MyPDQ54DLW5GXtwl/rdk7WibDo0N+kZCexWvf173CUuN77g574GC+UFj7sUSVXzvKxmBycg9nLoOo+z7;20:o+DQPo1Q8rBlmGJcWV1TGemR5UDfnqOqpzEss5Dm18zwNzu/ZZ22/0hhIl1BQN3ZUkrf5s/irGOk1IQxCmQMtjvdHI9BplX+Ir7nAyHgvV7QYKYfaiiwuRAuGLT5NjE/vwBIlxksU6wDoKFA3fQMpSGUJytsPCmJoaCAOvV3kpw1o12ZsEwK9/pGZqAr2GYpd8ZTd9MuTL3zXgor8ajfjEnsmvJQw3VwKE9qhJsnw341bjKI+krxpZn55Vc5raMQpX1IuvfNfSrbyg6AJxZciJcgXIHtGLjJ4Gde1Dv4ChYwTDbxcNbGszIIcBJgtoRA17+l7Tc/8RVyKxC28bWYtw==
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10019020)(346002)(39380400002)(376002)(39850400004)(366004)(396003)(189003)(199004)(186003)(102836004)(26005)(59450400001)(5250100002)(25786009)(76176011)(99286004)(6346003)(14454004)(6506007)(86362001)(54906003)(5660300001)(2900100001)(33656002)(68736007)(8936002)(7696005)(74316002)(7736002)(305945005)(81156014)(81166006)(7416002)(6916009)(8676002)(476003)(6436002)(3280700002)(229853002)(53936002)(478600001)(3846002)(105586002)(316002)(93886005)(486006)(6246003)(6116002)(97736004)(9686003)(446003)(2906002)(3660700001)(55016002)(4326008)(66066001)(11346002)(106356001)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:HK2PR03MB1683;H:HK2PR03MB1684.apcprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:HK2PR03MB1683;
x-ms-traffictypediagnostic: HK2PR03MB1683:
x-microsoft-antispam-prvs: <HK2PR03MB1683BDC0DACAFB84213EBA0892990@HK2PR03MB1683.apcprd03.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(93006095)(93001095)(3231254)(944501410)(52105095)(149027)(150027)(6041310)(20161123558120)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(6072148)(201708071742011);SRVR:HK2PR03MB1683;BCL:0;PCL:0;RULEID:;SRVR:HK2PR03MB1683;
x-forefront-prvs: 0667289FF8
x-microsoft-antispam-message-info: xFdUpGL7Qo3dR1IxgZf2Yj+MhFpzK8XpPu5kMOJ6OZ/lw8dvAuuP5+FWNowzAsyTeL+/7DYzHNxSEEH9FlzQSb8GFklhsrEz7XqOV+yuVvHGwubdkiHOq1tcC3mFeY/xOIj5HOOLTbv9NjWvwLTHUDY1Vt1PWJc1ArDyOgfnVgtbvQNq9jNoWtQIf38aAsi3
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: e9af076c-9274-4d0a-0e59-08d5b568075e
X-MS-Exchange-CrossTenant-Network-Message-Id: e9af076c-9274-4d0a-0e59-08d5b568075e
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 May 2018 04:47:54.5952
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5c7d0b28-bdf8-410c-aa93-4df372b16203
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK2PR03MB1683
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w494mNSC010243


> 
> On Tue, May 08, 2018 at 02:59:40AM +0000, Huaisheng HS1 Ye wrote:
> > Currently in our mind, an ideal use scenario is that, we put all page caches to
> > zone_nvm, without any doubt, page cache is an efficient and common cache
> > implement, but it has a disadvantage that all dirty data within it would has risk
> > to be missed by power failure or system crash. If we put all page caches to NVDIMMs,
> > all dirty data will be safe.
> 
> That's a common misconception.  Some dirty data will still be in the
> CPU caches.  Are you planning on building servers which have enough
> capacitance to allow the CPU to flush all dirty data from LLC to NV-DIMM?
> 
Sorry for not being clear.
For CPU caches if there is a power failure, NVDIMM has ADR to guarantee an interrupt will be reported to CPU, an interrupt response function should be responsible to flush all dirty data to NVDIMM.
If there is a system crush, perhaps CPU couldn't have chance to execute this response.

It is hard to make sure everything is safe, what we can do is just to save the dirty data which is already stored to Pagecache, but not in CPU cache.
Is this an improvement than current?

> Then there's the problem of reconnecting the page cache (which is
> pointed to by ephemeral data structures like inodes and dentries) to
> the new inodes.
Yes, it is not easy.

> 
> And then you have to convince customers that what you're doing is safe
> enough for them to trust it ;-)
Sure. 😊

Sincerely,
Huaisheng Ye
