Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932674AbeE2JMu (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 05:12:50 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:61634 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932542AbeE2JM3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 05:12:29 -0400
Subject: Re: [PATCH 4/5] remoteproc: rename subdev probe and remove functions
To: Alex Elder <elder@linaro.org>, <ohad@wizery.com>,
        <bjorn.andersson@linaro.org>
CC: <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20180515205345.8090-1-elder@linaro.org>
 <20180515205345.8090-5-elder@linaro.org>
From: Arnaud Pouliquen <arnaud.pouliquen@st.com>
Openpgp: preference=signencrypt
Autocrypt: addr=arnaud.pouliquen@st.com; prefer-encrypt=mutual; keydata=
 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
 8mOik8I/F6EW8XyQAA2P
Message-ID: <dc10f869-48fb-84da-9df2-409d6c3568dc@st.com>
Date: Tue, 29 May 2018 11:12:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180515205345.8090-5-elder@linaro.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.75.127.44]
X-ClientProxiedBy: SFHDAG7NODE3.st.com (10.75.127.21) To SFHDAG3NODE1.st.com
 (10.75.127.7)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-29_03:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Alex


We have the same needs (prepare unprepare steps) on our platform. We
tested you core patches and they answers to our need.

Just a remark below

On 05/15/2018 10:53 PM, Alex Elder wrote:
> Rename functions used when subdevices are started and stopped to
> reflect the new naming scheme.
> 
> Signed-off-by: Alex Elder <elder@linaro.org>
> ---
>  drivers/remoteproc/qcom_common.c     | 16 ++++++++--------
>  drivers/remoteproc/remoteproc_core.c |  8 ++++----
>  2 files changed, 12 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/remoteproc/qcom_common.c b/drivers/remoteproc/qcom_common.c
> index 4ae87c5b8793..6f77840140bf 100644
> --- a/drivers/remoteproc/qcom_common.c
> +++ b/drivers/remoteproc/qcom_common.c
> @@ -33,7 +33,7 @@
>  
>  static BLOCKING_NOTIFIER_HEAD(ssr_notifiers);
>  
> -static int glink_subdev_probe(struct rproc_subdev *subdev)
> +static int glink_subdev_start(struct rproc_subdev *subdev)
>  {
>  	struct qcom_rproc_glink *glink = to_glink_subdev(subdev);
>  
> @@ -42,7 +42,7 @@ static int glink_subdev_probe(struct rproc_subdev *subdev)
>  	return PTR_ERR_OR_ZERO(glink->edge);
>  }
>  
> -static void glink_subdev_remove(struct rproc_subdev *subdev, bool crashed)
> +static void glink_subdev_stop(struct rproc_subdev *subdev, bool crashed)
>  {
>  	struct qcom_rproc_glink *glink = to_glink_subdev(subdev);
>  
> @@ -64,8 +64,8 @@ void qcom_add_glink_subdev(struct rproc *rproc, struct qcom_rproc_glink *glink)
>  		return;
>  
>  	glink->dev = dev;
> -	glink->subdev.start = glink_subdev_probe;
> -	glink->subdev.stop = glink_subdev_remove;
> +	glink->subdev.start = glink_subdev_start;
> +	glink->subdev.stop = glink_subdev_stop;
>  
>  	rproc_add_subdev(rproc, &glink->subdev);
>  }
> @@ -129,7 +129,7 @@ int qcom_register_dump_segments(struct rproc *rproc,
>  }
>  EXPORT_SYMBOL_GPL(qcom_register_dump_segments);
>  
> -static int smd_subdev_probe(struct rproc_subdev *subdev)
> +static int smd_subdev_start(struct rproc_subdev *subdev)
>  {
>  	struct qcom_rproc_subdev *smd = to_smd_subdev(subdev);
>  
> @@ -138,7 +138,7 @@ static int smd_subdev_probe(struct rproc_subdev *subdev)
>  	return PTR_ERR_OR_ZERO(smd->edge);
>  }
>  
> -static void smd_subdev_remove(struct rproc_subdev *subdev, bool crashed)
> +static void smd_subdev_stop(struct rproc_subdev *subdev, bool crashed)
>  {
>  	struct qcom_rproc_subdev *smd = to_smd_subdev(subdev);
>  
> @@ -160,8 +160,8 @@ void qcom_add_smd_subdev(struct rproc *rproc, struct qcom_rproc_subdev *smd)
>  		return;
>  
>  	smd->dev = dev;
> -	smd->subdev.start = smd_subdev_probe;
> -	smd->subdev.stop = smd_subdev_remove;
> +	smd->subdev.start = smd_subdev_start;
> +	smd->subdev.stop = smd_subdev_stop;
>  
>  	rproc_add_subdev(rproc, &smd->subdev);
>  }
> diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
> index ca39fad175f2..2ede7ae6f5bc 100644
> --- a/drivers/remoteproc/remoteproc_core.c
> +++ b/drivers/remoteproc/remoteproc_core.c
> @@ -301,14 +301,14 @@ void rproc_free_vring(struct rproc_vring *rvring)
>  	rsc->vring[idx].notifyid = -1;
>  }
>  
> -static int rproc_vdev_do_probe(struct rproc_subdev *subdev)
> +static int rproc_vdev_do_start(struct rproc_subdev *subdev)
>  {
>  	struct rproc_vdev *rvdev = container_of(subdev, struct rproc_vdev, subdev);
>  
>  	return rproc_add_virtio_dev(rvdev, rvdev->id);
>  }
>  
> -static void rproc_vdev_do_remove(struct rproc_subdev *subdev, bool crashed)
> +static void rproc_vdev_do_stop(struct rproc_subdev *subdev, bool crashed)
>  {
>  	struct rproc_vdev *rvdev = container_of(subdev, struct rproc_vdev, subdev);
>  
> @@ -399,8 +399,8 @@ static int rproc_handle_vdev(struct rproc *rproc, struct fw_rsc_vdev *rsc,
>  
>  	list_add_tail(&rvdev->node, &rproc->rvdevs);
>  
> -	rvdev->subdev.start = rproc_vdev_do_probe;
> -	rvdev->subdev.stop = rproc_vdev_do_remove;
> +	rvdev->subdev.start = rproc_vdev_do_start;
> +	rvdev->subdev.stop = rproc_vdev_do_stop;
>  
>  	rproc_add_subdev(rproc, &rvdev->subdev);

Could you split in 2 patches one for the core another, the other for the
glink driver?

Regards
Arnaud
