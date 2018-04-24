Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752252AbeDXSNI (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 14:13:08 -0400
Received: from mail-eopbgr50080.outbound.protection.outlook.com ([40.107.5.80]:43472
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751216AbeDXSNG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 14:13:06 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Ayan.Halder@arm.com;
From: Ayan Kumar Halder <ayan.halder@arm.com>
To: ayan.halder@arm.com, liviu.dudau@arm.com, brian.starkey@arm.com,
        malidp@foss.arm.com, airlied@linux.ie, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Cc: nd@arm.com
Subject: [PATCH v3 0/5] Enhance support for system and runtime power management on malidp.
Date: Tue, 24 Apr 2018 19:12:42 +0100
Message-Id: <1524593567-5559-1-git-send-email-ayan.halder@arm.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [217.140.96.140]
X-ClientProxiedBy: VI1PR07CA0189.eurprd07.prod.outlook.com
 (2603:10a6:802:3f::13) To VI1PR08MB3037.eurprd08.prod.outlook.com
 (2603:10a6:803:45::14)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(48565401081)(2017052603328)(7153060)(7193020);SRVR:VI1PR08MB3037;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR08MB3037;3:f9qLyElUCyqV56/gxZfflmM3mhK76B9kgO0tlfUt9iLf8qc7NR3ieVvoiy2asC+eBnYlhDNw6R88c2dHOF1fMiWnpRXB1fcoU+obIiFHGjvwsQU2g/nI1My5zC4qJKuEI8WGUNDa0Tji+lDb0NSwRuParrmjZittHSQrttUYoJMSK3ixVIVlIs0LDHFmVTjIm6h1TNv7g/PBWIXqOpfV89ocSNHxO1kK67BAawkY4pnAQYohLIQKHgrSyuwUiYvS;25:CL6z8D6Ya4oR4oQegPCthcumlNoN5jvr08b00qenLacmic7IY20yPUtnnpoSdVgRnf2eSYWLcVXoPDUQLCTT1M0pu5Si7Fuw6VJn37GE4+fiQKMeCZiKd8l3OmtAYPppqS+VYkXxoNlvYiuxPYZ93BkXtaKO0y4RI8DFNZ8WwTPhl7+xE7yfk3rg9NtmYceGV27FY8kj6kIfDHChdBqkWfqNhCTOA5SlWVl0JSkEJiS73itwFciuJR2uMftTZ6eOxcas34ewKkcC9R4MbAT9LMZPwAuohOlK1WWXPpyBj97Z6NSb13u/EPYlEBYOYheDwEflvzXX3pJrrsSP3xB6Tw==;31:T44R4VC0hQ7IAnzqslCeIKdQZG0kL91p3Q6hW4Q33p44QsFkVmKGFzuu0eZCGHq6cBQbhog9E0xSoI6oTojoIzn/SGiEwhz0BLvLLLHIIklbHmpc4rGHaJTWwq0lJNNqGrmoZe5ADbgmsND8GUkCakiWGQ8ZvujhLhsca7kzsT7ihaC24s5dxgoPp8TPVVDR7Ms+OA6JqFAJimOg9c2GC0JkJaTd1nXOzLSsNwhDMKs=
X-MS-TrafficTypeDiagnostic: VI1PR08MB3037:
NoDisclaimer: True
X-Microsoft-Exchange-Diagnostics: 1;VI1PR08MB3037;20:JcHHlwBBvAZLi6jOw9BXNPwDjIL3emPltOtwhmZF3VhrQVenIqX1iqEKEdYjfp7xLoWZNF4VJUUiAllnjT7R+GRwIWQNrX9Tx/Boj47Sztx/0k4sqyAI8N15y4ViL48RR1Yuz9mFGMshmU4T/m+1kUR3IxZxK+lSde1C+ycpDW6B4FcgTXOXU1wUb9tusgR8JziK991h68o3GyMFV8Vcys/ZA8PxY791odoqiq6qRsWHlPMuS8GAfBcDU7Ea++aR;4:gSzmaRDV/4q7MjFFivI2T6lvaVnjmNIJDYGTsAoIF0qBfpUpM4vn/zC8UAqPXW0b6TwwgkroyHXoX0pvWZ89w9EDQ6OVvXcl4xZeKbqVfgcOAjf0f3IiEY0rs8Hiwn7LLXOyeLAUIKXEtzxtSrvqpaXlbdGqhTO16vK2KM7kfoLzgj9LuzZ9vbwNL7LOtFEhXMl7wkATY/7TaMgD7W+Jg0HvwNntPO39eJnkSzSJtXtZt/Yslvuv2yJiJpGVvDZRfSMBbQqEGmkDJT8YPcGNKrWgGZtdJPiuLkKCj/SOesEE3b85d6jX6SNcJLJ19pBM
X-Microsoft-Antispam-PRVS: <VI1PR08MB30376801406BE7EF12598600E4880@VI1PR08MB3037.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(180628864354917);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231232)(944501410)(52105095)(3002001)(10201501046)(6055026)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(20161123560045)(20161123564045)(6072148)(201708071742011);SRVR:VI1PR08MB3037;BCL:0;PCL:0;RULEID:;SRVR:VI1PR08MB3037;
X-Forefront-PRVS: 0652EA5565
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(376002)(39380400002)(366004)(39860400002)(346002)(396003)(189003)(199004)(316002)(6666003)(51416003)(6116002)(53936002)(3846002)(97736004)(6486002)(486006)(66066001)(2906002)(36756003)(25786009)(86362001)(72206003)(478600001)(105586002)(8936002)(26005)(8676002)(956004)(476003)(47776003)(48376002)(7736002)(305945005)(81156014)(7696005)(68736007)(81166006)(386003)(52116002)(106356001)(50226002)(16586007)(50466002)(16526019)(4326008)(2616005)(5660300001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR08MB3037;H:e113505-lin.cambridge.arm.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;VI1PR08MB3037;23:gt1qcn0XyhcJ341LV1oiPvMTzdztu2LM9k9ABTGj7?=
 =?us-ascii?Q?9JGa+5jpehoinqt5gAehJdoIOSCz1GATdOeucbZ7pzIvUVCEGMJjxxc78nsL?=
 =?us-ascii?Q?kly8Xg7uB+h20uPwyg903SCv4Qnr61AKGf8ij7HMVDiKBQBUALh3VFknYPqz?=
 =?us-ascii?Q?Vw2cnGaKtwOzySCiZQuEdz3bGtfMy44/ZhvrFD2qft4vGqwcQPEVoWLKYhvQ?=
 =?us-ascii?Q?+rV43gKoilTBWdGaR19PgkcsMFhpm4Ljyq4mZf/NUI51aIqgLr95oZlAzDbX?=
 =?us-ascii?Q?pfDjVVoLu/RwwSGZF2NsF9+VyrKkd6JDkUHc6wWgy47kMDWHZCoLsRc1U70i?=
 =?us-ascii?Q?bOIosUdQOA2kNlMFP/ebAuP9GjuFYVZPwTI2KxvJmbF0bioaQdmw4hm6nf4F?=
 =?us-ascii?Q?wqQR917RrKzzcLNHINjrByPf4xAUGeE+Nmx7VjwRXmrBSpX19k3mrCgU8o1c?=
 =?us-ascii?Q?EES+6lm1YNb8Xkq9IOsVH5qw53mSz2wf1aIXk0IRtYjxueLhIZPT1phSLgXH?=
 =?us-ascii?Q?jcPOMLVpavZ+BVnlZEnUP3Orbyp9gDHQiCSKQXy35ZNtpYhpjDOmqzMaIxdR?=
 =?us-ascii?Q?LlDGjJmdjzg5dI58EdebRzKmOp3cHM7RcvA1YZuc45y7sq6rOsu2zU/QGvEA?=
 =?us-ascii?Q?/ks1I2iuSRpAGl86kF0h79dGs+S5s7HY0v/+EZQ46vLJy6NZQjOlr9mfRUed?=
 =?us-ascii?Q?WaJtJhKjjYnvSZAyayN1Q7+aGPnzUKNfTDId0Gcacv8NeMauxof6BpAO6/m8?=
 =?us-ascii?Q?CLlXFlGJQCIGS1RHt0280Q0t+BqYRNMja3uLcWyjaL7tvu2VV5FQzBokUeB2?=
 =?us-ascii?Q?HnnjQZPIM1isLixX4RffVKZdpocCYfVDLj23Ql9X/2Qef2OKFDcDaa4SsJ/7?=
 =?us-ascii?Q?kZVBTgCbyQfMt+0MsxlXqZlUgjLsgFyqU1k0ZO3HzbQ5MFQLFC+wArRC2nKS?=
 =?us-ascii?Q?CkctDw+bnZsEj9AMKFoGjeOTnOKw+a1L1g2YQPto/632frD8X2U1VJmyQldu?=
 =?us-ascii?Q?MeqL8FwNWXthS8tEF2X34OFw3biWopJZwRawL/UlEhlJEtFIb8V+7jI2PWol?=
 =?us-ascii?Q?bT49I4sf7iz0y/fL9jNcgJo9UergcKdA2760H/stqm3ZsXbcw=3D=3D?=
X-Microsoft-Antispam-Message-Info: Z9WwyR/zOYteu+77rzHOybAFskqhup3xtrVZPZr/oHo0QNQ41uJ0fEX64s/bTUNTurneBZI5EK/I/rhzzKRr5rtHqVtSppVMorJ0fhi+4DfDO5DHL6eA9nlHv4bnmeujN1lwoE6hu4Wa8ogJ+aTNNGEDct3K2u/Kix8XhXzzkkOVyEEuCIG5Sw+l8ZTmjF3+
X-Microsoft-Exchange-Diagnostics: 1;VI1PR08MB3037;6:JDEBF+gkjiMm8cbr2FZjLd+eW0aEqRtvbgR+2ueG91g44vLHysYvvV924o94YHK4pwhIYnQtK3QwjopUbNkOKCn4VVGn++L1rAYf6I4T4EIiBEIsI8j0AYkg5B/BJnFQ+Sp6gfwnATJMi9gg0H6c9o1FA2QzmG685RjR/L5Qr0f0ItmnqzU/jJNrxxT5974Yb/aahyYlZrW5dFj2THEuEhvOX+GhB4Q0mAS13MyhYEFZ+eKiC/0Q2eGS+6XZxI6ZuZJJ2c95Rmke6MjhAghc8TuhflxbrAE3xW60GrM/l8nXEJ5J3/99Ooexl26+KyjmGJDo3YbAZKDpOgpYCVGkn3/5UuPwYULEHWM3xGLtndoghmFyv0LFHu2BiNop/M6J775rXOYW81lQZtXwzqe23Xu4DhAraCEaXFZJsOnzaOgF4TqP0wLP7YQlw6gNNo6DBGOLEsExtjXpFwpQHrkl1A==;5:qoEGKqw0lxGB1nfm0BNj9iJHyziRmszmOfv7siE6Nk4rW1RHP1m+teUjY5l3F7RbHXUcCfRV0eFoHd0SMzJXdyBLPjwezY+T8QIACCexKdxbMtA3kGdWBi6i18S1/o6ECIvb68trfHjwSjHPaONY//KPxbVtmpRLc15bjdIXcGw=;24:4WggirFR5K4waSoWYx/AgKxqHcR8GdmYpTl4DjCmw4i4lYN7vkx3yUFEt8n2dNOQiVZvdtrIxEryhoxpXJm3DH/u7PipV+rNzifzbP6nGak=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;VI1PR08MB3037;7:/IQhoHxXc/uvQKA0Qztm6/7F7seBwl5ua3wMN0jlYIJN4r3QMfTk9MuC4fEL0SVpY2DZJogKafLbgwS8mmF+NNn4n17hQKrN35xu6MlaAnvR5xK7CBWWeSbr3C1PQ+c8riex2Yx1ebuDDdqVBzudXWqavLkDoBB4vpQ/n0gDAeqY2GZpLtqc15yUBYITjES/ZinGJPy5FHqffYIjno8cjKBFCgz6wI5wRRUzI46VYAO08mqV21MA3QZJn0wlont5
X-MS-Office365-Filtering-Correlation-Id: 9eff82ee-edaa-4c05-3d23-08d5aa0f0620
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2018 18:13:04.3363
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9eff82ee-edaa-4c05-3d23-08d5aa0f0620
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB3037
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series enhances and fixes certain issues relevant to system and
runtime power management on malidp.

---
Changes in v3:
- Squashed some commits. 
- Fixed an issue related to writeback.
  Reported-by: Alexandru-Cosmin Gheorghe <Alexandru-Cosmin.Gheorghe@arm.com>

Changes in v2:
- Removed the change ids and modified some commit messages

---
Ayan Kumar Halder (5):
  drm/arm/malidp: Modified the prototype of malidp irq de-initializers
  drm/arm/malidp: Split malidp interrupt initialization functions.
  drm/arm/malidp: Enable/disable interrupts in runtime pm
  drm/arm/malidp: Set the output_depth register in modeset
  drm/arm/malidp: Added the late system pm functions

 drivers/gpu/drm/arm/malidp_drv.c | 35 +++++++++++++++++++++++----
 drivers/gpu/drm/arm/malidp_hw.c  | 52 +++++++++++++++++++++++++++-------------
 drivers/gpu/drm/arm/malidp_hw.h  |  7 ++++--
 3 files changed, 70 insertions(+), 24 deletions(-)

-- 
2.7.4
