Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1034095AbeCASn0 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 13:43:26 -0500
Received: from mail-lf0-f67.google.com ([209.85.215.67]:42302 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1034013AbeCASnW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 13:43:22 -0500
X-Google-Smtp-Source: AG47ELtZPWwWSVnYS+e83G6QFEfrMnvTnGiV+uz8RYREobAMRDzB2THQ7VzQpjjIYUmdmRv6GiUSzw==
Subject: Re: [PATCH V2] lightnvm: pblk: remove unused variable
To: =?UTF-8?Q?Javier_Gonz=c3=a1lez?= <jg@lightnvm.io>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1519833444-28160-1-git-send-email-javier@cnexlabs.com>
 <2cf2565b-0a2c-ecba-ea55-9a63591d8f93@lightnvm.io>
 <D5C55585-6CB6-4F47-9AD0-6CE961BA1392@lightnvm.io>
From: =?UTF-8?Q?Matias_Bj=c3=b8rling?= <mb@lightnvm.io>
Message-ID: <84044d5d-10d4-7b2f-7f58-4af1fbe71cac@lightnvm.io>
Date: Thu, 1 Mar 2018 19:43:19 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <D5C55585-6CB6-4F47-9AD0-6CE961BA1392@lightnvm.io>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/01/2018 11:24 AM, Javier González wrote:
> 
> 
>> On 1 Mar 2018, at 11.07, Matias Bjørling <mb@lightnvm.io> wrote:
>>
>> On 02/28/2018 04:57 PM, Javier González wrote:
>>> # Changes since V1:
>>>   - Rebase on top of latest 2.0 changes
>>> Javier González (1):
>>>    lightnvm: pblk: remove unused variable
>>>   drivers/lightnvm/pblk-core.c | 3 ---
>>>   1 file changed, 3 deletions(-)
>>
>> Okay if I merge this with Hans' patch? It has not gone upstream yet.
> 
> Of course!
> 

Thanks. Applied.
