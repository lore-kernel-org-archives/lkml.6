Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932897AbeBMAKm (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 19:10:42 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:38126 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932403AbeBMAKk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 19:10:40 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 2AF0660227
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=timur@codeaurora.org
Subject: Re: [PATCH] arm64: Make L1_CACHE_SHIFT configurable
To: Florian Fainelli <f.fainelli@gmail.com>,
        linux-arm-kernel@lists.infradead.org
Cc: tchalamarla@cavium.com, rrichter@cavium.com, opendmb@gmail.com,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>, Mark Rutland <mark.rutland@arm.com>,
        open list <linux-kernel@vger.kernel.org>
References: <1518479125-14428-1-git-send-email-f.fainelli@gmail.com>
 <ca6c47f9-86df-bcdb-bbe1-eac9db68ec33@codeaurora.org>
 <ffc090d5-62c9-e608-32e2-8d13d01234e6@gmail.com>
From: Timur Tabi <timur@codeaurora.org>
Message-ID: <f5d6d768-d354-56b5-ce0c-4f46d4e6d642@codeaurora.org>
Date: Mon, 12 Feb 2018 18:10:38 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <ffc090d5-62c9-e608-32e2-8d13d01234e6@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/12/2018 05:57 PM, Florian Fainelli wrote:
> That is debatable, is there a good publicly available table of what the
> typical L1 cache line size is on ARMv8 platforms?

I don't have that, but I was under the impression that we moved from 6 
to 7 because more and more ARMv8 platforms have 128-byte caches, so that 
is the "new normal".

-- 
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm
Technologies, Inc.  Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
