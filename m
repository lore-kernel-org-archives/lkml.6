Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934371AbeEYB6k (ORCPT <rfc822;w@1wt.eu>);
        Thu, 24 May 2018 21:58:40 -0400
Received: from mail-by2nam01on0064.outbound.protection.outlook.com ([104.47.34.64]:54272
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933717AbeEYB6d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 May 2018 21:58:33 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=sherry.hurwitz@amd.com;
From: Sherry Hurwitz <sherry.hurwitz@amd.com>
To: linux-firmware@kernel.org
Cc: linux-kernel@vger.kernel.org, jwboyer@kernel.org, hmh@debian.org,
        r.marek@assembler.cz, suravee.suthikulpanit@amd.com,
        sherry.hurwitz@amd.com
Subject: [PATCH 1/1] Update AMD cpu microcode for family 15h
Date: Thu, 24 May 2018 20:57:59 -0500
Message-Id: <1527213479-121361-1-git-send-email-sherry.hurwitz@amd.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [165.204.77.1]
X-ClientProxiedBy: SN4PR0501CA0151.namprd05.prod.outlook.com
 (2603:10b6:803:2c::29) To BN6PR1201MB2514.namprd12.prod.outlook.com
 (2603:10b6:404:b0::19)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:BN6PR1201MB2514;
X-Microsoft-Exchange-Diagnostics: 1;BN6PR1201MB2514;3:gHJ+axla5UuliPLNJOxgzfCYjTXTtCJf5GrJfcdwt3bFYqBWiVaV6yBvbk/2deWE1YTodEWLJugZKfds5QRn6fXeRmvHYQu9XuTqBNZtFATJQKFDQa/EXC6NSPCckATAqWhAKQBHncnXda7Bi8M/15H3qQHR+Tcm3UtW1U3/vZlYivURJS3bb7qSW8GgkvTQ0A9XzHaU1bF6hU622IXiFpP4einnyihxtWD7uOae154jKnko8i2fjjGGWtW+yj0v;25:3Pu2nEbYl6KXhmFWAe1c+BxCT/MKz9FrJcSqeeTbNSpw3nb4Dv24WQ79K0LGDnZOZIJYz2N6G1bCWfb6gTE/SFtiMFuhYepssLLQmxIxE+z66URNhhOorszu6Xo1U/ZPanT1PZKhnYNZ9UFx0/8YakT2NIHB2Ygsida5ZER8KFkjbJt1PxcEUmHl30Pdkba/h+fCGSpkP0s5SzqubnQBs2s4KasTSGi9Y9BAFQisZJleThhH+g7ifJBVWdQ5TG1M5Xp+wO2ryW/fOkfpMcur6aBzAIIU4fCBiZxUKozKHzEAtSMY2rIJCDsIHICnoxJqLbbOjHJPRwDF4GukD/44gg==;31:jpVveE0Yq+2ns6/JQ6rgY8q1nP5C365Y4/PLPoM6DsgHAxYXdUlmIw5UJNisYmFNTE7giFR000WcVICpwYkkGWDsO3BDO/2YXj6lyhCG5C09X4nz3Po9gk1kEYSIbevIouaGxVrF+D6a/CBBx0SpstTblStNZQKClB+8ULjoXT6Zj4VKN7EtLKYhYAYjYHNlYWN5a7yzFZQx38sxvNQBNvO2sg9Y7wHC9IBTViXDM2g=
X-MS-TrafficTypeDiagnostic: BN6PR1201MB2514:
X-Microsoft-Exchange-Diagnostics: 1;BN6PR1201MB2514;20:GVz6iRN7JajXZhqNy5LN4jlC1N4XHNZyzx+K5MKy+YbqBXaGEHHyyoICM9WvR/Bu/9yN5KXQGDxr9Te389Y6CH0/bZpGdacoiD1xycNY0HrbWhR83DquHGJvb7y3VisDRdOrOgvHcepuG3CarK/EkQiGHlZKMr4+6f0Ty+jSXKZ7qBIjLcisrQbKtinwhUyeKXead4z1kRR2+upnIEdv0rDIHSdzR6i7OHM3VTNcB9upl8hxZthJjE6sMachVwop9kzp03LssjU4Wo74Br+KWt4JkLLE+xLRQtuVJKIihhWNmR68kHQZ5rmjzAYossPkrhJSiPNTmoX1fSA1LsWZ/csRn+xhjopCkDaPkXHPBQgE/W7yYE6mKcaMvwRqBHwksTQ1u0m4Jbx1NWKELSHKaJT04kN0du2YZxz7UuutkYqwNEOCSecZ9VqwzzCpZz4Sdwke77WxYRBrgX8CFCxA61ChoGYjJJUs45cvCQ742tkY5D8+RGC2HkN+fBeQM5fv;4:AK0seHhc3zv7Bz2JkUGFXPmUQ17WNLKSMVHu0GGaInhbTyVry844uT+hcHSutGvDAJ/frH1VSgKNKaIgIs8jiEn56IIQzxyE8oTwuHi1GFeVSWYW/qoVtPjPws2H6qbChZUjOrh3v8cKF2w9lWUV4Yqh042IFTIkm68iY5ulcWXAlDlgI0lta+sU9NVLquCkVmsw+SD7s14vvZXhvmEHIdUEtpBj+EAWftD0KsIqYREEvqSFwDv1g6bJZkd6gy+DPC9OSSo1x/v8KekCTHIZqe5UOzD3GGC8fOJ12bby+JhrjhBuigpE/CVWYHnPAaax
X-Microsoft-Antispam-PRVS: <BN6PR1201MB2514323311FB41201E33D36F8B690@BN6PR1201MB2514.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(767451399110);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(10201501046)(93006095)(93001095)(3231254)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123564045)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:BN6PR1201MB2514;BCL:0;PCL:0;RULEID:;SRVR:BN6PR1201MB2514;
X-Forefront-PRVS: 06833C6A67
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(396003)(376002)(366004)(39860400002)(39380400002)(346002)(377424004)(199004)(189003)(106356001)(105586002)(53416004)(6916009)(6666003)(68736007)(47776003)(305945005)(48376002)(50466002)(4326008)(36756003)(476003)(186003)(3846002)(50226002)(486006)(6116002)(956004)(386003)(2616005)(66066001)(59450400001)(5660300001)(2906002)(575784001)(16526019)(86362001)(26005)(52116002)(7736002)(81166006)(16586007)(478600001)(81156014)(7696005)(8936002)(51416003)(8676002)(2361001)(316002)(2351001)(4001150100001)(44832011)(25786009)(53936002)(15650500001)(6486002)(97736004);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR1201MB2514;H:amd-ubuntu-1404.amd.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BN6PR1201MB2514;23:PzIcqO65btYjeaKXP10VcDNejaQS3FAMA4j65EQ?=
 =?us-ascii?Q?/X+zkJ0HDFWmClIgKmCS1sXUCSgUlyfo7xz1ft9LvLntDNBmSYg3tYOliCIf?=
 =?us-ascii?Q?bSOGWZrd9nJVTKDVVfakoQWAernzQFYnokbzrct1vueFvHc5fNj2E8/WjZp1?=
 =?us-ascii?Q?ZWoI7d124GA5pr16+f40Wqzfsa/Di+W4+x8c+Ww7ZJDVlGcEYqghJ9h3SsoS?=
 =?us-ascii?Q?l29HCECt1u1eu0KsBWwRegSM+SxWIGHksyKu0sM82FV+QrWhLHyg0FY4hvUb?=
 =?us-ascii?Q?QgylLZiiQFGxaIJzrQst9Xp6DDbFCzE+21DA4R6HS0zW3aUHS1Wjul/3XF6I?=
 =?us-ascii?Q?FQ1nEG25Q6X8FV7AIR3g3GNpqlaTItAgu4lL9NxoGwlMDxN5DDWN8BC/WMvf?=
 =?us-ascii?Q?8DzYm0fJa3Dzk2+YfdECw3RB+JvpSOk2nT4XrWQ5svarH3lJ3M6odyoMgn8V?=
 =?us-ascii?Q?boZYvIwoghAXHRLzkjZD7b/RQCIY009gBJZHdWtedSvhIJV0emQzTDSID6tw?=
 =?us-ascii?Q?55+iQVXR/GX+4e+bG8YD0vdYjPlR7Ho24qAlguD781u5VmeVC45snRnvhQ2i?=
 =?us-ascii?Q?y+dhuhH3TZbwLT5jLxk8ADxkbEP7Lo5DH0ao1MNIF5AjfRu24a99O7UJf+Fv?=
 =?us-ascii?Q?wEhuwnntuvC8wOZ+3VybROKKr3HshhZ0ie+d5ybziWiT3sTfOgRJedGZ014o?=
 =?us-ascii?Q?6U/FNJT3dlYFilwaim4ztEFT1WnJTmCHuVjkwb2y0ioiZwmQA/mvBceOL+LA?=
 =?us-ascii?Q?9Pv3EVye/f+GuhFJT0W52rGmIxC5/WQPyklMLSbc0nunHDiv29aYsIG3T1yO?=
 =?us-ascii?Q?DCHh4+aARi0BQtOefE2GIVyITN6UVLC0cVI27hCS53McIXSCwBcYeQC4x/AP?=
 =?us-ascii?Q?y79TJc1w7iqbm/8egT9KA2SbfDYIjQO/qZCoLLdroEUMNeDzy47x3oWs2trv?=
 =?us-ascii?Q?j2RHSMq/Jn9wL4zvo72NTEdjd/BW5q9jtZ/RRZfs3JqFi6mYiI0tkMDIJjm0?=
 =?us-ascii?Q?ZYEYavzWdCErxpKB9it2mELQ1RMCI+Oyy1PhJR7H++1CYVF3GJ048xgRl7Mf?=
 =?us-ascii?Q?vTMUuxAc8gSMPYeiofLtEvOz0Rjyhi1PMBHzGvVE2NNe34CygKL+zbzNu+CT?=
 =?us-ascii?Q?0GhgqRBR+1X+b48bYNUo/LCAp1y6yakQkn/YNq55lU/xpDM6SiJlycIhloLt?=
 =?us-ascii?Q?ZnYmrTj8phegzIBBtdHg6qrMr3joZlNhjHLyJrI5hVjouR4NoT2Hrx9ISQiY?=
 =?us-ascii?Q?E/+DJ5YAU/OKDfORgm0cxJkBDDWmZrTaz9EFxqfgt4uI66GZ9o3HA7alPaIJ?=
 =?us-ascii?Q?spdWKYJ2sWG2AxMjYlY2MCVI=3D?=
X-Microsoft-Antispam-Message-Info: KB0wmBxjcnmqmspyKPzzp/wjtD7aiIRhsmINXkeOINnf5uF/UiI+lyOzjEul13BmUMWe9i8919XFs84j3YyZ5t4U/ZqZjFDJU9zyPAbv6LJeduzgKaUTS13e4USDEvzJrENKizKK86TI0Zjd20SLrEUgUPKpF3a6hBWVOStOAmubalSD3GdYYfWgbV74my4W
X-Microsoft-Exchange-Diagnostics: 1;BN6PR1201MB2514;6:xQBqNwVz/0z6oekY6TE5TD8daTxXJeeBKt3OXxAqhuau86YS8mPv3pYVxgaH/PRiWHF2YUCf6u8RM8BuhXN6Vckl0MS5fC9b7Ean8HAKP5/+p32y6x+56wKF8OK01UFoNFJTILLnUAW2VoRr9ubESC89b7AxRxpzM+ic1YIz7WYUIZp7GMU1Q4BXAzFRDtvGEx8rpL8kJISuWiHmSVEd87+5Q2tryEupA4aGV8xfkyF8z86P8ymKVMM85zEdbYoi23hvs0psWFxNuvt4158r05AryAiDYUAw/XzYwAdqPHEuD/4rSrRQsNsQYryS5Il9C8nvPrDV0Bstijpjkw9ynJaM7qlqSsOySRSC4lxZDpaAshhsbMeScqxgMLNvTZ9PTGMED04KGqM/nnPasICUXgFrEHvr+2i9c0SYdbP2Fh16rxHmALES3tvvPPb1r6WdCp8WGmOtdIXWfnvBr6RZ9g==;5:G55w7wElidab94KGYWxsBErecKlua9oGJGR0Wkuna6Y0PBR05rdX6mtgKrzRiF+Et8QVFhNGYcBl8qAkEJC7NgUPSYXxnp37tChIi7F3rZsPGjEO49ueg8RPzqN2nJHNnjl2zPZ6XDu+3nRVFjc7nRp4qKMDj4Yt0GXom7P9ryo=;24:NKpGhwQjj6YZ+gVNwa2D9USylXtBK1vr4/sLw3qZIZwJA9HqpXJ1h/7ENK9GyUl1amqpaofmj2ahJkksJS83IdP1nNamOF1/a7LKvDZEhQ8=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BN6PR1201MB2514;7:LoUiHseN2jOwKWRPjkoFk7wY6WNcOtiDBkUXLyH+mw1Hkpoch1pXoemyQPXKlWJLXmB/I98Mn6biI/jk6dEYgIBVAU4tOD3ZEKo/STQXioki1PD4rfVdOb1fhYKmfKBTOhWDcQFmTgW3ThChpKB8+XYOqMg4R2WGCYxgCQvuPR3Iq+xLHSUooYXLrfmydehIu6oiNZgOk/4v/F8Wf3aj+KJBPoZK56nfbIkuh3X8Vg550N1hXpUNclRv9m7c8hC8;20:DWstkQAOTiUsZgLgdVsLB9fDwDnrTlLldfbAz0nyWvPpK+q48TnUhwMK8TtJjU94fNBWlaFUfo2lkStR8CrM8f9bDKAS4aJ7n9t9t3dkY0BmSCseYx0h3VzclU2QaHC8NVioiMmUV/NJxCkOVNhH4Hu3YNCFomIgt4YcdoRIJwUmbTIRv2SWrq+1Y0A9cHkwecEwNlcxXcdmh3nTvLZQHI4sw1xhIRL7Xf8EuowA8ythRtFJZQkM1GlbLqqkUp2/
X-MS-Office365-Filtering-Correlation-Id: edfa2139-f4d4-4f3d-50db-08d5c1e300e6
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2018 01:58:25.4539 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: edfa2139-f4d4-4f3d-50db-08d5c1e300e6
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1201MB2514
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Processor Revision ID 0x00610f01 was accidently not included in the previous
  submitted microcode container file.
* Update the Version for family 15h microcode .bin file

Key Name        = AMD Microcode Signing Key (for signing microcode container files only)
Key ID          = F328AE73
Key Fingerprint = FC7C 6C50 5DAF CC14 7183 57CA E4BE 5339 F328 AE73

Signed-off-by: Sherry Hurwitz <sherry.hurwitz@amd.com>
---
 WHENCE                                 |   2 +-
 amd-ucode/microcode_amd_fam15h.bin     | Bin 5356 -> 7876 bytes
 amd-ucode/microcode_amd_fam15h.bin.asc |  14 +++++++-------
 3 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/WHENCE b/WHENCE
index 7cf7026..4aa5c20 100644
--- a/WHENCE
+++ b/WHENCE
@@ -3100,7 +3100,7 @@ Driver: microcode_amd - AMD CPU Microcode Update Driver for Linux
 File: amd-ucode/microcode_amd.bin
 Version: 2013-07-10
 File: amd-ucode/microcode_amd_fam15h.bin
-Version: 2018-05-15
+Version: 2018-05-24
 File: amd-ucode/microcode_amd_fam16h.bin
 Version: 2014-10-28
 File: amd-ucode/microcode_amd_fam17h.bin
diff --git a/amd-ucode/microcode_amd_fam15h.bin b/amd-ucode/microcode_amd_fam15h.bin
index d0629acf0974171050550d96968573015774451a..f12ff79a538dd12d0e8c3a8eef7a3dbf27c77312 100644
GIT binary patch
delta 2657
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
PStNF5<GR0AO%(V(lAji$

delta 116
zcmX?N`$m(~#n+Jm1SU-6RE}fhF935u1S60s#Ge4?3jvve{0(rvAdo49#1{hcg^~Ee
OAf-rrhK7w+Ng@C~oeYWq

diff --git a/amd-ucode/microcode_amd_fam15h.bin.asc b/amd-ucode/microcode_amd_fam15h.bin.asc
index b10865f..cf6b810 100644
--- a/amd-ucode/microcode_amd_fam15h.bin.asc
+++ b/amd-ucode/microcode_amd_fam15h.bin.asc
@@ -1,11 +1,11 @@
 -----BEGIN PGP SIGNATURE-----
 Version: GnuPG v1
 
-iQEcBAABAgAGBQJa+7WFAAoJEOS+UznzKK5zu7sH/A1IGyMXU/OuUnJVdIN9VNW9
-mtTRbymKK0PdL3gSbK30pVMMMR2rLUZQm96OAcHyN3ETp3OSXA291zqZ1PEQnLNM
-8sXCVsKmU+kogUy+anoxyLPaiYnnO9Z7Ga+hTKuq4u107XPp+t/z6m/bjc7opbkP
-TABokyIkkXLa9miP6OWqgWizb4ucGvx+tm7USzUulLf2OVpNz7pBnldILli7HgK0
-naLiCijRwPl/KFRXdkbrQfQvS8Nnwe8+qrY9/ooESahWoEr8sd0HlRLLULzsuLJi
-MuAIASWbaNSKptqv4ucp6AvzbALAOmsxSHRR0rQ68+ddxe16f7xDiv7HQMWe/O4=
-=5C/J
+iQEcBAABAgAGBQJbB09SAAoJEOS+UznzKK5z8kAIAK1In82D88fGFbhluAl13UFu
+rs8BhXKL2w7B2KAspBNTmYpIQnfvVDrZzn6t6nqssuJ4bnWH8sf0mC/w5dSQLG4M
+WdpDd+qkdkDGJFlbl3zkr14Q7ZCQPV44pT7BOF07VPflOeQQjRWug9cdyqRIfO4n
+XGR5wvBOJZ2BlriRkYagQHn6iB/UJWXodmTr8CRGIHTApQg6K0NPNvmbwa/W5Z9X
+bS6eniACMfFDH7NXG2uTpFiGa3DYbDyNZiZeM7Uv3BFxtAOGY8vTFghtRyk0qxAl
+o6d8fT6ozkTUxE40Lgb6MegDJPwJ+uDfB7jKVPnYsbDAp6K7L8k/7PQQQRJ69Pc=
+=k2EA
 -----END PGP SIGNATURE-----
-- 
2.7.4
