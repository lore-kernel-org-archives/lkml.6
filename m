Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752133AbeEPCcw (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 22:32:52 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:52916 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750810AbeEPCcu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 22:32:50 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 8388F601D4
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=timur@codeaurora.org
Subject: Re: [PATCH] net: qcom/emac: Encapsulate sgmii ops under one structure
To: Hemanth Puranik <hpuranik@codeaurora.org>,
        netdev <netdev@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <1526433053-16308-1-git-send-email-hpuranik@codeaurora.org>
From: Timur Tabi <timur@codeaurora.org>
Message-ID: <94b37c40-42d8-77eb-da6f-a3ea7dff9a9d@codeaurora.org>
Date: Tue, 15 May 2018 21:32:48 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:52.0)
 Gecko/20100101 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <1526433053-16308-1-git-send-email-hpuranik@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/15/18 8:10 PM, Hemanth Puranik wrote:
> This patch introduces ops structure for sgmii, This by ensures that
> we do not need dummy functions in case of emulation platforms.
> 
> Signed-off-by: Hemanth Puranik<hpuranik@codeaurora.org>

Acked-by: Timur Tabi <timur@codeaurora.org>

-- 
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm
Technologies, Inc.  Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
