Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751569AbeEROUh (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 10:20:37 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:49590 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750977AbeEROUc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 10:20:32 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 54931601D7
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=okaya@codeaurora.org
Subject: Re: [PATCH] efi/fb: Convert PCI bus address to resource if translated
 by the bridge
To: Robin Murphy <robin.murphy@arm.com>, linux-pci@vger.kernel.org,
        timur@codeaurora.org, ard.biesheuvel@linaro.org
Cc: "open list:EFIFB FRAMEBUFFER DRIVER" <linux-fbdev@vger.kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        linux-arm-msm@vger.kernel.org,
        open list <linux-kernel@vger.kernel.org>,
        "open list:FRAMEBUFFER LAYER" <dri-devel@lists.freedesktop.org>,
        Peter Jones <pjones@redhat.com>, linux-arm-kernel@lists.infradead.org
References: <1526563343-28721-1-git-send-email-okaya@codeaurora.org>
 <36cf3f12-bfe8-1c38-4d2c-b785fc64a3f6@arm.com>
From: Sinan Kaya <okaya@codeaurora.org>
Message-ID: <733101d0-9051-a5a6-ef64-162d8d1e10a1@codeaurora.org>
Date: Fri, 18 May 2018 10:20:29 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <36cf3f12-bfe8-1c38-4d2c-b785fc64a3f6@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/18/2018 6:42 AM, Robin Murphy wrote:
> 
> FWIW, now that I've actually gone and looked, it appears you could simplify the whole function quite a bit by getting rid of these and just using the new local resource directly, especially since the only actual use of size is an open-coded resource_contains().

Posted V2 a minute ago. I did the simplification on a prior patch in order not to
mix the issues.

-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
