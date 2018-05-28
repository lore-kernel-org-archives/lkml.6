Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932735AbeE1P6O (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 11:58:14 -0400
Received: from mail-eopbgr00075.outbound.protection.outlook.com ([40.107.0.75]:57505
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932523AbeE1P6B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 11:58:01 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com;
Date: Mon, 28 May 2018 09:57:47 -0600
From: Jason Gunthorpe <jgg@mellanox.com>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Doug Ledford <dledford@redhat.com>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: Signed-off-by missing for commits in the rdma tree
Message-ID: <20180528155747.GC17491@mellanox.com>
References: <20180526132829.0cbb8826@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180526132829.0cbb8826@canb.auug.org.au>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [174.3.196.123]
X-ClientProxiedBy: LO2P265CA0034.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:61::22) To AM0PR05MB4450.eurprd05.prod.outlook.com
 (2603:10a6:208:5a::23)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:AM0PR05MB4450;
X-Microsoft-Exchange-Diagnostics: 1;AM0PR05MB4450;3:0Tn0JIrL89uv3wta++dHfteMO1USWRtp4EuVua3/7brfQjMnmOtOsvvTXKRdi+aLDEMIphuASlVV1RRjOfY17n9hMpby5r3KbG/Cs/xKK8sEydhpa9v1Cu6C4ZESKORHgOTQwQKVd1LbgQa76p4I0n8jo4ON5um5gIEw52aFOnoQZrE80NILkTX2UEz27DqvUSHw7vT9PJFr5ovmDEt3hp6aHWFrL/+J+ajKZ2vMMupAem2GUlZMjHvXV4fxG8us;25:I43HZNAL3yh2WdwGgy7uUaExDDgnFftpHtNh1SbLhvIGcbL9eYdfGAM2bNzwtGwuQ+Me0eflDTZYeueSjCjIFb63sSc9r5giwWGcn0OhJXVGewapndrrp7Ian5WTXJPhBxML1n2iz9DYSXW3INXm17M41ZUiHBDR52aGBuGjzMm2FKTR+rMgr7ZBBmTwtpCag3RkFka2vECsgyIGxgYO26drQE0pOEAUcHYglmdp1X4mOVHaD6pWBPbZsuAUaz8GnBuXWA1lC3GMlBHK8F0p/b9vZbO20voTfAq7JQUu58rO9Z2r5ZlLl35nnFwI8oT3wt0FdBewvaAIPKmoprGuXA==;31:vE7hSYOH+/jNv/AsUFu1MpIpq/r1qQWQaHaKlVqt0mW2XFkQnDER3da8riQhVqUBfbJ5xgWD2eGDLdO6omr2haawgsiQgsA83dNCv7AGU21Snk5QueKSCWRY3ADxKBl+YyFPlkZ8qPn9sEFSmKDCc5+r2GZ9cHEhuMT9/mR7RDRP3AXKIX0NbVqx79sua8AM7YPaxlgVZbWhsUYrOr56SVyX0y6DKM0jfj+Vbzy6LIk=
X-MS-TrafficTypeDiagnostic: AM0PR05MB4450:
X-Microsoft-Exchange-Diagnostics: 1;AM0PR05MB4450;20:+ttIJ/xJSs7QmkApmVoC/IPTrcz9eXWS707xrHG07kDdjjzD5EmVdeUWMGm2AyvIf9W6w5J3ZVzp+n/JOYr/4WDDfvtgvlwl2zih/OIF141Sgpb6jmd50ZMArAq5ahEyKq591VON/W9KZgF52trHqALkLFp54/EnjJn75BN2yQdpfZwG5C4lYWNcN48pivpUwx+YMgIEpZS/nolgu0F6NZ9wZp0XJ7zsdA1xOFKFxVjC2hMbPbvIdLE5EpR4lPEprSbm6oxlYINeyNH1GazXp/Pap+V2NDz0OzDVw9tooHRyPi7lvHplt86cP8sQ9N4MwQ9oi/IZOVVMUyOA+p6hBmY5Dt6hi8/Yjd2UXVTZT1rvK6dHFLnyiAneH5yY3xxrIkaddub9x9VkewdKJu1RlQ+vP9BRHpmWo/dufN9AwnvSvsGs90/cQrZno8vRSftPQU8RfrVJDoeUqAhAtPJnPKNPttHzQ0utdtCAky65CV1ReG+B6oVZibePDB0MW1GQ;4:4/1sa4izdweJDVSS3fjdlF4y25vpyJ66a3mykL3d89zWAhXab0B3PPR/gBAYWJGX3f4LuuVQxZsEqPmpHLWxWaAsxhHm3YH2GhcP5v3825PXAKJSFKCWfp638WYcNhlx7xuStC6HQnpAEy6slV3VI4GB8Aj3t0CvH5DLQpr5AWhG0AVTj41DeMDoyXopFDFI83GHjMMpotnatjI2+NbgJPKtXQC1KFAKGNkAH3hp8tOTsCGX0TVH1P14SByMAh05mAouDBLis7ypfB+wi6vkKA==
X-Microsoft-Antispam-PRVS: <AM0PR05MB4450BEA21C772B870A37005ECF6E0@AM0PR05MB4450.eurprd05.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(93006095)(93001095)(3002001)(3231254)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:AM0PR05MB4450;BCL:0;PCL:0;RULEID:;SRVR:AM0PR05MB4450;
X-Forefront-PRVS: 06860EDC7B
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(396003)(39380400002)(39860400002)(366004)(346002)(376002)(53754006)(189003)(199004)(23726003)(53936002)(76176011)(229853002)(3846002)(11346002)(52116002)(50466002)(6116002)(478600001)(386003)(6246003)(446003)(1076002)(8676002)(46656002)(69596002)(66066001)(81166006)(33656002)(68736007)(59450400001)(122856001)(81156014)(2616005)(476003)(47776003)(4326008)(9746002)(9786002)(486006)(8936002)(7736002)(97736004)(305945005)(186003)(86362001)(16586007)(316002)(54906003)(58126008)(2906002)(36756003)(106356001)(83796002)(6916009)(105586002)(57986006)(5660300001)(26005)(18370500001)(24400500001)(42262002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR05MB4450;H:mlx.ziepe.ca;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM0PR05MB4450;23:WMYYj0EHtQSX5Yeb33ZArSmIXzqp38rOsbWubVmXd?=
 =?us-ascii?Q?IYVMCmr85uVQ79Re84kNUvqBDRUCDLN4zk9eqZOSXkXydb5TMzIA5j7z81hj?=
 =?us-ascii?Q?IrO+k76fZT0M7GRj9nPcCw0jh5Ak3DyEVXtJkRrVI4JyuE/TToEn7IROUcW4?=
 =?us-ascii?Q?M48X3aS9w88mlhLBVGVQVi47sIdCaDygjxYMzl+sRKAohbhaaK+CFXSjz5f0?=
 =?us-ascii?Q?rJSL7SpMvupRJbwfkj0CQeMdcUlI63tW2QcCI6riVYoCBIZ/b0unPNuu1DP3?=
 =?us-ascii?Q?q2UuUXF0wiPLzyD1TN8FJDfRmFP2LufKU3NZ9OGD1dAEFQdInht4aktYu/+n?=
 =?us-ascii?Q?DqFjafFwR4zxcsLjAJ5rOh4it9hKOptw/k3TRwf9O0eZDlIyCzyfMg79SmgG?=
 =?us-ascii?Q?aHM1fMcRn8mApqByW1j/tkr/xEvRtLy3i51BUK5h+B9X9MzJMq9CgyZMLnlM?=
 =?us-ascii?Q?GfTqsBYGEeX9ruSz/f9OVXX/L6CpDFQF2r3m2EVZc+Sy8Rrb5lGm6tmEQAgk?=
 =?us-ascii?Q?eX6hqZpLxlk5YuakIIYwcVlsrRKVxmFnuLEYuuF/BrqbDMqqvJnFAObDMFhJ?=
 =?us-ascii?Q?s1xOKfDM921gFZuH+sm+m5673+LEL7CkapYLNOyzSlWflIEp9A3sAhHVWnja?=
 =?us-ascii?Q?FtSLy4Vp25BlfLYa68TJDx6yRdbWjQq7LsYletoMw69Upa0WslnN1oUqiK1/?=
 =?us-ascii?Q?CsvNkKJwIUguWlnfXQMU1waRWn1mWWlRYlb4zma29gKV4G7wvUKOMXjZBVwp?=
 =?us-ascii?Q?qnmuuP197cRezsEUF3U0ei1t7eybxdDsMO3OQS86oSm/csDP9O8oSIX0NmH2?=
 =?us-ascii?Q?/dTWIxq+BKuwDcAJqcRnHrbO21nPyYdhb+iIYCE9Pqa5wxryuT5iKMOUM6SE?=
 =?us-ascii?Q?jhRtWa9JTX1iWljn9ot6B/4YYwBf1tpXo9He9+vYTK2UIz2Djw3C4HupEYYS?=
 =?us-ascii?Q?foVv9VOMndFWdKOi+AKaW52XU3qrSyL4KQo0JDUzW1khba657k9accngOPER?=
 =?us-ascii?Q?gO5vyU5szX3JqfSlq1arNaVt7gMMkn/x+m3vu26YmwksKfNodW5SjZNKiOGC?=
 =?us-ascii?Q?27QxYsbX81zb+rXCPeQmQyBs2iY9KHuYcvnqDHtHr2KC3yoyPNsgGBqg6jE/?=
 =?us-ascii?Q?n09Mk8eb6EuGJC8rnXTexFvL0hzFPGJgbR8bm7Dvne10nxQr39KYknTjP0pV?=
 =?us-ascii?Q?1xV/eCpVJzAeDOvKS1+y1adTh5xBFAYhh2DvETdlYZNRVYm1PnehyuLPyseI?=
 =?us-ascii?Q?ecnQ38FOd22mvIKt02pILLH5yfToLez/pqdDaIU1Lnn/GEd8etHLEipuu/+2?=
 =?us-ascii?Q?Em1cboMpNTn5kcK+V7kS2cPRFduGnBjYgw1WKe36VcDI/f3ngwTUN6mqsW8P?=
 =?us-ascii?Q?fb/sHwweUowq85WQNfoQnjLI5vm3is37IDzfsShSP5QNAQT?=
X-Microsoft-Antispam-Message-Info: 4+wv7MvUjsTH/Ozn5McbRGoVFvvtxf/FHtiC8uUans4s7SIGgAFKfr1fnri8dOumzHaeUGfC81jQga766KsLbyeIKy57Tj4x/cYW7fAAmnrlh6KlZQ7Wjmk5Yc9/u2JIHanWsQsabPt8BXnrsfFBEePhC6POYdCor506jyBFDAc86OOnvPE1pfRCWAUKrP/5
X-Microsoft-Exchange-Diagnostics: 1;AM0PR05MB4450;6:MBLmnxpimjYcG7qBrPItSiKqSeOh0LrTSorf2IonbegE0Arq4VMFU5gEp65EwK2fmqgqi4pPpoiUEC+NSON/sOUQBAlerY73xrz8OolBMNLeh1NHZHWxliwf6FBLnj/SmrYK5vpXzJ++MgQkRAGCdWt+eK7yHIkvutaKAPs05QH9TYZLNeJnhx5uy3jebPZjmcu+DBn0kxzFp9xcbMh4SD2i6TuUL7P9IMyGbwBTX1wh0ewxLzO9zskLqlPxcW9c3Yvgoi4OLAHYGDWON4d+WTr9xP8WSSGJq0CN9vO/IGmcXdMjzNE61XMF+QIXyULWnp+RPGq0acqXd6gEFbes3DpTPPUzJjY8o1ui66UPSr0cYG+obzpz+47sFGTS9z2nEqXfRfMyxWOuIzXCuVQTQtivlPGWxQZXnAzBddvi6lIlQCUKs0mnS0tB4HYw3xgOsZOR+98ygCw12wn2h0Perw==;5:DU7OhDpEU9+T4H5aFU50ZsKHDRiuoS5LLMRtvi47CbuOeWLMYmK0qS5mfWU4CH6x+ebXc4rygl5WO6jf5M0bEidB2ZWsDOVJcbbYaUv9TxpQxi0S5SI3VYU/a2sxE6F46z5g/XUq7WD//VgaWrHl8sMreDHjJyboWWruwnLYfcg=;24:5Zj+r7zJSvgue7Y2UdD+8uMqoNSNt04w1ExAEbXokxxfF9UFbTLbj+D2XgkRzJBAkVwSMzxokN5mvpilWKPxdjd1zOZnF4Yu9XJzXFxZ3rA=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM0PR05MB4450;7:pD7G8jhdRngI+BEAqVi/czGxgJT1sUAok72sdw/Rm+dr5oMyKJsWCBnpKUOKg9ydz/7WiODoJh5LmUsAJErc9CR/gPaME/6uu26cNUhLZd8n9STuqTwGQz7VOEnZk290PRcZkktAChg09bW4HI1CHUMS3AvX9yVnse8zOFYYnqT6YMcqo+Piy509u1bVkDdF60ptYFFdDiGLU0u7w6PZTzwWQBpY4p3pj1LnYy6OVniXPetjosxjQ3mMI7NbZ3SD
X-MS-Office365-Filtering-Correlation-Id: 8b59c2e4-e5a5-489f-f3b3-08d5c4b3c552
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2018 15:57:52.9900 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b59c2e4-e5a5-489f-f3b3-08d5c4b3c552
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR05MB4450
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 26, 2018 at 01:31:12PM +1000, Stephen Rothwell wrote:
> Hi all,
> 
> Commits
> 
>   116aeb887371 ("iw_cxgb4: provide detailed provider-specific CM_ID information")
> to
>   0252f73334f9 ("IB/qib: Fix DMA api warning with debug kernel")
> 
> are missing a Signed-off-by from their committer.  I presume they have
> been rebased?

Yes, there was a compilation problem and I rebased some of Doug's
commits before finalizing them.

Jason
