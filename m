Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933614AbeEWQn3 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 12:43:29 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:35822 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754623AbeEWQn0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 12:43:26 -0400
Subject: Re: [PATCH 01/14] memory: ti-emif-sram: Add resume function to recopy
 sram code
To: Keerthy <j-keerthy@ti.com>, linus.walleij@linaro.org,
        grygorii.strashko@ti.com, tony@atomide.com
Cc: t-kristo@ti.com, Russ.Dill@ti.com, linux-omap@vger.kernel.org,
        linux-kernel@vger.kernel.org, ssantosh@kernel.org,
        haojian.zhuang@linaro.org, linux-arm-kernel@lists.infradead.org,
        d-gerlach@ti.com
References: <1523505239-16229-1-git-send-email-j-keerthy@ti.com>
 <1523505239-16229-2-git-send-email-j-keerthy@ti.com>
 <31688cf4-b6ca-e7ce-3407-46262006b38f@oracle.com>
 <d52373eb-1707-17ff-fabb-9f7200cf54c0@ti.com>
 <739d9bbf-2acc-9c90-db43-cf78f5b184e3@ti.com>
From: Santosh Shilimkar <santosh.shilimkar@oracle.com>
Organization: Oracle Corporation
Message-ID: <443e8bb5-91d8-8bd9-ed6a-cf78377eeef4@oracle.com>
Date: Wed, 23 May 2018 09:42:54 -0700
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <739d9bbf-2acc-9c90-db43-cf78f5b184e3@ti.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8902 signatures=668700
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=946
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1805230164
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 5/23/2018 1:47 AM, Keerthy wrote:
> 
> 
> On Monday 16 April 2018 03:59 PM, Keerthy wrote:
>>
[..]

>>> Instead of this indirect method , why can't just check the previous
>>> deep sleep mode and based on that do copy or not. EMIF power status
>>> register should have something like that ?
>>
>> I will check if we have a register that tells the previous state of sram.
> 
> Unfortunately i do not see any such register for knowing SRAM previous
> state in am43 TRM and hence this indirect way of knowing.
> 
OK.

> 
>>
>>>
>>> Another minor point is even though there is nothing to do in suspend,
>>> might be good to have a callback with comment that nothing to do with
>>> some explanation why not. Don't have strong preference but may for
>>> better readability.
> 
> I can add a blank suspend call with comment
> 
> "The contents are already present in DDR hence no need to explicitly save"
> 
> The comment in resume function pretty much explains the above. So let me
> know if i need to add the suspend callback.
> Please add the empty suspend callback with comment.

Regards,
Santosh
