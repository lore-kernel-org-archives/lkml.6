Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752096AbeCLQ1z (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 12:27:55 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:39483 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751956AbeCLQ1y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 12:27:54 -0400
X-Google-Smtp-Source: AG47ELuKmD520uRzf26dqZJh5Z/mw5xgLALLy1hfQpEq94lw6DVCCwz+w6L078cPwEp3j7w9yHitWg==
Subject: Re: [PATCH] net: hns: use put_device() if device_register fail
To: David Miller <davem@davemloft.net>
References: <fa970be78de11dee1a217c9a75ab0850f1780e0c.1520591977.git.arvind.yadav.cs@gmail.com>
 <20180312.104323.14368638452528082.davem@davemloft.net>
Cc: yisen.zhuang@huawei.com, salil.mehta@huawei.com,
        linyunsheng@huawei.com, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org
From: arvindY <arvind.yadav.cs@gmail.com>
Message-ID: <5AA6AA84.6040001@gmail.com>
Date: Mon, 12 Mar 2018 21:57:48 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.6.0
MIME-Version: 1.0
In-Reply-To: <20180312.104323.14368638452528082.davem@davemloft.net>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Monday 12 March 2018 08:13 PM, David Miller wrote:
> From: Arvind Yadav <arvind.yadav.cs@gmail.com>
> Date: Fri,  9 Mar 2018 16:11:17 +0530
>
>> if device_register() returned an error! Always use put_device()
>> to give up the reference initialized.
>>
>> Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
> I do not see anything giving cls_dev an initial non-zero reference
> count before this device_register() call.
Yes,  you are correct there is nothing to release (hnae_release).
>
> And I have no idea why you use a "!" when saying 'error' you this
> commit log message.
>
Sorry for that. next time I will take care.

~arvind
