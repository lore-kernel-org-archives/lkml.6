Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753105AbeCFDGg (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Mar 2018 22:06:36 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:49160 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752480AbeCFDGe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Mar 2018 22:06:34 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org B6079601A1
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=timur@codeaurora.org
Subject: Re: [PATCH] net: qcom/emac: Use proper free methods during TX
To: Hemanth Puranik <hpuranik@codeaurora.org>,
        netdev <netdev@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <1520304486-14466-1-git-send-email-hpuranik@codeaurora.org>
From: Timur Tabi <timur@codeaurora.org>
Message-ID: <5e169b94-bc5b-72fc-377f-f37caf3045ff@codeaurora.org>
Date: Mon, 5 Mar 2018 21:06:31 -0600
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.9; rv:52.0)
 Gecko/20100101 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1520304486-14466-1-git-send-email-hpuranik@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/5/18 8:48 PM, Hemanth Puranik wrote:
> This patch fixes the warning messages/call traces seen if DMA debug is
> enabled, In case of fragmented skb's memory was allocated using
> dma_map_page but freed using dma_unmap_single. This patch modifies buffer
> allocations in TX path to use dma_map_page in all the places and
> dma_unmap_page while freeing the buffers.
> 
> Signed-off-by: Hemanth Puranik<hpuranik@codeaurora.org>

Acked-by: Timur Tabi <timur@codeaurora.org>

-- 
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm
Technologies, Inc.  Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
