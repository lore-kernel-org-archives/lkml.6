Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754262AbeEORDk (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 13:03:40 -0400
Received: from mailout.easymail.ca ([64.68.200.34]:54736 "EHLO
        mailout.easymail.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750810AbeEORDi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 13:03:38 -0400
Subject: Re: [PATCH] selftests: cgroup/memcontrol: add basic test for swap
 controls
To: Tejun Heo <tj@kernel.org>, Mike Rapoport <rppt@linux.vnet.ibm.com>
Cc: Roman Gushchin <guro@fb.com>, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, Shuah Khan <shuah@kernel.org>
References: <1526400353-12991-1-git-send-email-rppt@linux.vnet.ibm.com>
 <20180515164034.GF2368884@devbig577.frc2.facebook.com>
From: Shuah Khan <shuah@kernel.org>
Message-ID: <74c0905f-efce-7409-9da3-34fac29ff3cb@kernel.org>
Date: Tue, 15 May 2018 11:03:29 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180515164034.GF2368884@devbig577.frc2.facebook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/15/2018 10:40 AM, Tejun Heo wrote:
> On Tue, May 15, 2018 at 07:05:53PM +0300, Mike Rapoport wrote:
>> The new test verifies that memory.swap.max and memory.swap.current behave
>> as expected for simple allocation scenarios
>>
>> Signed-off-by: Mike Rapoport <rppt@linux.vnet.ibm.com>
> 
> Looks good to me.
> 
> Acked-by: Tejun Heo <tj@kernel.org>
> 
> Thanks.
> 

Thanks. Applied to linux-kselftest next for 4.18-rc1

thanks,
-- Shuah
