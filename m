Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756505AbeEIOEu (ORCPT <rfc822;w@1wt.eu>);
        Wed, 9 May 2018 10:04:50 -0400
Received: from mail1.bemta8.messagelabs.com ([216.82.243.198]:57816 "EHLO
        mail1.bemta8.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1756288AbeEIOEr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 May 2018 10:04:47 -0400
X-Brightmail-Tracker: H4sIAAAAAAAAA1WTfUwbdRjH+7u73h2Eq0eh8ogDXLOoQ6hj7I/
  zJWYxWXKJUZf9o2GLesDZVvuCvW5BjVoySDrosBADrLDXCBlY2CxsbtOVBGoYo8t0L84BbjDb
  zLExIkzXgYJ3PZj63+d5vt/n5Xd5jsb1fiqbFivdossh2IxkKmHOnSooXFyaLVn3bZDi2o4ES
  e5Q2MI1V52nuK9Cr3IXT7WR3LXgkpbb2TBGcSfawxh3+88OnKsZPElwrdV3tdz0eLNMVfWIW0
  i0kRt1/OCdGZw/2d2F8b2H8/lQ1y6SD802UvyZlgWCr2tdJPjf46MEHz0QofjekY/5Y/Mv8TX
  3DfxcKHczU6K1Okqdle9oLU2/dJAVPU9Udl+Zwz0okVeLUmk9exNB1B9BavA9guYxH6UEBOvD
  4UHLBKUquzH4rWMGV4NxBLH6H7FalEKT7FoYvvMTrnAmuwaO1I8nK3B2TguX+s4hRchgzVAzE
  qVUkwVO/b2TUPlluNZTI3toed4aOPfgBSXNsNsgfD+xPGwBg4g3nhyWwm6Aq9MxUmHE5kDTje
  vJPM5mwd6mgFZhYFn48rvzuMoGuPXrolbpj9gtcLfvrVpEyWkj/PWUasiBC/vrkq8H1q+F0YY
  /lrsUwVBnP64KXhICZ7yYGhxH0DjpWe6fD57mHlLl92Hicky7kvdGApjKudC1e5JQiztxuJH4
  YblgFdxq+Yb0o2cD/3mDyvmwz7OAqbwavqibpALJD5MOw3tixAFEdKGnJdG1Q3QVrn/OVOqym
  i1uu2C1FRat40x2UZIEs2gTSiVTmdMeQvJdfqbRoBMoEdk6gB6jMaOB2XNptkSvK3WWf2gRJM
  vbru02URpAq2jaCIxJvl99uks0i5XvWm3yca/IQKcZM5nXFZmRKgS7ZDWr0llUTAf7Gn04Hbv
  Y5MP1hMPpELOzmA2KlVWslu2Oh41WfpQLKCc7g0EajUafViG67Fb3//UplEUjYwZToHRJszrc
  D+dNyatg8irpEzPKKm7hXynbgzY+v69qaPrg+kNH49Wrrx/WpdP3omWp5ZmP94bn817LO/b1P
  T15u20rO1z++cH2YH90U9qOzc/sb33xcmf3m2Ne/VDKcPjR4+2vvDE6sGnw04nTvpuZpyfXFl
  wRdcVbyt+bnzaU5eicHz3yZDG2ZIiHGzr7R0xXMz74OX521lotLO36xG8kJItQlI+7JOEfFWD
  GySMEAAA=
X-Env-Sender: yehs1@lenovo.com
X-Msg-Ref: server-4.tower-128.messagelabs.com!1525874675!69006794!1
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
Thread-Index: AQHT5oc89K0fVKx8vE2XYGyeMTEHcaQmvz4wgACKowCAABddoA==
Date: Wed, 9 May 2018 14:04:21 +0000
Message-ID: <HK2PR03MB168425F6D00C30918169C77C92990@HK2PR03MB1684.apcprd03.prod.outlook.com>
References: <1525746628-114136-1-git-send-email-yehs1@lenovo.com>
 <1525746628-114136-4-git-send-email-yehs1@lenovo.com>
 <HK2PR03MB1684653383FFEDAE9B41A548929A0@HK2PR03MB1684.apcprd03.prod.outlook.com>
 <ce3a6f37-3b13-0c35-6895-35156c7a290c@infradead.org>
 <HK2PR03MB16847B78265A033C7310DDCB92990@HK2PR03MB1684.apcprd03.prod.outlook.com>
 <20180509114712.GP32366@dhcp22.suse.cz>
In-Reply-To: <20180509114712.GP32366@dhcp22.suse.cz>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [114.240.70.199]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;HK2PR03MB1361;7:RUCi1afqOtfSr4nHv1cl2qnGSxt9JKNTcJaalDg8IB+WSwGLxtKJmEb6b60GVcEHAqLXOldSND2m/4Gjz1gMuyArxtn6o5wts4W82Rr8SVUKwxJRkgE0G6c5/U6xJxucgGZu0KZZfMf9LnFbEq9cqLBIO7sx98Y4tvc7V4H8y0tocE1ABjRy3A8fqihm3NMs6P6nmuEguo702yz/k2XQQqDyMh24AIvtgITyfkN5ABNXdpX6YYrL6y1yyRHU5Urs;20:MbmIYY3JPCpBeSzVPd2DW9N3j0qmzOxVdM6qEOrQEBIJRUn8QceQ/hBOobozTR0FMPaTVLHdqhhljt8b8dt1Fi17zl3Ux4BVCkgH/mMXPlTGlyK+42K551t8qQwUHUMVQLMJIq1ZVTbkiSdzonO7mDrPvCDK6uf8PTRjNo7/5Pc5TfEmXskx/6A9QDumLEPZicpw77zZYGYhnSe47i1TKlQuZbbg/LPxW2CguqsQryP3CD8g1Dg+1UgCQTVbI8YtXOA4D45BbcecW9vTGW+eun2MsYurljpB+tDGytFvhkZooRIHntK1QV1xehd/IpvSlxF8yo4SPptgaoksmxPqRg==
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10019020)(39380400002)(39850400004)(396003)(366004)(376002)(346002)(199004)(189003)(377424004)(6116002)(6506007)(4326008)(97736004)(7696005)(446003)(8676002)(105586002)(3846002)(76176011)(55016002)(11346002)(66066001)(81156014)(9686003)(7736002)(54906003)(99286004)(316002)(305945005)(6916009)(74316002)(106356001)(229853002)(86362001)(14454004)(33656002)(53936002)(8936002)(2900100001)(3280700002)(2906002)(68736007)(81166006)(478600001)(476003)(7416002)(26005)(186003)(25786009)(6246003)(102836004)(53546011)(5660300001)(3660700001)(486006)(6436002)(5250100002)(93886005)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:HK2PR03MB1361;H:HK2PR03MB1684.apcprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(2017052603328)(7153060)(7193020);SRVR:HK2PR03MB1361;
x-ms-traffictypediagnostic: HK2PR03MB1361:
x-microsoft-antispam-prvs: <HK2PR03MB1361538C96114656D29E928D92990@HK2PR03MB1361.apcprd03.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(3231254)(944501410)(52105095)(93006095)(93001095)(149027)(150027)(6041310)(20161123558120)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(6072148)(201708071742011);SRVR:HK2PR03MB1361;BCL:0;PCL:0;RULEID:;SRVR:HK2PR03MB1361;
x-forefront-prvs: 0667289FF8
x-microsoft-antispam-message-info: dFoMwlSI7dRDcQzzF/8gM8MWbQRlYFEBMcyo4ZHB+wB1y/UglEm+Ynyr9fmDt2tv3RGr8UT1pQbReqRuelZefF4mFlhDNjjvu62+Ed4R7AHqNxuZjvWyTfaCxl/S5yM2nC8ihO6ZlDGsanE7GAoeazPbI6Ttr2+c6LBQBeKzYvwl6MeP25X3ICDca2BkSHrJ
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="gb2312"
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: f630ef0a-24f5-48a4-41a7-08d5b5b5c3b4
X-MS-Exchange-CrossTenant-Network-Message-Id: f630ef0a-24f5-48a4-41a7-08d5b5b5c3b4
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 May 2018 14:04:21.9221
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5c7d0b28-bdf8-410c-aa93-4df372b16203
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK2PR03MB1361
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w49E4t7c011955

> From: owner-linux-mm@kvack.org [mailto:owner-linux-mm@kvack.org] On Behalf Of Michal Hocko
> 
> On Wed 09-05-18 04:22:10, Huaisheng HS1 Ye wrote:
> >
> > > On 05/07/2018 07:33 PM, Huaisheng HS1 Ye wrote:
> > > > diff --git a/mm/Kconfig b/mm/Kconfig
> > > > index c782e8f..5fe1f63 100644
> > > > --- a/mm/Kconfig
> > > > +++ b/mm/Kconfig
> > > > @@ -687,6 +687,22 @@ config ZONE_DEVICE
> > > >
> > > > +config ZONE_NVM
> > > > +	bool "Manage NVDIMM (pmem) by memory management (EXPERIMENTAL)"
> > > > +	depends on NUMA && X86_64
> > >
> > > Hi,
> > > I'm curious why this depends on NUMA. Couldn't it be useful in non-NUMA
> > > (i.e., UMA) configs?
> > >
> > I wrote these patches with two sockets testing platform, and there are two DDRs and
> two NVDIMMs have been installed to it.
> > So, for every socket it has one DDR and one NVDIMM with it. Here is memory region
> from memblock, you can get its distribution.
> >
> >  435 [    0.000000] Zone ranges:
> >  436 [    0.000000]   DMA      [mem 0x0000000000001000-0x0000000000ffffff]
> >  437 [    0.000000]   DMA32    [mem 0x0000000001000000-0x00000000ffffffff]
> >  438 [    0.000000]   Normal   [mem 0x0000000100000000-0x00000046bfffffff]
> >  439 [    0.000000]   NVM      [mem 0x0000000440000000-0x00000046bfffffff]
> >  440 [    0.000000]   Device   empty
> >  441 [    0.000000] Movable zone start for each node
> >  442 [    0.000000] Early memory node ranges
> >  443 [    0.000000]   node   0: [mem 0x0000000000001000-0x000000000009ffff]
> >  444 [    0.000000]   node   0: [mem 0x0000000000100000-0x00000000a69c2fff]
> >  445 [    0.000000]   node   0: [mem 0x00000000a7654000-0x00000000a85eefff]
> >  446 [    0.000000]   node   0: [mem 0x00000000ab399000-0x00000000af3f6fff]
> >  447 [    0.000000]   node   0: [mem 0x00000000af429000-0x00000000af7fffff]
> >  448 [    0.000000]   node   0: [mem 0x0000000100000000-0x000000043fffffff]	Normal 0
> >  449 [    0.000000]   node   0: [mem 0x0000000440000000-0x000000237fffffff]	NVDIMM 0
> >  450 [    0.000000]   node   1: [mem 0x0000002380000000-0x000000277fffffff]	Normal 1
> >  451 [    0.000000]   node   1: [mem 0x0000002780000000-0x00000046bfffffff]	NVDIMM 1
> >
> > If we disable NUMA, there is a result as Normal an NVDIMM zones will be overlapping
> with each other.
> > Current mm treats all memory regions equally, it divides zones just by size, like
> 16M for DMA, 4G for DMA32, and others above for Normal.
> > The spanned range of all zones couldn't be overlapped.
> 
> No, this is not correct. Zones can overlap.

Hi Michal,

Thanks for pointing it out.
But function zone_sizes_init decides arch_zone_lowest/highest_possible_pfn's size by max_low_pfn, then free_area_init_nodes/node are responsible for calculating the spanned size of zones from memblock memory regions.
So, ZONE_DMA and ZONE_DMA32 and ZONE_NORMAL have separate address scope. How can they be overlapped with each other?

Sincerely,
Huaisheng Ye | Ò¶»³Ê¤
Linux kernel | Lenovo
