Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751527AbeCNWVq (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 18:21:46 -0400
Received: from mail-by2nam03on0074.outbound.protection.outlook.com ([104.47.42.74]:26976
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751131AbeCNWVo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 18:21:44 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Gary.Hook@amd.com;
Subject: [PATCH] Documentation/CodingStyle: Add an example for braces
From: Gary R Hook <gary.hook@amd.com>
To: linux-doc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, corbet@lwn.net
Date: Wed, 14 Mar 2018 17:21:38 -0500
Message-ID: <152106609844.18780.6843553697430932588.stgit@taos>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [165.204.78.1]
X-ClientProxiedBy: DM5PR07CA0044.namprd07.prod.outlook.com
 (2603:10b6:3:16::30) To SN1PR12MB0702.namprd12.prod.outlook.com
 (2a01:111:e400:c42a::16)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: d42a67a2-da6d-4fd6-3737-08d589f9f68a
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:SN1PR12MB0702;
X-Microsoft-Exchange-Diagnostics: 1;SN1PR12MB0702;3:ClxpLY6NkKiR7OoWFp8xsMGUE2GI+Oy4KfzqTv263o+VKtHUBm5kPKg9eVWopKmVxnT7t1+1BIFxVOx8qEZHDtEAh3h0nmEmU5kZsPGU8NlZLNj0qhEaI1TncK52IGtpmLNWTJVrbAHurva9KysX6ItOTIA1gqnwfT98rPEG0niiJEqZIWlhO/eHE7mB1y/og+1JRtJF2kVFt8Ii8uc3wd3WWv1P/6fuOHchBQ5dnaeuh1v89hm4UFWMByjF1PUl;25:lwGW1yGzMpyOSMNBE5WYSJmnym+odcf/0IFpDVDeqmvttNHkJzL+fsSYwAzYBjhWg1o7yz9Zq6uIKatrZOl5Cn8NosCP6mWE4ahNbPEL+L1iS8NMlvYavfLi9+ZlK4TWVgUOtb+N3jhXifocqoRX5fE3uXlzpeTJsv+jbQNaSMARa3xzhlMvKmvY2c3KJixRZvqPV8Dl6SJRrAFbrTe0BWufQM6IFiPcN7ep6b7TEKSiRNbvxpSWpYdZEaL5lRm0NWx1hXyq8R4alYLJ0dfdtFBjqkHvNO0lShJkBWbNfqtLAFb05Kr71K6hf39BVsqVhMxgi757sbZPBegdshIiZKgwnDeGdhPmdUfABkupoDQ=;31:lAArAo4vwyCW2o2NUFoyehEkU1CVTc8JAxWRBA3bXhYknXtDCpMvrutjgEg5UEcqDyFdp+P7SzfXxLqlwjT8BIkgr5c9j6MVhA2uzb5Vu2EcJl6URQdOcqaqXduZpMGr9njVkd/7g1QN6v27O2d/XP91/Wovlcluujerl4GcoLwnWcv5yM9yafigOJjxESnroYHfz6XdNziiv+jzAgGTN8aaUeNpQiYWIHESu6ikT44=
X-MS-TrafficTypeDiagnostic: SN1PR12MB0702:
X-Microsoft-Exchange-Diagnostics: 1;SN1PR12MB0702;20:b5m6HIvB22WqxtjSP4GqHNPNu34yrI9Q4UtaYMmzRFb3NSkq04FRve+7//Ku76mxsd8NqzGmlt9pZBIMrUOMQMwE29+yH7P4LJMJl9i7/CYh5dd5tZpsHA3EvdeTzXTi1RMWTTa9A2Mxgv6HM+8AKrvsbGgn1pzc/Vyl2qgYlRgZpYCaBZ3KjU7g9wzxaie5AHHOSpcWSqZ0InE5kd8CKhqx0hamVg0+Q2fZjqydzP89aToFH32/5d70TZ4Judfc7CXrfwOL5VD8jfdn8zJsXjawHKWniAXHYy7JxnUAV5wlKXKVgpNV+FjgGUe8dn72LF6+grEf+9clfP+J7ZRYT+cdsOJgzBY4eV+JnlfmQPt0C9BMirBBRaR+0Bx+87PoX1s6H/hDkWBSLPK4xvHfea2BPz9QBASUsluAdIfxdwniToD9AAX7odPUx8k66KitxImgclQnzJ+AuNqFivh2FinLX5MF1+WDv1QdXmN9gBUS5JCAIWXYFvlMenNfdn9D;4:hY0/oxVOhTI1CNk6ePj08U1u6EHrCt6pnI0BEWc02LbK+0qacrqvgajEljyBduZH3xqEbDXpqjkaWA5VFMnZTGeLRjxgYUPmOwiL99wPRKzzdNPEmU+x3uQGQxdqU+XTRu/hoTU/BnZumPnldwohoS+kTl4iuHkGbrwndhBPQuBgcZVJGy3vJrgbwPB+zk5CNNC/r078rld7M4NcpM7mTFj3FCkIPDsQ7GQd0Xg9Fj6b6HmAY0IuZkRiXqWw6v0nsKF/+WIPdvnwWBAcCPaoZgQAklY/EkN/UWo9uE6Wfvo5/eFswMH9N8eKFGCa6JH/
X-Microsoft-Antispam-PRVS: <SN1PR12MB070244AB15CB0DA9F081F1D3FDD10@SN1PR12MB0702.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(767451399110);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501244)(52105095)(93006095)(93001095)(3002001)(10201501046)(6055026)(6041310)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011);SRVR:SN1PR12MB0702;BCL:0;PCL:0;RULEID:;SRVR:SN1PR12MB0702;
X-Forefront-PRVS: 0611A21987
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(7916004)(376002)(346002)(396003)(39860400002)(366004)(39380400002)(199004)(189003)(103116003)(316002)(478600001)(6666003)(7736002)(33716001)(16526019)(6916009)(230700001)(105586002)(72206003)(5660300001)(6486002)(97736004)(8676002)(81156014)(81166006)(8936002)(50466002)(33896004)(25786009)(6116002)(9686003)(4326008)(53936002)(186003)(23676004)(77096007)(305945005)(386003)(2486003)(2906002)(16576012)(58126008)(86362001)(68736007)(3846002)(1857600001)(47776003)(2361001)(2351001)(26005)(66066001)(106356001)(52116002);DIR:OUT;SFP:1101;SCL:1;SRVR:SN1PR12MB0702;H:[127.0.1.1];FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtTTjFQUjEyTUIwNzAyOzIzOk00N1N2TjlwMVJCWVdUL1AvdzQxUWFmZWI0?=
 =?utf-8?B?ZUpqQU1QQll1QXY3ekYrdVJ5T3dNS3VpU1JudlZrNG45anB0bVpzQVNzSVM1?=
 =?utf-8?B?b1BueHNjZXZVTmZGU0xDZ0s1NDN6ZDE2cnNoVi9yWGE5dUovZ2s0TzdaalFD?=
 =?utf-8?B?Q3NJQUY1QllRaFVDL3pQUTFrM3V5cDRuR3hEdTR4ZGMrWlc3QU16aEMrOG11?=
 =?utf-8?B?U2RaYkg3SXI1V25ENVdqZGI5ZzNrbWp5azJlSk42eFUzRldZdW1pN1FXVldi?=
 =?utf-8?B?a0R2ZlFoaENXYjFUajRiWFZ3dStta0Z0WHpIaTd6K3cwZi9NNEQ4ZXArUTdh?=
 =?utf-8?B?R24rc1FteTM3eDVVNnFZWDJYV1ZKL3ZLUjd0d2RHYmZtcm13VlJmeEl6aG5C?=
 =?utf-8?B?OEFINkQxbElqTzllYnBwN1Zjc2xaTlBWdVZxK1owK0ZIZmZ3algvUkVCdklr?=
 =?utf-8?B?bzRRWTNZTG1aOXZ5ZUNrTjJXdXhwY1JINjdhaHEwK3JkaUwva1duL0xobjZ6?=
 =?utf-8?B?ejdxOU1MZERlRWpzNVlrdWcySmM1UGlmejhVNDVmUkkyTlhMZzJvZG0xK01T?=
 =?utf-8?B?dnpiRXpDb1FDNU9EcGFETTljR1VCZG5hTno5bk4wNllGYnJpQk16cmJtbStU?=
 =?utf-8?B?bDhtYTRERkJRVDB4Ynd2VkdnOXlPSkF5TDlCMVRTVVNDZ2x3eWtPVkRJZEJS?=
 =?utf-8?B?M3ZXLzRHL09KVEdncEZ2TDBUdzdNV1N1Mnk1WFBManJYVGxJVUtxYkw4bGJJ?=
 =?utf-8?B?OFJ0UHc3OUt5VjlwY1Y2bHJuTlRDWnViN0dISjZibW1DVkROclBBQ2tJMVZR?=
 =?utf-8?B?YjRGUzIvU3Fpb0Z6Nldmd0k4ZzRtNnc2UVpYK3h4WTJLVU01OThhWFZsUFY5?=
 =?utf-8?B?SmphSG0wWDBjbkk5azlSTHRPMkl4R05FNUZyUXUvcElXQXk0cHB5elQ1aGtj?=
 =?utf-8?B?R2VqaGdBbkU1SDNqMGJHQVZBUGlCVHZuM1M0dzlSYVRoL3h6VENHNUQyNzFK?=
 =?utf-8?B?Qm5DWVhrTTZmTUxvWURURWZJd3U3a0MrTkxYYlA1V2J3RWovbXY1SkJqa2VW?=
 =?utf-8?B?VWw0TkZSV0NQeGpKdTM3NFlnTXo5TlNxdWpjZndYMEt4ZnlHRWN0VE1XbGZz?=
 =?utf-8?B?Um9RUUR5NHZvSENPN1M5d0FPbTh1MmJWWTI5dWRsVFpyd3M2OGVoZ0ppbkJi?=
 =?utf-8?B?WVp5R3BQRE9ONzhKTE43SnNaMCtoQWtBKzFlQlI2aHJUMmtQc3YwcFkyS0Ny?=
 =?utf-8?B?cnJWd0NmWEJQa252a0VVVmVUMVV2cW1JNmdlL1lCZmtTVnd6Rkl6RGZGR2hv?=
 =?utf-8?B?U1Nab014ODcyWWVTNXUzOWovMlBabitLUjFxRHI2aW1VWHc1S0x3NXhBWjg3?=
 =?utf-8?B?NEt0MjJodVV5TGN6NWhCS3VsUVFCM2FpS1hwT0YvK3JlYWF1WUp2eUEvYURJ?=
 =?utf-8?B?ZG1BaHhDTTI4SnFhUHg4cmNPZWxhdlRjRjlYVkt6RUJaV1ZXeDVQK0RDNjlK?=
 =?utf-8?B?U0FBczVSTWZjQllrQW5UZkMyRXkwZTltOGVacDN3c1JoajloMW5zeWJFV3ow?=
 =?utf-8?B?VU1tTEMrRjlBZnZwQ3Q4YWo2a3pwOUZudjdtZk9keUcxK0lEWXpJaTBHQklh?=
 =?utf-8?B?dHl0WjNWbUMrMGN2dENudkVrVzBSMzVEL3dHRlpUYjl0ZnJZWm1YU3RZbUQv?=
 =?utf-8?Q?/Y7zO/vPQ/on/vJSXU=3D?=
X-Microsoft-Antispam-Message-Info: diQF1/xYm9bo0bjfAh0Hv067DBB44zKhqqmIv3Sxt1zrkwprKbzeuNn5UqFgCBchghbySE2qbBO9alDGQ8CiSpAhOaxdVihc56cQBRzky3tY9U9CtbbchCL8BKEFV2g532lhpB4/qYY0A6LL7ZGdeWEaHhWOUetE3eCvRDo9lV8abRqKNpSkGRAviZ8X9Jrv
X-Microsoft-Exchange-Diagnostics: 1;SN1PR12MB0702;6:EFm/DZRzD9r9lgi4DDcidkbgyxg+smYG8JUgHVduGlu/NP+ElEGfhFljXg6k3V4JgcsL1IxxuBI4EobGCq38TPLNKqOTCNH9ifah6M4RSK8XnfERn5af13I2KnLv6ZrSsWQYMZ5iz7PJ4Ytt38+pI+jefQhrrBnxDO2c3w2p2gQYCwwfpiYV15Yk71M9llL+scFZlcN0PV7BUr8H9MYYBEqTzS30hqPrEIHNZtbPXYkfdePeuTzSG0IwjNs9Aa6FrtUzCJt6bdYSlj6QPfPHxHoR1lLaoGS6HWs3dlXfhcnoUEB0uTlPzk91X2lvcNKRnFuM9SQLcNOwHatU7y2oNrG9N8WMqG+6W8Lgs3YNT4Y=;5:16945tmv3HE9p8+vGXq0LYkL93w9OUWQe4YWqG/BZuCO0sFEqujlLmBESS5OzLzMsmPxSh2+3Vxnt1bDCRxDUpJerDB8Xc25Ce0oocS5zfJro5Ky2rU6jaFUfZqKypb14Of50H/AdNYuXr0j9e5V/+JAQM3ZCCqvSbJWRwWXHUM=;24:JYr+yYgtePEvT7RqIY3/m6fAt32qWbE0XSP9unX/ypHWpVXdSeroAjU+L2hSHp7tNyiyb+IkM/OvUg1rJ+sNA6AdvYoyjLjS240nKY9HdLc=;7:HVseFYGVLbQwb1ew0qeEqZq1T2Z5WORVs7HNqDWoEP0HdrlyBgGVzYQ1w80YRaGGcJ9xpeRSmhKujDLotRGYf4UG1HrnFFgHjOM4mvTeOM2LrC92ZZvBLK/AVMbQK7DzgbLyA+ya1SYF1cWZYHSNmgYUN1mRNxLJO6/p0TNjMypkdPtKsR/I4f8thAU5aEIZxH9VQMJ9c0b8vH8jDTsBgmsKp52JbIA9uBAOnw3L1q2ZAu+GSexYVHRNCLy7WzZd
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;SN1PR12MB0702;20:grSLgxEgLA5srR0PPbMiO72q0QUnev+ESqrIavXFwFLIokMqtK3+c8dTP6kc5UJDc+6T778/nzdXHD8JvqzNhk8JvmyExvSTlPcTpjJQMhgPwk7FU1cwfqsRkUKXPkaO9FUV+nK9Ho4AqtToiIGE4B6DZPBwPZO9sv/XzgKELC3etkXFpy14rLWi6lQg1O0tOpgW9404g1xtQdr0rCVKYe9nWu1iGlJIQ6C6QTA88LrGGcJlgy0zQCmiL7y+bdIy
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2018 22:21:41.5627 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d42a67a2-da6d-4fd6-3737-08d589f9f68a
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB0702
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add another example of required braces when using a compound statement in
a loop.

Signed-off-by: Gary R Hook <gary.hook@amd.com>
---
 Documentation/process/coding-style.rst |    9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/Documentation/process/coding-style.rst b/Documentation/process/coding-style.rst
index a20b44a40ec4..d98deb62c400 100644
--- a/Documentation/process/coding-style.rst
+++ b/Documentation/process/coding-style.rst
@@ -200,6 +200,15 @@ statement; in the latter case use braces in both branches:
 		otherwise();
 	}
 
+Also, use braces when a loop contains more than a single simple statement:
+
+.. code-block:: c
+
+	while (condition) {
+		if (test)
+			do_something();
+	}
+
 3.1) Spaces
 ***********
 
