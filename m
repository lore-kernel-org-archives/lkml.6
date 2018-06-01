Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751170AbeFAKEu (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 06:04:50 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:55510 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750770AbeFAKEr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 06:04:47 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org C4148601A1
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=timur@codeaurora.org
Subject: Re: [PATCH 4.16 269/272] pinctrl: msm: Use dynamic GPIO numbering
To: Bjorn Andersson <bjorn.andersson@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linus Walleij <linus.walleij@linaro.org>
Cc: Sebastian Gottschall <s.gottschall@dd-wrt.com>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Sasha Levin <alexander.levin@microsoft.com>
References: <20180528100240.256525891@linuxfoundation.org>
 <20180528100302.722883806@linuxfoundation.org>
 <7c34ccef-2fa8-8b53-2677-29f6fbe71a04@dd-wrt.com>
 <20180531114553.GB11598@kroah.com> <20180531165759.GJ14924@minitux>
From: Timur Tabi <timur@codeaurora.org>
Message-ID: <f21c447b-d342-9b48-80e9-2e05e084367b@codeaurora.org>
Date: Fri, 1 Jun 2018 05:04:43 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:52.0)
 Gecko/20100101 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180531165759.GJ14924@minitux>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/31/18 11:57 AM, Bjorn Andersson wrote:
> (Although
> that would probably break if Timur's customers move their user space to
> the new platform as "the first instance" isn't deterministic).

Users of platforms that have multiple TLMMs should be required to use 
gpiolib instead of sysfs.  I've already updated all our internal code to 
use it, and there is no external code that does GPIO on our server SoCs 
anyway.

-- 
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm
Technologies, Inc.  Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
