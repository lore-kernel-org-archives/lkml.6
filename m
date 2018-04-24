Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756350AbeDXH01 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 03:26:27 -0400
Received: from mailout1.samsung.com ([203.254.224.24]:39374 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756299AbeDXH0Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 03:26:25 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20180424072622epoutp01ecfeaf21ee2383e758c6f1fd38ad66d4~oTn9aICc90124901249epoutp01a
X-AuditID: b6c32a38-6f7ff7000000105c-a9-5adedc1b42bd
MIME-version: 1.0
Content-transfer-encoding: 8BIT
Content-type: text/plain; charset="UTF-8"
Message-id: <5ADEDC1A.2000101@samsung.com>
Date: Tue, 24 Apr 2018 16:26:18 +0900
From: Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101
        Thunderbird/31.6.0
To: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Vinayak Holikatti <vinholikatti@gmail.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Vivek Gautam <vivek.gautam@codeaurora.org>
Subject: Re: [PATCH 1/3] PM / devfreq: Actually support providing freq_table
In-reply-to: <20180424052916.GD2052@tuxbook-pro>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupnk+LIzCtJLcpLzFFi42LZdlhTX1f6zr0og7tLJS1O73/HYnG26Q27
        xcT9Z9ktLu+aw2bxufcIo0X39R1sFsuP/2OyuN24gs1ix8IqixM/dzA7cHlc7utl8tg56y67
        x51re9g8Pj69xeLRt2UVo8fnTXIBbFGpNhmpiSmpRQqpecn5KZl56bZK3sHxzvGmZgaGuoaW
        FuZKCnmJuam2Si4+AbpumTlAlykplCXmlAKFAhKLi5X07WyK8ktLUhUy8otLbJWiDQ2N9AwN
        zPWMjIC0cayVkSlQSUJqxuldU1kL/klXXHy8n6mB8ZpYFyMnh4SAicTJXdvZuhi5OIQEdjBK
        HL96jRHC+c4osWjnPGaYqm9dX1kgEhsYJZpPHmYESfAKCEr8mHwPKMHBwSwgL3HkUjZImFlA
        U2Lr7vXsEPV3GSUuvT3PAlGvJdHyqhusl0VAVeJq/22wOBtQfP+LG2wgNr+AosTVH4/BakQF
        IiR2zv/GDmKLCBhIHD1zGewIZoF7TBK/v9xmAlksLOAjce5NAUgNJ1BN84opTCA1EgLv2SS+
        3lkN9YGLRMuC1SwQtrDEq+Nb2EF6JQSkJS4dtYWob2eUaN8L8jGIM4VR4tz1e0wQDcYSzxZ2
        MUG8xifx7msPK0Qzr0RHmxBEiYfE+9t72SBsR4k5j/5AQ6uHSeLZijamCYxys5ACbBYiwGYh
        BdgCRuZVjGKpBcW56anFhgUmesWJucWleel6yfm5mxjBiVHLYgfjnnM+hxgFOBiVeHgX/Lwb
        JcSaWFZcmXuIUYKDWUmEd6/cvSgh3pTEyqrUovz4otKc1OJDjKbA8J7ILCWanA9M2nkl8Yam
        RsbGxhYmhmamhoZK4rxPfc5ECQmkJ5akZqemFqQWwfQxcXBKNTDuUUlwvW2/413U2eWa7Zve
        pnIfyHiQnNQvc77+cn/8/Jc5PmeSvpyR0rWeGdYvs0cinT0tRMgvVbxyg/OlJbu/3Lp8fqKm
        4rITXCp+R1wXtHwwKZ9yPY33SZ2pxn4JtoPNRqnfA3V818cG2Qmwn0j1s53wf+7k7+wXXixc
        //L/puPaO/lNpdKUWIozEg21mIuKEwHdonF+ogMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrILMWRmVeSWpSXmKPExsVy+t9jQV3pO/eiDHY08Vic3v+OxeJs0xt2
        i4n7z7JbXN41h83ic+8RRovu6zvYLJYf/8dkcbtxBZvFjoVVFid+7mB24PK43NfL5LFz1l12
        jzvX9rB5fHx6i8Wjb8sqRo/Pm+QC2KK4bFJSczLLUov07RK4Mk7vmspa8E+64uLj/UwNjNfE
        uhg5OSQETCS+dX1l6WLk4hASWMco0d5zgBUkwSsgKPFj8j2gBAcHs4C8xJFL2SBhZgF1iUnz
        FjFD1N9nlPgz9RYbRL2WRMurbkYQm0VAVeJq/20WEJsNKL7/xQ2wGn4BRYmrPx4zgswUFYiQ
        6D5RCRIWETCQOHrmMtgNzAL3mCQunJvEDlIjLOAjce5NAcSuHiaJd1s2M4E0cAI1NK+YwjSB
        UWAWklNnIZw6C8mpCxiZVzFKphYU56bnFhsVGOallusVJ+YWl+al6yXn525iBEbEtsNafTsY
        7y+JP8QowMGoxMO74OfdKCHWxLLiytxDjBIczEoivHvl7kUJ8aYkVlalFuXHF5XmpBYfYpTm
        YFES572ddyxSSCA9sSQ1OzW1ILUIJsvEwSnVwLi67eCsJTbTbGdsCWy70yF6lZ9FyLZJOagh
        z1gjYeuT7lrX8p+J9h+m7VKa8OP9h4QtHd43T3ozl8VE8WjMmLVvz5PbO2VN2edN0ljj4F77
        SLheY+tmb9+Xj7kO3+aeKdCe53Lx6C6e5LAzf2xuua2fXXT1pID4Er7T1TEhZ1hjBNb+Ltvn
        +VmJpTgj0VCLuag4EQAc0E+ChAIAAA==
X-CMS-MailID: 20180424072619epcas1p4b0003f9a52e42270e01be0a2f67fdb38
X-Msg-Generator: CA
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20180424002041epcas5p11439bec6de910c2a465c5cf3acb45a3b
X-RootMTR: 20180424002041epcas5p11439bec6de910c2a465c5cf3acb45a3b
References: <20180424002016.9205-1-bjorn.andersson@linaro.org>
        <CGME20180424002041epcas5p11439bec6de910c2a465c5cf3acb45a3b@epcas5p1.samsung.com>
        <20180424002016.9205-2-bjorn.andersson@linaro.org>
        <5ADE9AE6.9090601@samsung.com> <20180424052916.GD2052@tuxbook-pro>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 2018년 04월 24일 14:29, Bjorn Andersson wrote:
> On Mon 23 Apr 19:48 PDT 2018, Chanwoo Choi wrote:
> 
>> Hi,
>>
>> On 2018??? 04??? 24??? 09:20, Bjorn Andersson wrote:
>>> The code in devfreq_add_device() handles the case where a freq_table is
>>> passed by the client, but then requests min and max frequences from
>>> the, in this case absent, opp tables.
>>>
>>> Read the min and max frequencies from the frequency table, which has
>>> been built from the opp table if one exists, instead of querying the
>>> opp table.
>>>
>>> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
>>> ---
>>>
>>> An alternative approach is to clarify in the devfreq code that it's not
>>> possible to pass a freq_table and then in patch 3 create an opp table for the
>>> device in runtime; although the error handling of this becomes non-trivial.
>>>
>>> Transitioning the UFSHCD to use opp tables directly is hindered by the fact
>>> that the Qualcomm UFS hardware has two different clocks that needs to be
>>> running at different rates, so we would need a way to describe the two rates in
>>> the opp table. (And would force us to change the DT binding)
>>>
>>>  drivers/devfreq/devfreq.c | 22 ++++------------------
>>>  1 file changed, 4 insertions(+), 18 deletions(-)
>>>
>>> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
>>> index fe2af6aa88fc..086ced50a13d 100644
>>> --- a/drivers/devfreq/devfreq.c
>>> +++ b/drivers/devfreq/devfreq.c
>>> @@ -74,30 +74,16 @@ static struct devfreq *find_device_devfreq(struct device *dev)
>>>  
>>>  static unsigned long find_available_min_freq(struct devfreq *devfreq)
>>>  {
>>> -	struct dev_pm_opp *opp;
>>> -	unsigned long min_freq = 0;
>>> -
>>> -	opp = dev_pm_opp_find_freq_ceil(devfreq->dev.parent, &min_freq);
>>> -	if (IS_ERR(opp))
>>> -		min_freq = 0;
>>> -	else
>>> -		dev_pm_opp_put(opp);
>>> +	struct devfreq_dev_profile *profile = devfreq->profile;
>>>  
>>> -	return min_freq;
>>> +	return profile->freq_table[0];
>>
>> It is wrong. The thermal framework support the devfreq-cooling device
>> which uses the dev_pm_opp_enable/disable().
>>
> 
> Okay, that makes sense. So rather than registering a custom freq_table I
> should register the min and max frequency using dev_pm_opp_add().

Thanks.

> 
>> In order to find the correct available min frequency,
>> the devfreq have to use the OPP function instead of using the first entry
>> of the freq_table array.
>>
> 
> Based on this there seems to be room for cleaning out the freq_table
> from devfreq, to reduce the confusion. I will review this further.

Actually, devfreq must need to have the freq_table[] array. But, freq_table[]
array should be handled in the devfreq core. Now, the devfreq device drivers can
touch the freq_table. I think it is not good.

There is a reason why we have to maintain the freq_table[] as the internal variable.
OPP doesn't provide the OPP API which get the all registered frequencies.
If devfreq-cooling device disables the specific frequency by using dev_pm_oppdisable(),
the user of OPP interface can not get the disabled frequency list.
So, I maintain the freq_table even if using the OPP interface.

And, devfreq-cooling device uses the freq_table directly because released MALi driver
from ARM initializes the freq_table list directly.

I have no any objection for refactoring. Just I'm sharing the issue and current status.

> 
> Thanks,
> Bjorn
> 
> 
> 


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
