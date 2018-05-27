Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1032569AbeE0Baa (ORCPT <rfc822;w@1wt.eu>);
        Sat, 26 May 2018 21:30:30 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:58010 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1032474AbeE0Ba2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 May 2018 21:30:28 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org C92EA60390
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=timur@codeaurora.org
Subject: Re: [PATCH, net-next] qcom-emag: hide ACPI specific functions
From: Timur Tabi <timur@codeaurora.org>
To: Arnd Bergmann <arnd@arndb.de>, "David S. Miller" <davem@davemloft.net>
Cc: Hemanth Puranik <hpuranik@codeaurora.org>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20180525213714.2120604-1-arnd@arndb.de>
 <d625691f-a240-23ee-3751-d577c5e72423@codeaurora.org>
Message-ID: <571f3cca-dfa4-2c60-bfcd-3c219963d185@codeaurora.org>
Date: Sat, 26 May 2018 20:30:25 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:52.0)
 Gecko/20100101 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <d625691f-a240-23ee-3751-d577c5e72423@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/25/18 7:22 PM, Timur Tabi wrote:

> -    phy->open = emac_sgmii_open;
> -    phy->close = emac_sgmii_close;
> -    phy->link_up = emac_sgmii_link_up;
> -    phy->link_down = emac_sgmii_link_down;
> 
> I'll take it look at it next week when I'm back in the office.

I posted a patch that fixes this problem and also retains device-tree
support.

-- 
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm
Technologies, Inc.  Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
