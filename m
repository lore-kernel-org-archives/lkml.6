Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752234AbeEPIdj (ORCPT <rfc822;w@1wt.eu>);
        Wed, 16 May 2018 04:33:39 -0400
Received: from mail1.bemta12.messagelabs.com ([216.82.251.3]:9324 "EHLO
        mail1.bemta12.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750775AbeEPIdf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 May 2018 04:33:35 -0400
X-Brightmail-Tracker: H4sIAAAAAAAAA1WTb1AUZRzH79l9bm8xTpdD4hcI1TVOAsPZYdP
  s5EwjvdpxsskoZ4K07mzlbro/zO6hML5QE5rJOwhQuDguOS0NCGWOIxWHCMFSTMIBrjKm8BQc
  TgH/8KLGK2r39rR6993f5/v97XefeZYmdUc0GTRf4eIFh8mmp5Zhy2yEyP91Llb83Acn1rP+r
  k6KPdpvYb37RjWst/EKYu9HryH2y+5N7MiDMGbHz/op9rfOv9Xs/vpJDXvmWD/BTtVuYKuHej
  HbUrWgZlv21SI29oef2sBwQ3N3SK73RAfBhdpyuc/6ogTXfb9Bw138JIY5d8sS5u7N/IK5O/1
  hiuvqCWPucuC8hgt9v5v76sFLXPXvadxid/ZrK4rVVofZWfGu2nLQc1lTFsyp+Pju2r1obs0B
  tIzWMdMIFoON5AGUJD0MITgYflYGmGkjoaEmhBRQS8BsQKskphBU3x7DMqCYHBie+zGeXsnkQ
  b3/HCmbSKZXDcHzVzUySGWK4OjFGaSY3oCaq8cpRRfAoZGThKwxsxr+6gnGl2qZt2FiMJKo5K
  FgIOSSdRKzGcaHg2pZIyYLmq5PxbMkkw6fNvnic2AY+LxvlFR0GkRvLCXmegh5P8KKzoKxVje
  SiwJTp4YrF04nAka40P4NqYBWCrpaWhOuUwj+rL+ZiOdCNForaVqq8Tos9GxTxu9DVfMioeiN
  MOmeQIrOho6aCFb2tJNwb6SRUsAqqD/pxXXI4PvPV/iktaR0rF1n1yrjp+GQO6LxxQ8mBYabp
  3EA4Q60RuSFnbyQ//wLBrNgLbW47CarLd9oLDDYeVE0lfI2k1k0bHfau5F0UfeoVOgMCh8pGU
  RP0IQ+Tet1x4p1y83O9yotJtHyjlBu48VBtIqm9aCtuy2xFIEv5St2WG3SbX+IgU7Wr9QGZKw
  Vy0x20VqqoEtoHd3Z0+Ah6enxJg+pww6ng89I1x6WrYxstZQ7Hi16+OeMoayMVC1SqVS65DJe
  sFtd/+e3UDqN9Kna0/KWZKvD9eh9t6QqhFQFDcSruEz/ooy9aNf89TxuMqdA2Hoz72Xr0Kbqo
  u2+a+0leEtb5fJnPswc2fMtFlYk7S/cduPF3fOr6Syn3xtZf6xkl/ncq74fXhl4PJJ0l5t5K7
  1P/eTEKSZseOynS8d5f6ywMpOdLyo/XGZM8ewc/S6QqbFubZ79OnPJ4Vvgt2Rv/uLnpwo3tu9
  Y92aVHosWkzGXFETTP+3glOQ0BAAA
X-Env-Sender: yehs1@lenovo.com
X-Msg-Ref: server-4.tower-143.messagelabs.com!1526459610!54165700!1
X-Originating-IP: [104.232.225.2]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.9.15; banners=-,-,-
X-VirusChecked: Checked
From: Huaisheng HS1 Ye <yehs1@lenovo.com>
To: Dan Williams <dan.j.williams@intel.com>
CC: Matthew Wilcox <willy@infradead.org>, Jeff Moyer <jmoyer@redhat.com>,
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
Subject: RE: [External] Re: [RFC PATCH v1 0/6] use mm to manage NVDIMM (pmem)
 zone
Thread-Topic: [External] Re: [RFC PATCH v1 0/6] use mm to manage NVDIMM (pmem)
 zone
Thread-Index: AQHT7MCGTe3a9jmbpUOrQm87KIOeqaQyAwMQ
Date: Wed, 16 May 2018 08:33:13 +0000
Message-ID: <HK2PR03MB1684733BFC9773814A6E522C92920@HK2PR03MB1684.apcprd03.prod.outlook.com>
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
 <HK2PR03MB1684F8D2724BB8AF1FCCF02A92920@HK2PR03MB1684.apcprd03.prod.outlook.com>
 <CAPcyv4hFzzF-jZd3-3vLNbB6SHD1Z5+wuRqgiuubnztAEzsSJQ@mail.gmail.com>
In-Reply-To: <CAPcyv4hFzzF-jZd3-3vLNbB6SHD1Z5+wuRqgiuubnztAEzsSJQ@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [111.201.10.230]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;HK2PR03MB1572;7:Xf5Lt7XcONG5AIs0mueDGUWx/z9btS1X3GhrYOILutSflIgp5NV140gav4Ywxb8LGiLG/yBw+0MLLDq0oBQP81L3O+h77EPxMawrLxuM8ZkxOQLpcYCOAmf7Wo8HKdODcVWqFovjsdG5lDwIsxWzvuBhvO+6I0h//KqlofeHtfMonaA/SWS/J2UVPBFeZBLJSaXLc0/qOD4VAPdwH4DHSD051XnkgEjtqXT+93GFo5UPHOcWhQI9612yExIME4Zc;20:mWCzj56Qok18L6wIJAWKXvWYUSXao4eFEJF6xIdqnItQmn5ETldkq2gJqs7HS1pYp5ZEI55ubHAPftPQ4FX0tvpWSv/jeCj4+J4WakQmNpXYLC/z5Cf8kBwKDxO8Ck5uC5fVNLwzgnJSeOs4R2b83VWx9y3x5YYJWumtW/zqnVyev0sKD0ZZqkb8nAHpB48YHE2EbY36ZIqdBPBGg3K86tSHs6Wr4SlpFUVg1ibcm0Ko2QyxiI/FGRRzLpn+hAsYAlP56olT40z7uZ/4xBlfsUF23zaAXDTJb9M0tV3Qcqt83KdE3KDEiB3n9I4z/cvJ3aMsp+3wnzhbsEEdfpgbHg==
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10019020)(366004)(396003)(346002)(39850400004)(376002)(39380400002)(199004)(189003)(26005)(107886003)(102836004)(53936002)(106356001)(59450400001)(6246003)(3280700002)(7696005)(76176011)(7416002)(97736004)(99286004)(33656002)(8936002)(105586002)(53546011)(6436002)(6506007)(186003)(55016002)(8676002)(4326008)(86362001)(9686003)(305945005)(81166006)(3660700001)(14454004)(68736007)(81156014)(229853002)(5660300001)(2900100001)(66066001)(6916009)(476003)(11346002)(74316002)(5250100002)(25786009)(93886005)(486006)(446003)(316002)(478600001)(3846002)(6116002)(7736002)(2906002)(54906003)(13296004)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:HK2PR03MB1572;H:HK2PR03MB1684.apcprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:HK2PR03MB1572;
x-ms-traffictypediagnostic: HK2PR03MB1572:
x-microsoft-antispam-prvs: <HK2PR03MB15723BDF10AA6E5F51D1E9B992920@HK2PR03MB1572.apcprd03.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(3940261145250)(228905959029699);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3231254)(944501410)(52105095)(10201501046)(3002001)(93006095)(93001095)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123558120)(20161123564045)(6072148)(201708071742011);SRVR:HK2PR03MB1572;BCL:0;PCL:0;RULEID:;SRVR:HK2PR03MB1572;
x-forefront-prvs: 0674DC6DD3
x-microsoft-antispam-message-info: skFQWoD94LmFsoQI+EB71RKSi5gJdZy6C5eo4FiAh0w7Lp6h82gapWL6jF2TWcc8nhgPIz29xhZpLEexM8ukmFVrQm7+3t3jJ2jWUHDm871T1d0ANunKrDnN8nMhvbpNpyOLwcYmlAFOpoaDgUyKLUt9p1UgbHB/mtCgg+m6nMryuvMCFXdKFURAH1AdXIH3
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: ab2033f1-9d46-4dea-1942-08d5bb07aa84
X-MS-Exchange-CrossTenant-Network-Message-Id: ab2033f1-9d46-4dea-1942-08d5bb07aa84
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 May 2018 08:33:13.9460
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5c7d0b28-bdf8-410c-aa93-4df372b16203
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK2PR03MB1572
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w4G8XkR2017873

> From: Dan Williams [mailto:dan.j.williams@intel.com]
> Sent: Wednesday, May 16, 2018 10:49 AM
> On Tue, May 15, 2018 at 7:05 PM, Huaisheng HS1 Ye <yehs1@lenovo.com> wrote:
> >> From: Matthew Wilcox [mailto:willy@infradead.org]
> >> Sent: Wednesday, May 16, 2018 12:20 AM>
> >> > > > > Then there's the problem of reconnecting the page cache (which is
> >> > > > > pointed to by ephemeral data structures like inodes and dentries) to
> >> > > > > the new inodes.
> >> > > > Yes, it is not easy.
> >> > >
> >> > > Right ... and until we have that ability, there's no point in this patch.
> >> > We are focusing to realize this ability.
> >>
> >> But is it the right approach?  So far we have (I think) two parallel
> >> activities.  The first is for local storage, using DAX to store files
> >> directly on the pmem.  The second is a physical block cache for network
> >> filesystems (both NAS and SAN).  You seem to be wanting to supplant the
> >> second effort, but I think it's much harder to reconnect the logical cache
> >> (ie the page cache) than it is the physical cache (ie the block cache).
> >
> > Dear Matthew,
> >
> > Thanks for correcting my idea with cache line.
> > But I have questions about that, assuming NVDIMM works with pmem mode, even we
> > used it as physical block cache, like dm-cache, there is potential risk with
> > this cache line issue, because NVDIMMs are bytes-address storage, right?
> 
> No, there is no risk if the cache is designed properly. The pmem
> driver will not report that the I/O is complete until the entire
> payload of the data write has made it to persistent memory. The cache
> driver will not report that the write succeeded until the pmem driver
> completes the I/O. There is no risk to losing power while the pmem
> driver is operating because the cache will recover to it's last
> acknowledged stable state, i.e. it will roll back / undo the
> incomplete write.
> 
> > If system crash happens, that means CPU doesn't have opportunity to flush all dirty
> > data from cache lines to NVDIMM, during copying data pointed by bio_vec.bv_page to
> > NVDIMM.
> > I know there is btt which is used to guarantee sector atomic with block mode,
> > but for pmem mode that will likely cause mix of new and old data in one page
> > of NVDIMM.
> > Correct me if anything wrong.
> 
> dm-cache is performing similar metadata management as the btt driver
> to ensure safe forward progress of the cache state relative to power
> loss or system-crash.

Dear Dan,

Thanks for your introduction, I've learned a lot from your comments.
I suppose that there should be implementations to protect data and metadata both in NVDIMMs from system-crash or power loss.
Not only data but also metadata itself needs to be correct and integrated, so kernel could have chance to recover data to target device after rebooting, right?

> 
> > Another question, if we used NVDIMMs as physical block cache for network filesystems,
> > Does industry have existing implementation to bypass Page Cache similarly like DAX way,
> > that is to say, directly storing data to NVDIMMs from userspace, rather than copying
> > data from kernel space memory to NVDIMMs.
> 
> Any caching solution with associated metadata requires coordination
> with the kernel, so it is not possible for the kernel to stay
> completely out of the way. Especially when we're talking about a cache
> in front of the network there is not much room for DAX to offer
> improved performance because we need the kernel to takeover on all
> write-persist operations to update cache metadata.

Agree.

> So, I'm still struggling to see why dm-cache is not a suitable
> solution for this case. It seems suitable if it is updated to allow
> direct dma-access to the pmem cache pages from the backing device
> storage / networking driver.

Sincerely,
Huaisheng Ye
