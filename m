Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753907AbeEHCvi (ORCPT <rfc822;w@1wt.eu>);
        Mon, 7 May 2018 22:51:38 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:56784 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753529AbeEHCvf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 May 2018 22:51:35 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20180508025133epoutp0398d93c30ec2382dc9f0c6d986b635ab9~si6ABx1YB0389703897epoutp035
X-AuditID: b6c32a46-145ff70000001024-2d-5af110b112d3
MIME-version: 1.0
Content-transfer-encoding: 8BIT
Content-type: text/plain; charset="UTF-8"
Message-id: <5AF110B0.1030206@samsung.com>
Date: Tue, 08 May 2018 11:51:28 +0900
From: Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101
        Thunderbird/31.6.0
To: Bjorn Andersson <bjorn.andersson@linaro.org>,
        Vinayak Holikatti <vinholikatti@gmail.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>, linux-scsi@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Vivek Gautam <vivek.gautam@codeaurora.org>
Subject: Re: [PATCH v2 2/2] scsi: ufs: Use freq table with devfreq
In-reply-to: <20180504224427.32606-3-bjorn.andersson@linaro.org>
X-Brightmail-Tracker: H4sIAAAAAAAAA01Sa0gUURT27qyzo7R1W7UuSmYT/VBw20erY2aZiWxUID0gDFlHHXztw3ZW
        qSBZ/ZFiPjOhtjINyfCBKT7WR5mraFpKpGn00F5aRJYimGZFMztG/brf+c53zrnn4xCYrAj3
        JlKMFsZspPUk7i5u6/PXBDbBhRhFY2so9ajnq5gayfkioUp7RiTUWOd1nFos7AfUxUk7TtUM
        /hZRL7Pv4JS96hz1cMWOhbtrx4oKRdoO22uJ9tVEN65dmHkh1ha11ALtYrNvNB7D7Elm6ETG
        7McYE0yJKcakMPLQMd0BnSZIoQxUhlDBpJ+RNjBhZOTh6MCoFD33M9Ivk9ZncFQ0zbLkzr17
        zKYMC+OXbGItYeQppVIlVyqC5SoV96pjd6s0nCSOSW7oCkpvJM8U9FJWMO+TD9wIBHehgWsP
        xPnAnZBBO0C3vxa7CsF3gPLu8xlBNZT9ExcSdwF6sfwO4xNSuBEtl01xIoLA4FbU/zSNpzHo
        j1q7GiU8lsHXAM2vHOclUhiA5qY38bQY7kBT32ZwHuMc3fPpuRNvgNvQs+X3gMde8CTquLkk
        4cd6wlKAisqvivgAg6sA1cxVOis8YARaHP3lHOYGw9F163unCMFvOHLYrmHCBpHI+rJ9DXug
        z4MtEgH7oNnaJiAU5AKUe68CE4LLAI1OTokElRrNVuWLhN3Wo7w+fhzB8VKUd0EmSLToyvCr
        tab7UdVkISbYNQTQ2952SQnwtf3nmO2fY7b/HKsEWC3YxKSzhiSGVaWr5CxtYDOMSfIEk6EZ
        OG8xIMoOqkcPOwAkALlOGs3Ox8hc6Uz2rMEBEIGRnlJ8O0dJE+mz5xizSWfO0DOsA2g4y0sx
        b68EE3fZRotOqVGp1WpKExyiVoSQm6XWI49jZDCJtjBpDJPOmP/WiQg3bysIqy8lW26pqkVv
        s+j4CnK6/kS4ITXIoRsodxCnDxp9Ot/Exqds84/YUseqn4RmhXedOWSWFyzoiIXKhqWSyL6P
        /W4r8fqSmSUCK+vLylS4jNvjOqznm9pWp8d7xrtnAy4Vf/plOirZt1Q3cVWUg8WmDt8YmnD5
        oMN+/CyYmg8hxWwyrQzAzCz9B1oInHOhAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrHLMWRmVeSWpSXmKPExsVy+t9jQd2NAh+jDF59F7A4vf8di8XZpjfs
        FhP3n2W3uLxrDpvF594jjBbd13ewWSw//o/J4nbjCjaLHQurLE783MHswOVxua+XyWPnrLvs
        Hneu7WHz+Pj0FotH35ZVjB6fN8kFsEVx2aSk5mSWpRbp2yVwZazdbVawXqmi56BFA+MH6S5G
        Tg4JAROJk41/2LoYuTiEBNYxShz7/JsJJMErICjxY/I9li5GDg5mAXmJI5eyQcLMAuoSk+Yt
        YgaxhQTuM0rcXKQOUsIroCXx9r4YSJhFQFXi3vunbCA2G1B4/4sbYDa/gKLE1R+PGUHKRQUi
        JLpPVIJsFRGYzCjxe+IlJhCHWeA3o8TPmf/AGoQFnCQ+n/vLDrHrJKPE+04OEJtTwEFiTsNj
        pgmMArOQXDoL4dJZSC5dwMi8ilEytaA4Nz232KjAKC+1XK84Mbe4NC9dLzk/dxMjMBa2Hdbq
        38H4eEn8IUYBDkYlHt4fBR+ihFgTy4orcw8xSnAwK4nwsikDhXhTEiurUovy44tKc1KLDzFK
        c7AoifPy5x+LFBJITyxJzU5NLUgtgskycXBKNTDK/TDNDf4xoc11tfIEtgunpLaf2tCbztW0
        sT+k3Dh427+nsm3XQyTsgtsWLlXgeSkb5cLi+p1zy4Vz3W/MNhq+k/OWt1fYHzyJzXuv8uX7
        e6wkFDTv7IkzcppcpdAw/aO5X56RqPijeJZXPz4ZOa/fydq38kXGvwc3gn4Gd6rsyWE2epDF
        56LEUpyRaKjFXFScCAC5pz6+gQIAAA==
X-CMS-MailID: 20180508025129epcas2p1e836dec99d2209af4b3dd4fb15ee97c2
X-Msg-Generator: CA
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20180504224448epcas4p14166331ab890398af7fedab3b0cbb3b1
X-RootMTR: 20180504224448epcas4p14166331ab890398af7fedab3b0cbb3b1
References: <20180504224427.32606-1-bjorn.andersson@linaro.org>
        <CGME20180504224448epcas4p14166331ab890398af7fedab3b0cbb3b1@epcas4p1.samsung.com>
        <20180504224427.32606-3-bjorn.andersson@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 2018년 05월 05일 07:44, Bjorn Andersson wrote:
> devfreq requires that the client operates on actual frequencies, not
> only 0 and UMAX_INT and as such UFS brok with the introduction of
> f1d981eaecf8 ("PM / devfreq: Use the available min/max frequency").
> 
> This patch registers the frequencies of the first clock as opp levels
> and use these to determine if we're trying to step up or down.
> 
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---
> 
> Chances since v1:
> - Register min_freq and max_freq as opp levels.
> - Unregister opp levels on removal, to make e.g. probe defer working
> 
>  drivers/scsi/ufs/ufshcd.c | 47 +++++++++++++++++++++++++++++++++------
>  1 file changed, 40 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/scsi/ufs/ufshcd.c b/drivers/scsi/ufs/ufshcd.c
> index 2253f24309ec..257614b889bd 100644
> --- a/drivers/scsi/ufs/ufshcd.c
> +++ b/drivers/scsi/ufs/ufshcd.c
> @@ -1168,16 +1168,13 @@ static int ufshcd_devfreq_target(struct device *dev,
>  	struct ufs_hba *hba = dev_get_drvdata(dev);
>  	ktime_t start;
>  	bool scale_up, sched_clk_scaling_suspend_work = false;
> +	struct list_head *clk_list = &hba->clk_list_head;
> +	struct ufs_clk_info *clki;
>  	unsigned long irq_flags;
>  
>  	if (!ufshcd_is_clkscaling_supported(hba))
>  		return -EINVAL;
>  
> -	if ((*freq > 0) && (*freq < UINT_MAX)) {
> -		dev_err(hba->dev, "%s: invalid freq = %lu\n", __func__, *freq);
> -		return -EINVAL;
> -	}
> -
>  	spin_lock_irqsave(hba->host->host_lock, irq_flags);
>  	if (ufshcd_eh_in_progress(hba)) {
>  		spin_unlock_irqrestore(hba->host->host_lock, irq_flags);
> @@ -1187,7 +1184,13 @@ static int ufshcd_devfreq_target(struct device *dev,
>  	if (!hba->clk_scaling.active_reqs)
>  		sched_clk_scaling_suspend_work = true;
>  
> -	scale_up = (*freq == UINT_MAX) ? true : false;
> +	if (list_empty(clk_list)) {
> +		spin_unlock_irqrestore(hba->host->host_lock, irq_flags);
> +		goto out;
> +	}
> +
> +	clki = list_first_entry(clk_list, struct ufs_clk_info, list);
> +	scale_up = (*freq == clki->max_freq) ? true : false;
>  	if (!ufshcd_is_devfreq_scaling_required(hba, scale_up)) {
>  		spin_unlock_irqrestore(hba->host->host_lock, irq_flags);
>  		ret = 0;
> @@ -1257,16 +1260,29 @@ static struct devfreq_dev_profile ufs_devfreq_profile = {
>  
>  static int ufshcd_devfreq_init(struct ufs_hba *hba)
>  {
> +	struct list_head *clk_list = &hba->clk_list_head;
> +	struct ufs_clk_info *clki;
>  	struct devfreq *devfreq;
>  	int ret;
>  
> -	devfreq = devm_devfreq_add_device(hba->dev,
> +	/* Skip devfreq if we don't have any clocks in the list */
> +	if (list_empty(clk_list))
> +		return 0;
> +
> +	clki = list_first_entry(clk_list, struct ufs_clk_info, list);
> +	dev_pm_opp_add(hba->dev, clki->min_freq, 0);
> +	dev_pm_opp_add(hba->dev, clki->max_freq, 0);
> +
> +	devfreq = devfreq_add_device(hba->dev,
>  			&ufs_devfreq_profile,
>  			"simple_ondemand",
>  			NULL);
>  	if (IS_ERR(devfreq)) {
>  		ret = PTR_ERR(devfreq);
>  		dev_err(hba->dev, "Unable to register with devfreq %d\n", ret);
> +
> +		dev_pm_opp_remove(hba->dev, clki->min_freq);
> +		dev_pm_opp_remove(hba->dev, clki->max_freq);
>  		return ret;
>  	}
>  
> @@ -1275,6 +1291,22 @@ static int ufshcd_devfreq_init(struct ufs_hba *hba)
>  	return 0;
>  }
>  
> +static void ufshcd_devfreq_remove(struct ufs_hba *hba)
> +{
> +	struct list_head *clk_list = &hba->clk_list_head;
> +	struct ufs_clk_info *clki;
> +
> +	if (!hba->devfreq)
> +		return;
> +
> +	devfreq_remove_device(hba->devfreq);
> +	hba->devfreq = NULL;
> +
> +	clki = list_first_entry(clk_list, struct ufs_clk_info, list);
> +	dev_pm_opp_remove(hba->dev, clki->min_freq);
> +	dev_pm_opp_remove(hba->dev, clki->max_freq);
> +}
> +
>  static void __ufshcd_suspend_clkscaling(struct ufs_hba *hba)
>  {
>  	unsigned long flags;
> @@ -6966,6 +6998,7 @@ static void ufshcd_hba_exit(struct ufs_hba *hba)
>  			if (hba->devfreq)
>  				ufshcd_suspend_clkscaling(hba);
>  			destroy_workqueue(hba->clk_scaling.workq);
> +			ufshcd_devfreq_remove(hba);
>  		}
>  		ufshcd_setup_clocks(hba, false);
>  		ufshcd_setup_hba_vreg(hba, false);
> 

For using OPP entries for devfreq:
Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
