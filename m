Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753824AbeEHC76 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 7 May 2018 22:59:58 -0400
Received: from mail1.bemta8.messagelabs.com ([216.82.243.208]:45521 "EHLO
        mail1.bemta8.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753525AbeEHC7z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 May 2018 22:59:55 -0400
X-Brightmail-Tracker: H4sIAAAAAAAAA1WTbUxTVxjHe3pP770yOm6LjGeNuOzONMoGo9E
  Pd1symR+WO182I1uWsMXZuittbAveWxxmH6wikdHiEOXFwtQ4qKXg2Hgx0mDdFObcJGwY9qIi
  FDEbDuhA47tsvdzqti83v+f8n//5P+fkXJrQBygDLRS5BNFptrNkArb+EVFnBPXTuVm7jqZz9
  a0tJHckbOVqdvRTXE3Vj4ibGR9BXHPbGq7v3iDmLoTqSe5Ky98arnjvJYo70RhWc8N7srmSM1
  2Yq9s1peHqduxB3P079WQ2w5+ZiBJ817Ggmm8PpPOfd4+r+baZSor/rvY+5j11s5ifvnYR89H
  wIMm3dgxi/vzhHopv/+FjvvPeq3zJ7RT+RtvCtUm5GpvTkl+0QWNtLH2IC0bZotqDOyk3CrBl
  aB6tZ35H8GDo9TKUEONeBH2hZkouMOMl4OLuEawo5WoovuUnlOIygqpPf0Wyn2SWwLmJnwmZ5
  zOrYLL8JikzwdzE8MndN8oQTSczb4P3Kq+0vAMnz08ihVfAL6caKJkxswi6p4rnrFrmffjp7F
  /xrD8R/NZ3ea5pHrMcGkPtc4yYNKgeHVYrWanwWbVPIzMwDDR09xMKp8D41VmNPANi1sFUx3p
  lmQXfNw3x9jQYOORBchYwFRo44t2HFMEEZ5tOEYrgJWGorlOjFMcRVEbc8YR0cNd8QSq8Gdz+
  aNz9CkxEqrDCCyFYHsGKuYmAo7OTlCIsgPqhMK5AL/r+cwpfbFoidqutofjys7DfE6F8czejg
  3MHxvBhhINosSSIWwUxY9nSTItoy7O6HGabPcOUxWU6BEky5wl2s0XK3JjvaEOxl7pdpUIn0A
  3/e6fR07SaTdFuxdO5+ict+R9us5ol6wdioV2QTqMFNM2CtlEX03SikCcUbbLZY8/9kQx0Ijt
  f2yzLWqnA7JBseYr0PXqJbumo9BJ0aXR/7Dt2odpL6LEz3ykYUrWjsoGRDdZC5+PtHv1AAyjN
  kKxFKpVKn1ggiA6b6//6dZRKIzZZe1LeJdHmdD1OvR4bSB0bSDcSlQdymf+VDG7UdGXGzz6Yv
  Tv55sum2i9vX1ohXktpMC5666mHnt3cpkBPr8lwp+K40PNcQmildaK38ImNXSWbv/p65UDYk3
  Ps2wGfP+O1nH7jcNKa6Ef2F4Qk4/LA6iXaSnbMsm/xKjLVufaWuLNs+7LSbc2O4AbjM89vWZ2
  43tiR9e7egzm67E5q6RYWS1azKZ0QJfM/QhRXvjsEAAA=
X-Env-Sender: yehs1@lenovo.com
X-Msg-Ref: server-14.tower-37.messagelabs.com!1525748394!99284479!1
X-Originating-IP: [104.232.225.2]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.9.15; banners=-,-,-
X-VirusChecked: Checked
From: Huaisheng HS1 Ye <yehs1@lenovo.com>
To: Jeff Moyer <jmoyer@redhat.com>,
        Dan Williams <dan.j.williams@intel.com>
CC: Matthew Wilcox <willy@infradead.org>, Michal Hocko <mhocko@suse.com>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        NingTing Cheng <chengnt@lenovo.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
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
Thread-Index: AQHT5jPWfBz2tzl9Xk+fNx5ZDx4cXqQknf8AgAADSZKAAIHYsA==
Date: Tue, 8 May 2018 02:59:40 +0000
Message-ID: <HK2PR03MB1684659175EB0A11E75E9B61929A0@HK2PR03MB1684.apcprd03.prod.outlook.com>
References: <1525704627-30114-1-git-send-email-yehs1@lenovo.com>
        <20180507184622.GB12361@bombadil.infradead.org>
        <CAPcyv4hBJN3npXwg3Ur32JSWtKvBUZh7F8W+Exx3BB-uKWwPag@mail.gmail.com>
 <x49a7tbi8r3.fsf@segfault.boston.devel.redhat.com>
In-Reply-To: <x49a7tbi8r3.fsf@segfault.boston.devel.redhat.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [111.197.250.78]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;HK2PR03MB1361;7:+W7FEDBVE4of9uG2rZ4ekdifeCYO6i+Y5FDOgpWo0Tn2szjNkKSwXDkmx5hwH+DQAsVFUDE3bb5MUVPXWV4z7MXkc6jr4gfwl0rBbvvTACkVU0XXLQXxvEZ3obHSYQU/i846LqrZJvhoO9kFKepNdW4ZsP3srhp8nFO/yZtA4ZhDtFPlbH3bbZ9TFJJgsDGibZfvB0lmjqIdITfAAPUfGwyEyIfImHoLKwxq0I5UPj2u3twBsIwA7dEFSTUvGsp8;20:7xGeiFzBrI6ZMO/ZHoDUl8Rhz3fGKkk8xDSCNfxgZM3szKk6Z3G1jAERxCjH5fLiGruMpkITYkMbK8E8qohVcACrJsGpJFsvXgya9nrV8sAUz/fl4+DkJifvYKNMS43b+vD6qhTS9cXSOsoRtZ1P2BkxvXgId7DDwltfHEPb4+7IZx8qu1qWea/kKp8XpryFayMuiypW6Q/qz/+2/sMJLamWpFN9RpH7i/i72s6lZlacP3U7FZaZMGBdm+KaA4ZHkFeylGIA0CMinglqwrHETTUsvhMygD7+Rxd4/DHE7MHtk+XJe53uZCqwOQQ9tNU654Y/eUZCHwDyu06QTwwbOw==
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10019020)(39380400002)(39850400004)(376002)(366004)(396003)(346002)(189003)(199004)(6116002)(3846002)(105586002)(97736004)(7696005)(6506007)(4326008)(76176011)(59450400001)(55016002)(81166006)(54906003)(316002)(81156014)(110136005)(8676002)(66066001)(99286004)(11346002)(229853002)(74316002)(446003)(106356001)(305945005)(86362001)(7736002)(9686003)(2900100001)(53936002)(2906002)(478600001)(3280700002)(14454004)(476003)(33656002)(68736007)(8936002)(25786009)(26005)(6246003)(7416002)(102836004)(6436002)(186003)(5250100002)(5660300001)(3660700001)(486006)(93886005)(13296004)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:HK2PR03MB1361;H:HK2PR03MB1684.apcprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(2017052603328)(7153060)(7193020);SRVR:HK2PR03MB1361;
x-ms-traffictypediagnostic: HK2PR03MB1361:
x-microsoft-antispam-prvs: <HK2PR03MB1361A531E539A2152E35FA77929A0@HK2PR03MB1361.apcprd03.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(228905959029699);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(10201501046)(3231254)(944501410)(52105095)(93006095)(93001095)(3002001)(149027)(150027)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:HK2PR03MB1361;BCL:0;PCL:0;RULEID:;SRVR:HK2PR03MB1361;
x-forefront-prvs: 0666E15D35
x-microsoft-antispam-message-info: VuHTo4s3EueUxlTcmWIlwLJWjBCDJA+EeVkqPxRPaQZcjqVO5i+wGJyuULOu+fEMCeePNqhUdyiVxWpS9bPMvRmBhhvoLSJPWQ8ls0SO9dkqqnOXWm9bULTvnZtUUBVZKbTQHc5i8dIGAXBRXysizfTDgrXsp08L1zxohe9XF7z04QwNW3hqtVvM38s+MsVT
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 478063eb-69e9-4ec0-1813-08d5b48fbe7b
X-MS-Exchange-CrossTenant-Network-Message-Id: 478063eb-69e9-4ec0-1813-08d5b48fbe7b
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 May 2018 02:59:41.0092
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5c7d0b28-bdf8-410c-aa93-4df372b16203
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK2PR03MB1361
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w48302jc010440

>
>Dan Williams <dan.j.williams@intel.com> writes:
>
>> On Mon, May 7, 2018 at 11:46 AM, Matthew Wilcox <willy@infradead.org>
>wrote:
>>> On Mon, May 07, 2018 at 10:50:21PM +0800, Huaisheng Ye wrote:
>>>> Traditionally, NVDIMMs are treated by mm(memory management)
>subsystem as
>>>> DEVICE zone, which is a virtual zone and both its start and end of pfn
>>>> are equal to 0, mm wouldn’t manage NVDIMM directly as DRAM, kernel
>uses
>>>> corresponding drivers, which locate at \drivers\nvdimm\ and
>>>> \drivers\acpi\nfit and fs, to realize NVDIMM memory alloc and free with
>>>> memory hot plug implementation.
>>>
>>> You probably want to let linux-nvdimm know about this patch set.
>>> Adding to the cc.
>>
>> Yes, thanks for that!
>>
>>> Also, I only received patch 0 and 4.  What happened
>>> to 1-3,5 and 6?
>>>
>>>> With current kernel, many mm’s classical features like the buddy
>>>> system, swap mechanism and page cache couldn’t be supported to
>NVDIMM.
>>>> What we are doing is to expand kernel mm’s capacity to make it to
>handle
>>>> NVDIMM like DRAM. Furthermore we make mm could treat DRAM and
>NVDIMM
>>>> separately, that means mm can only put the critical pages to NVDIMM
>
>Please define "critical pages."
>
>>>> zone, here we created a new zone type as NVM zone. That is to say for
>>>> traditional(or normal) pages which would be stored at DRAM scope like
>>>> Normal, DMA32 and DMA zones. But for the critical pages, which we hope
>>>> them could be recovered from power fail or system crash, we make them
>>>> to be persistent by storing them to NVM zone.
>
>[...]
>
>> I think adding yet one more mm-zone is the wrong direction. Instead,
>> what we have been considering is a mechanism to allow a device-dax
>> instance to be given back to the kernel as a distinct numa node
>> managed by the VM. It seems it times to dust off those patches.
>
>What's the use case?  The above patch description seems to indicate an
>intent to recover contents after a power loss.  Without seeing the whole
>series, I'm not sure how that's accomplished in a safe or meaningful
>way.
>
>Huaisheng, could you provide a bit more background?
>

Currently in our mind, an ideal use scenario is that, we put all page caches to
zone_nvm, without any doubt, page cache is an efficient and common cache
implement, but it has a disadvantage that all dirty data within it would has risk
to be missed by power failure or system crash. If we put all page caches to NVDIMMs,
all dirty data will be safe. 

And the most important is that, Page cache is different from dm-cache or B-cache.
Page cache exists at mm. So, it has much more performance than other Write
caches, which locate at storage level.

At present we have realized NVM zone to be supported by two sockets(NUMA)
product based on Lenovo Purley platform, and we can expand NVM flag into
Page Cache allocation interface, so all Page Caches of system had been stored
to NVDIMM safely.

Now we are focusing how to recover data from Page cache after power on. That is,
The dirty pages could be safe and the time cost of cache training would be saved a lot.
Because many pages have already stored to ZONE_NVM before power failture.

Thanks,
Huaisheng Ye
