Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752080AbeEQLgU (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 07:36:20 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:35510 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751334AbeEQLgT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 07:36:19 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 28DD960881
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=timur@codeaurora.org
Subject: Re: [PATCH] net: qcom/emac: Allocate buffers from local node
To: Hemanth Puranik <hpuranik@codeaurora.org>,
        netdev <netdev@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <1526545680-21650-1-git-send-email-hpuranik@codeaurora.org>
From: Timur Tabi <timur@codeaurora.org>
Message-ID: <30094e1d-1117-8800-e1a8-2b8c555b6f26@codeaurora.org>
Date: Thu, 17 May 2018 06:36:14 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:52.0)
 Gecko/20100101 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <1526545680-21650-1-git-send-email-hpuranik@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/17/18 3:28 AM, Hemanth Puranik wrote:
> Currently we use non-NUMA aware allocation for TPD and RRD buffers,
> this patch modifies to use NUMA friendly allocation.
> 
> Signed-off-by: Hemanth Puranik<hpuranik@codeaurora.org>

Acked-by: Timur Tabi <timur@codeaurora.org>

-- 
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm
Technologies, Inc.  Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
