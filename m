Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752208AbeEPCFg (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 22:05:36 -0400
Received: from mail1.bemta12.messagelabs.com ([216.82.251.8]:15761 "EHLO
        mail1.bemta12.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751309AbeEPCFe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 22:05:34 -0400
X-Brightmail-Tracker: H4sIAAAAAAAAA1WTe0xbVRzHe+49vb1gO+9KG37DQWLjY+ssjpm
  QGzUL/5jcLBqNjy1hunk7r73d+iD3FmVxRhhONkCg6OjWwixuLhuwhwUHcwwdw8hrmaKgzsSO
  PWCMxyK4oTRDe3th6n+f8/v+vr/zPSfn0KQxpEujhQKfIHl4l4VKxuKNYcI27o/lrt59PIOtP
  dFEsZ92iGyg6KKODez9DrHTY5cR2xh5jr0wN4jZH76spdjfmv7WssX+X3Vs22cdBButyGF3nT
  +N2dD7U1o2VFSB2NiftVQOw52fuEVyp481EFzzESt3sH2M4CLT1Tque18Mc2Whecz9fv0S5m5
  1DFLciZZBzPWHu3Rcc9873Bdza7lds2ZuJpLxwv25WqfH7i14XStGgo047/qSgqFwlCpEd+8r
  Rcm0kRlF8PndgK4UJcUX3yDovb1DETBzhIRwySWkdlUSMDM8qVMXUQRd0f6EhWJWQs/EEFmKa
  NrErICJljVKD8m0ayGw85pWqacwL0P5VU5pNzGvwNn+SaTyVpg7c4BSGDMPQ93Jr0mFDcyrcH
  K8jlD3+gPDZPPhhJDEPA0j5/5KmBGTDjVXooTCJJMKdTVBrcLAMHCo/SKpshnGrs4nMiDmRZh
  q2aSWLdAc2INVToeBT8qQylVaONhtUTkLvj361cKYvRQUt65X8gBzCsGdiakFsxViZVFK5W1Q
  XlSLFuu7u4KEyhnQ8OEwVs1HSTgw2rZgWA7+4wFchR4P/ucMKj8G4TPTlMqr4HD9OBlMXMxS6
  Nl/DYcRbkArZEF6S5BsT2Rn2iWnQ/S5eafLlpW1JtMtyDLvEFy8Xc7c4nVHUPyhvqfRoDZ0oX
  5jJ1pGExazIVAWyzUusXvf2C7ysrhZyncJcidaTtMWMNiq4tpSSXAIBW86XfHXvigDrbeYDNO
  Vcdkg5/Fu2elQpV5ko5taqstJI/Z4PUJaqsGrzGCUJjHfc2/E4p8ZQOlpKQak0WiM+jxBcjt9
  /9dvolQaWVIMjyhT9E6P795ON+MhiHgIqXdWCeHj/5XSCpG1Zn/FtivWD3z5k0b3Wp/tI+0OU
  +tG874HHuy8Udm9YeBsyrPPh0qK376Ts3n+8vzHgds77abV2R3JMX3fM+uds0OPjrzmX5lbdU
  6/jtv00M+t1Vu2r+t7ypwt/lg3RpUuK5mRnKfMUc+ekQ2FJauSerZ+f4x4Msn/02hj/bsvGR2
  HfsEWLIt8lpWUZP4faAVQdy4EAAA=
X-Env-Sender: yehs1@lenovo.com
X-Msg-Ref: server-10.tower-138.messagelabs.com!1526436327!92973887!1
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
        Vlastimil Babka <vbabka@suse.cz>, "Ocean HY1 He" <hehy1@lenovo.com>
Subject: RE: [External]  Re: [RFC PATCH v1 0/6] use mm to manage NVDIMM (pmem)
 zone
Thread-Topic: [External]  Re: [RFC PATCH v1 0/6] use mm to manage NVDIMM
 (pmem) zone
Thread-Index: AQHT5jPWfBz2tzl9Xk+fNx5ZDx4cXqQknf8AgAADSZKAAIHYsIAABJCAgAGpooCAAlnpAIAHx6xwgAAR2YCAAJGJ4A==
Date: Wed, 16 May 2018 02:05:05 +0000
Message-ID: <HK2PR03MB1684F8D2724BB8AF1FCCF02A92920@HK2PR03MB1684.apcprd03.prod.outlook.com>
References: <1525704627-30114-1-git-send-email-yehs1@lenovo.com>
 <20180507184622.GB12361@bombadil.infradead.org>
 <CAPcyv4hBJN3npXwg3Ur32JSWtKvBUZh7F8W+Exx3BB-uKWwPag@mail.gmail.com>
 <x49a7tbi8r3.fsf@segfault.boston.devel.redhat.com>
 <HK2PR03MB1684659175EB0A11E75E9B61929A0@HK2PR03MB1684.apcprd03.prod.outlook.com>
 <20180508030959.GB16338@bombadil.infradead.org>
 <HK2PR03MB16841CBB549F40F86BB8D35C92990@HK2PR03MB1684.apcprd03.prod.outlook.com>
 <20180510162742.GA30442@bombadil.infradead.org>
 <HK2PR03MB1684B34F9D1DF18A8CDE18F292930@HK2PR03MB1684.apcprd03.prod.outlook.com>
 <20180515162003.GA26489@bombadil.infradead.org>
In-Reply-To: <20180515162003.GA26489@bombadil.infradead.org>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [111.201.10.230]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;HK2PR03MB0866;7:hvqJP3By/tqEMqb8YpWAn655mUFoAYFfQrKQzH6uRJEZN22LtblSXmzc/6UiYjBhzGRTcdy7s1Jlz8yaMVftXap2o421R0T34wAvGDPQSQwmjxdrsMoGEfvCQJKrGi41CinSGxuj95WW7Ff+ULwH4p4gm6LZd7YPvHuX3iDD1tB6NXrLJCZTwK9Rto9Rs0kT8gA17f5SkD7LcWa4kE4rX7JB+82GrQ+/n4aFTfmZtzWrbwV2tos91HxM66xkmuVE;20:W52/Mm8yXxqNeYcp10+5pzHHEyrJshlUYdRzuYBmzUa3HFyE1g2Yk2hS5CWlJ36l76sU+oAPdfRZSY+9jZQRalzghOzkdsdCwb0zmW9Q5J35NMniF+BAfnV6t4e8YoIrCDzIE6u8bOitb/NuutrBYmh64QafXeVzhARAhmRifGg9E/nPXEZy/k4zOteFKJrJRU6I5PH5Hr/wyn+YhP465S1PH6ZN/aeGfevpM7NEAjK9NEjhoweuWNVkBbLYYTIOOyHDxNGTx952ZSXcTbQ4l42+7VJ82tYpVvIowfO7zoSzrWgnFmqVyx6nzw9OBZsrl4rYJHysDHoSq+uM9+ueNg==
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10019020)(39850400004)(39380400002)(376002)(346002)(366004)(396003)(199004)(189003)(5660300001)(476003)(8936002)(486006)(2906002)(305945005)(7736002)(25786009)(68736007)(97736004)(8676002)(81156014)(81166006)(106356001)(3280700002)(446003)(11346002)(105586002)(2900100001)(3660700001)(229853002)(66066001)(74316002)(6436002)(7416002)(55016002)(76176011)(6116002)(14454004)(6916009)(478600001)(3846002)(33656002)(86362001)(99286004)(9686003)(107886003)(93886005)(186003)(4326008)(26005)(59450400001)(102836004)(6506007)(53936002)(5250100002)(316002)(54906003)(7696005)(6246003)(13296004)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:HK2PR03MB0866;H:HK2PR03MB1684.apcprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:HK2PR03MB0866;
x-ms-traffictypediagnostic: HK2PR03MB0866:
x-microsoft-antispam-prvs: <HK2PR03MB0866DA9AC258246E45EB151792920@HK2PR03MB0866.apcprd03.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3231254)(944501410)(52105095)(93006095)(93001095)(3002001)(10201501046)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:HK2PR03MB0866;BCL:0;PCL:0;RULEID:;SRVR:HK2PR03MB0866;
x-forefront-prvs: 0674DC6DD3
x-microsoft-antispam-message-info: gxFZaYjfXhzylv8gKdPMChKZrx7xNWVZt3F5CAjc9sNKNClMlEFBUqtMeu7GVPrrjZGowXuhLjcTTs6gRzJO1oOTqYDi2WJdRfxBH5SSxVGuZd2bk6/5I2VEPUhAzV3GePumUawKO1EJOAZiUXoE34ftoouQtk7RuNh3E5OBa8AolsV7m8qQnpCbEhjgma6n
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 7780a728-fb8b-4622-ccbc-08d5bad171ac
X-MS-Exchange-CrossTenant-Network-Message-Id: 7780a728-fb8b-4622-ccbc-08d5bad171ac
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 May 2018 02:05:05.8999
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5c7d0b28-bdf8-410c-aa93-4df372b16203
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK2PR03MB0866
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w4G25gQZ011262

> From: Matthew Wilcox [mailto:willy@infradead.org]
> Sent: Wednesday, May 16, 2018 12:20 AM> 
> > > > > Then there's the problem of reconnecting the page cache (which is
> > > > > pointed to by ephemeral data structures like inodes and dentries) to
> > > > > the new inodes.
> > > > Yes, it is not easy.
> > >
> > > Right ... and until we have that ability, there's no point in this patch.
> > We are focusing to realize this ability.
> 
> But is it the right approach?  So far we have (I think) two parallel
> activities.  The first is for local storage, using DAX to store files
> directly on the pmem.  The second is a physical block cache for network
> filesystems (both NAS and SAN).  You seem to be wanting to supplant the
> second effort, but I think it's much harder to reconnect the logical cache
> (ie the page cache) than it is the physical cache (ie the block cache).

Dear Matthew,

Thanks for correcting my idea with cache line.
But I have questions about that, assuming NVDIMM works with pmem mode, even we
used it as physical block cache, like dm-cache, there is potential risk with
this cache line issue, because NVDIMMs are bytes-address storage, right?
If system crash happens, that means CPU doesn't have opportunity to flush all dirty
data from cache lines to NVDIMM, during copying data pointed by bio_vec.bv_page to
NVDIMM. 
I know there is btt which is used to guarantee sector atomic with block mode,
but for pmem mode that will likely cause mix of new and old data in one page
of NVDIMM.
Correct me if anything wrong.

Another question, if we used NVDIMMs as physical block cache for network filesystems,
Does industry have existing implementation to bypass Page Cache similarly like DAX way,
that is to say, directly storing data to NVDIMMs from userspace, rather than copying
data from kernel space memory to NVDIMMs.

BRs,
Huaisheng
