Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752162AbeEPXLd (ORCPT <rfc822;w@1wt.eu>);
        Wed, 16 May 2018 19:11:33 -0400
Received: from mail-cys01nam02on0060.outbound.protection.outlook.com ([104.47.37.60]:14784
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752059AbeEPXLW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 May 2018 19:11:22 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=sherry.hurwitz@amd.com;
From: Sherry Hurwitz <sherry.hurwitz@amd.com>
To: linux-firmware@kernel.org
Cc: linux-kernel@vger.kernel.org, suravee.suthikulpanit@amd.com,
        sherry.hurwitz@amd.com
Subject: [PATCH 1/1] linux-firmware: Update AMD cpu microcode
Date: Wed, 16 May 2018 18:10:48 -0500
Message-Id: <1526512248-54510-1-git-send-email-sherry.hurwitz@amd.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [165.204.77.1]
X-ClientProxiedBy: SN2PR01CA0023.prod.exchangelabs.com (2603:10b6:804:2::33)
 To CY4PR1201MB2518.namprd12.prod.outlook.com (2603:10b6:903:d6::23)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(2017052603328)(7153060)(7193020);SRVR:CY4PR1201MB2518;
X-Microsoft-Exchange-Diagnostics: 1;CY4PR1201MB2518;3:Ixd71D4ecTNV59AljflyJRUgezvZy4kyIhZmehhXA7FC/Zhed7OGAnc6YN+n3xk3wHqVVJN0vPFFwBhrZfC8jrIsRyZGCfrj6i4g/pY6NwlEHYQilaWUfALHuyZ5yCB5JbP5X6ncqmLtxY088UbXVQz4LoXPOXaCCSemZlxZvzXcDPBSKcR+8w45w5ssW5P8kHx6nqMCn6NPJ7zDS5s0vSLy8zbZtXT1rYZQEQlOZsLec/pTwXRVNSEcTy/FNYg/;25:xlw0wOEzZIBfysMaSfqs7r2qP/PajiRMGQTo+GNFRQBpUfWXAYHRZvc63QVqFwKQK3rKG8eujOHi6Yl0v+nZdwo86hxlPOakrWsD/VEkPdbgJdvH87JPk/e+W6cqYkcGRy8w55t5ZQAgs6IcIk83DXwCC2Mxpj0HRhybisnU0ejcJCbpTIpDhBA3P2x7skeY59+VRLQnj6ba4zh4+0w9UvGVp+Mw+8GeTUfRUX636J0zYI12GDDpQmJKEB2na3hfEQu5Qr0IysA6V8x5VZ64fiRZak5CwmVEz6Kqh2z9pknPMutx57rZF+a9RPxvFf2tJ8x0j7smnXV+qSxoy4TkYQ==;31:FIRydnPAetx/NArUoyP/gBZ1jicVLf0MAhJqS1jIKltR/gsQyqdMkJ6FlkRLiDg7jivXgSld1I8P8I29LwPWuM07yB7oSUjBUXc6DAh8eRjp68gKKrnlZxE839vJuY4ph7ZRym6UhL38USJTsAyOvRc+l973dZOOSa6V3K8+/4JV7MP1y3dPA35FFlWWUGdmHPaFXf6I0UxFKa4EKUXfIxLOk/x1EkI+seQpggYXmRI=
X-MS-TrafficTypeDiagnostic: CY4PR1201MB2518:
X-Microsoft-Exchange-Diagnostics: 1;CY4PR1201MB2518;20:X3jGGLWQDj1j5ICUSsPzs3O7HgMA2sbrkzcWBJTRzPDkiKusoVTaQBbhZSWdrC+JqIusUNZkW4nlEgLbGar2r4J36JBpFxLX0DGPIhRqE0/ULF9Pp7Xfa8+CrE0babw4WG9RNcx9ch9jf0TyLAS1l5BjwryuH95enrzbzRhW5tquIAyRT7vONjRc7KxSKDlh51W2qa25OI01Gzst0JGgXUO6vevfugwQvLzxnSoSD3bH5ZRut0K7PQVgOUpdS5uEeqtgVbxK9Wl3H3+Iz0aUNApwVaqHJIpSAy1fKTLcnNSsGlmMp74L7OQM9gSSGzwVLx3Jdribp5OkxXdmy5gkQJiDw1lymguTz2F3+s1ufTjWc0Mf+cbr6DsRRzVmK6O11M2c4bCEq9iNGXQt5TIQYg3CPLd/cB4VZtlZ1vRlzXb3k9bJ4llkPFPpfn8bIJFFztMdT0QXFatq7xmSIyhxyqhaRBZBygHKRLAaMMkK+b8JR3rCtCWjGD/0DADJqqhv;4:poCU9/Nuo8jHVxMqGAfeROdnerd5bWH4UUiJEThUQIW/WsX4SBAwFG4whtoBv8QlkW/OUBo/SDfRUgu2FlCnQA6gwO1rIAGiNlUnsjugXOBmuScfNg9WcFitkG1J/rOSeI4h+8I/KCpjGmOlVkd6HkBfu1WBW18H5XQ408x+2JsXivkekfN8+LXmqcRsI7ElZnubmQ74BlU9wMFD47wEPgw0FXklHnzP8zY6xu9O+OoXyVrSHkSDSBcPHCTCFEqYMWC2gs0kAjZNCzawNpwBHWMYa/Q0UU08ucfKexIUA5sHde6AqxfDIUzavtwsvVtr
X-Microsoft-Antispam-PRVS: <CY4PR1201MB251815ADBC54DE9A5C330EC28B920@CY4PR1201MB2518.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(767451399110);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231254)(944501410)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123564045)(20161123562045)(6072148)(201708071742011);SRVR:CY4PR1201MB2518;BCL:0;PCL:0;RULEID:;SRVR:CY4PR1201MB2518;
X-Forefront-PRVS: 0674DC6DD3
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(39380400002)(346002)(376002)(39860400002)(396003)(366004)(377424004)(189003)(199004)(486006)(66066001)(305945005)(7736002)(97736004)(48376002)(2361001)(47776003)(4001150100001)(2351001)(59450400001)(4326008)(50226002)(2616005)(316002)(16586007)(476003)(5660300001)(956004)(16526019)(3846002)(186003)(6116002)(52116002)(7696005)(51416003)(6666003)(6916009)(81166006)(478600001)(106356001)(36756003)(53416004)(8936002)(25786009)(8676002)(26005)(386003)(6486002)(2906002)(50466002)(53936002)(105586002)(68736007)(81156014)(44832011)(86362001)(575784001)(15650500001);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR1201MB2518;H:amd-ubuntu-1404.amd.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CY4PR1201MB2518;23:KmcwdgaiIexwyNSmYDkXGvdbRHUyzMzvoepP1zo?=
 =?us-ascii?Q?9W3JrYiSxJyxPM1arh4HCnMaUwisjUyALaVywadhx5R0qnIgU8/XjMfbbVeY?=
 =?us-ascii?Q?3SulrPS9wZ/+q+2PAlw53NeHIwSv2AW2wkb4GDZVJNNg5bl+n3ZDP4hFAkV0?=
 =?us-ascii?Q?smzTtSI0guGO8lNDsnoLCjyMdXHCC1qNlIoB+VbttfGWuQsuKtZsJfS+07ZL?=
 =?us-ascii?Q?ZQmT/7lIw9UGlj1Avxpsz9v0XTQcvez59rz7W3rxkVUVEQCye/L3FXQYYiol?=
 =?us-ascii?Q?0m8cwyF7fFYEVcoxo31Oug9OH7dXvcChsbmbE69HbrE3Vj4T3Vc7IHvsx9xq?=
 =?us-ascii?Q?2RzKsaaoLCQClSWA8Q95F1ngLZ/WfSO/cM0J8IX+ji1oxHyyDukTdptEEzy3?=
 =?us-ascii?Q?r58HPqQbRDH4HzFvHofxq4Mlj5Zk74q2nE1fen+O5yh3aaPp1oQW3d6kUtda?=
 =?us-ascii?Q?CJrX/nvpFcUF3gu5f7umi9aCiIXygYI2cT6LZwr8jH/ohZn1g3nWPNOxwP6o?=
 =?us-ascii?Q?GCwQoYSLr6xpAv23qfOGgJ4XbSdCMc48/YWwsxORL8KdjjuLpnjPYswZzbgq?=
 =?us-ascii?Q?hS6xrdXSJKWuA0/UMsJkvbeVOrmM2zVOOzT2wxGyAKz7qjN4QtnDFRDgpMA/?=
 =?us-ascii?Q?e7g9kZ0lkAhbsjy0lITJzpUaX+0YcSQ488Z9IOIe31Z67gTA+BKvJwFU1fqZ?=
 =?us-ascii?Q?epWZ/Zf7ZqjeVgp2BQkO85ORehTDKMzGk3XzM+gpVLISpFboPebRQYPgxHT5?=
 =?us-ascii?Q?rdvgLwdgGS/DHXM5GOyxjsMCwJySq1PX2C4KWgt8RlbnJsWWcIsHroSV14M9?=
 =?us-ascii?Q?01bJXMCH3Rr5wfptS56WfG5WF0F8WracLOnsljIYaHbuefvMB32TByH5Oz28?=
 =?us-ascii?Q?hR7Vji5Mse0t6tZTChsSBPB1yFo9JJxsuqSBK9LQU8GV4jKWi8hwOmiSKbga?=
 =?us-ascii?Q?vCAWMYe/TmmAiKN0J1xsDMTBFWmtb6A/eJsbbO+hQ0/cZdzccAJY0IGDasTi?=
 =?us-ascii?Q?5xqrcX8DYLf828Nr9LBXadvCKvLE2kkoSYR1qwjZqcJZ6coVqKJRpXajtC9a?=
 =?us-ascii?Q?vpKV4HSIbJgSG7xPphQvApon8GsH784I+8YK8JZyqg+Ixx5jTrjLLLTpUf0Y?=
 =?us-ascii?Q?WfAucOK9wSk4S+vuTL6XxMRV4KDQmzuU9tX5l3di+c2cOpd7fVaqi5/ufQdg?=
 =?us-ascii?Q?HwvEidO/bKZX1o9BOENsVjR0t+TO71PvDDpdOdNPt/p2krF3OHXuV4xCFOke?=
 =?us-ascii?Q?R/9mXSe5lg5JRd/qGaUWh/KRzJELXJ7IBcBnBb7Gcj2xokRS6C+a998D3l7E?=
 =?us-ascii?Q?jvlNiCdSUTX7s/GBWXyrwxj4=3D?=
X-Microsoft-Antispam-Message-Info: R2YkQq97JZVcxct5xAqHTUEu3csO6+ihVxX2ocyzkyTkBPG9Lpi6wrgrC4nClNDctiIPDhQa4rUX7h1bHEnJxQOzmM4HXYvEkoD2M0pj8xXL06zoXj/bzeN6vrnNZ+LAyIhxuZmQx17l64BXTMOweXM5AKCpf9X/qzRGsRhDyF5DLZC/lm++t4g1vLMG2npH
X-Microsoft-Exchange-Diagnostics: 1;CY4PR1201MB2518;6:z9pb4DlrPjlgrcEWb3Jal34wrNGp47rBzNgtseq2BTkjw0d3bNGZTA50OvP8sPpPFX4mqtDsdDn+BqAlo1Ioqa8PLBIJhOpvhx8150hJMBUQsDM7K8OoIp19N2vZqhquuXXb0TR7uSKVkGo1JqD7XXgmhdJEiqGNwbX5oYUqmNoFVsaWjMc+P8vbirvrODFVaB/zjmUBzMI2tWp72qMQ1IazgE2TFZgITc6vwLUvEmePCOGXqmo9KUFXMPwg6j8Ycz/A/3R9rWx9CXJY7+YkT1c19YaEYWFGVyO1fnF0/EKVXkrkPMiL0KWvfhlk0lscdDb8WBWOgDCqoBEzYkH5gPZ1CCkyJT3F+KNL7wIv5v8ceV7x1OZFVB05CYNXJu2eL/5VVbnaQOgpBoRVT8NEpyzziEsfJPIpylMzz7OQwwnLnBpA5CoC7y0PhklLtQ8qA8wmmIsxk0ucYRxtpjn1Bg==;5:+0sa3tfPwROkfLQenK9H8Y6c4o/eQ23TmhuivNiW8tIVy9iGXxxQswTN9457WZ64sPM51DYNbivt7m2+SshNLpoebILjMHZieG5U5mt1BGzUHVj3b2bsSokHlNY8AvxXV8EHYRT31Tne8SLq1meKcBCapMnB8yPH/yH5EUzzKEE=;24:UPbhV4SMmewRZm+rvmUhXUNiv7IHrO/yelkOnbf7vfIQGRJ/fcayDKgWyXaQEOgkF7FyE5Gv8MKL849BrFdLHWf4THDIkCG4b01LJGXfdmk=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CY4PR1201MB2518;7:gqkkA2re/6/xmf+JTOriA0cNPkUJsrvAhzUrdoKpZCWfXSPm7yY6HyeiKydp3WhvIzvxLHSG8rHRWDneu3Og2ROZA0AwNBs5qJREDLP9NH0sESCmZyX+qoaq7bw/vlu1/V2E63I5z4fAjG077m+OF2uNjAHN3jBr1wPXTwKhObXw+DzPSkdeTikhQ7hLytgiCr0wXBt4uqdD4NMYkRnGzcPaSoLle0Abvmn27XHFVCPib6CsSDy8bNp/u/Be+HJZ;20:pgaLv++BvCuMfk+6JzdwByEs+CMkeX0xBfHbXZI6wvzzulfMjowZkTGBAeE6d8YUFf8pgtoP611ZXQHxY5nmWEWB/Zg5R4BCaKitOQc5aj/Wi8Y879U6zyYlqEBTBECPRBX7Njato+Asu6nIp1CjGByTSKAyZRSYD1GLGESP37OoHeEwKCgzEm/H5f4JxjCsJctevb/pbaycefe95doKw64T570IK4sgBrjUYpBuMcAQGOUYS7ovL/7l/MFz+wnG
X-MS-Office365-Filtering-Correlation-Id: 959878c0-398b-426b-0d2a-08d5bb8255b7
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2018 23:11:19.7558 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 959878c0-398b-426b-0d2a-08d5bb8255b7
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB2518
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Add AMD cpu microcode for processor family 17h
* Update AMD cpu microcode for processor family 15h
* Update the AMD cpu microcode license copyright
* Add a Version for both microcode family 15h and 17h

Key Name        = AMD Microcode Signing Key (for signing microcode container files only)
Key ID          = F328AE73
Key Fingerprint = FC7C 6C50 5DAF CC14 7183 57CA E4BE 5339 F328 AE73

Signed-off-by: Sherry Hurwitz <sherry.hurwitz@amd.com>
---
 LICENSE.amd-ucode                      |   2 +-
 WHENCE                                 |   4 +++-
 amd-ucode/microcode_amd_fam15h.bin     | Bin 7876 -> 5356 bytes
 amd-ucode/microcode_amd_fam15h.bin.asc |  14 +++++++-------
 amd-ucode/microcode_amd_fam17h.bin     | Bin 0 -> 3364 bytes
 amd-ucode/microcode_amd_fam17h.bin.asc |  11 +++++++++++
 6 files changed, 22 insertions(+), 9 deletions(-)
 create mode 100644 amd-ucode/microcode_amd_fam17h.bin
 create mode 100644 amd-ucode/microcode_amd_fam17h.bin.asc

diff --git a/LICENSE.amd-ucode b/LICENSE.amd-ucode
index 2cf8590..de5b29c 100644
--- a/LICENSE.amd-ucode
+++ b/LICENSE.amd-ucode
@@ -1,4 +1,4 @@
-Copyright (C) 2010-2014 Advanced Micro Devices, Inc., All rights reserved.
+Copyright (C) 2010-2018 Advanced Micro Devices, Inc., All rights reserved.
 
 Permission is hereby granted by Advanced Micro Devices, Inc. ("AMD"),
 free of any license fees, to any person obtaining a copy of this
diff --git a/WHENCE b/WHENCE
index b360a49..9be6118 100644
--- a/WHENCE
+++ b/WHENCE
@@ -3100,9 +3100,11 @@ Driver: microcode_amd - AMD CPU Microcode Update Driver for Linux
 File: amd-ucode/microcode_amd.bin
 Version: 2013-07-10
 File: amd-ucode/microcode_amd_fam15h.bin
-Version: 2016-03-16
+Version: 2018-05-15
 File: amd-ucode/microcode_amd_fam16h.bin
 Version: 2014-10-28
+File: amd-ucode/microcode_amd_fam17h.bin
+Version: 2018-05-15
 
 License: Redistributable. See LICENSE.amd-ucode for details
 
diff --git a/amd-ucode/microcode_amd_fam15h.bin b/amd-ucode/microcode_amd_fam15h.bin
index fc4278900493525f8bb122033aef9b818274b378..d0629acf0974171050550d96968573015774451a 100644
GIT binary patch
literal 5356
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

literal 7876
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

diff --git a/amd-ucode/microcode_amd_fam15h.bin.asc b/amd-ucode/microcode_amd_fam15h.bin.asc
index f303a1b..b10865f 100644
--- a/amd-ucode/microcode_amd_fam15h.bin.asc
+++ b/amd-ucode/microcode_amd_fam15h.bin.asc
@@ -1,11 +1,11 @@
 -----BEGIN PGP SIGNATURE-----
 Version: GnuPG v1
 
-iQEcBAABAgAGBQJW6d1MAAoJEOS+UznzKK5zSxkH+gJLffKGRM9BHe0D0/fkb0Gs
-FZVp0eUNREOQoYwHJq9Ms1RebaZJkaUnd8SXCODJrqxDsxqUgunUtP6Qfh3Ru6fV
-n0wgFVISKSQVLDP+I/ANFbWA2KhV5e4LuLQp5cDSItv6916kmNlM5kxtJ5QBrNXu
-kr5bNReYgYTl7PSoCPuPfVILToG0ltZQMdKI1GImRCMVrYjGMbv8EyUC3r8ZbChG
-Lv6K0AsULA81lXBAW0JYlxu6cNv1MJ3mxttwCswaJNcd+Y11ZQA8r2sjJoWbNSlS
-nsDPLsUKE/RsW9MlMxiI2Jqo9PrZz923bu/cWMU1FPp+cJII0T7idWGUTVhQjc8=
-=MTxP
+iQEcBAABAgAGBQJa+7WFAAoJEOS+UznzKK5zu7sH/A1IGyMXU/OuUnJVdIN9VNW9
+mtTRbymKK0PdL3gSbK30pVMMMR2rLUZQm96OAcHyN3ETp3OSXA291zqZ1PEQnLNM
+8sXCVsKmU+kogUy+anoxyLPaiYnnO9Z7Ga+hTKuq4u107XPp+t/z6m/bjc7opbkP
+TABokyIkkXLa9miP6OWqgWizb4ucGvx+tm7USzUulLf2OVpNz7pBnldILli7HgK0
+naLiCijRwPl/KFRXdkbrQfQvS8Nnwe8+qrY9/ooESahWoEr8sd0HlRLLULzsuLJi
+MuAIASWbaNSKptqv4ucp6AvzbALAOmsxSHRR0rQ68+ddxe16f7xDiv7HQMWe/O4=
+=5C/J
 -----END PGP SIGNATURE-----
diff --git a/amd-ucode/microcode_amd_fam17h.bin b/amd-ucode/microcode_amd_fam17h.bin
new file mode 100644
index 0000000000000000000000000000000000000000..8e6f4c181c32206dfac82c1f0025b2fd6b72495a
GIT binary patch
literal 3364
zcmb7F3s6&M7CyP$zztkW5^fMe0vF{G6^c3_sp1ku5noFbd_|Nv>xzu-VtuRuU$=^)
z6e>y;s-cYtN?ov3(P7zI-_;^^QCweG@lhSMwX1GhsUq(AlN+UJox1-_=KLrBx!?bt
z|Gb8dNdU5n@yC0c$=1GjGl0Z<x~SnEw-WEUFLm51y@eOL61R#jx&n1&7d)jIz^BW(
z51vC89f<C-B&Z84fFCcT!j-_#!Y>WTon*b2^YrqcOEyjPyi|~odfKz~<i*9s)Wt!&
zQkSP}2`yhWyQ)WX``#P*d;j~i*U>WzsLL@qxl;?z#T2Qc0*=pK8~7~faNV?r?&j&*
z#rytU)v)kE(l-O<Jj>m<=-l<3&&OU6if7(_wpkY%n>#UyQ^CEAt-BVUA2~e!*59Z<
zRy-}~`2LG_VersY-LnA$-uY-v|7n97`fZ9gw@gWl`1}2!_WO6QZ&+E+&A7CnrR=Rm
z*WVqzyRt5C*vO<q8-zJ0Jez(#pY?53TI!A_MX_F?ewbSlJ4nmyzdJVc-3pm0@^VsB
zzx0hqcYNA9NUHsKiK?LUtChQt-MDpaebtbH4h7p&ai?)|)Y%i({LrgEw&dp|we8n!
ztomR}YhLf;ML9#bi_c?EcKSByV^$1Y++mG;oU|+Q?Z(#3_JWwWtj1xbcZQE!+u}Xu
zS=zm<%`uHjE0%X2etT}OZ5iYEt7BBntKQ3BQ^K6OJ<19@&o^Iz-hW9-Q#UeimMg-2
zd(}Q!Z%S<XuJ&<$T6}cY@xONGC&SK8ubpdCQoc#3U9@fKlz_^V$vLLL-ldhJ3jc8K
zSjvU{57!iz#2V+Dj?7o93KDaQ8kYJWNKF`jDgBW$zGB*0dGhqA(LKsbOK)8WKC2I0
zopb;0qWZHo;X%jljG#S@pZ)X5DpTK{o`;*in7SkN>(ky}YW`tf(B4oh95pTcAZyU#
zKD{rn$tMyu%l0=XwYga$%REPHzA~@dTi?&0b>q_ci|M_#&QDak4-8#e6r60@z}#x#
zCM>u)q*e0e{_^IG0{58Q)~woxcdxWu&TjWGd?fQ-a<`4sZ<qE_`vnHZ9`Tr}_1*XA
z`LX)+j&)zHow7XD<1t%xbEhyndAt63`pK1<%xd-ES%+^QHU+Obv?O3+WBk1F!oaU*
z$z`=2_dnULx|y!p77EeB&P?s|Xisahc8e)=-!6`BP5R`Hdp~X6F0TXQ;(ts!-#Opw
zU*qN;G|g(*685K(fD6M@f=%V?F0b6P+qmS!jiJo*%+`*?(%4I~A!7n^VRC+o|BYr9
zsR2?S1v8GZl9|oy^EXRm^@}QG0W;t5{5hQUe2|&RUhO-WjSQPAJMeK0R@DE!ghFek
ze_4JwEloF;0man$TB9s>6zg(eeJBcqo^@PYwvG{cMyukotK}$Buhz(QJXn=BQp>o)
zICher28I{dNfwYWbadfJOMJas4Di{-N*@Xfp3!k^24eGkTHy%&*}QO?9%?K*lNX)`
z24k5I+F0;EE+V^Hf;cL~ky4C}V`o^}R)y#J^V!vuI|X=0CCBmv=d?eYp$9Oa3_*zt
zIqy|cu)dVfBmNYlq={d^>!3)dpTII;uu5zbSPIVJz2q(xFd@(_%wj*&NNi4=#-e!u
z`QdqjEvkMFe#cuWTM_c}Lmr3+{;V->2I54#&(q{RR1$_KT=Dw^KRYi6AN%|G0NAX-
zL&l1}0?pK@G&*8y=gfed5&{o#tOlmw_L}}fkNzMBA;Q|9LJ35!0J$5YNH~o#4&;o$
zu||s=--RA+EYkub_@W*tSAq~|=<dJ)GykEqKdc8cXrt5wCsM>g9yI6hgXfAu^!VO+
zY3vBXN1|f&`a3}sFu>?kY~Q(fhLXIup$g-tN8dw$oz4@#J`>}G@dg#%zlll?hC;P%
z59$Vd%RO5)5bK3+r=e|_01ob8+c!Zo0&yT3G+wp}kV}x;N!A+E17&87#$SzR_IGj0
z)A3pw&kUlCXv>>xG=9V{{KijxI!Fn>hx6n$aGp4De&a6WCGvY3uO)Z=hRsVpPhSJ)
z)NA0JLL37|!w=sVrGR;7aYIRT1^!R;^-?9&ZF1xxkF~>TGAu-Q<i6uAC$LJOHacub
zeR0-F7NXm2^luo|Wl@$I%pd2Qze-}<>9!yeQ_AK6OoY%)XIY0aCUxcfromGQ3Z4lO
zSe>Oqv~`|2<v|Z6#*`LF-pJl})T{H%DYt@I>fFCd5<a~#4_ENIdS2n+<!ZZ7O4)5F
z>@!}#^d<Gq0wX7VgnUD|^9l+QFxO+)k(Rxl445@;HdmZ=tCjQ!V1^RE{__gIK9>={
zm?rE^7BDh=G~$7ou~`a7S@N-7{rHS}5-(S5SDp9;?vA>`n&XkP9;A$JyrWL-^&!E`
zaQ)6zzu)FhyZ+~@e;0%{bXc|FkhDN9O3Wjjs_^A3_%_2I7&q)&WIix_4U=y4V;DX{
zhW%BJI+549E8$bx(VGyjQpB@MUexblZ|N)U4We}AWA`0<FVyPl(f5c$+AzJd2S31f
zC%uK_^VUs#9^kz;QF;SULt&I(^Faz!8l&YvffCx6GvJGRH}OnZMhVzMEoKk8n)rfu
z0oId_(}a-v(t%WGmtFhwBjj8m*3%C`Yl4AQ+nNtzENFYr6k`G4j<bZ|;2aGhI4CQ*
zE`9!oE;v7lIKncfGR*}C`9z3(B1AsFm=`~F!D)5!31Vto`MAETtB!N<cXNZp;^j<v
zF`MkO1bd);Mv>X{a(?}4?!2&Z&eMY)j(Pfy*t6vBjyc~)Mgi8Ry>Il9y|A&z81n#d
X=EaeC*%!|GS4qP8RcFrsiOv525?x-I

literal 0
HcmV?d00001

diff --git a/amd-ucode/microcode_amd_fam17h.bin.asc b/amd-ucode/microcode_amd_fam17h.bin.asc
new file mode 100644
index 0000000..4d513eb
--- /dev/null
+++ b/amd-ucode/microcode_amd_fam17h.bin.asc
@@ -0,0 +1,11 @@
+-----BEGIN PGP SIGNATURE-----
+Version: GnuPG v1
+
+iQEcBAABAgAGBQJa+7YMAAoJEOS+UznzKK5zGvIH/jDlOORyc1hk1rubB1Txh3C7
+yq7BJwaMotOHZqNzCHuIAGCSCuUrN/HJ465deJXGuRFDbl+Ywt/AHKBMN4RglyO6
+JoM2zZwkgVpLzqJyNwedzGpAxPT/dT1daDDWRyd66cz98iEVNlYS4Wc92aXteYdq
+qzxidXi1MmN8+Iycl7L5MYV12jysrssIYmiVe974Rb9y+84tJVCohAONl/N6m9PX
+VJuW6d5uch3NNLVo4ZFZIx53E3JiyB4nI0JU2C2dj4S7XDP5T17kxBvUNwbgtxBV
+xdTuT6ITu7bGxderze3iPkkAzCgemgLF+sKFbXLDnnHch3YfFMWskuE4TEwMAZU=
+=Ae/7
+-----END PGP SIGNATURE-----
-- 
2.7.4
