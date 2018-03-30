Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752384AbeC3Abx (ORCPT <rfc822;w@1wt.eu>);
        Thu, 29 Mar 2018 20:31:53 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:50822 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752247AbeC3Abv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Mar 2018 20:31:51 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 593A860131
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=tsoni@codeaurora.org
Subject: Re: [PATCH v3 2/2] drivers: soc: Add LLCC driver
To: Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        Rishabh Bhatnagar <rishabhb@codeaurora.org>,
        linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org
Cc: linux-arm@lists.infradead.org, linux-kernel@vger.kernel.org,
        kyan@codeaurora.org, ckadabi@codeaurora.org
References: <1522176722-12691-1-git-send-email-rishabhb@codeaurora.org>
 <1522176722-12691-3-git-send-email-rishabhb@codeaurora.org>
 <ff949d44-1b2a-15d4-511d-8686a973b081@linaro.org>
From: Trilok Soni <tsoni@codeaurora.org>
Message-ID: <9d6dad94-3e17-2ca6-2921-3f461e8315ca@codeaurora.org>
Date: Thu, 29 Mar 2018 17:31:47 -0700
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <ff949d44-1b2a-15d4-511d-8686a973b081@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stanimir,

+/* Get the slice entry by index */
>> +static struct llcc_slice_desc *llcc_slice_get_entry(struct device *dev, int n)
> drop this *slice* word from function names

Please note that we are activating/de-activating  a "slice" of the LLCC 
and not a whole LLCC. "slice" makes perfect sense here since the 
granularity is at the "slice" level and not the complete LLCC.

--Trilok Soni
