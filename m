Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932791AbeE2JQ4 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 05:16:56 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:46299 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932404AbeE2JQY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 05:16:24 -0400
Subject: Re: [PATCH 5/5] remoteproc: Introduce prepare and unprepare for
 subdevices
To: Alex Elder <elder@linaro.org>, <ohad@wizery.com>,
        <bjorn.andersson@linaro.org>
CC: <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20180515205345.8090-1-elder@linaro.org>
 <20180515205345.8090-6-elder@linaro.org>
From: Arnaud Pouliquen <arnaud.pouliquen@st.com>
Openpgp: preference=signencrypt
Autocrypt: addr=arnaud.pouliquen@st.com; prefer-encrypt=mutual; keydata=
 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
 8mOik8I/F6EW8XyQAA2P
Message-ID: <3580eff5-56ef-c2a0-c8eb-c27850598587@st.com>
Date: Tue, 29 May 2018 11:16:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180515205345.8090-6-elder@linaro.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.75.127.47]
X-ClientProxiedBy: SFHDAG5NODE3.st.com (10.75.127.15) To SFHDAG3NODE1.st.com
 (10.75.127.7)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-29_03:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Alex,


On 05/15/2018 10:53 PM, Alex Elder wrote:
> From: Bjorn Andersson <bjorn.andersson@linaro.org>
> 
> On rare occasions a subdevice might need to prepare some hardware
> resources before a remote processor is booted, and clean up some
> state after it has been shut down.
> 
> One such example is the IP Accelerator found in various Qualcomm
> platforms, which is accessed directly from both the modem remoteproc
> and the application subsystem and requires an intricate lockstep
> process when bringing the modem up and down.
> 
> [elder@linaro.org: minor description and comment edits]
> 
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> Acked-by: Alex Elder <elder@linaro.org>
> ---
>  drivers/remoteproc/remoteproc_core.c | 56 ++++++++++++++++++++++++++--
>  include/linux/remoteproc.h           |  4 ++
>  2 files changed, 57 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
> index 2ede7ae6f5bc..283b258f5e0f 100644
> --- a/drivers/remoteproc/remoteproc_core.c
> +++ b/drivers/remoteproc/remoteproc_core.c
> @@ -776,6 +776,30 @@ static int rproc_handle_resources(struct rproc *rproc,
>  	return ret;
>  }
>  
> +static int rproc_prepare_subdevices(struct rproc *rproc)
> +{
> +	struct rproc_subdev *subdev;
> +	int ret;
> +
> +	list_for_each_entry(subdev, &rproc->subdevs, node) {
> +		if (subdev->prepare) {
> +			ret = subdev->prepare(subdev);
> +			if (ret)
> +				goto unroll_preparation;
> +		}
> +	}
> +
> +	return 0;
> +
> +unroll_preparation:
> +	list_for_each_entry_continue_reverse(subdev, &rproc->subdevs, node) {
> +		if (subdev->unprepare)
> +			subdev->unprepare(subdev);
> +	}
Here you could call rproc_unprepare_subdevices instead of duplicating
the code.

regards
Arnaud
> +
> +	return ret;
> +}
> +
>  static int rproc_start_subdevices(struct rproc *rproc)
>  {
>  	struct rproc_subdev *subdev;
> @@ -810,6 +834,16 @@ static void rproc_stop_subdevices(struct rproc *rproc, bool crashed)
>  	}
>  }
>  
> +static void rproc_unprepare_subdevices(struct rproc *rproc)
> +{
> +	struct rproc_subdev *subdev;
> +
> +	list_for_each_entry_reverse(subdev, &rproc->subdevs, node) {
> +		if (subdev->unprepare)
> +			subdev->unprepare(subdev);
> +	}
> +}
> +
>  /**
>   * rproc_coredump_cleanup() - clean up dump_segments list
>   * @rproc: the remote processor handle
> @@ -902,11 +936,18 @@ static int rproc_start(struct rproc *rproc, const struct firmware *fw)
>  		rproc->table_ptr = loaded_table;
>  	}
>  
> +	ret = rproc_prepare_subdevices(rproc);
> +	if (ret) {
> +		dev_err(dev, "failed to prepare subdevices for %s: %d\n",
> +			rproc->name, ret);
> +		return ret;
> +	}
> +
>  	/* power up the remote processor */
>  	ret = rproc->ops->start(rproc);
>  	if (ret) {
>  		dev_err(dev, "can't start rproc %s: %d\n", rproc->name, ret);
> -		return ret;
> +		goto unprepare_subdevices;
>  	}
>  
>  	/* Start any subdevices for the remote processor */
> @@ -914,8 +955,7 @@ static int rproc_start(struct rproc *rproc, const struct firmware *fw)
>  	if (ret) {
>  		dev_err(dev, "failed to probe subdevices for %s: %d\n",
>  			rproc->name, ret);
> -		rproc->ops->stop(rproc);
> -		return ret;
> +		goto stop_rproc;
>  	}
>  
>  	rproc->state = RPROC_RUNNING;
> @@ -923,6 +963,14 @@ static int rproc_start(struct rproc *rproc, const struct firmware *fw)
>  	dev_info(dev, "remote processor %s is now up\n", rproc->name);
>  
>  	return 0;
> +
> +stop_rproc:
> +	rproc->ops->stop(rproc);
> +
> +unprepare_subdevices:
> +	rproc_unprepare_subdevices(rproc);
> +
> +	return ret;
>  }
>  
>  /*
> @@ -1035,6 +1083,8 @@ static int rproc_stop(struct rproc *rproc, bool crashed)
>  		return ret;
>  	}
>  
> +	rproc_unprepare_subdevices(rproc);
> +
>  	rproc->state = RPROC_OFFLINE;
>  
>  	dev_info(dev, "stopped remote processor %s\n", rproc->name);
> diff --git a/include/linux/remoteproc.h b/include/linux/remoteproc.h
> index 8f1426330cca..e3c5d856b6da 100644
> --- a/include/linux/remoteproc.h
> +++ b/include/linux/remoteproc.h
> @@ -477,15 +477,19 @@ struct rproc {
>  /**
>   * struct rproc_subdev - subdevice tied to a remoteproc
>   * @node: list node related to the rproc subdevs list
> + * @prepare: prepare function, called before the rproc is started
>   * @start: start function, called after the rproc has been started
>   * @stop: stop function, called before the rproc is stopped; the @crashed
>   *	    parameter indicates if this originates from a recovery
> + * @unprepare: unprepare function, called after the rproc has been stopped
>   */
>  struct rproc_subdev {
>  	struct list_head node;
>  
> +	int (*prepare)(struct rproc_subdev *subdev);
>  	int (*start)(struct rproc_subdev *subdev);
>  	void (*stop)(struct rproc_subdev *subdev, bool crashed);
> +	void (*unprepare)(struct rproc_subdev *subdev);
>  };
>  
>  /* we currently support only two vrings per rvdev */
> 
