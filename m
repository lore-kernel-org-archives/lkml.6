Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752197AbeEQNFf (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 09:05:35 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:44406 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750924AbeEQNFc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 09:05:32 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 0406B605A8
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=okaya@codeaurora.org
Subject: Re: [RFC PATCH] efi/fb: Convert PCI bus address to resource if
 translated by the bridge
To: Robin Murphy <robin.murphy@arm.com>, linux-pci@vger.kernel.org,
        timur@codeaurora.org
Cc: "open list:EFIFB FRAMEBUFFER DRIVER" <linux-fbdev@vger.kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        linux-arm-msm@vger.kernel.org,
        open list <linux-kernel@vger.kernel.org>,
        "open list:FRAMEBUFFER LAYER" <dri-devel@lists.freedesktop.org>,
        Peter Jones <pjones@redhat.com>, linux-arm-kernel@lists.infradead.org
References: <1526495029-25783-1-git-send-email-okaya@codeaurora.org>
 <74ae2347-464c-ddc1-3cb9-f928692e792f@arm.com>
From: Sinan Kaya <okaya@codeaurora.org>
Message-ID: <6e875491-38a9-f7cf-92d7-53698299403a@codeaurora.org>
Date: Thu, 17 May 2018 09:05:28 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <74ae2347-464c-ddc1-3cb9-f928692e792f@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/17/2018 6:17 AM, Robin Murphy wrote:
>> +    }
>> +
> 
> Is this not pretty much just pcibios_bus_to_resource()?
>

Agreed, let me convert the code to use pcibios_bus_to_resource() API.
I wasn't aware of its existence.
 
> Robin.


-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
