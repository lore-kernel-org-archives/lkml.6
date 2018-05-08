Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754034AbeEHCff (ORCPT <rfc822;w@1wt.eu>);
        Mon, 7 May 2018 22:35:35 -0400
Received: from mail1.bemta12.messagelabs.com ([216.82.251.11]:28972 "EHLO
        mail1.bemta12.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753919AbeEHCfc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 May 2018 22:35:32 -0400
X-Brightmail-Tracker: H4sIAAAAAAAAA1WTbUwUVxSG987Hzog77WUROW6FpFsbFQUFEzP
  1h6XGH5M2GtMmttKqHdphZ+N+4M5Ct9EEUUCrSMFWVFhbaJWULRsUsS5IICAWtFYNWjCIoqip
  UoQCNlRR6gyDVv89533fnHNuci5LmrczFlbyeSWPS3RYjWGUfPcmETdsGkpeGAzE8P6qSiP/Q
  4PM78u6wPA/V6/gL9X5jfz1yv9oflvhVYYPHW4g+J78JD7nVC3Fl2QP0HxJVj7ix/71G5M44V
  T/ICnUBgOEcOynWKF6eA8jtO0fo4RdJeOUMHSnixKqav6ghHOlLYxw7LdNwvFHS4Wc0UhhpDp
  mFZdM210pbt+ntNwaukKknce+I6P/0FtQIbcThbFm/CeCYPbfjF60IBj88RtSKyicR8JoRxHS
  nXwC2r67OhnrRlBVX6E6U1gjngtn+jtIjafhVGh/WEdoIRLn0tCZs3fCiMAyXCwspPSQEy7nH
  lVDrMqJ0HtP0WQKz4Lbj7tpTebwJzBSE6fJZuyDA1lVRk2egpdBwa9YkxGOhqLeHkJjEkfBwa
  JiWmPAGA7VXyB1joR7t8YnOiL8PgzUrNNlKxQ3HZqMR0P797smngi4gIa2plqjbiRAa0UjqRt
  9NJw43MHoxS8IHjb6JyfEQqj7DqNNALwBLnVadPkt2NF+hdI5BgK7b05yBQl942/qPBP81xqo
  ArSg+IU36DwfSk8OG3WeB+Vlf5Eaczgczhy4TZUiKoDmKJInQ/LELeLjUzx2m+x1inZHXEJCY
  rxTUhTRJjnEFCX+M7ezGqnnmGkwoBC62/hxM5rBEtZILoMaSja/kuL+/EtZVOT1nnSHpDSjmS
  xrBe70VNUL90g2yZdqd6g3/cwG1mSdxoWpV23mlDTRqdhtunUWLWK7c/PySLayZk8eaaZcbpd
  kieIuap2wFpXTXc8bPfsf7SjaEsEhg8FgNqVJHqfd+7Lfh6JYZI3gerUuJrvL+3xen7oKoa4S
  fmNQW8Ur/m9ZtqDodWXLg5sDvy99tYy43MOtGVl8P/Or5eUr6l57+8Ebr38QSi//umVv05qVT
  2jvrI/un7+2oDlx+3t4qlcZ23+LecDZ3s3OOufuX7taiPgiszVp29GY/p2zO4NL6v1buwyj/s
  Vb3ab1dSfeMXfMb7u+4cn0s10bwZbh+3D1wW8j1w6kzhk/YqUUWUyIJT2K+BR4kOb5GgQAAA=
  =
X-Env-Sender: yehs1@lenovo.com
X-Msg-Ref: server-2.tower-47.messagelabs.com!1525746927!48446338!1
X-Originating-IP: [104.232.225.2]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.9.15; banners=-,-,-
X-VirusChecked: Checked
From: Huaisheng HS1 Ye <yehs1@lenovo.com>
To: "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
CC: "mhocko@suse.com" <mhocko@suse.com>,
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
Subject: [External]  [RFC PATCH v1 6/6] arch/x86/mm: create page table mapping
 for DRAM and NVDIMM both
Thread-Topic: [External]  [RFC PATCH v1 6/6] arch/x86/mm: create page table
 mapping for DRAM and NVDIMM both
Thread-Index: AQHT5nLo8hbgzoGgok+c55ua3SkdRaQlHUeA
Date: Tue, 8 May 2018 02:35:13 +0000
Message-ID: <HK2PR03MB1684101846A9D9639BE00001929A0@HK2PR03MB1684.apcprd03.prod.outlook.com>
References: <1525746628-114136-1-git-send-email-yehs1@lenovo.com>
 <1525746628-114136-7-git-send-email-yehs1@lenovo.com>
In-Reply-To: <1525746628-114136-7-git-send-email-yehs1@lenovo.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [111.197.250.78]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;HK2PR03MB0802;7:K7u+0t/QHo5KVnegafuy9WP+X98tLm7qbLFieOFIhDK40lwULIkxUjZHQbei2LKjECti1DJunypwZw/xMZeWpOeveu1pTuAuxIU5AoZDkeDyCwcKsBL4x3CsrHU9GcLMbyoTrFFGhGUOyYssXhCyoWxwasoV39NkvYA6e5TcJuIDoXJ64iIojs5+hbYv9RjT6E4bOhj0vad7OqQinXKLjXzwt9EZ/PTvLYU8aUPqun2244xpNXBba6vLEyWAlRo6;20:aPsLzq8EBmrMfZSocJ6rmBEHHgu/LW7T5r/mCCuylKtBzclTnYcrF3qgu4PwHi7Y7+glYbog5ciyhGSJ0Jew8hbr43QfL9KgLm0rDor0kLKfkEwIKSHAn7Fk+JceKaCPRo4k7+dTwhEzRqb5G6tJ3IeVHMISeEVMum2pf60fuaTVL6iny1/R/SXwSCY3fkUpv1vL80f6T+ElPklXHZJ1TyGR5uwu4wQwxvBBtRUHJITy0ZMDvQ2WTD9z8R4OfeRVOJ1D1txmEBQu4qsrSN+7Txm/wNV9XpF7KjpdPymoVqA9UOhCbxH3V+ogo0rUrbdWLTTDdSE0qHEwnLElHU6whA==
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10019020)(366004)(39380400002)(376002)(39850400004)(396003)(346002)(199004)(189003)(14454004)(68736007)(6436002)(106356001)(8676002)(81166006)(81156014)(25786009)(478600001)(66066001)(8936002)(2906002)(110136005)(7736002)(97736004)(305945005)(54906003)(86362001)(3660700001)(3280700002)(105586002)(26005)(55016002)(102836004)(53936002)(7696005)(186003)(76176011)(6506007)(3846002)(9686003)(7416002)(74316002)(5660300001)(446003)(11346002)(33656002)(476003)(486006)(2900100001)(4326008)(316002)(5250100002)(2501003)(99286004)(6116002)(13296004)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:HK2PR03MB0802;H:HK2PR03MB1684.apcprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(2017052603328)(7153060)(7193020);SRVR:HK2PR03MB0802;
x-ms-traffictypediagnostic: HK2PR03MB0802:
x-microsoft-antispam-prvs: <HK2PR03MB08029E6BDBD51516661419CB929A0@HK2PR03MB0802.apcprd03.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(3940261145250);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(93006095)(93001095)(3231254)(944501410)(52105095)(149027)(150027)(6041310)(20161123558120)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(6072148)(201708071742011);SRVR:HK2PR03MB0802;BCL:0;PCL:0;RULEID:;SRVR:HK2PR03MB0802;
x-forefront-prvs: 0666E15D35
x-microsoft-antispam-message-info: 5nb14QRHMH9lJV4ZQZc0/ywtGMxOvfF/I7P1vEBes/s7akaScbc4zza3WKLf4B0SFYAdzsgvjB0rzuEl6x/BZtiiUsBPYJUZubzhIVLCOoiki13JqZqTIUZMMK8jjFhoczeQGjqfZmEO2n4vZ4URMYzJ4mNNxs7QM/q3X07fzqfMt3pOt9FhKdT8pXtu3V6R
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 46c7d637-def9-43c7-5aef-08d5b48c53aa
X-MS-Exchange-CrossTenant-Network-Message-Id: 46c7d637-def9-43c7-5aef-08d5b48c53aa
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 May 2018 02:35:13.3396
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5c7d0b28-bdf8-410c-aa93-4df372b16203
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK2PR03MB0802
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w482ZetV006713

Create PTE, PMD, PUD and P4D levels page table mapping for physical
addresses of DRAM and NVDIMM both. Here E820_TYPE_PMEM represents
the region of e820_table.

Signed-off-by: Huaisheng Ye <yehs1@lenovo.com>
Signed-off-by: Ocean He <hehy1@lenovo.com>
---
 arch/x86/mm/init_64.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/x86/mm/init_64.c b/arch/x86/mm/init_64.c
index af11a28..c03c2091 100644
--- a/arch/x86/mm/init_64.c
+++ b/arch/x86/mm/init_64.c
@@ -420,6 +420,10 @@ void __init cleanup_highmap(void)
 			if (!after_bootmem &&
 			    !e820__mapped_any(paddr & PAGE_MASK, paddr_next,
 					     E820_TYPE_RAM) &&
+#ifdef CONFIG_ZONE_NVM
+			    !e820__mapped_any(paddr & PAGE_MASK, paddr_next,
+					     E820_TYPE_PMEM) &&
+#endif
 			    !e820__mapped_any(paddr & PAGE_MASK, paddr_next,
 					     E820_TYPE_RESERVED_KERN))
 				set_pte(pte, __pte(0));
@@ -475,6 +479,10 @@ void __init cleanup_highmap(void)
 			if (!after_bootmem &&
 			    !e820__mapped_any(paddr & PMD_MASK, paddr_next,
 					     E820_TYPE_RAM) &&
+#ifdef CONFIG_ZONE_NVM
+			    !e820__mapped_any(paddr & PAGE_MASK, paddr_next,
+					     E820_TYPE_PMEM) &&
+#endif
 			    !e820__mapped_any(paddr & PMD_MASK, paddr_next,
 					     E820_TYPE_RESERVED_KERN))
 				set_pmd(pmd, __pmd(0));
@@ -561,6 +569,10 @@ void __init cleanup_highmap(void)
 			if (!after_bootmem &&
 			    !e820__mapped_any(paddr & PUD_MASK, paddr_next,
 					     E820_TYPE_RAM) &&
+#ifdef CONFIG_ZONE_NVM
+			    !e820__mapped_any(paddr & PAGE_MASK, paddr_next,
+					     E820_TYPE_PMEM) &&
+#endif
 			    !e820__mapped_any(paddr & PUD_MASK, paddr_next,
 					     E820_TYPE_RESERVED_KERN))
 				set_pud(pud, __pud(0));
@@ -647,6 +659,10 @@ void __init cleanup_highmap(void)
 			if (!after_bootmem &&
 			    !e820__mapped_any(paddr & P4D_MASK, paddr_next,
 					     E820_TYPE_RAM) &&
+#ifdef CONFIG_ZONE_NVM
+			    !e820__mapped_any(paddr & PAGE_MASK, paddr_next,
+					     E820_TYPE_PMEM) &&
+#endif
 			    !e820__mapped_any(paddr & P4D_MASK, paddr_next,
 					     E820_TYPE_RESERVED_KERN))
 				set_p4d(p4d, __p4d(0));
-- 
1.8.3.1
