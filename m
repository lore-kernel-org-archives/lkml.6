Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751695AbeEQCBq (ORCPT <rfc822;w@1wt.eu>);
        Wed, 16 May 2018 22:01:46 -0400
Received: from mailout2.samsung.com ([203.254.224.25]:33979 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751438AbeEQCBo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 May 2018 22:01:44 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20180517020142epoutp021d739e6c954498684fba9737b4380b43~vTCDbbhVo2316823168epoutp02r
X-AuditID: b6c32a36-b6dff70000001027-84-5afce27fb69d
MIME-version: 1.0
Content-transfer-encoding: 8BIT
Content-type: text/plain; charset="UTF-8"
Message-id: <5AFCE27E.20803@samsung.com>
Date: Thu, 17 May 2018 11:01:34 +0900
From: Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101
        Thunderbird/31.6.0
To: Matthias Kaehlcke <mka@chromium.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Brian Norris <briannorris@chromium.org>
Subject: Re: [RFC PATCH] PM / devfreq: Add policy notifier
In-reply-to: <20180515212447.180595-1-mka@chromium.org>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrNKsWRmVeSWpSXmKPExsWy7bCmnm79oz9RBvfn6Vps+vie1eJs0xt2
        i8u75rBZfO49wmjxecNjRovbjSvYHNg8ZjdcZPHo27KK0ePzJrkA5qhUm4zUxJTUIoXUvOT8
        lMy8dFsl7+B453hTMwNDXUNLC3MlhbzE3FRbJRefAF23zBygvUoKZYk5pUChgMTiYiV9O5ui
        /NKSVIWM/OISW6VoQ0MjPUMDcz0jIyBtHGtlZApUkpCa8aHnMmPBQv2K9kWHWRsYt6p1MXJy
        SAiYSKx59Ie1i5GLQ0hgB6PE83/3mCCc74wSHx5MYIWpOvxhPiNEYjejxIXOw2wgCV4BQYkf
        k++xdDFycDALyEscuZQNEmYW0JTYuns9O0T9XUaJp7cPQNVrSHS8aQOzWQRUJWb9X8wOYrMJ
        aEnsf3EDLM4voChx9cdjRhBbVCBCYuf8b+wg80UE6iRWfKmHmJ8qcXfTJrDbhAWsJG7MWwdm
        cwqYS0z6uwzsTgmBPWwSSx+8Y4R4wEVixZFDULawxKvjW8BmSghIS1w6agtR384o0b53HjOE
        M4VR4tx1UFCANBhLPFvYxQSxmU/i3dceVohmXomONiGIEg+Jv/cnQgPLUeLLt4Ngu4QEuhgl
        2nq5JzDKzUIKrlmI4JqFFFwLGJlXMYqlFhTnpqcWGxYY6RUn5haX5qXrJefnbmIEJzQtsx2M
        i875HGIU4GBU4uEVsPsTJcSaWFZcmXuIUYKDWUmEV6gbKMSbklhZlVqUH19UmpNafIjRFBja
        E5mlRJPzgck2ryTe0NTI2NjYwsTQzNTQUEmcd47S1yghgfTEktTs1NSC1CKYPiYOTqkGRiez
        8285Y6dcTN+171R4x6J5OeJedvPtKpevrlBf3P617MoldXlllykzK67sXn1vq7e34CvZXR0b
        tCMZLpx+dMwnbKfBbBFNJY5LUVXCGaoxTxfPue2mf/cr4//+cw6t0XEl9ZttaoL5jn0wXeD/
        0+mtF8MK/cLGazcWbPHmPcUgPH2hppbRWSWW4oxEQy3mouJEAFebEV9+AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrALMWRmVeSWpSXmKPExsVy+t9jAd36R3+iDH5fkbTY9PE9q8XZpjfs
        Fpd3zWGz+Nx7hNHi84bHjBa3G1ewObB5zG64yOLRt2UVo8fnTXIBzFFcNimpOZllqUX6dglc
        GR96LjMWLNSvaF90mLWBcataFyMnh4SAicThD/MZuxi5OIQEdjJKrJrVzwqS4BUQlPgx+R5L
        FyMHB7OAvMSRS9kgYWYBdYlJ8xYxQ9TfZ5RoeXKKGaJeQ6LjTRsbiM0ioCox6/9idhCbTUBL
        Yv+LG2BxfgFFias/HjOCzBQViJDoPlEJMkdEoIFRovHVbDaIBakST583gt0gLGAlcWPeOlaI
        ZT2MEsf7HzCBJDgFzCUm/V3GOIFRYBaSW2ch3DoLya0LGJlXMUqmFhTnpucWGxUY5qWW6xUn
        5haX5qXrJefnbmIEhvO2w1p9OxjvL4k/xCjAwajEwytg9ydKiDWxrLgy9xCjBAezkgivUDdQ
        iDclsbIqtSg/vqg0J7X4EKM0B4uSOO/tvGORQgLpiSWp2ampBalFMFkmDk6pBsaoE+wLTSwm
        Hkplf3vxm7Xa/vIj2dfm/ai9zqvaZ9jmeK7b5XSpe9n06Ha35jzBP0eXtxa6Pdj5+evqQ7pL
        a9knJJer9gV7THQuOXbc4xKbyXaTvzkbzCMjz/Por9Q/su1s1TtnqZLydZOWhTG8SODZ/vZN
        zoQfPr+lnx9qaa51tD9y8tT3GgklluKMREMt5qLiRAAU7kH9YwIAAA==
X-CMS-MailID: 20180517020135epcas1p323c2c4e83f86e79182dfab065abe827a
X-Msg-Generator: CA
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20180515212545epcas1p2bdfd9c90f2ce6b74ac0fdd8cd9f9f63b
X-RootMTR: 20180515212545epcas1p2bdfd9c90f2ce6b74ac0fdd8cd9f9f63b
References: <CGME20180515212545epcas1p2bdfd9c90f2ce6b74ac0fdd8cd9f9f63b@epcas1p2.samsung.com>
        <20180515212447.180595-1-mka@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Could you give some use-case of DEVFREQ_POLICY_NOTIFIER
or send use-case patch with this patch?

I already knew the CPUFREQ_POLICY_NOTIFIER.
But, until now, there are no any requirements of DEVFREQ_POLICY_NOTIFIER.
If there are no any use-case, it is not necessary codes.

On 2018년 05월 16일 06:24, Matthias Kaehlcke wrote:
> Policy notifiers are called before a frequency change and may adjust the
> frequency, similar to CPUFREQ_ADJUST. The purpose of policy notifiers is
> to support non-thermal throttling of devfreq devices.
> 
> As of now notifiers may only select a lower frequency, but not increase it.
> The reason for this limitation is that devfreq currently doesn't have an
> actual policy for frequencies and OPPs > freq might be disabled by a
> devfreq cooling device (see drivers/thermal/devfreq_cooling.c).
> 
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> ---
> Marked as RFC since I'm aware that this isn't quite a 'policy' notifier,
> but I also didn't want to make it too specific. Maybe devfreq devices should
> have a policy similar to cpufreq?
> 
> Should devfreq core be in charge of disabling/enabling OPPs instead of
> the thermal cooling device? Typically we don't want to use higher OPPs
> than those whitelisted by thermal, so in practice the current situation
> shouldn't be much of an issue.
> 
>  drivers/devfreq/devfreq.c | 20 ++++++++++++++++----
>  include/linux/devfreq.h   |  6 ++++++
>  2 files changed, 22 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
> index fe2af6aa88fc..a7294c056f65 100644
> --- a/drivers/devfreq/devfreq.c
> +++ b/drivers/devfreq/devfreq.c
> @@ -273,6 +273,9 @@ int update_devfreq(struct devfreq *devfreq)
>  	if (err)
>  		return err;
>  
> +	srcu_notifier_call_chain(&devfreq->policy_notifier_list,
> +			DEVFREQ_ADJUST, &freq);

It is not proper to used 'freq' as the passed data.
In current step,'freq' is not adjusted and is not final decided frequency.

> +
>  	/*
>  	 * Adjust the frequency with user freq, QoS and available freq.
>  	 *
> @@ -640,6 +643,7 @@ struct devfreq *devfreq_add_device(struct device *dev,
>  	devfreq->last_stat_updated = jiffies;
>  
>  	srcu_init_notifier_head(&devfreq->transition_notifier_list);
> +	srcu_init_notifier_head(&devfreq->policy_notifier_list);
>  
>  	mutex_unlock(&devfreq->lock);
>  
> @@ -1414,7 +1418,7 @@ EXPORT_SYMBOL(devm_devfreq_unregister_opp_notifier);
>   * devfreq_register_notifier() - Register a driver with devfreq
>   * @devfreq:	The devfreq object.
>   * @nb:		The notifier block to register.
> - * @list:	DEVFREQ_TRANSITION_NOTIFIER.
> + * @list:	DEVFREQ_TRANSITION_NOTIFIER or DEVFREQ_POLICY_NOTIFIER.
>   */
>  int devfreq_register_notifier(struct devfreq *devfreq,
>  				struct notifier_block *nb,
> @@ -1430,6 +1434,10 @@ int devfreq_register_notifier(struct devfreq *devfreq,
>  		ret = srcu_notifier_chain_register(
>  				&devfreq->transition_notifier_list, nb);
>  		break;
> +	case DEVFREQ_POLICY_NOTIFIER:
> +		ret = srcu_notifier_chain_register(
> +				&devfreq->policy_notifier_list, nb);
> +		break;
>  	default:
>  		ret = -EINVAL;
>  	}
> @@ -1442,7 +1450,7 @@ EXPORT_SYMBOL(devfreq_register_notifier);
>   * devfreq_unregister_notifier() - Unregister a driver with devfreq
>   * @devfreq:	The devfreq object.
>   * @nb:		The notifier block to be unregistered.
> - * @list:	DEVFREQ_TRANSITION_NOTIFIER.
> + * @list:	DEVFREQ_TRANSITION_NOTIFIER or DEVFREQ_POLICY_NOTIFIER.
>   */
>  int devfreq_unregister_notifier(struct devfreq *devfreq,
>  				struct notifier_block *nb,
> @@ -1458,6 +1466,10 @@ int devfreq_unregister_notifier(struct devfreq *devfreq,
>  		ret = srcu_notifier_chain_unregister(
>  				&devfreq->transition_notifier_list, nb);
>  		break;
> +	case DEVFREQ_POLICY_NOTIFIER:
> +		ret = srcu_notifier_chain_unregister(
> +				&devfreq->policy_notifier_list, nb);
> +		break;
>  	default:
>  		ret = -EINVAL;
>  	}
> @@ -1485,7 +1497,7 @@ static void devm_devfreq_notifier_release(struct device *dev, void *res)
>   * @dev:	The devfreq user device. (parent of devfreq)
>   * @devfreq:	The devfreq object.
>   * @nb:		The notifier block to be unregistered.
> - * @list:	DEVFREQ_TRANSITION_NOTIFIER.
> + * @list:	DEVFREQ_TRANSITION_NOTIFIER or DEVFREQ_POLICY_NOTIFIER.
>   */
>  int devm_devfreq_register_notifier(struct device *dev,
>  				struct devfreq *devfreq,
> @@ -1521,7 +1533,7 @@ EXPORT_SYMBOL(devm_devfreq_register_notifier);
>   * @dev:	The devfreq user device. (parent of devfreq)
>   * @devfreq:	The devfreq object.
>   * @nb:		The notifier block to be unregistered.
> - * @list:	DEVFREQ_TRANSITION_NOTIFIER.
> + * @list:	DEVFREQ_TRANSITION_NOTIFIER or DEVFREQ_POLICY_NOTIFIER.
>   */
>  void devm_devfreq_unregister_notifier(struct device *dev,
>  				struct devfreq *devfreq,
> diff --git a/include/linux/devfreq.h b/include/linux/devfreq.h
> index 3aae5b3af87c..8edc538d78f7 100644
> --- a/include/linux/devfreq.h
> +++ b/include/linux/devfreq.h
> @@ -33,6 +33,10 @@
>  #define	DEVFREQ_PRECHANGE		(0)
>  #define DEVFREQ_POSTCHANGE		(1)
>  
> +#define DEVFREQ_POLICY_NOTIFIER		1
> +
> +#define	DEVFREQ_ADJUST			0
> +
>  struct devfreq;
>  struct devfreq_governor;
>  
> @@ -136,6 +140,7 @@ struct devfreq_dev_profile {
>   * @time_in_state:	Statistics of devfreq states
>   * @last_stat_updated:	The last time stat updated
>   * @transition_notifier_list: list head of DEVFREQ_TRANSITION_NOTIFIER notifier
> + * @policy_notifier_list: list head of DEVFREQ_POLICY_NOTIFIER notifier
>   *
>   * This structure stores the devfreq information for a give device.
>   *
> @@ -174,6 +179,7 @@ struct devfreq {
>  	unsigned long last_stat_updated;
>  
>  	struct srcu_notifier_head transition_notifier_list;
> +	struct srcu_notifier_head policy_notifier_list;
>  };
>  
>  struct devfreq_freqs {
> 


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
