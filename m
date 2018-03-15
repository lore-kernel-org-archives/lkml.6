Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752468AbeCOQrH (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 12:47:07 -0400
Received: from mail-db5eur01on0091.outbound.protection.outlook.com ([104.47.2.91]:63912
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751727AbeCOQpx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 12:45:53 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=aryabinin@virtuozzo.com;
From: Andrey Ryabinin <aryabinin@virtuozzo.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Mel Gorman <mgorman@techsingularity.net>, Tejun Heo <tj@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org
Subject: [PATCH 2/6] mm/vmscan: Update stale comments
Date: Thu, 15 Mar 2018 19:45:49 +0300
Message-Id: <20180315164553.17856-2-aryabinin@virtuozzo.com>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180315164553.17856-1-aryabinin@virtuozzo.com>
References: <20180315164553.17856-1-aryabinin@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [195.214.232.6]
X-ClientProxiedBy: HE1P192CA0012.EURP192.PROD.OUTLOOK.COM (2603:10a6:3:fe::22)
 To DB7PR08MB3257.eurprd08.prod.outlook.com (2603:10a6:5:1f::19)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e3217c04-2656-4d1d-ffe3-08d58a9435f5
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:DB7PR08MB3257;
X-Microsoft-Exchange-Diagnostics: 1;DB7PR08MB3257;3:RQ+IHfw8L0lPRBasRNERyy3yuIlOIFXRtb846kWISuf0LR5yK+2Lbmk6iqoe9WC+S7Oi4npgSiPrdOPpqd7mFZ867SNm3lNMvu/5RRgB9j/0aAX19rfODPEsTdQFYH3kU/oFLEBzl94RMD3RznQzmvIB05njmrxBwCs8zQsNtFz7ijc4ntlSajl9ostEbjFYe7pQJMBlZR0Alji7Ze+Nm6JSRXuCi6z8YPjXFn5hEhN72Ll3IA3a++mUICT8mNf1;25:yqvpy+684RO71W93670J4hKTAYx9yrbYQGAqaJFIuVTcIqVqE0EWAW+a9uyMjHVG0FDxjHJZdCreC0r3zwb4SVTiaGkerUv2IptDQRkr5WOlaf1Ip9QnYJOo6sotEOjElUVEbfxNewpH4go1z+hhQIwYydyKdVlx8xsYp0Z/4GZ2twphQyd1t3VNFDHo43d9icQBJM6h3ra7tDXD+LHG0RWOv/H++aKMlIIeVTjhS/LvSr15cl0kwVjot6yynWnkpPMAnFcDAbc0xpDGjNrphe2KlQZ+SNx7oQIHvO6q4Azuv1eMnGdiC9EvoDe0sxc18Zp90s4l4jajXMP7iV45JQ==;31:ncFwrAtWCsO1gz2Hcnr8r00/3kRwhzaVkoZdm+HSkAOnWKZj3SM2uvStBqkz9NFvtXENNIFGiQuG7ulFxjBsKWD8mSU7NW25OjaHtW1XezvFmzZi66zTFT5FSKQOl0bSBTZQ3T1KMbOEnAC2Ec1b3biRuFOUccKzlcOtjOkn/QUsi7KuUWOwxZP2HDtWR0SMDEDWuS0aHfghCXsABUCi/R81MFpAqQ2oc39hRcqhrPE=
X-MS-TrafficTypeDiagnostic: DB7PR08MB3257:
X-Microsoft-Exchange-Diagnostics: 1;DB7PR08MB3257;20:C9zYOu3SWQMH3PwbSHqRF+LZ17/bm7ykYbng6SMR+1dn6r7CDPN7JVPNwZKF3rWdU/VMt9WZNcN2fGFqxMFx3Nm8U0D7oditkGDYbVUIdGsFH8hJzZn9e1hEfOmVwcqMWD3/J0l83JIHrIING6I4aI3qrwPBT1k0autw1xxJo9XYLzSKEdMzFyoUsyep9R1Z88Fs9RP5I9rtEGb4uT0XgAO7Gp66eGthTfIiqqbog3psNlpjumT0Vi2o7zz2kkKTvrsv3h7CBQ/F+3NdkW/AEdwGZuLlVUnpQEdI5mEfQ8mXlluouuYdtvlWU/JSgkxquJV6MDpyln7lgzxWFL6nG7oc8m4GJ3OpPpIpuKnrOT1xhu8qPWb0yrSNZXLe7OCHlG1Otzac8IhBOTPlVDctqw1+h7HGpUOZlk4FvDg1a1rLSI+wcH+Dl3BO+559MdLdJgUwrbuagaxV1oiRzgGVT0bPYUrGjRjLaND4ZyW7gB/OZOklZoW/h2eH9NswzziX;4:jJVnuHLh7RO7Dt1xBMKFyTRYq748IciNKi2sTpwdYtqnBbBEhmMji6W4ZhrkPCTkjajFJmZBKLhh2VxmhIBYtdGuO/BX5mZuTB8N0e9emgNhlP/3k6P1tdLm430l71BPmzc0+hXrkjHK+GSyCM5qNFBPHbyNUP/Hnzg0MvKTY2QCFZhbLE0w0DsU0gCwXvWtUZgxejT6SLFebEITd+ftuT507tTORlEEw96FKlZa4+6EClGtGGDQ+yanWIbGcJzIJ2Oj5BlOzNsSKZJWNks2tQ==
X-Microsoft-Antispam-PRVS: <DB7PR08MB3257DF236D1A26DB7CE186D2B0D00@DB7PR08MB3257.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3231221)(944501244)(52105095)(93006095)(93001095)(3002001)(10201501046)(6041310)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(20161123562045)(6072148)(201708071742011);SRVR:DB7PR08MB3257;BCL:0;PCL:0;RULEID:;SRVR:DB7PR08MB3257;
X-Forefront-PRVS: 0612E553B4
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(376002)(396003)(366004)(39380400002)(39850400004)(346002)(189003)(199004)(51416003)(106356001)(8936002)(55236004)(59450400001)(36756003)(7736002)(6116002)(1076002)(6506007)(386003)(3846002)(47776003)(6512007)(105586002)(16526019)(186003)(86362001)(54906003)(5660300001)(66066001)(15650500001)(305945005)(53936002)(316002)(81166006)(4326008)(6486002)(50466002)(53416004)(68736007)(16586007)(2950100002)(26005)(52116002)(478600001)(2906002)(81156014)(50226002)(76176011)(97736004)(25786009)(48376002)(8676002)(6916009);DIR:OUT;SFP:1102;SCL:1;SRVR:DB7PR08MB3257;H:i7.sw.ru;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DB7PR08MB3257;23:nlQGQP+z9jJLHr8z+PRZ5psdrQHRpYDrSd3nnHNLM?=
 =?us-ascii?Q?dGycrQyb5mvA9sE1fNM8+ABZx2/Hfhqj/lZYrqObU/A14/WziSeAd0ciWjv6?=
 =?us-ascii?Q?Di/0ZonbeA7igW3UugH/Mxbm7VSuFdrhAdP45A6njFXTgoaCx6qIKyOWMnHq?=
 =?us-ascii?Q?VrC6Y4URm2D8J2J/ObAOqBtEyAXwmfLIuUFyNiWyt9Vdclcp9QFUZylSXREI?=
 =?us-ascii?Q?mEYVwYd41csoy30PcFX5ZuNssy2VoeL9BD8bSNIxDHWgj9Rg+RnxrdHAA7rd?=
 =?us-ascii?Q?OJb+lxnPOFXLYy+B2pKzWi5TQnn4ZBzJhVpdVxbQTUk4stWrn1M8RaEQyToA?=
 =?us-ascii?Q?hepNKZLrSRjWg43ph3Vxd8lxAn32XQxAcC0gBSi2QTsytURp9exx2N5ermC1?=
 =?us-ascii?Q?eNGzkZtJ1azzVcPsbiLE9UYy5COn5NUAXIcavwzDd1CYpr8EAZ7jZ1aycRf7?=
 =?us-ascii?Q?N0Oo3qt9HHyHc14uAUz1/EWV4M2UE8p7+t41b8WbbzWJLqCy69DxhSRq/Gb/?=
 =?us-ascii?Q?BeEo712ydPrVxCn+TvZZSV1b/adNkadjeW5ZyrjHkZpXq9WVnMji9qxBPR2q?=
 =?us-ascii?Q?N82nWG8E0GxIkLWg8vtrDJEzZVuEEQtRkew+SnFk/DRRgF1nl1r3qyZlLFBu?=
 =?us-ascii?Q?qcXMLu4bkDzuxU/XZZDfKAdbFDXgEQ3H0Klwh33PBWqaDJZ55kfvdewAkSHW?=
 =?us-ascii?Q?/pPeUKsZ1fpf/Y5P+VL21Yh2EHZqrSHVxkLd+kA301sOZp3DsevM2RTuTWpv?=
 =?us-ascii?Q?4rxHvJD7w7SDh86kS13En1qXRBUX/sIiOh5R9FZhdQvfoOuWHvvdYSm6uZmS?=
 =?us-ascii?Q?G2KupMb6mt56YQ1ttI6SDhUFMB/Fs9VxSeVseyHQzXR+HfcXAlu16TtOSxxX?=
 =?us-ascii?Q?KUuSAAhlWuuvSB3lSLLwEUkfP7p4HQOb7G6yGgjW2yik3VnOfSOYWZOd0dbq?=
 =?us-ascii?Q?TSOMXmriBCSwtUhqw/nkK6oI+putLZmJtqDKdQMuzvehBjZCD4DEhMe6AO1M?=
 =?us-ascii?Q?KZTipKctSMmmFTqU+n5Mn9GcRjq0aOe+u3oJsxq/eWRUZzvh4BUiJThL8Jg5?=
 =?us-ascii?Q?BB4Yrb74I/HJ41JkqvQ4J+5z4if7IpRGgPGvwb6/7jzgG84QhvwBHzarhf8t?=
 =?us-ascii?Q?T3K83dCYOk3hDFVvffF2Bb4nq8UapE/kucE5nQDdYID9iqY1lqWIqzb2hafZ?=
 =?us-ascii?Q?5/l0r22SQ8/dobbfXZ+m6Fe1iMvnYTOnALf8SzWrPnorjMkyUd+SWNKMA=3D?=
 =?us-ascii?Q?=3D?=
X-Microsoft-Antispam-Message-Info: LHK8ygVmrAd7A1Gbj9tSDe40L8y1Z+eFh+27cvG0IxXbfvEqovD9J1RnLaF7zlrdWHmOjSY8VWWrCizhuTL2cA3pxZUusfH5noi3209KttauTIZRNn8w4tEcdInJ0fe9r/kTjOC6qRj5lyvQocQOAaYE8TlQDvVsj2hDhtA9QT0ShRhbBqnN4aBg2IB1ZhJs
X-Microsoft-Exchange-Diagnostics: 1;DB7PR08MB3257;6:d6PM6eCOKodLCmiuSWp/PqEjcr/msJSbGsueGxmn91uRzjuRl8oTJTpoVk66/Uy8PJebDjU8us/MepLGCNRNs9Vx7SCPNK8etLMC8pMkO901Llq4qRBVlsBB9gofjSrz3fLsenz0pRs23EnjvnGeIqOf+RpiDKAcsMguUIvxN0B1t6E8/WYpVgd7VwROCjWn/UvISZBWT7r5GllvYd6r/lXPt3j0IpcFPNw8vSrF0QL83g+f9TwzuJvc95ZzIeFxyw9lxDEb7hum4XzfwDHg0PXAsHQIRJEKzmuZ69fZ9pskeEeavPOQWkwddMQI2GldG77cJMbfLhU1gQ2P/MH1A9jor8rUJit/vw2u48UjGEE=;5:xFpbE/yjxGU3yVtcY9qSgXIUkbOcz/MBKLIzsoH9wSl3bsjlyLudyBCASH4JHa2IVGNI7DjgeNyCnz0myalcF6USbyJsu8L4CqvAgvIoFZG24R57CRMttAsHwX0Oy5G9B6/gOo+jD2H/geRu+42eZf0zqngFGpJjIX6oNb3MytA=;24:B8PZOhZMtq3zu5WG12ut92VfSLubgUeoCVFjmJp0vC1aEoMfJsO1D5V+vGDiNWXC9/NcXt4z+Xp8CdJ9P2OZaqzNZfY5ywSZJMY1+GB4L80=;7:a+zgyGx6wOwPqOTzuobkqDLgqlEdbPrvk+MJgPmTsZrVDpNQGCVF8WOF75jxwMKJ/hvrPMnGmNz9I2VigzYfVpEDriJw4um5sXhjtx+ff0q+Uvt7D3mGkLBNDPGOvz4RzigvK/jiTsj5h5Jj7HbfhsrCX6+9hUtiCrsFVEsrbpiNZPvGYXuN6vf3/O5lIkIasHDd/dYSfZsOd4ZI/XPwQhBSW+mT2w0v09Acyh9d0iHe+mK/vkNV0AvAaJC79YUC
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DB7PR08MB3257;20:gsAEoy50+AhlByw6eW6ML5LnWYkO9dUyR8LHIONZnmyGhVC9Xac4KGF+QwXdBRdTdowhh0etoJggJLq/uj9ECxPufNnB4mQsuwt0DaTdIpEmQpMKPJhyP1yIg2J+iuxsliUe5SmfPlO+aZFoD8O8VjixYcxwmM9rHB4qw39NU9A=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2018 16:45:49.9462 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e3217c04-2656-4d1d-ffe3-08d58a9435f5
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR08MB3257
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update some comments that become stale since transiton from per-zone
to per-node reclaim.

Signed-off-by: Andrey Ryabinin <aryabinin@virtuozzo.com>
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
