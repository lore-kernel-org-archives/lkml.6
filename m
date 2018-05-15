Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753903AbeEOQIA (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 12:08:00 -0400
Received: from mail1.bemta8.messagelabs.com ([216.82.243.207]:40486 "EHLO
        mail1.bemta8.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753545AbeEOQH5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 12:07:57 -0400
X-Brightmail-Tracker: H4sIAAAAAAAAA1WTf0xTVxTHe997fX06ipcC6xkR/ihZImxlgn/
  sJe6Hf2zZ/cfMLNuyNIta2FtfY3+wvrrULZnKZDMIhCk/S4dsqCnYQSx1FkFMwM2JOJwD3SCD
  FdgUxaIsU1IE19eHbvvvc8733HO+9+Zcjtb5NBmc4HELLofZZmBXM+KNCGUcUy+a1nfVA+/rC
  LD8170iX7d3SMPX1VxG/PzM74g/HtzMX4qNMPzPp30sPx54qOY//WJMw4eP9lL8ROUmvrS/i+
  Eb90XVfOPeSsQvLvjYTZj0z87RpOubNop0+nNJS88MRYLzBzXkh/pFhhxoXGbI3T9GGTLXO8K
  SjtAIQwabz2lI58WPycnYS6T0fjr5K5i1ZY1JbXUUOj3b1eLI2ElNcdWTnos/tlN70OWUMrSa
  0+HrCKqXuhkl+A7BeGsoETDYT0PT9WtIUSop+PNqVF2GVsWDCQR3lvQyszgHLsxepcsQx6Xhd
  TAbKpDradyjhrqSabWcT8VvQvkUkcvT8FtwZvA2UtgE7dOnGZkZ/DQcma/QyKzF78KplvKVuX
  dpWOhfomRhFX4B+sIttMwIZ0Lt5EQiT2M9fFnrTXgDjOFIzxCtcDrMTC0nPCD8BkRDW5V0NvQ
  P1yGFM+HK4QOJWYCr1DA3VL3SJx/Ot56lFeEwC4fqfSvBtwiiwUlG7go4FzofrFEO7IC/p6Ia
  hXNh/zkvpXAWtFVEGOVsKw3eyGesIqyFfQN3UBV6zvufSyj8LDR3z7MKPwPHvrpFexMvkwIXG
  qaZZsS0oXWS4PpQcBkLNuQVuqwW0W03W23G/PV8nl2QJLNFsJkLpbwipz2I4pu6W6VCYVTf/V
  ofeoqjDOnajQ9iJl1yofO9XaJZEre5dtoEqQ+t5TgDaHXxjdaluASL4Hnfaouv+yMZuCRDmla
  QZa1UbLZLVosiDSAjFwgdLKd1jMPpEDL02hflIiwXiTsdj1s8+jRXUGZGqhapVCpdUrHgslvd
  /9dvIj2HDKnad5h4lySrw/140s24CSpuwjVwXzbhNv8rZexBjdbmUb8tXPtRyUPQ5+T8EoyJ+
  /3pNcEnKrKPGpzJBbeslvFhKBqM3j5xiiyk3IjwSQvnTZtfcbz+29acjRXJO36qyb43GmmIff
  5ruKG924FKUrdPvr1hS3GTv3T4Hnm1yfPyodYTxo4zu6v11AeaY2nXdn1/KSsgFD1/dvmTSH7
  AwEiiOT+XdknmfwBMmwK1LwQAAA==
X-Env-Sender: yehs1@lenovo.com
X-Msg-Ref: server-3.tower-128.messagelabs.com!1526400475!69576315!1
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
Thread-Index: AQHT5jPWfBz2tzl9Xk+fNx5ZDx4cXqQknf8AgAADSZKAAIHYsIAABJCAgAGpooCAAlnpAIAHx6xw
Date: Tue, 15 May 2018 16:07:28 +0000
Message-ID: <HK2PR03MB1684B34F9D1DF18A8CDE18F292930@HK2PR03MB1684.apcprd03.prod.outlook.com>
References: <1525704627-30114-1-git-send-email-yehs1@lenovo.com>
 <20180507184622.GB12361@bombadil.infradead.org>
 <CAPcyv4hBJN3npXwg3Ur32JSWtKvBUZh7F8W+Exx3BB-uKWwPag@mail.gmail.com>
 <x49a7tbi8r3.fsf@segfault.boston.devel.redhat.com>
 <HK2PR03MB1684659175EB0A11E75E9B61929A0@HK2PR03MB1684.apcprd03.prod.outlook.com>
 <20180508030959.GB16338@bombadil.infradead.org>
 <HK2PR03MB16841CBB549F40F86BB8D35C92990@HK2PR03MB1684.apcprd03.prod.outlook.com>
 <20180510162742.GA30442@bombadil.infradead.org>
In-Reply-To: <20180510162742.GA30442@bombadil.infradead.org>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [123.112.142.186]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;HK2PR03MB1729;7:9kdps3I+QZ+EJQrKR61Jehgyj6lA+jJR7MIJ0l/8dDspd+Ilg3JmrO7Ym6d63cJYcJTs5R9wp8VvpZtYG1ySA/euF0xd5sclXLpk1Zs02UE4fuEYljPb6SefczV4EFP9ouajAdERsEh66JEnqr66qoxf6B1VE5oUI03dIlrhGm63ocFWB6j+Kpo4SmDln/yB3fZIwv+E/tRdOxVL5JcQbEioRc2zHstmHk2cPzbxTodJmih3MrBOzocloT1LrJMU;20:sApgTHLsPEB7ig7BRmNahQGIQ+ozEHP4HpFQaNshf7S0zvGWJ47HkdZxOGjJSYv07vIU1mA9UK7or/cP7695Mbh54Fu6Nk+QdcGhhZzZ8Ak3roX1mNB3bAe++B4AkgrRIvgwOy/zMoBroC6fVOQ45Ll5ZLOwRM/62gtzvgdJ6D1qAfvANJJh7dDNRWVKVCOoIAnJ4hh3mb14Ix5jclXr7E/waa9jjZbDg082z1yfZAMQS6hn/Jlkjx+rDOa5ZzmnodLa2pyu2ED9bIBjpV18iaoYcvm5SL6Hr4voi/1LMPp5jWVDjitYvy+hnkoQ5cxrDX+mst26cBGgQFR9PdrIjw==
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10019020)(39380400002)(396003)(39850400004)(366004)(376002)(346002)(189003)(199004)(68736007)(53936002)(55016002)(59450400001)(9686003)(2906002)(8676002)(102836004)(7696005)(81156014)(7416002)(97736004)(3280700002)(3660700001)(81166006)(8936002)(5250100002)(76176011)(5660300001)(6506007)(229853002)(11346002)(93886005)(446003)(486006)(2900100001)(4326008)(6916009)(476003)(66066001)(316002)(105586002)(106356001)(107886003)(561944003)(54906003)(478600001)(33656002)(86362001)(6116002)(26005)(3846002)(6436002)(25786009)(6246003)(14454004)(74316002)(7736002)(99286004)(186003)(305945005)(9126004)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:HK2PR03MB1729;H:HK2PR03MB1684.apcprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:HK2PR03MB1729;
x-ms-traffictypediagnostic: HK2PR03MB1729:
x-microsoft-antispam-prvs: <HK2PR03MB172921FCDEAEA2EF6D751FE792930@HK2PR03MB1729.apcprd03.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(93006095)(93001095)(3231254)(944501410)(52105095)(149027)(150027)(6041310)(20161123560045)(20161123558120)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:HK2PR03MB1729;BCL:0;PCL:0;RULEID:;SRVR:HK2PR03MB1729;
x-forefront-prvs: 0673F5BE31
x-microsoft-antispam-message-info: 6PdGJSV8CH5ePS3begjfJ/m4bVyJ+VX2TLSRjDqKKNkDri3caL9Rdp61h4ySM33pzwPrhyAi6nfFt7PRhRMjcgPMpVqTI3jYoY8N2GKo+jPWXNIGezPWc7+3K1UGhUJMMJnt8NlWcdcpxhbeqm5aai0e8dzLpOEcMsBKvPeOgX/Br8D2GG8erfLk9can4c2J
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 99346adf-9d87-448e-2615-08d5ba7df4ed
X-MS-Exchange-CrossTenant-Network-Message-Id: 99346adf-9d87-448e-2615-08d5ba7df4ed
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 May 2018 16:07:28.4091
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5c7d0b28-bdf8-410c-aa93-4df372b16203
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK2PR03MB1729
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w4FG8MSi000525




> From: owner-linux-mm@kvack.org [mailto:owner-linux-mm@kvack.org] On Behalf Of Matthew
> Wilcox
> Sent: Friday, May 11, 2018 12:28 AM
> On Wed, May 09, 2018 at 04:47:54AM +0000, Huaisheng HS1 Ye wrote:
> > > On Tue, May 08, 2018 at 02:59:40AM +0000, Huaisheng HS1 Ye wrote:
> > > > Currently in our mind, an ideal use scenario is that, we put all page caches to
> > > > zone_nvm, without any doubt, page cache is an efficient and common cache
> > > > implement, but it has a disadvantage that all dirty data within it would has risk
> > > > to be missed by power failure or system crash. If we put all page caches to NVDIMMs,
> > > > all dirty data will be safe.
> > >
> > > That's a common misconception.  Some dirty data will still be in the
> > > CPU caches.  Are you planning on building servers which have enough
> > > capacitance to allow the CPU to flush all dirty data from LLC to NV-DIMM?
> > >
> > Sorry for not being clear.
> > For CPU caches if there is a power failure, NVDIMM has ADR to guarantee an interrupt
> will be reported to CPU, an interrupt response function should be responsible to flush
> all dirty data to NVDIMM.
> > If there is a system crush, perhaps CPU couldn't have chance to execute this response.
> >
> > It is hard to make sure everything is safe, what we can do is just to save the dirty
> data which is already stored to Pagecache, but not in CPU cache.
> > Is this an improvement than current?
> 
> No.  In the current situation, the user knows that either the entire
> page was written back from the pagecache or none of it was (at least
> with a journalling filesystem).  With your proposal, we may have pages
> splintered along cacheline boundaries, with a mix of old and new data.
> This is completely unacceptable to most customers.

Dear Matthew,

Thanks for your great help, I really didn't consider this case.
I want to make it a little bit clearer to me. So, correct me if anything wrong.

Is that to say this mix of old and new data in one page, which only has chance to happen when CPU failed to flush all dirty data from LLC to NVDIMM?
But if an interrupt can be reported to CPU, and CPU successfully flush all dirty data from cache lines to NVDIMM within interrupt response function, this mix of old and new data can be avoided.

Current X86_64 uses N-way set associative cache, and every cache line has 64 bytes.
For 4096 bytes page, one page shall be splintered to 64 (4096/64) lines. Is it right?


> > > Then there's the problem of reconnecting the page cache (which is
> > > pointed to by ephemeral data structures like inodes and dentries) to
> > > the new inodes.
> > Yes, it is not easy.
> 
> Right ... and until we have that ability, there's no point in this patch.
We are focusing to realize this ability.

Sincerely,
Huaisheng Ye
