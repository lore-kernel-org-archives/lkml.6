Return-Path: <jgg@mellanox.com>
X-Google-Smtp-Source: AIpwx49KzOMUUrEbMvK0bEPVBkv0IS96FVT1RPij62/3mAtzk+/fZurMQyn343QgeZJqhEx2Vefc
ARC-Seal: i=1; a=rsa-sha256; t=1524239368; cv=none;
        d=google.com; s=arc-20160816;
        b=FsJIU80/uhhMoo5R/9Z5Vz2jfZNjdERUx3sSUOJ3TNQC9jccJ3gVDRW7HPp3BIwz54
         LUvcNSYF51Ys9sQHOIQ+waUSZxVwJQ6jY+qNouA3xmKXrgzhZZaTEfZAhwdqTqZl+aFD
         IiSGFIaFhd3D4agjVi0bkvhQ8Mh3JZOfLFl6XjLK2y58AZ9ym7H7CzylC0xkn+Aip2Ok
         tTfNnqUE21iFxxMYeQ/BMAXLs4JUlmgTFBEyCysYiSkhIlL0dJb6eIkMOoUgADZGQo2O
         thY5JsTIbhkrVkPpgSSDUbJN86X9j9kFebyZedVVtn+0lzsTsQUMVBu7tICYNXp3Zvvu
         A57w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=spamdiagnosticmetadata:spamdiagnosticoutput:user-agent
         :content-disposition:mime-version:message-id:subject:cc:to:from:date
         :dkim-signature:arc-authentication-results;
        bh=CUoc0NizA1nQWPSseDPOWZU9MSO1LzE6H5gXGfRixDY=;
        b=WOm+C6pvTqs7AyOZuPlQ0oufUWtgzeKvseUJ/iVoCFriA272tftQHcTZuGbH5JiaRY
         uDsqnaiDVnDMG3R9tNyaYJvpV/Oydj2BnS4akXxoFCXOwKaQuWE1P86kvnPvm1l9/7+J
         0TAEhi0bkDIWeGV34bVvhACdbwiTvWGTEEP2r3sh8H4Q5rGlOYrYiDgM9L0hBl38s8qq
         6IwVzSdSZfhLATusLipAU9ryAa2seIyjNVL0ehVxR6sXQ4VOH2QIyO7jAey15MdKuRML
         b0IA/AUNjlwvsVqPnb5KRKG1yniZvJQ1DRJuOXXovqLBVkWg64UE/cAEe8vZaxnGM6nw
         Uv0g==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@Mellanox.com header.s=selector1 header.b=y1t3Zcqc;
       spf=pass (google.com: domain of jgg@mellanox.com designates 104.47.2.43 as permitted sender) smtp.mailfrom=jgg@mellanox.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=mellanox.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@Mellanox.com header.s=selector1 header.b=y1t3Zcqc;
       spf=pass (google.com: domain of jgg@mellanox.com designates 104.47.2.43 as permitted sender) smtp.mailfrom=jgg@mellanox.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=mellanox.com
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=mellanox.com;
Date: Fri, 20 Apr 2018 09:49:10 -0600
From: Jason Gunthorpe <jgg@mellanox.com>
To: linux-rdma@vger.kernel.org
Cc: Kate Stewart <kstewart@linuxfoundation.org>,
	Philippe Ombredanne <pombredanne@nexb.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Steve Winslow <swinslow@linuxfoundation.org>,
	Santosh Shilimkar <santosh.shilimkar@oracle.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Dave Watson <davejwatson@fb.com>
Subject: [PATCH for-rc] uapi: Fix SPDX tags for files referring to the
 'OpenIB.org' license
Message-ID: <20180420154910.GA2519@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [174.3.196.123]
X-ClientProxiedBy: MWHPR1301CA0004.namprd13.prod.outlook.com
 (2603:10b6:301:29::17) To AM0PR05MB4451.eurprd05.prod.outlook.com
 (2603:10a6:208:5a::24)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(2017052603328)(7153060)(7193020);SRVR:AM0PR05MB4451;
X-Microsoft-Exchange-Diagnostics: 1;AM0PR05MB4451;3:5kMYgBWiweIkeanqyG1xStLSyXwBF3fyI8irkfiVVaqaltzOZppElzculo/h9pyuPYvd1Z9UeoR9guAAOa2kAai7jgzbBWlyKELfXkC/EVtZWBTG/b69PBvgB8AkfUE90Zl7AMA4X6GjEleEK7ebYs4uo9Q4Of2tpcCK8VSkfJVFx3VLICfwHlXvuqvToS+2bkG1pnHiPZhMxU8GuhZ6hkloQNeSi+/fbNcVgrOFlWotT0bqKlLhYTxooWSboBXh;25:ILFQP3Z6DMFy7wG54vpcEUzQQJAubIyGTBPOIWUZf0VcHXqahwZwRQc7Yditx29pBiCgzt83qLee0V/ss0YSaXBcPlmdczIfwjD1K9pDR9TsISFeAWxUk6s6jhUCu3DenMPqAz7rC3ppBvFu2UPGpKHQhw1R9UFQ9VTbX+VVMY6+qOd52H1WIrRL5qUv1Czae92igHStXFGqEqgtprKcUVJhS5s4+upvdzUYDRDIIUkd9i6ETtvC1RGCVqRTav1kguZyEi8+31sBWErBGWLSpvPtw/fw2ej3I6EiCE73SCgM4hINPWC/069AlKAW8lYmSP/PuQXFsmZ7gbsMRHF6Lg==;31:cMPq0zgjzXjgpJnG9FSCJjNVMi7bEssTqV7YsY5imQ5WvR5W7Nj+m5vtNv+rOyLNgyAqAARcSHUQvJKE7QlFGNFeYDvJmqUsjKw6gEcVgf2AYO99GubbVVv5ffI130fvqOkzd0TRRZ8Jh5eUKy0oS91YNfjn6MyN6vAFay2jDSRW3I0sgtKE2eGjDT7fbBtyM5rMfRbi9/CjcV5YzY3qQvREOPg7qbGjcISjEKA1tBM=
X-MS-TrafficTypeDiagnostic: AM0PR05MB4451:
X-Microsoft-Exchange-Diagnostics: 1;AM0PR05MB4451;20:0zfMf70ozh+6XgBm1oOoldCSOq9IWYSLrigZOtUF+8++9NOwMVxzAiSEJvXF2nfDRYDMD1reMomwIdsRfvWtSkwK0UBdpj/AsYHPh6+9l/CRreJbBlp9JXROdDc8tmhf9yl2OB/lf5+XqsE/dR82WfuPJ2itumn38LjPSh/BBmHg5N/OIwpgOG730f4OKVpI5wjBYvWcI9tRjhEiNog3/67gnmfFC9Gysj2HdSBYn9Pqah2PoJaO+t5mn5/MmMRHNOo8a/YvokhIi3oEBfelGJko9GEBie+TLm4Tp0W3dJ5L5Ndj3/Bju0WKLOOfMR/rLlslLOCLRzm0D3DMWOLswFTSrR3KlDvAma78R6f90QOqEwaU0Ik7Za9zS7dDQ1hJZpZAPVsjyndog12koIHAAqRhqN1M9KuhLhsPnYt94mkfqs+rmDD3GO+oPYkFlCJrRymVlHYJiYX9qwvivH8As/htye7AcXdqfv0cs4HuXAVqgR4rZspVEzCgmDcosGB5;4:XbPa3WGM75yWCIYyXCPPhpo1FQhD/yKT999Lacqo/buhhE7PD2paOsWG5PB/tnf2TTmVsUW1zRs9XxE+9eNKFh2aJ/oaA3UaZ1KFqEVwxqIEX5QlFNAGYfNRZxyxfrU+jBSsshwtr1QXKnDzH7ydzM9OxJoHQyiRAer2GHsr/uHX0NOY83XpBvpK0ALQuE/STYReSvQOzhOBNqMUj9Oq3VIhoUJORvwhb1hJQju6bVM5BEQsof7KqrhsQCKyqyKfELwR1z+5I18Mk6m8QN67bg==
X-Microsoft-Antispam-PRVS: <AM0PR05MB44514AED866E16B94C30C979CFB40@AM0PR05MB4451.eurprd05.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3231232)(944501327)(52105095)(3002001)(93006095)(93001095)(6055026)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(20161123562045)(6072148)(201708071742011);SRVR:AM0PR05MB4451;BCL:0;PCL:0;RULEID:;SRVR:AM0PR05MB4451;
X-Forefront-PRVS: 0648FCFFA8
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(396003)(346002)(376002)(366004)(39860400002)(39380400002)(33656002)(305945005)(52116002)(47776003)(81166006)(478600001)(33896004)(9686003)(8676002)(53936002)(2906002)(8936002)(66066001)(7736002)(4326008)(36756003)(46656002)(5660300001)(9786002)(7416002)(186003)(54906003)(575784001)(83796002)(86362001)(26005)(9746002)(16586007)(3846002)(23726003)(50466002)(6116002)(1076002)(476003)(316002)(6916009)(2361001)(2351001)(386003)(57986006)(18370500001)(24400500001)(42262002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR05MB4451;H:mlx.ziepe.ca;FPR:;SPF:None;LANG:en;MLV:sfv;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM0PR05MB4451;23:W8f5R3hLhltdCz4s/DSSBJJL0yUF/dVNCiWAO8S1N?=
 =?us-ascii?Q?FpKtH28mmcd8G9B6HMKUmRThiPcl1P6jrRVUX3YNKR+y8hItpso9wZGxrhaL?=
 =?us-ascii?Q?roIgjoS8h6iXYK4QhR9bXH1TgU293xTI78dR3CezPtK+LGsNtjtGmNQKry4J?=
 =?us-ascii?Q?7AZbcGvChvXd1Jf49qZkLyD+cmwiZTftT/RRYrdJ2M01kY/iXr+l8s+cjVDP?=
 =?us-ascii?Q?BJ8WMe8RALFTK8Gnt3FJdrkYmPAi4RpX/nirOdiwEyEEMxjPy3hfrFJxAfi4?=
 =?us-ascii?Q?oCfq2qfUV2NYyIH3/P6Tq2wYsoPDv4lp1DxvSVqw9+QW3OUB52kHRgdgfJfK?=
 =?us-ascii?Q?UC/kLxsTCFlEZmOC7MnKgtwC5rxrJL9G1JTmEnM8/uK5vlvQOSlamN0fS56G?=
 =?us-ascii?Q?kbPbxhIQg0NoLfDtLKFzhZXi/T7gJr//z8P1Y62mNtlT/6VX6QKjuN0Smle5?=
 =?us-ascii?Q?0Oe4Cf3DRwgMvBvg8rzs1cAesDXid36Q/vTSoE/GHA8jw3DtFuIgg91vyvdh?=
 =?us-ascii?Q?oOHTwDGmsirYAuv/NzVyG/2/VGO2DPsxccjU9Gv2f+A4pyHhskpzLSjo6qE3?=
 =?us-ascii?Q?8NHP4mqwpXa3PeIwhfaTNyGp67yik5tSkO6yV1umfBMGzWiqP8biJAILf3y7?=
 =?us-ascii?Q?XqZsIm4+p0Lub2jan1lAfzvEP8Iw0s/6b2uPu/+3SbwO7hT6GmnNKzS3srY9?=
 =?us-ascii?Q?3XNrXh3+7ajHttmO5596j9LU5aRIAPPIcqdPCNxSDrJm9evMYu9DqUK5pLQV?=
 =?us-ascii?Q?MCR1srEwH5j4wIm/tGNFowcHcmw0YBc2Ya1d+TCCPRznodb8xj5rN1tLuDu6?=
 =?us-ascii?Q?ftE0DgNeOyJ1jw9kh25/7lAHK8nqoptvi9Bb6+XpbMbmgutu76aWn/nx5Sg5?=
 =?us-ascii?Q?J/xt9geUJrRjyugAkMGpbjMKmdvMPhJqiSbg+yR6n8FyzenGWvzbpV/8gqvV?=
 =?us-ascii?Q?vs8xeB6ofx5xVX3zoLwNrCz8H1AZ9FWNqxVTuAuskppmK7YKRG/YTFF2GD3r?=
 =?us-ascii?Q?RQv1k7GPzpx4xDE+jrUfOPmcvOwo91AAMT1dZEP0BxJ+zQ+I3l9LeGWK5/SC?=
 =?us-ascii?Q?RjOuPdCq/iZTYPZbfEQbK6HwaT68Gq3va5e77SLCI5uImoXqvaTIa7ueb5lR?=
 =?us-ascii?Q?Lg2z5Nva4Il/0GJTeVqJRcOotIQBKhR?=
X-Microsoft-Antispam-Message-Info: tgSC/wPREGVqvghVaThSbyuE7QSCueKRk//4pmnKk6LnJToKpl6VsdIaV9oN/AovzMqbNy3l14cUEuVN1NKeEyFkboYj9qlQeRNLTBpwDmoNshPzpQnIBMLvERZrsppSLBNZfzwC7LilCr6Sde92hWUsGVHfNkOnqXlqUudfCyAxb7lwJNVOrmOBeWxX21IY
X-Microsoft-Exchange-Diagnostics: 1;AM0PR05MB4451;6:QiJ8pPgKYHlOdao+PRGF5VJl6rF314DSBlQRyxIWZNlBAp5nDprfwxn1cdin5ZsqwWH0/mWkQrOb5EzZty96pG+GbTM6Ugd/Jm56RhZGNjKB+hLD4xtnmYbmuWlqG0n9J4rngOD8YM/dWLsKZtUxL1f2hJJH3gpKxTEHs2DlFeQcocvg6dUYyYsUvjodtesP7pSyVW4HTX3fJYvIzF0OXR5RRFnta/418Re5uoJth7fUcD3fIFpeDPh5VqGXBifmKEnqknqfX1pbd8NqDPE5xQVtDv+zky04kdfiJB9MVFMVAvnr4DNMkH5Gyz7di8qYWRxKhpkusmyPz5BzLpP3xzt4THQyoXzlOnDfVTsINCH6Ofqh9Ksf7+NgXz0vQ8ipL1BwIdBYiK99ZvkF6oRDr8dik0zL9ZdmZ6ag6zADOfMguP4vQDwB0UfxOQyLMT96OZzJfmIW+OCa4VfTzFNRlQ==;5:FnkU07PoyrX3uX4KVV8D2gnX5UgZHXL9ZmmK2b6J29XwFxvRf5Z+X1VFPNwkB+NvCvDf7HjVDFr7A+8rhFz6V8xsDt/C/WxxXDEzwU0O/C1AZ3IvxuyztW7Yp+ifENXMHSA/QriqJCLFN63BjK/t0CEW58uUD+LI5VKLAYWNbQ0=;24:jegErr+O3pfLfqkvbaFqdkGVPHjcZyQu2rsqtZnFReIRSEZjEe0whBPtMzg9XNaf3jlX8041K9Yh2YNxsgUAoSXwD+XDP0H1kds85Ub7ub4=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM0PR05MB4451;7:la5uYVgqvDlJt8am3OLv46HVTHvjPz1pp3hYhg+1F2Pj/yTsDEn0yV9x6t4EOVYhYkXU5/5HSnCV5wFFsxbyCqmdPLGrTqwgtNVPri6rVMcmMrJUQZg+reyL9dg98KdUsRuWthwNJQp241B27VVcYt0iqSgI4WXEyJ3FFM28Tn71bTbHasIK27xTqpTyxd2asWNxAeSbQyJi3yiQL8GScjqfs8rfbUf+N+egM194ODBXmzRDb0Vj8ieoFqH28wFt
X-MS-Office365-Filtering-Correlation-Id: 38bcff51-38b8-4dc0-03f2-08d5a6d64a14
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2018 15:49:23.6956 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 38bcff51-38b8-4dc0-03f2-08d5a6d64a14
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR05MB4451
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598280819210868767?=
X-GMAIL-MSGID: =?utf-8?q?1598280819210868767?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Based on discussion with Kate Stewart this license is not a
BSD-2-Clause, but is now formally identified as Linux-OpenIB
by SPDX.

The key difference between the licenses is in the 'warranty'
paragraph.

if_infiniband.h refers to the 'OpenIB.org' license, but
does not include the text, instead it links to an obsolete
web site that contains a license that matches the BSD-2-Clause
SPX. There is no 'three clause' version of the OpenIB.org
license.

Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
---
 include/uapi/linux/if_infiniband.h      | 2 +-
 include/uapi/linux/rds.h                | 2 +-
 include/uapi/linux/tls.h                | 2 +-
 include/uapi/rdma/cxgb3-abi.h           | 2 +-
 include/uapi/rdma/cxgb4-abi.h           | 2 +-
 include/uapi/rdma/hns-abi.h             | 2 +-
 include/uapi/rdma/ib_user_cm.h          | 2 +-
 include/uapi/rdma/ib_user_ioctl_verbs.h | 2 +-
 include/uapi/rdma/ib_user_mad.h         | 2 +-
 include/uapi/rdma/ib_user_sa.h          | 2 +-
 include/uapi/rdma/ib_user_verbs.h       | 2 +-
 include/uapi/rdma/mlx4-abi.h            | 2 +-
 include/uapi/rdma/mlx5-abi.h            | 2 +-
 include/uapi/rdma/mthca-abi.h           | 2 +-
 include/uapi/rdma/nes-abi.h             | 2 +-
 include/uapi/rdma/qedr-abi.h            | 2 +-
 include/uapi/rdma/rdma_user_cm.h        | 2 +-
 include/uapi/rdma/rdma_user_ioctl.h     | 2 +-
 include/uapi/rdma/rdma_user_rxe.h       | 2 +-
 19 files changed, 19 insertions(+), 19 deletions(-)

I propose to send this patch through the RDMA tree.

diff --git a/include/uapi/linux/if_infiniband.h b/include/uapi/linux/if_infiniband.h
index 050b92dcf8cf40..0fc33bf30e45a1 100644
--- a/include/uapi/linux/if_infiniband.h
+++ b/include/uapi/linux/if_infiniband.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause) */
+/* SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-2-Clause) */
 /*
  * This software is available to you under a choice of one of two
  * licenses.  You may choose to be licensed under the terms of the GNU
diff --git a/include/uapi/linux/rds.h b/include/uapi/linux/rds.h
index a66b213de3d7a4..20c6bd0b00079e 100644
--- a/include/uapi/linux/rds.h
+++ b/include/uapi/linux/rds.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-2-Clause) */
+/* SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR Linux-OpenIB) */
 /*
  * Copyright (c) 2008 Oracle.  All rights reserved.
  *
diff --git a/include/uapi/linux/tls.h b/include/uapi/linux/tls.h
index c6633e97eca40b..ff02287495ac56 100644
--- a/include/uapi/linux/tls.h
+++ b/include/uapi/linux/tls.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-2-Clause) */
+/* SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR Linux-OpenIB) */
 /*
  * Copyright (c) 2016-2017, Mellanox Technologies. All rights reserved.
  *
diff --git a/include/uapi/rdma/cxgb3-abi.h b/include/uapi/rdma/cxgb3-abi.h
index 9acb4b7a624633..85aed672f43e65 100644
--- a/include/uapi/rdma/cxgb3-abi.h
+++ b/include/uapi/rdma/cxgb3-abi.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-2-Clause) */
+/* SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR Linux-OpenIB) */
 /*
  * Copyright (c) 2006 Chelsio, Inc. All rights reserved.
  *
diff --git a/include/uapi/rdma/cxgb4-abi.h b/include/uapi/rdma/cxgb4-abi.h
index 1fefd0140c26f6..a159ba8dcf8f13 100644
--- a/include/uapi/rdma/cxgb4-abi.h
+++ b/include/uapi/rdma/cxgb4-abi.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-2-Clause) */
+/* SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR Linux-OpenIB) */
 /*
  * Copyright (c) 2009-2010 Chelsio, Inc. All rights reserved.
  *
diff --git a/include/uapi/rdma/hns-abi.h b/include/uapi/rdma/hns-abi.h
index 7092c8de4bd883..78613b609fa846 100644
--- a/include/uapi/rdma/hns-abi.h
+++ b/include/uapi/rdma/hns-abi.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-2-Clause) */
+/* SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR Linux-OpenIB) */
 /*
  * Copyright (c) 2016 Hisilicon Limited.
  *
diff --git a/include/uapi/rdma/ib_user_cm.h b/include/uapi/rdma/ib_user_cm.h
index 4a8f9562f7cd9b..e2709bb8cb1802 100644
--- a/include/uapi/rdma/ib_user_cm.h
+++ b/include/uapi/rdma/ib_user_cm.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-2-Clause) */
+/* SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR Linux-OpenIB) */
 /*
  * Copyright (c) 2005 Topspin Communications.  All rights reserved.
  * Copyright (c) 2005 Intel Corporation.  All rights reserved.
diff --git a/include/uapi/rdma/ib_user_ioctl_verbs.h b/include/uapi/rdma/ib_user_ioctl_verbs.h
index 04e46ea517d328..625545d862d7e4 100644
--- a/include/uapi/rdma/ib_user_ioctl_verbs.h
+++ b/include/uapi/rdma/ib_user_ioctl_verbs.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-2-Clause) */
+/* SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR Linux-OpenIB) */
 /*
  * Copyright (c) 2017-2018, Mellanox Technologies inc.  All rights reserved.
  *
diff --git a/include/uapi/rdma/ib_user_mad.h b/include/uapi/rdma/ib_user_mad.h
index ef92118dad9770..90c0cf228020dc 100644
--- a/include/uapi/rdma/ib_user_mad.h
+++ b/include/uapi/rdma/ib_user_mad.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-2-Clause) */
+/* SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR Linux-OpenIB) */
 /*
  * Copyright (c) 2004 Topspin Communications.  All rights reserved.
  * Copyright (c) 2005 Voltaire, Inc. All rights reserved.
diff --git a/include/uapi/rdma/ib_user_sa.h b/include/uapi/rdma/ib_user_sa.h
index 0d2607f0cd20c3..435155d6e1c6a5 100644
--- a/include/uapi/rdma/ib_user_sa.h
+++ b/include/uapi/rdma/ib_user_sa.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-2-Clause) */
+/* SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR Linux-OpenIB) */
 /*
  * Copyright (c) 2005 Intel Corporation.  All rights reserved.
  *
diff --git a/include/uapi/rdma/ib_user_verbs.h b/include/uapi/rdma/ib_user_verbs.h
index 9be07394fdbe50..6aeb03315b0bd5 100644
--- a/include/uapi/rdma/ib_user_verbs.h
+++ b/include/uapi/rdma/ib_user_verbs.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-2-Clause) */
+/* SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR Linux-OpenIB) */
 /*
  * Copyright (c) 2005 Topspin Communications.  All rights reserved.
  * Copyright (c) 2005, 2006 Cisco Systems.  All rights reserved.
diff --git a/include/uapi/rdma/mlx4-abi.h b/include/uapi/rdma/mlx4-abi.h
index 04f64bc4045f1b..f745575281756d 100644
--- a/include/uapi/rdma/mlx4-abi.h
+++ b/include/uapi/rdma/mlx4-abi.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-2-Clause) */
+/* SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR Linux-OpenIB) */
 /*
  * Copyright (c) 2007 Cisco Systems, Inc. All rights reserved.
  * Copyright (c) 2007, 2008 Mellanox Technologies. All rights reserved.
diff --git a/include/uapi/rdma/mlx5-abi.h b/include/uapi/rdma/mlx5-abi.h
index cb4a02c4a1cef0..fdaf00e206498c 100644
--- a/include/uapi/rdma/mlx5-abi.h
+++ b/include/uapi/rdma/mlx5-abi.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-2-Clause) */
+/* SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR Linux-OpenIB) */
 /*
  * Copyright (c) 2013-2015, Mellanox Technologies. All rights reserved.
  *
diff --git a/include/uapi/rdma/mthca-abi.h b/include/uapi/rdma/mthca-abi.h
index ac756cd9e80772..91b12e1a6f43ce 100644
--- a/include/uapi/rdma/mthca-abi.h
+++ b/include/uapi/rdma/mthca-abi.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-2-Clause) */
+/* SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR Linux-OpenIB) */
 /*
  * Copyright (c) 2005 Topspin Communications.  All rights reserved.
  * Copyright (c) 2005, 2006 Cisco Systems.  All rights reserved.
diff --git a/include/uapi/rdma/nes-abi.h b/include/uapi/rdma/nes-abi.h
index 35bfd4015d0705..f80495baa9697e 100644
--- a/include/uapi/rdma/nes-abi.h
+++ b/include/uapi/rdma/nes-abi.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-2-Clause) */
+/* SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR Linux-OpenIB) */
 /*
  * Copyright (c) 2006 - 2011 Intel Corporation.  All rights reserved.
  * Copyright (c) 2005 Topspin Communications.  All rights reserved.
diff --git a/include/uapi/rdma/qedr-abi.h b/include/uapi/rdma/qedr-abi.h
index 8ba098900e9aac..24c658b3c79042 100644
--- a/include/uapi/rdma/qedr-abi.h
+++ b/include/uapi/rdma/qedr-abi.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-2-Clause) */
+/* SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR Linux-OpenIB) */
 /* QLogic qedr NIC Driver
  * Copyright (c) 2015-2016  QLogic Corporation
  *
diff --git a/include/uapi/rdma/rdma_user_cm.h b/include/uapi/rdma/rdma_user_cm.h
index e1269024af47f0..0d1e78ebad0515 100644
--- a/include/uapi/rdma/rdma_user_cm.h
+++ b/include/uapi/rdma/rdma_user_cm.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-2-Clause) */
+/* SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR Linux-OpenIB) */
 /*
  * Copyright (c) 2005-2006 Intel Corporation.  All rights reserved.
  *
diff --git a/include/uapi/rdma/rdma_user_ioctl.h b/include/uapi/rdma/rdma_user_ioctl.h
index d223f4164a0f8d..d92d2721b28c5b 100644
--- a/include/uapi/rdma/rdma_user_ioctl.h
+++ b/include/uapi/rdma/rdma_user_ioctl.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-2-Clause) */
+/* SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR Linux-OpenIB) */
 /*
  * Copyright (c) 2016 Mellanox Technologies, LTD. All rights reserved.
  *
diff --git a/include/uapi/rdma/rdma_user_rxe.h b/include/uapi/rdma/rdma_user_rxe.h
index 1f8a9e7daea43e..44ef6a3b7afc8c 100644
--- a/include/uapi/rdma/rdma_user_rxe.h
+++ b/include/uapi/rdma/rdma_user_rxe.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-2-Clause) */
+/* SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR Linux-OpenIB) */
 /*
  * Copyright (c) 2016 Mellanox Technologies Ltd. All rights reserved.
  *
-- 
2.17.0
