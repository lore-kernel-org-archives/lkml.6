Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1032685AbeE0PFP (ORCPT <rfc822;w@1wt.eu>);
        Sun, 27 May 2018 11:05:15 -0400
Received: from mail-eopbgr30081.outbound.protection.outlook.com ([40.107.3.81]:64864
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S965484AbeE0PFL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 May 2018 11:05:11 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=leonro@mellanox.com;
Date: Sun, 27 May 2018 18:05:00 +0300
From: Leon Romanovsky <leonro@mellanox.com>
To: "Wei Hu (Xavier)" <xavier.huwei@huawei.com>
Cc: dledford@redhat.com, jgg@ziepe.ca, linux-rdma@vger.kernel.org,
        lijun_nudt@163.com, oulijun@huawei.com, charles.chenxin@huawei.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V3 rdma-next 3/4] RDMA/uverbs: Hoist the common process
 of disassociate_ucontext into ib core
Message-ID: <20180527150500.GA3085@mtr-leonro.mtl.com>
References: <1527324107-56593-1-git-send-email-xavier.huwei@huawei.com>
 <1527324107-56593-4-git-send-email-xavier.huwei@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="PEIAKu/WMn1b1Hv9"
Content-Disposition: inline
In-Reply-To: <1527324107-56593-4-git-send-email-xavier.huwei@huawei.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
X-Originating-IP: [5.29.173.205]
X-ClientProxiedBy: CWLP265CA0249.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:401:25::21) To HE1PR05MB3257.eurprd05.prod.outlook.com
 (2603:10a6:7:35::19)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:HE1PR05MB3257;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR05MB3257;3:v+l6JgruGAGTP4vig47PV8+z7X9dwNVWoUP8Mk2fmWSzgiwjyY0HJdhJhMktmORsp5OhmViQszS0Di/uZfnzDxTF6DjSTEBKhTtWbC7TCIzNuu1IY8GKX8/T5CQ5+njx0KTdbCCc9mdcGsc0JWogJDm2CuS7we5bzPIIvrlJcUuhKxLuTxm1NVQDQZjL4mHQe1CYFqbbD8Q0M8axOAstgdlt2JIrU+em2CEwb20CR0BYzNS8f86+zNe4bTXL/Dpx;25:sFZy56VjY+Y1yysKVV9ywjdhnOuHvpT8KCI1NckJV+BM5S65WownQBmmWw/bBhCUqR67kqU4mNrd29KZYthJatOcKqBSlbQNGjggQd/KWwGJ05cTHR2Os0OZGA38T/wXons1xuFwtT/xu7UbzB9oviRxTGCO59hH1N4J6S/kFSf7X07rkJe7Sj5d26vPRpwE8cZVS9yifNr7pxvIcMx/WzdZ41JByd6PeEfyG4Nm0tmS4c22huM78GSvPR8bC5SIUiqkejmf8hTZnqcpWiLGYbIjzdX0ZygxCfpclvtBKlHKWikgmVBKjog028fuUifaOQ97NriJWd23gOBcp8dBqA==;31:8tbCTlQFiWDtIDfvcZZYAbD1keRxeR4SEtuk2QQMQ91ECdSf+V++VYhxhVvM3/kF2MY/UbfTWPPjon8xWUoPZEbNx8UgB5d+KTutrjUcn4xVWLmsPyrnd1uViVzzhjWQMD2AztloQlxoz8IPafiN6XBVzw438ppSByHjaanEmHXw2b+YPqXVupC+S7bf8udKUxF6mqnMWbVRf+pabUJ0I1V1OoP230xPvk77UkpxS/0=
X-MS-TrafficTypeDiagnostic: HE1PR05MB3257:
X-Microsoft-Exchange-Diagnostics: 1;HE1PR05MB3257;20:w92gxoavtMZYZFUMT1IlX5JE62DnDfgQx/zaS1LFYfW5rkzbAzU6mbH4JL3PcBHfKRkPX7Xg3g0QsxJiphaxL7MlNX/vLkbqHw831dWK8sgCndMYrI4XpoIHfbwgFwaferNwIvKDltmZE/IXbtRfklc19LedsiaXS18bc3HWA79OvlWWQUG0A7yC6Ajlnm5xIFp2LRvea7y+XWodcx0SVcLw08SpLV2UzllxijNVZL/YnszZMOoFiwCHEyyL5JcEFHaF1d4kxn6pU2HJZvilQWWXJAL5uIj+0Ybhy1QUDjgBn9aME0KwHbIT4pp53kkgnlTSRlkliXpvznU4JmDwFAQ1ARlG1aRFlacy5n+GGvKRqn8IKYhzbgSt2lpIYa469TuF5jT/Nfax5UxPH/rgPuDc7p3X9jMBVbRrVjfLna0ebtytzxFk7I39wdmT6HleaA1PKEIxvlzSnOjM23Nvt9FdcQbPPva1UMft9mWjr8pTFnwmKwvHS8lJCzXsxM3t;4:Fk2uPOUKok130sIoMBdi2dblIO0swS+fR2ifvf1gqHbPucCgbmQpXwR/vI+HO+2e4fX5SMT8J3vFEG88lpzSvi2eUtEj1SWo+yxVZsfqSl7hPTHFeSKi2NDPf3utp2Xthtx/efVHF8FOU97kTXklpQ8Syf14qovuQqq72srnE7J3fw3zkLKmBZMNSzTx2YCalXQlI/d6qr+14gDHg9XY1jcVC7fLYHqxx1LPqjj1op+hR/RBRELLEzozu4jkt8c5dOz4S9/PBhHBRcWwFYvnoIYCRPkJ28X1zCTizqIhyDB9tSBUPg4Zt+cCS/G8pfc9
X-Microsoft-Antispam-PRVS: <HE1PR05MB3257CBEA212DF402B4A3781AB06F0@HE1PR05MB3257.eurprd05.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(50582790962513);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(93006095)(93001095)(3231254)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(6072148)(201708071742011)(7699016);SRVR:HE1PR05MB3257;BCL:0;PCL:0;RULEID:;SRVR:HE1PR05MB3257;
X-Forefront-PRVS: 0685122203
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6069001)(39860400002)(366004)(39380400002)(396003)(346002)(376002)(189003)(199004)(4326008)(63394003)(106356001)(2906002)(6916009)(6496006)(66066001)(229853002)(33656002)(52116002)(105586002)(11346002)(476003)(97736004)(956004)(486006)(5660300001)(3846002)(1076002)(71446004)(6666003)(86362001)(575784001)(6116002)(21480400003)(26005)(9686003)(25786009)(76176011)(81156014)(8676002)(316002)(81166006)(446003)(76506005)(16586007)(6486002)(33896004)(58126008)(53936002)(44144004)(186003)(84326002)(478600001)(6246003)(68736007)(8936002)(386003)(305945005)(59450400001)(16526019)(7736002)(18370500001)(2700100001);DIR:OUT;SFP:1101;SCL:1;SRVR:HE1PR05MB3257;H:localhost;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;HE1PR05MB3257;23:GpPb+QTmv8uJc/fIlg7gQrJ2qP3D0mkhGxyKY4DJI?=
 =?us-ascii?Q?ShsoaosaxNHvy/u5exdn8vC2IbmvxT1kqULcNw3XL5j5HwHaP5JBVRYEllaM?=
 =?us-ascii?Q?xZx26yBNFYaIPJZ+WjLmtWoCR+VjYx33mAxYdDK4KhI8Y09wsM1rhkB0dTmz?=
 =?us-ascii?Q?DTrIZxqEkt6SKWYssuk3WjxveC7NQDefcdL+w408Qj0Z9EKRJVr7eX8xH2lB?=
 =?us-ascii?Q?APIcBDPkuccYDtUrfhI4/NBbJRwHtDKP3IWvIoOmrQND6ywr9v/wUlQBeOhI?=
 =?us-ascii?Q?xec9PdFP+FEfsbe30m7rlb+wDMSn+iNCBeiH13MKiHV0gXBXDtznKBBCVebm?=
 =?us-ascii?Q?f1r8x8VsqnPBhMLCos7sFmLnZSDR7EFN5L10Tb9lnIc4PODlE8xQs5bunA6L?=
 =?us-ascii?Q?CG8z1WAbIEsmV87ZHmaRFCkWXZVjTK0SFAMiOL8MDkC+9rxNzJn+gGdGZTEu?=
 =?us-ascii?Q?tL8uwpLyXmJTk1d8LpRVQnQ9cZc8WhayUZQ7VhPrDMZe409LAX2Wgu9AiHON?=
 =?us-ascii?Q?8D4/jf+WR5vyPJhLahSvzQ0yXRutpp2BsLqHtux+aWh8D5qQlh8Pc/MtAGvI?=
 =?us-ascii?Q?h9VUSrhTtKqgQW3l16eGA+9OyYg0g/UfFEIZzCQHR8ESmfvGNamTdj/egPgl?=
 =?us-ascii?Q?pSAi8WXLcDLYO5Z1yJtTzcG4gUqDMhlg0mdd/MrbtwpCuMPXcou4X3cPt1v/?=
 =?us-ascii?Q?zDfSxOQQPdT8dWc/Q97oFtSz2NdZM/i4XerDAKkQA5Jf2cYF6IoNlo6PG3vr?=
 =?us-ascii?Q?RSzew+0GPXD4wWZrP2isXZ/UJ/MhM5seNbX/QUkXAzmrLJU4cDV9Itv6+WwW?=
 =?us-ascii?Q?7/TUpS8BGQ22LnBfkBj1aH9i9/8DuLZvrFR+PcmL543chum8DkJcbcYpOmVI?=
 =?us-ascii?Q?cTp9aWlSUNjGxDzw31trrnn8XsKETBCMfj0Z/oQ6EmtlPLrMWwR27X5V5vJL?=
 =?us-ascii?Q?Br3dCfAZa1LVfWovVyAq5sVHmAg2lfe/OrlwYA+TLVA+cbqnaO246HwL1uci?=
 =?us-ascii?Q?DIdE1z2wNyqOeg8Q7+OqwNvtndNLQ+DmbAdOtQwBsY7xddnIfxsU1h4snfWV?=
 =?us-ascii?Q?uYzcLWsyfqTBdioXOuWja4YySNJESf+1lrjT3wYJbkj2b0tfl4BYjnq18kCi?=
 =?us-ascii?Q?fgYV05pfzPm9W61PPa9kwPuH0tW9M6rEgAF6IFOHco2xwbT0swxp0wUR6Kmy?=
 =?us-ascii?Q?B2VizMSI2Gwk/GNJ8p5jZJGf+tWQehRSq185Kkzy052sEUEQvcY5Zx6mm5qA?=
 =?us-ascii?Q?aXhnsuIwGpWxpRkmyZRO52IrMdeP2Nwp0HtL2UN4mLyUbKhL9WmFM98RpFXl?=
 =?us-ascii?Q?TyC/avzTnNh/S52f4rG5VlgsRENHVu/eS6dfphhzyEDRvqiNLsOwaSPSQIug?=
 =?us-ascii?Q?B98pWv5CpH7Uky6Dv3RfK6eJqzuJnKa1LGwjeNgNHIj37TZ?=
X-Microsoft-Antispam-Message-Info: xQprcMwPREUhy2wz3xMRA+UsXr0ojeA5/PWUmKhU7tQ+duxs748xsn3nXsE4mqybU8YdijnwZpYhtsKvGWSa3YZ8bi1KMg35W0xAV2Or4OYFgp1BwSayvfyM0jj7ked/sG2nUKxTTutfiaPlG8ajeXuaBUzr1J5HihYVqTVul7Kn1ZxpOTiqIddw4Iv0k3Jp
X-Microsoft-Exchange-Diagnostics: 1;HE1PR05MB3257;6:uqKff++GU0oRqEAyOOmcOM4YBe5Ig2xbnWIzBsNsET0GPFGtHeFGJqVKliKcCm4waXZlkLCtZDIQNEORim6kxAk/6jXBFzI9tBsw6nplkLwYA1zzMckP563NyOJLhWjsGhI7jN167kwTNE/yHXSOZyLYfinWwfkvmj+0UqsdqSfCP4zTjiDnpUCe+JjZXMgilNxr0pB7WtdEwfLWw9oT6hrKJwB+2putu+W8NHNXN9AZKHGa5DGbGNf6M6tJc9sV50hcoQEtJTbEwhnepU/uzPfRbykIcNEjW5UfoAntnvwWyEE2nvJUDzzdKOvmgCMf3slYYtbKKc/R/5lKM3+U9/UWwmwUVTfIH7/zfDb8GC4ig2ZNjbKipwta/Ne6PgyouIBOsLH2/Gc2HZTWHENi16Zx7PHAy8xiRV+B2OqXXljPoLa1FmnjTZ5tV93/OpNTNCusz07RoljJ9WonE4BNQA==;5:/NMzEbmnNlU4r/wR7ysaWGHLnEtqeb7vFAVBvBn3VZm5Qz8JeujMObJC6Tn83Pw4DEVcAreCgJgFdEzdZX5clMC0Z73vkuhIWqrLTU0bcKZ7YqenUYzjZ7Yfhq/z+uuZvHyjANsm414TPAWPOfmvdQjnRewwlVvsOJhuuOe0JxE=;24:rWV5KO9McphCOakuEcMzfZi9JbNyrJjxfzRBJ0b+qOYV518ztWp6CcVUhupIOCpKm7RA1q7fDqsTnYKLc0nGrbFPnWn6ITV5+oIe+ImujMw=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;HE1PR05MB3257;7:GGCo7DRkkk9PbUqcWEja55qUPtT6snHV3dEbjRtjzYhWx05RHCae/O0Xts+4CTCyCK6ROxryBfpxBfvVFLk3YnZdOOBODAtAhvhLIca2XdRDt1kSET5XXDJ33Xb4og631onev1NM9bvuywwP3JVuweqArhsqH5zAsIuA76jrXXp7WMst+t9EOgsVzrtPAIK8eE+Ths5IgcY6G2Zb1o0HbH1HSWviJA8dfhLoLhoJ3FVYQiEv0L2jKq1E9iHjJlrW
X-MS-Office365-Filtering-Correlation-Id: f50c326d-fa35-4e88-a7c0-08d5c3e33c1a
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2018 15:05:07.1790 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f50c326d-fa35-4e88-a7c0-08d5c3e33c1a
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR05MB3257
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--PEIAKu/WMn1b1Hv9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, May 26, 2018 at 04:41:46PM +0800, Wei Hu (Xavier) wrote:
> This patch hoisted the common process of disassociate_ucontext
> callback function into ib core code, and these code are common
> to ervery ib_device driver.
>
> Signed-off-by: Wei Hu (Xavier) <xavier.huwei@huawei.com>
> ---
>  drivers/infiniband/core/uverbs_main.c | 45 ++++++++++++++++++++++++++++++++++-
>  drivers/infiniband/hw/mlx4/main.c     | 34 --------------------------
>  drivers/infiniband/hw/mlx5/main.c     | 34 --------------------------
>  3 files changed, 44 insertions(+), 69 deletions(-)
>
> diff --git a/drivers/infiniband/core/uverbs_main.c b/drivers/infiniband/core/uverbs_main.c
> index 4445d8e..a0a1c70 100644
> --- a/drivers/infiniband/core/uverbs_main.c
> +++ b/drivers/infiniband/core/uverbs_main.c
> @@ -41,6 +41,8 @@
>  #include <linux/fs.h>
>  #include <linux/poll.h>
>  #include <linux/sched.h>
> +#include <linux/sched/mm.h>
> +#include <linux/sched/task.h>
>  #include <linux/file.h>
>  #include <linux/cdev.h>
>  #include <linux/anon_inodes.h>
> @@ -1090,6 +1092,47 @@ static void ib_uverbs_add_one(struct ib_device *device)
>  	return;
>  }
>
> +static void ib_uverbs_disassociate_ucontext(struct ib_ucontext *ibcontext)
> +{
> +	struct ib_device *ib_dev = ibcontext->device;
> +	struct task_struct *owning_process  = NULL;
> +	struct mm_struct   *owning_mm       = NULL;
> +
> +	owning_process = get_pid_task(ibcontext->tgid, PIDTYPE_PID);
> +	if (!owning_process)
> +		return;
> +
> +	owning_mm = get_task_mm(owning_process);
> +	if (!owning_mm) {
> +		pr_info("no mm, disassociate ucontext is pending task termination\n");
> +		while (1) {
> +			put_task_struct(owning_process);
> +			usleep_range(1000, 2000);
> +			owning_process = get_pid_task(ibcontext->tgid,
> +						      PIDTYPE_PID);
> +			if (!owning_process ||
> +			    owning_process->state == TASK_DEAD) {
> +				pr_info("disassociate ucontext done, task was terminated\n");
> +				/* in case task was dead need to release the
> +				 * task struct.
> +				 */
> +				if (owning_process)
> +					put_task_struct(owning_process);
> +				return;
> +			}
> +		}
> +	}
> +
> +	/* need to protect from a race on closing the vma as part of
> +	 * mlx5_ib_vma_close.

Except this "mlx5_ib_vma_close"

Acked-by: Leon Romanovsky <leonro@mellanox.com>

> +	 */
> +	down_write(&owning_mm->mmap_sem);
> +	ib_dev->disassociate_ucontext(ibcontext);
> +	up_write(&owning_mm->mmap_sem);
> +	mmput(owning_mm);
> +	put_task_struct(owning_process);
> +}
> +
>  static void ib_uverbs_free_hw_resources(struct ib_uverbs_device *uverbs_dev,
>  					struct ib_device *ib_dev)
>  {
> @@ -1130,7 +1173,7 @@ static void ib_uverbs_free_hw_resources(struct ib_uverbs_device *uverbs_dev,
>  			 * (e.g mmput).
>  			 */
>  			ib_uverbs_event_handler(&file->event_handler, &event);
> -			ib_dev->disassociate_ucontext(ucontext);
> +			ib_uverbs_disassociate_ucontext(ucontext);
>  			mutex_lock(&file->cleanup_mutex);
>  			ib_uverbs_cleanup_ucontext(file, ucontext, true);
>  			mutex_unlock(&file->cleanup_mutex);
> diff --git a/drivers/infiniband/hw/mlx4/main.c b/drivers/infiniband/hw/mlx4/main.c
> index bf12394..59aed45 100644
> --- a/drivers/infiniband/hw/mlx4/main.c
> +++ b/drivers/infiniband/hw/mlx4/main.c
> @@ -1189,40 +1189,10 @@ static void mlx4_ib_disassociate_ucontext(struct ib_ucontext *ibcontext)
>  	int ret = 0;
>  	struct vm_area_struct *vma;
>  	struct mlx4_ib_ucontext *context = to_mucontext(ibcontext);
> -	struct task_struct *owning_process  = NULL;
> -	struct mm_struct   *owning_mm       = NULL;
> -
> -	owning_process = get_pid_task(ibcontext->tgid, PIDTYPE_PID);
> -	if (!owning_process)
> -		return;
> -
> -	owning_mm = get_task_mm(owning_process);
> -	if (!owning_mm) {
> -		pr_info("no mm, disassociate ucontext is pending task termination\n");
> -		while (1) {
> -			/* make sure that task is dead before returning, it may
> -			 * prevent a rare case of module down in parallel to a
> -			 * call to mlx4_ib_vma_close.
> -			 */
> -			put_task_struct(owning_process);
> -			usleep_range(1000, 2000);
> -			owning_process = get_pid_task(ibcontext->tgid,
> -						      PIDTYPE_PID);
> -			if (!owning_process ||
> -			    owning_process->state == TASK_DEAD) {
> -				pr_info("disassociate ucontext done, task was terminated\n");
> -				/* in case task was dead need to release the task struct */
> -				if (owning_process)
> -					put_task_struct(owning_process);
> -				return;
> -			}
> -		}
> -	}
>
>  	/* need to protect from a race on closing the vma as part of
>  	 * mlx4_ib_vma_close().
>  	 */
> -	down_write(&owning_mm->mmap_sem);
>  	for (i = 0; i < HW_BAR_COUNT; i++) {
>  		vma = context->hw_bar_info[i].vma;
>  		if (!vma)
> @@ -1241,10 +1211,6 @@ static void mlx4_ib_disassociate_ucontext(struct ib_ucontext *ibcontext)
>  		/* context going to be destroyed, should not access ops any more */
>  		context->hw_bar_info[i].vma->vm_ops = NULL;
>  	}
> -
> -	up_write(&owning_mm->mmap_sem);
> -	mmput(owning_mm);
> -	put_task_struct(owning_process);
>  }
>
>  static void mlx4_ib_set_vma_data(struct vm_area_struct *vma,
> diff --git a/drivers/infiniband/hw/mlx5/main.c b/drivers/infiniband/hw/mlx5/main.c
> index f3e7d7c..136d64f 100644
> --- a/drivers/infiniband/hw/mlx5/main.c
> +++ b/drivers/infiniband/hw/mlx5/main.c
> @@ -1965,38 +1965,7 @@ static void mlx5_ib_disassociate_ucontext(struct ib_ucontext *ibcontext)
>  	struct vm_area_struct *vma;
>  	struct mlx5_ib_vma_private_data *vma_private, *n;
>  	struct mlx5_ib_ucontext *context = to_mucontext(ibcontext);
> -	struct task_struct *owning_process  = NULL;
> -	struct mm_struct   *owning_mm       = NULL;
>
> -	owning_process = get_pid_task(ibcontext->tgid, PIDTYPE_PID);
> -	if (!owning_process)
> -		return;
> -
> -	owning_mm = get_task_mm(owning_process);
> -	if (!owning_mm) {
> -		pr_info("no mm, disassociate ucontext is pending task termination\n");
> -		while (1) {
> -			put_task_struct(owning_process);
> -			usleep_range(1000, 2000);
> -			owning_process = get_pid_task(ibcontext->tgid,
> -						      PIDTYPE_PID);
> -			if (!owning_process ||
> -			    owning_process->state == TASK_DEAD) {
> -				pr_info("disassociate ucontext done, task was terminated\n");
> -				/* in case task was dead need to release the
> -				 * task struct.
> -				 */
> -				if (owning_process)
> -					put_task_struct(owning_process);
> -				return;
> -			}
> -		}
> -	}
> -
> -	/* need to protect from a race on closing the vma as part of
> -	 * mlx5_ib_vma_close.
> -	 */
> -	down_write(&owning_mm->mmap_sem);
>  	mutex_lock(&context->vma_private_list_mutex);
>  	list_for_each_entry_safe(vma_private, n, &context->vma_private_list,
>  				 list) {
> @@ -2013,9 +1982,6 @@ static void mlx5_ib_disassociate_ucontext(struct ib_ucontext *ibcontext)
>  		kfree(vma_private);
>  	}
>  	mutex_unlock(&context->vma_private_list_mutex);
> -	up_write(&owning_mm->mmap_sem);
> -	mmput(owning_mm);
> -	put_task_struct(owning_process);
>  }
>
>  static inline char *mmap_cmd2str(enum mlx5_ib_mmap_cmd cmd)
> --
> 1.9.1
>

--PEIAKu/WMn1b1Hv9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJbCskcAAoJEORje4g2clinLGUP/j5qy5VHbuLZdFHI5YWa0O2G
SiK/IQC8nWvKbTi4Ljbz70mjlhKGlHHRlTsbmsFj27ImiB3zUXKPYnd5B34fY0hs
eWtPTIdzunYeQP+atW17F/zOhv95Bb1Yg6IkeE6NnBvbZhmfnnPsromKbPD/N3QS
O+g/2rQcJ6+wZuCHAs5nudjwngEtyIwiPvw4fjOAuT8bghUzdgF5ypKzccjcymNg
9SyWw02FpuaAnKUC1RNzTKe6x7s+zAn5708sSY+ZmC9ObKogrUOGbINwp6F6s7IY
fNBzKQBEvoII/H5p5IkfLqtOSJtbyPvw803GPejdHJ7MGXP7Mh0sXP7NTdvRJtBK
NTtJi7M/RhKnhvs3JaQP/gd+9fb9A0j0vKRbg5GTM7W+VmjTLcNHv7cfBljM3tg+
kggcamC2z+i0BvFdANgWEyZ2fHE+ePqVCFaMYTSRyP25eY9rmXYysWyLohn+sezd
MvL/DCTVjc1jiRkKS0I0559LFrii9xltG1DqHIf287EXQCux7cFgHsgeWyEyH0+p
yJklKDN99y5hyNIGON9Tp7Vx+cFDsGj6rxm3mQndPtHwqUv1KYYDDlvchoU0qsBm
D3ZOk2nAVRikur8N8ns1r9ryRjI8sBtY8kTe4sj5fADD087z0WVFnG5l+sqZpGlX
fhq8kbYUfDCWaraPUj9f
=5rZP
-----END PGP SIGNATURE-----

--PEIAKu/WMn1b1Hv9--
