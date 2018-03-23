Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752169AbeCWPVN (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Mar 2018 11:21:13 -0400
Received: from mail-he1eur01on0107.outbound.protection.outlook.com ([104.47.0.107]:19840
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751531AbeCWPUD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Mar 2018 11:20:03 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=aryabinin@virtuozzo.com;
From: Andrey Ryabinin <aryabinin@virtuozzo.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Mel Gorman <mgorman@techsingularity.net>, Tejun Heo <tj@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        Steven Rostedt <rostedt@goodmis.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org
Subject: [PATCH v2 1/4] mm/vmscan: Update stale comments
Date: Fri, 23 Mar 2018 18:20:26 +0300
Message-Id: <20180323152029.11084-2-aryabinin@virtuozzo.com>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180323152029.11084-1-aryabinin@virtuozzo.com>
References: <20180323152029.11084-1-aryabinin@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [195.214.232.6]
X-ClientProxiedBy: HE1PR0101CA0011.eurprd01.prod.exchangelabs.com
 (2603:10a6:3:77::21) To AM6PR08MB3253.eurprd08.prod.outlook.com
 (2603:10a6:209:47::18)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 68a1c54a-eed8-463c-6e29-08d590d18adb
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:AM6PR08MB3253;
X-Microsoft-Exchange-Diagnostics: 1;AM6PR08MB3253;3:RfV5evCrrQIC/3LpXaGPrlztRCkS+KGorMGeXl57mciQbGzKSPoKvnIdFveEEgKEtR2QNgYFl/InaDqTb0S4DHWJze1eQShqJH7I3cCkho4nyj2LFSSpIM9DkEBfcgIEMoOFVByLw2LPV11LsloUhvaJbJCJWNHw6pvK/BQ0PMnbhEgz6e2aGT9e9HEcNj7kIUcdWu7ULllPD6oMKGJgcEKiAVOIarDb5Cx774ydBrnz9U0xcCaXmDJwknqTPYD8;25:xNuGKSJWDYAcjCZiK2qotzeJmcwjZq+Nr1AXLzyX50dklesbxhO2jA+vnhomdL8QA3wiA/8AR+u5FVfxJtkcng/KZ1uyQXL0X+tfk7acvSqDGj3Xsvg/JiAlv7nZpiAg60OQxpee9qdlHCdG0jatPndsZy8mAh9J6rjCNBvKdygVtUreuITsD+VxDx6+5x/RtiY9C3v/vWpQZmouH8zQ3pqHIyiqR7oIlp+26gmgR+YvrEatptrzKXbDHzax1Kmrs4VqDuK0AOw9HPlLyxeOeNEPiW6iQwbQY2axFdVarsYZFWIEMtscb/X+phV0EnAeMTXyiKMiVkTK0Plb84FIIw==;31:SQ64M+0iWAj9CXvSL3ehlEHRjmJ1WFfJlotARaNCYJ4J2GjskLHM+w3Coja1PWKWwLAy0yunWN24FfCLbOGRhgAjt29/oqGbyiTB3QQMsjcUGwlLYq09UPevbTcwl7zXL1GuMwh3etmfaMB1aEgFuisufoYJlQgM2i4t/KLvw2fa+KlhuVMkVBxrkCxb0gBU+C/nzNyl6QyyiGk433RQ7I11R9ER1MSzxgE2t9Gc1P4=
X-MS-TrafficTypeDiagnostic: AM6PR08MB3253:
X-Microsoft-Exchange-Diagnostics: 1;AM6PR08MB3253;20:fcbHIQ95B5x1PJaBwSBrWrRYP9U8vtP096wFD1rsLNsfnQIXg8nGsH1nCXsyTixq5ycSaHLr/YlUsP0ywHt+3lFaI9GyFYKFyChBq0HK4fuJBt3fw3cM2Ed8NKOEK87yTQkZUFE1Et3LIwsz0KodxLLz0LKm63eMXRzVYR1XMrYZqXkxRTlWDLI+54bTpJlpAKJKFBPoK8ldhzjBda9IN5hlPytfPM/goejlv4yhhO+plE5J3D5vdAxCyFxd93k0y1lbjI9zlo/ya8V/Ec/jxPPGyTsInZJSl9crXcWLzCP3qnxvNf8J19BTRIZTEghHvL0pmCRLDQVZ7J6whIecLKbv9yeqJGCj3yvjGMHQ59nMsvDiJcy4Kg71RGUImtRlKdSVRD14YQE4yjss0zGMuFCwXBPfwHvgB/hAP3154YU72z689mXwA4LDCCRf5WzzamCR1rsbfE95J5MJ3erARcr1H+HPU1e+871wBOLSMxbXTsiTQyFgL7CaUEP2w28H;4:E4xUoApLTIvoGjfwMxEJJwbOvtB8r/rkz1D2v+zh1gep3+5ngq8qy+geCBl4PDhGIipgkabMoc+aeJCL3aQxpjT8JAdcuCWxzwIUzax15l3MhhPfXo91k67AZ29nuFDLpAH9JLmDh2IyHdPq3iuq79k0irWTwIxwNnaXJ0raeoQYNR3DOEr5K+p1F5xTFKNi9x5bqGFgjmJtIx1p5CMnJUikfFLTKLcJbdTE/HuTircWnhiedQsMm6eaI7smvOYRjRjfMVsMM2rawBs7HH5hIw==
X-Microsoft-Antispam-PRVS: <AM6PR08MB325340D0117DA6751A77627FB0A80@AM6PR08MB3253.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3231221)(944501327)(52105095)(93006095)(93001095)(10201501046)(3002001)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(20161123562045)(6072148)(201708071742011);SRVR:AM6PR08MB3253;BCL:0;PCL:0;RULEID:;SRVR:AM6PR08MB3253;
X-Forefront-PRVS: 0620CADDF3
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(346002)(39850400004)(39380400002)(366004)(396003)(376002)(189003)(199004)(36756003)(25786009)(186003)(97736004)(1076002)(3846002)(53416004)(478600001)(48376002)(11346002)(50466002)(66066001)(47776003)(105586002)(106356001)(53936002)(305945005)(6512007)(4326008)(7736002)(50226002)(81156014)(8936002)(52116002)(6666003)(54906003)(76176011)(81166006)(386003)(86362001)(6506007)(7416002)(2906002)(59450400001)(51416003)(316002)(68736007)(55236004)(6486002)(15650500001)(446003)(6116002)(6916009)(5660300001)(16586007)(8676002)(26005)(16526019);DIR:OUT;SFP:1102;SCL:1;SRVR:AM6PR08MB3253;H:i7.sw.ru;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM6PR08MB3253;23:+bYBSX2F1rzOuz0iKLyIYI6e4E3kBmTOSfSj9Yhmh?=
 =?us-ascii?Q?qJPdBAahcnaZLieMeO4AwoeteW59zb+tF8yS3+7E11o+K8+iBSxIfvIzkq0h?=
 =?us-ascii?Q?RdvW8HFX62ZSRp+i3bafB2oyVQmairAbIVhGJsaJBHUki1oguJXK610e0o8n?=
 =?us-ascii?Q?SK9vD991MPfAP7mfuNWWZn9XbhIipQjweQp2Ul95p42ULDEl932r4ZsDmG+u?=
 =?us-ascii?Q?HrFKcFlWYl3/4HzlWq58Iq/ZF45uS1/1sh4ImQv+jamMyBisytBteTQ9pq6p?=
 =?us-ascii?Q?or2KLQ5zucVtAD8Wmt57n9Ke9FBZvjrBsUL2DTCzXQuFadUURn3K3Cg6SmHu?=
 =?us-ascii?Q?ZOkEjTK0oEbbxHgwAWANdnPRUcU9om72M89DUbUSGGLDQ+LICelIsDgzkdLK?=
 =?us-ascii?Q?Fumw6BfDwZpyQ0CVCLacACgTZKq0+JfmfLeddTleORMXGGHK4jrWc6jh3EcJ?=
 =?us-ascii?Q?wi/e7Venu8jiC5pv8l86Y49UXzqZgXrQm+Hd6I76+8oFOaoMfGu+s3jokS+0?=
 =?us-ascii?Q?Oz5cpR2pqgp4h8EzCEGLvgQC//WraRc8g2J+bqiZrZD5T0HVlO22wQJQf5Ve?=
 =?us-ascii?Q?55/d0DRw/BoVxj5u7HzfVwZzwg4UyQrNToUjVdoVZnEVn7hSGx/NDxzdwUbz?=
 =?us-ascii?Q?MZGYCyF0T5Tt26ZvMb4bbUfCeoLnKnnNUOH7yVKBbjuS/M8fkj5VBDtvdyF/?=
 =?us-ascii?Q?nm12+ZraktPpPevMiG/dJeUoxOzyc2LOp9U4OWZwZS7+ZY2j/dp+loME203e?=
 =?us-ascii?Q?j2+KnN4P4acYolied//h7SnkYYLLCm9y7aXSzKLLyM7TtVCVHhbHtB/TYxvd?=
 =?us-ascii?Q?pEebOB8fy/vwp9iTwzSQMBqaKmftZfxQO47dEoh/gvcT/BjlbvnePH93M/W9?=
 =?us-ascii?Q?enTZKPayvEYwy1vHgmGrcm/kmt0mbzIkpCCXcSiA0hSkSyacfWYVLLIvSj2K?=
 =?us-ascii?Q?yh9AREDxqTm6ORfjDS9ctM6eogcZ723cNQpFwVf+hrtcwihjhSXkKdDBSa/u?=
 =?us-ascii?Q?r1tShApIZ9OiCkuskdE/AAEqMJbwO3sneFu9AUvL8No39pSnSzkOlVVntaFT?=
 =?us-ascii?Q?vCp+rk7MDKAmuKBA4bcBWgqlTQ+KaQuz9ahmlxqMlZGrS6/m0UBzJY4Hc081?=
 =?us-ascii?Q?rIPQQ+BSSLF6VU4m39Tu6y3hypBxLhEk+sWpWBncvuSNCnuLINBeeV06Sd+p?=
 =?us-ascii?Q?vznSh2YNi+mgeGgPNQEBZ5G2aX76LC6u06rMbzEtC/NqAgZiXAQyX5WVVDwa?=
 =?us-ascii?Q?7mku21ZTWjGF/2VUuq5TKWJcMoVSj0iKn1y4aY/?=
X-Microsoft-Antispam-Message-Info: dhX3JYoXK9uSom7EkIEKat3SgSHLM+u4HNxiVA6cX3VzAjx0tvOB8KD3g7B10ywJQtGicMCbVjn0Drk5JN1l2dU1wxNFdiW1ltbV4NrjtMIYN+Vy9YIn0d3W4ScYzIbElkYtsh/yndvsJoQGzy+c1lZ+ZXjEJ699pm3osYLMriS9TOCqdADvpb9VvkScqAG4
X-Microsoft-Exchange-Diagnostics: 1;AM6PR08MB3253;6:8FTfJYJpeqyhpxsCXlCqR7mxIBNFn8nsoHa/zqcIEJcu5JTPReVqBSHN4WoiUi1+qXXL2XrsXu/PhLZ3Uf3WcXvT++6wWvqRFsgudPi0h2ndJBxeQz5zn1dNVaqwqdvlFU/yYQM5uN/oZs2ivBQbWfG0eA3SHicMqS29cdD795uD0lkcbFGq5C3wEoCOettS8FkipNxNrY0XD49u1NpkTIeenr957RsJH97AokSZ+Qo9DyQcij87iqxn6P/UFOdBxbqPeKAb32X1Equ7XgjIHwoL6eLISTfg85aUhtqlXoCJZYG9PeljUtxVmCmne+XXVZprK3wg/ARWG0oCLmL1KgeIBHkjioI7vuXSVkls7XrkW2q/rRuE+Ocgk+4NU0QvQ2w+/qRWTaNOwMX0SuvT0PE0HMppVX/vPlfd81uSXqyJ7JZbZ56RT9Z5T6uBF6v/msSAz+GGTpkHXHqh7qO/hw==;5:YXFFlOEwZ64zkAjSg4P/WMf+x3IeWzXI0k8ez9g+L50xVELG5Iw1ORuWy8Ki1r4JPCpdHWZSlRDKJ1W0+I3aH2AzFR/XnlPhyn9dV3LMFyws/fokYHehq855Ps3NIKo3DRA1isqTNubF+FlbHeWfwaWnIjDsokk/GBZ8NNCh4tc=;24:3vaY2eEH1KqfYTYjU5Z+n0ePkacIVpgziVTEZiuHdLkmTzPxLCXztLIohai49L5Uhonvy3rTy//iVDUvCzVw3f0aHGi6XyhWtVKEKCHuHdk=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM6PR08MB3253;7:wyuPWUoKeO9bIeFJzmE3KQO9scspJClq0C8Y9DeDgThHOZpO+njWN4coWdbEtm4zoY2f8dYIC01IjDvm0WE5bMHEnH5xyfKCaAgJGeK062QRam4RLpQMOh/KXekwwpMLFiN+QS710IB/Beaq0j1GdM20HmrnIZHd6YBfrXxPJosloEpQOkMa2AMvpzM7rpTMzyY03DlnGiGjMzqd6IiGrFqWM4zJRRJ2Yl1Q1SfW2R8piyiwlF4KZrXPmwv7YJaS;20:gEVSWAZukLchpFdctZmb9N2AF/v1E8fhMSCiFzSoueczUARpKfhnE++Wa1oBmaxf3SzjeDoG2TKv4VNrwh+qvPNg8Vx2W3HbuRRa5cDUU+yfElTKRHVrgc3nz09vuNdWs9YWXohnUvFJOYJRDOlLl2s+B4+4yEjuN98qf6u/2eY=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2018 15:19:58.7494 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 68a1c54a-eed8-463c-6e29-08d590d18adb
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3253
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update some comments that become stale since transiton from per-zone
to per-node reclaim.

Signed-off-by: Andrey Ryabinin <aryabinin@virtuozzo.com>
Acked-by: Michal Hocko <mhocko@suse.com>
---
 mm/vmscan.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index 4390a8d5be41..6d74b12099bd 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -926,7 +926,7 @@ static unsigned long shrink_page_list(struct list_head *page_list,
 			(PageSwapCache(page) && (sc->gfp_mask & __GFP_IO));
 
 		/*
-		 * The number of dirty pages determines if a zone is marked
+		 * The number of dirty pages determines if a node is marked
 		 * reclaim_congested which affects wait_iff_congested. kswapd
 		 * will stall and start writing pages if the tail of the LRU
 		 * is all dirty unqueued pages.
@@ -1764,7 +1764,7 @@ shrink_inactive_list(unsigned long nr_to_scan, struct lruvec *lruvec,
 	 * as there is no guarantee the dirtying process is throttled in the
 	 * same way balance_dirty_pages() manages.
 	 *
-	 * Once a zone is flagged ZONE_WRITEBACK, kswapd will count the number
+	 * Once a node is flagged PGDAT_WRITEBACK, kswapd will count the number
 	 * of pages under pages flagged for immediate reclaim and stall if any
 	 * are encountered in the nr_immediate check below.
 	 */
@@ -1791,7 +1791,7 @@ shrink_inactive_list(unsigned long nr_to_scan, struct lruvec *lruvec,
 	 */
 	if (sane_reclaim(sc)) {
 		/*
-		 * Tag a zone as congested if all the dirty pages scanned were
+		 * Tag a node as congested if all the dirty pages scanned were
 		 * backed by a congested BDI and wait_iff_congested will stall.
 		 */
 		if (stat.nr_dirty && stat.nr_dirty == stat.nr_congested)
@@ -1812,7 +1812,7 @@ shrink_inactive_list(unsigned long nr_to_scan, struct lruvec *lruvec,
 	}
 
 	/*
-	 * Stall direct reclaim for IO completions if underlying BDIs or zone
+	 * Stall direct reclaim for IO completions if underlying BDIs and node
 	 * is congested. Allow kswapd to continue until it starts encountering
 	 * unqueued dirty pages or cycling through the LRU too quickly.
 	 */
@@ -3808,7 +3808,7 @@ static int __node_reclaim(struct pglist_data *pgdat, gfp_t gfp_mask, unsigned in
 
 	if (node_pagecache_reclaimable(pgdat) > pgdat->min_unmapped_pages) {
 		/*
-		 * Free memory by calling shrink zone with increasing
+		 * Free memory by calling shrink node with increasing
 		 * priorities until we have enough memory freed.
 		 */
 		do {
-- 
2.16.1
