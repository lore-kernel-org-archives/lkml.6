Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751943AbeEECK6 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 4 May 2018 22:10:58 -0400
Received: from mail1.bemta8.messagelabs.com ([216.82.243.205]:23673 "EHLO
        mail1.bemta8.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751709AbeEECK4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 May 2018 22:10:56 -0400
X-Brightmail-Tracker: H4sIAAAAAAAAA1WTa0wTaRSG+3Wm0+EyOhQJRxQSJ8QL2groj/E
  Sbz901GD8ZyRGd6pjp9m2kJmqGE0UFy/FSypRUECtxkuAItrdBXR32QhsRDRBqtG1i+i6oIGi
  VYy6sUacYfD27/3O837nvN/kDImZIkQKKRS4BcnFOxgiFrel9U8zXzQ9z83sPDqZrazzE+yZJ
  pEtK+wwsjWBHPbO1UqC7fYPGdjGc016Nvz2PMbubrmCsxVFLwxsReEhtCCOaxmIYNyV2mo9F6
  j2EFxgsMTItR2L4tyr3hDO3fK1Grmfb27jfn0/j9v9Lol7HUhbGZdrsLuseQU/GMSfgoNEfji
  uoDw0ZNyJwjHFKJY00c8Q9IT/wbXDXwjuhB5i6gGnD2DQHn1qLEYxCjmoh4rLqzRXF4Ijfj+u
  AoKeAjcG7mGqHkOnQ92hLqNqwuhrOLS0dOpVkEg74N/uBwbN5IQLj3tHdDbcHGpWLhuVcelQP
  1+tUvQaZe49XJvrQ/DSO0HVMfQMaPIODo9CdCqUPnk03B2jk+FEaflwR6BpOPt7B6bpJOj776
  NSJxXNQKUPtHIqBE/tR2pKoL0GONnmMWogC65X/YlpwENAWbAU10A9gopai6Yz4MOut4Smf4S
  6Mw0jnlmwL/g3rl0+jkGR/8VIovFw8Y8+pL1GhOKSKqQmMtFWqI3avchS/s0bND0NfL8NEpqe
  CudPh7Hy4e+SADeO9+A+hFejybIgbRYkc3amxSrZbaLbydsd5qxM1uIUZJm3CQ7eKlvW5zkDS
  Fm+HTodakQNHUua0VhSzyRRy9YO5JpGWfM2bBV5WVwnbXIIcjMaT5IMUDOUJTUlSIJNKNhody
  gb/BkDGc+MoXJUTMn5vFO22zTUjsyk/5eSA5gJd+W5hJRkapFqolWTuMn1pcXn/yCIUlMSKaT
  T6Uzx+YLktLu/5/0omURMIkWpXeLtLveXSf1KCL0SIjESVkO4+a8oZSfyPpD2tvnKpn64flha
  GPHEJjUMmbH6E5tzez3z97Zfmr5gTVXj65i7Zczinsjdp9ScxwdD/0931dxf+qq06KPhcFP8h
  tC47uXVNW9yJkVthcwe/fa5Oa1nO9PWrxT7EsRI/8nRE1fUH3s3Mzv99uiMLYtnt66m0qOtl5
  Y+WUXXvHzTdYvBZZHPysAkmf8E/V0fsAIEAAA=
X-Env-Sender: yehs1@lenovo.com
X-Msg-Ref: server-15.tower-144.messagelabs.com!1525486245!24255679!1
X-Originating-IP: [103.30.234.44]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.9.15; banners=-,-,-
X-VirusChecked: Checked
From: Huaisheng HS1 Ye <yehs1@lenovo.com>
To: Michal Hocko <mhocko@kernel.org>
CC: "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "vbabka@suse.cz" <vbabka@suse.cz>,
        "mgorman@techsingularity.net" <mgorman@techsingularity.net>,
        "pasha.tatashin@oracle.com" <pasha.tatashin@oracle.com>,
        "alexander.levin@verizon.com" <alexander.levin@verizon.com>,
        "hannes@cmpxchg.org" <hannes@cmpxchg.org>,
        "penguin-kernel@I-love.SAKURA.ne.jp"
        <penguin-kernel@I-love.SAKURA.ne.jp>,
        "colyli@suse.de" <colyli@suse.de>, NingTing Cheng <chengnt@lenovo.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [External]  Re: [PATCH 3/3] mm/page_alloc: Fix typo in debug info
 of calculate_node_totalpages
Thread-Topic: [External]  Re: [PATCH 3/3] mm/page_alloc: Fix typo in debug
 info of calculate_node_totalpages
Thread-Index: AQHT46qJke8dMZNHUUumfjnHjmGf66QgYGAA
Date: Sat, 5 May 2018 02:10:35 +0000
Message-ID: <HK2PR03MB16841DAC9D4C5D0569676F7692850@HK2PR03MB1684.apcprd03.prod.outlook.com>
References: <1525416729-108201-1-git-send-email-yehs1@lenovo.com>
 <1525416729-108201-4-git-send-email-yehs1@lenovo.com>
 <20180504131854.GQ4535@dhcp22.suse.cz>
In-Reply-To: <20180504131854.GQ4535@dhcp22.suse.cz>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [125.33.107.244]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;HK2PR03MB1489;7:LtbvgPH+XH7Be725xFavkIaBmT4Sov2opFGJbQxqa6s8AN4hiIa/R9APfKFjrRw5OGZxFBYrFL8M1+QvXDlnxIQIXIxe5Y8A5wmG9pKX+cY4qd8xBgL8ofDQJhaUtW1XJ6TZOebqShzLHK6BLV1TlK4yrMTQQnf/adny2saSvl5gGcPkkjaq781D6vYVGPxe5AF5s6yZyMap+Aj9mKJUmKpJLVl5V2F/E4tn1Gew+EcOZquoKWQ2t+WERsp4iqUI;20:D/5dgGmIiHhx8YYHPL+uU7OLOPld+qycNWtB7GxLIb8x/MAcKZMUoEXnhZ3O0WU7OzuI1DtoT3racC4UTeT1LV6xXy3ElgxR9YyboycKL8xklyxOr+PiA1g3CprdKsfdxJsoeVFA2ra59hDuXlXCjyRGcvmwVdIVM7QkWsj3+OyU4mvqyvu4yvFP7hEYaIaDZYWF7lPNOUxPPJURQVa0ReLGKLr7zcofdU+1fNE7cCSEirIY2kC0mbWU9BeVX0Z6EtNgHbdLYjysgfZKT2XzxgHtHYoiwibbIbqVpX5ndtpbAsE022EQuzWDD/Yub3WIUgP+FfjPV9z2xNXg4+FJRQ==
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10019020)(396003)(39850400004)(376002)(346002)(39380400002)(366004)(377424004)(199004)(189003)(6116002)(66066001)(8936002)(9686003)(316002)(5250100002)(55016002)(3846002)(229853002)(6916009)(54906003)(2900100001)(6346003)(53936002)(26005)(6246003)(7736002)(6436002)(86362001)(102836004)(4326008)(11346002)(6506007)(25786009)(476003)(97736004)(105586002)(446003)(59450400001)(478600001)(106356001)(74316002)(7416002)(76176011)(486006)(7696005)(305945005)(68736007)(2906002)(5660300001)(33656002)(8676002)(186003)(14454004)(81166006)(81156014)(14066004)(3280700002)(3660700001)(99286004);DIR:OUT;SFP:1102;SCL:1;SRVR:HK2PR03MB1489;H:HK2PR03MB1684.apcprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(2017052603328)(7153060)(7193020);SRVR:HK2PR03MB1489;
x-ms-traffictypediagnostic: HK2PR03MB1489:
x-microsoft-antispam-prvs: <HK2PR03MB1489506AF84F4329E736A04492850@HK2PR03MB1489.apcprd03.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(3940261145250);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231254)(944501410)(52105095)(10201501046)(3002001)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(20161123562045)(6072148)(201708071742011);SRVR:HK2PR03MB1489;BCL:0;PCL:0;RULEID:;SRVR:HK2PR03MB1489;
x-forefront-prvs: 0663390E1B
x-microsoft-antispam-message-info: 3uduzuakvPOCFFnI7ip6qczwJZyqLERt0iX0GatLJTzdiKIIwo6CNIF60CRDdXiQvRsHCTqMoDiDJa+UWXmwo3BGlif+g2+trjlvKC1treWIzXM7nmhQ8vYGhOW8aYdOlU9Fgsk5PWXj1ppXOzXZi8Ga6794L5iFKsZpiO3nzrxWdE0s2V/3u3EsXw27Fh46
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 2bd28e32-58c6-4caa-85a4-08d5b22d638e
X-MS-Exchange-CrossTenant-Network-Message-Id: 2bd28e32-58c6-4caa-85a4-08d5b22d638e
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 May 2018 02:10:35.3838
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5c7d0b28-bdf8-410c-aa93-4df372b16203
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK2PR03MB1489
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w452B7Fh031617


> On Fri 04-05-18 14:52:09, Huaisheng Ye wrote:
> > realtotalpages is calculated by taking off absent_pages from
> > spanned_pages in every zone.
> > Debug message of calculate_node_totalpages shall accurately
> > indicate that it is real totalpages to avoid ambiguity.
> 
> Is the printk actually useful? Why don't we simply remove it? You can
> get the information from /proc/zoneinfo so why to litter the dmesg
> output?

Indeed, we can get the amount of pfns as spanned, present and managed
from /proc/zoneinfo after memory initialization has been finished.

But this printk is a relatively meaningful reference within dmesg log.
Especially for people who doesn't have much experience, or someone
has a plan to modify boundary of zones within free_area_init_*.

Sincerely,
Huaisheng Ye
Linux kernel | Lenovo
> 
> > Signed-off-by: Huaisheng Ye <yehs1@lenovo.com>
> > ---
> >  mm/page_alloc.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> > index 1b39db4..9d57db2 100644
> > --- a/mm/page_alloc.c
> > +++ b/mm/page_alloc.c
> > @@ -5967,7 +5967,7 @@ static void __meminit
> calculate_node_totalpages(struct pglist_data *pgdat,
> >
> >  	pgdat->node_spanned_pages = totalpages;
> >  	pgdat->node_present_pages = realtotalpages;
> > -	printk(KERN_DEBUG "On node %d totalpages: %lu\n", pgdat->node_id,
> > +	printk(KERN_DEBUG "On node %d realtotalpages: %lu\n",
> pgdat->node_id,
> >  							realtotalpages);
> >  }
> >
> > --
> > 1.8.3.1
