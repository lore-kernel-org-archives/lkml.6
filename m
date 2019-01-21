Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5ED23C31D64
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 07:19:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1800520823
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 07:19:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="QP3H+wS+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726191AbfAUHS6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 02:18:58 -0500
Received: from mailout1.samsung.com ([203.254.224.24]:16706 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727881AbfAUHSq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 02:18:46 -0500
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20190121022843epoutp0187d63641fd210d8b8b76a74c8ce30843~7vBt1PW2b1003910039epoutp01J
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jan 2019 02:28:43 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20190121022843epoutp0187d63641fd210d8b8b76a74c8ce30843~7vBt1PW2b1003910039epoutp01J
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1548037723;
        bh=mGIncaGDAKEyfajmtTpj+ctWctNGcUzGQdzOuWC0uYU=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=QP3H+wS+GkybvlzNyuoJUsFMio9ERLXlhIQUeKh24YPI1wl2Hobk5SMghq6cPDXhh
         jtcl0Prfo538yik4O4ujzez6eOUSoGDispiBEkudDWuobuA6LSwOzGi5zjplo8pEVx
         Luh1uYnIWDQLRTgb9CcCqIBdBdjhbONkkhBMpvfo=
Received: from epsmges1p1.samsung.com (unknown [182.195.40.154]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190121022839epcas1p2d96889e44ec3fc96763938bf14a2bd02~7vBq_Fm831215112151epcas1p2n;
        Mon, 21 Jan 2019 02:28:39 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        9A.3C.04074.55E254C5; Mon, 21 Jan 2019 11:28:37 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
        20190121022837epcas1p47a2692895f039b87fc12fa30b72f100f~7vBocPxoE0987409874epcas1p45;
        Mon, 21 Jan 2019 02:28:37 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190121022837epsmtrp215523147adb9cd63101c52264c5ac1d9~7vBobCiXK2465124651epsmtrp2L;
        Mon, 21 Jan 2019 02:28:37 +0000 (GMT)
X-AuditID: b6c32a35-297ff70000000fea-66-5c452e55e93c
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        57.A2.03971.55E254C5; Mon, 21 Jan 2019 11:28:37 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190121022837epsmtip18ba545c95b6a9e3d954c1a01616385ac~7vBoTTOVJ2204122041epsmtip1X;
        Mon, 21 Jan 2019 02:28:37 +0000 (GMT)
Subject: Re: [PATCH] PM / devfreq: consistent indentation
To:     myungjoo.ham@samsung.com,
        "tiny.windzz@gmail.com" <tiny.windzz@gmail.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        =?UTF-8?B?7LWc7LCs7JqwIChzYW1zdW5nLmNvbSk=?= 
        <cw00.choi@samsung.com>
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <eb5b190b-0940-1ab1-5d28-0803f31e9448@samsung.com>
Date:   Mon, 21 Jan 2019 11:28:37 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190121021940epcms1p57620581b960dba9805dfddee903ccd6c@epcms1p5>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprEJsWRmVeSWpSXmKPExsWy7bCmgW6onmuMwcuL2hbXvzxntbi8aw6b
        xefeI4wWtxtXsFnM/T2BzYHVY+esu+wefVtWMXp83iQXwByVbZORmpiSWqSQmpecn5KZl26r
        5B0c7xxvamZgqGtoaWGupJCXmJtqq+TiE6DrlpkDtFJJoSwxpxQoFJBYXKykb2dTlF9akqqQ
        kV9cYquUWpCSU2BZoFecmFtcmpeul5yfa2VoYGBkClSYkJ1x7dwR1oKjOhVbXr1nbGB8qtTF
        yMEhIWAi8eK/ThcjF4eQwA5GiX2TdzBDOJ8YJQ4c+skI4XxjlGj/8hjI4QTreDO/CapqL6PE
        qeUvoareM0pMb17IDlIlLGApseXSXxYQW0Sgg1FizvV4kCJmgU5GiWlvbrOBJNgEtCT2v7gB
        ZvMLKEpc/QGxglfATqLn+kOwOIuAqsTWJ1tZQWxRgQiJjvur2SBqBCVOznwCtoBTwE9i8+e5
        YDXMAuISt57MZ4Kw5SWat84GO1VC4DqbxLIT65khfnCR2No8E8oWlnh1fAs7hC0l8fndXjYI
        u1pi5ckjbBDNQB9s2X+BFSJhLLF/6WQmUPAxC2hKrN+lD7GMT+Ld1x5WSKjySnS0CUFUK0tc
        fnCXCcKWlFjc3gk13kOiv+ExywRGxVlI3pmF5IVZSF6YhbBsASPLKkax1ILi3PTUYsMCQ+To
        3sQITo9apjsYp5zzOcQowMGoxMP7455LjBBrYllxZe4hRgkOZiUR3ozjzjFCvCmJlVWpRfnx
        RaU5qcWHGE2BoT2RWUo0OR+YuvNK4g1NjYyNjS1MDM1MDQ2VxHnXOwA1CaQnlqRmp6YWpBbB
        9DFxcEo1MLI+63nAd0F54e1/P6dZbjzyzeCG6t0fuooNmlGTj8l8vdl768VKDWH1R/KTrOUZ
        Re0NU7sfbc1au+YY79T6+JO511NULs/+v6VcP1324Ixz+yd6TZ7G4zpt9Uc/+80pEzlili2o
        imZv/l7JsP2s+KSQH7+314f8zVp2OEK05rCE4bGVh2erZAsrsRRnJBpqMRcVJwIAGOUvF6UD
        AAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrLLMWRmVeSWpSXmKPExsWy7bCSnG6onmuMwfHjPBbXvzxntbi8aw6b
        xefeI4wWtxtXsFnM/T2BzYHVY+esu+wefVtWMXp83iQXwBzFZZOSmpNZllqkb5fAlXHt3BHW
        gqM6FVtevWdsYHyq1MXIySEhYCLxZn4TM4gtJLCbUWJaYwREXFJi2sWjQHEOIFtY4vDh4i5G
        LqCSt4wS98/OZQOpERawlNhy6S8LSEJEoINRYuv6NkYQh1mgk1Fi4bZPrBAtUxklbmz6wwrS
        wiagJbH/xQ2wdn4BRYmrPx4zgti8AnYSPdcfgsVZBFQltj7ZClYvKhAhcfblOqgaQYmTM5+w
        gNicAn4Smz/PBathFlCX+DPvEjOELS5x68l8JghbXqJ562zmCYzCs5C0z0LSMgtJyywkLQsY
        WVYxSqYWFOem5xYbFhjmpZbrFSfmFpfmpesl5+duYgRHipbmDsbLS+IPMQpwMCrx8P645xIj
        xJpYVlyZe4hRgoNZSYQ347hzjBBvSmJlVWpRfnxRaU5q8SFGaQ4WJXHep3nHIoUE0hNLUrNT
        UwtSi2CyTBycUg2M81LONd74VRWn4cLKucHzxqOiVpmNTe/KE6s6GVfzRxgkbJwwf/eCWm39
        zTwH5qkc/7btUbhLS73H/vuhOce37u7IUqyunMk0yUvhwuarYmWdqzfq+1/kuS4SNtFrmktV
        f+rNN6IabZUBfFy8TwwEDZSm1kgKLwg+YFR+MePkzE1nVDd6qCYpsRRnJBpqMRcVJwIAbRj/
        y5ACAAA=
X-CMS-MailID: 20190121022837epcas1p47a2692895f039b87fc12fa30b72f100f
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20190121021940epcms1p57620581b960dba9805dfddee903ccd6c
References: <CGME20190121021940epcms1p57620581b960dba9805dfddee903ccd6c@epcms1p5>
        <20190121021940epcms1p57620581b960dba9805dfddee903ccd6c@epcms1p5>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19. 1. 21. 오전 11:19, MyungJoo Ham wrote:
> Following up with complaints on inconsistent indentation from
> Yangtao Li, this fixes indentation inconsistency.
> 
> In principle, this tries to put arguments aligned to the left
> including the first argument except for in the case where
> the first argument is on the far-right side.
> 
> Signed-off-by: MyungJoo Ham <myungjoo.ham@samsung.com>
> ---
>  drivers/devfreq/devfreq.c | 49 +++++++++++++++++++++++------------------------
>  1 file changed, 24 insertions(+), 25 deletions(-)

Looks better before.
Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>

> 
> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
> index 4af608a..428a1de 100644
> --- a/drivers/devfreq/devfreq.c
> +++ b/drivers/devfreq/devfreq.c
> @@ -528,7 +528,7 @@ void devfreq_interval_update(struct devfreq *devfreq, unsigned int *delay)
>  		mutex_lock(&devfreq->lock);
>  		if (!devfreq->stop_polling)
>  			queue_delayed_work(devfreq_wq, &devfreq->work,
> -			      msecs_to_jiffies(devfreq->profile->polling_ms));
> +				msecs_to_jiffies(devfreq->profile->polling_ms));
>  	}
>  out:
>  	mutex_unlock(&devfreq->lock);
> @@ -537,7 +537,7 @@ EXPORT_SYMBOL(devfreq_interval_update);
>  
>  /**
>   * devfreq_notifier_call() - Notify that the device frequency requirements
> - *			   has been changed out of devfreq framework.
> + *			     has been changed out of devfreq framework.
>   * @nb:		the notifier_block (supposed to be devfreq->nb)
>   * @type:	not used
>   * @devp:	not used
> @@ -683,12 +683,11 @@ struct devfreq *devfreq_add_device(struct device *dev,
>  		goto err_out;
>  	}
>  
> -	devfreq->trans_table =
> -		devm_kzalloc(&devfreq->dev,
> -			     array3_size(sizeof(unsigned int),
> -					 devfreq->profile->max_state,
> -					 devfreq->profile->max_state),
> -			     GFP_KERNEL);
> +	devfreq->trans_table = devm_kzalloc(&devfreq->dev,
> +			array3_size(sizeof(unsigned int),
> +				    devfreq->profile->max_state,
> +				    devfreq->profile->max_state),
> +			GFP_KERNEL);
>  	if (!devfreq->trans_table) {
>  		mutex_unlock(&devfreq->lock);
>  		err = -ENOMEM;
> @@ -696,9 +695,9 @@ struct devfreq *devfreq_add_device(struct device *dev,
>  	}
>  
>  	devfreq->time_in_state = devm_kcalloc(&devfreq->dev,
> -						devfreq->profile->max_state,
> -						sizeof(unsigned long),
> -						GFP_KERNEL);
> +			devfreq->profile->max_state,
> +			sizeof(unsigned long),
> +			GFP_KERNEL);
>  	if (!devfreq->time_in_state) {
>  		mutex_unlock(&devfreq->lock);
>  		err = -ENOMEM;
> @@ -1184,7 +1183,7 @@ static ssize_t available_governors_show(struct device *d,
>  	 */
>  	if (df->governor->immutable) {
>  		count = scnprintf(&buf[count], DEVFREQ_NAME_LEN,
> -				   "%s ", df->governor_name);
> +				  "%s ", df->governor_name);
>  	/*
>  	 * The devfreq device shows the registered governor except for
>  	 * immutable governors such as passive governor .
> @@ -1497,8 +1496,8 @@ EXPORT_SYMBOL(devfreq_recommended_opp);
>  
>  /**
>   * devfreq_register_opp_notifier() - Helper function to get devfreq notified
> - *				   for any changes in the OPP availability
> - *				   changes
> + *				     for any changes in the OPP availability
> + *				     changes
>   * @dev:	The devfreq user device. (parent of devfreq)
>   * @devfreq:	The devfreq object.
>   */
> @@ -1510,8 +1509,8 @@ EXPORT_SYMBOL(devfreq_register_opp_notifier);
>  
>  /**
>   * devfreq_unregister_opp_notifier() - Helper function to stop getting devfreq
> - *				     notified for any changes in the OPP
> - *				     availability changes anymore.
> + *				       notified for any changes in the OPP
> + *				       availability changes anymore.
>   * @dev:	The devfreq user device. (parent of devfreq)
>   * @devfreq:	The devfreq object.
>   *
> @@ -1530,8 +1529,8 @@ static void devm_devfreq_opp_release(struct device *dev, void *res)
>  }
>  
>  /**
> - * devm_ devfreq_register_opp_notifier()
> - *		- Resource-managed devfreq_register_opp_notifier()
> + * devm_devfreq_register_opp_notifier() - Resource-managed
> + *					  devfreq_register_opp_notifier()
>   * @dev:	The devfreq user device. (parent of devfreq)
>   * @devfreq:	The devfreq object.
>   */
> @@ -1559,8 +1558,8 @@ int devm_devfreq_register_opp_notifier(struct device *dev,
>  EXPORT_SYMBOL(devm_devfreq_register_opp_notifier);
>  
>  /**
> - * devm_devfreq_unregister_opp_notifier()
> - *		- Resource-managed devfreq_unregister_opp_notifier()
> + * devm_devfreq_unregister_opp_notifier() - Resource-managed
> + *					    devfreq_unregister_opp_notifier()
>   * @dev:	The devfreq user device. (parent of devfreq)
>   * @devfreq:	The devfreq object.
>   */
> @@ -1579,8 +1578,8 @@ EXPORT_SYMBOL(devm_devfreq_unregister_opp_notifier);
>   * @list:	DEVFREQ_TRANSITION_NOTIFIER.
>   */
>  int devfreq_register_notifier(struct devfreq *devfreq,
> -				struct notifier_block *nb,
> -				unsigned int list)
> +			      struct notifier_block *nb,
> +			      unsigned int list)
>  {
>  	int ret = 0;
>  
> @@ -1686,9 +1685,9 @@ EXPORT_SYMBOL(devm_devfreq_register_notifier);
>   * @list:	DEVFREQ_TRANSITION_NOTIFIER.
>   */
>  void devm_devfreq_unregister_notifier(struct device *dev,
> -				struct devfreq *devfreq,
> -				struct notifier_block *nb,
> -				unsigned int list)
> +				      struct devfreq *devfreq,
> +				      struct notifier_block *nb,
> +				      unsigned int list)
>  {
>  	WARN_ON(devres_release(dev, devm_devfreq_notifier_release,
>  			       devm_devfreq_dev_match, devfreq));
> 

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
