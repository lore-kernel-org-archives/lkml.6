Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751676AbeEAFYn (ORCPT <rfc822;w@1wt.eu>);
        Tue, 1 May 2018 01:24:43 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:53416 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750857AbeEAFYm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 May 2018 01:24:42 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 06FF660588
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=cpandya@codeaurora.org
Subject: Re: [PATCH v2 2/2] mm: vmalloc: Pass proper vm_start into
 debugobjects
To: Andrew Morton <akpm@linux-foundation.org>
Cc: vbabka@suse.cz, labbott@redhat.com, catalin.marinas@arm.com,
        hannes@cmpxchg.org, f.fainelli@gmail.com, xieyisheng1@huawei.com,
        ard.biesheuvel@linaro.org, richard.weiyang@gmail.com,
        byungchul.park@lge.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, khandual@linux.vnet.ibm.com,
        mhocko@kernel.org
References: <1523961828-9485-1-git-send-email-cpandya@codeaurora.org>
 <1523961828-9485-3-git-send-email-cpandya@codeaurora.org>
 <20180430160436.45f92ec5b3c78c84e4425ec4@linux-foundation.org>
From: Chintan Pandya <cpandya@codeaurora.org>
Message-ID: <6cfa516c-162a-c08a-80b9-3fed0c616b76@codeaurora.org>
Date: Tue, 1 May 2018 10:54:34 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180430160436.45f92ec5b3c78c84e4425ec4@linux-foundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/1/2018 4:34 AM, Andrew Morton wrote:
> should check for it and do a WARN_ONCE so it gets fixed.

Yes, that was an idea in discussion but I've been suggested that it
could be intentional. But since you are raising this, I will try to dig
once again and share a patch with WARN_ONCE if passing intermediate
'addr' is absolutely not right thing to do.

Chintan
-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center,
Inc. is a member of the Code Aurora Forum, a Linux Foundation
Collaborative Project
