Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932873AbeBLX5m (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 18:57:42 -0500
Received: from mail-qk0-f194.google.com ([209.85.220.194]:33971 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932712AbeBLX5l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 18:57:41 -0500
X-Google-Smtp-Source: AH8x2268eXi57dAEC6WuGGPPVVTQbXFksO4I1xVY8ugpUyakU5chqUNFgVAC7gCpBwSq6qYqc87Y2w==
Subject: Re: [PATCH] arm64: Make L1_CACHE_SHIFT configurable
To: Timur Tabi <timur@codeaurora.org>,
        linux-arm-kernel@lists.infradead.org
Cc: tchalamarla@cavium.com, rrichter@cavium.com, opendmb@gmail.com,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>, Mark Rutland <mark.rutland@arm.com>,
        open list <linux-kernel@vger.kernel.org>
References: <1518479125-14428-1-git-send-email-f.fainelli@gmail.com>
 <ca6c47f9-86df-bcdb-bbe1-eac9db68ec33@codeaurora.org>
From: Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <ffc090d5-62c9-e608-32e2-8d13d01234e6@gmail.com>
Date: Mon, 12 Feb 2018 15:57:29 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <ca6c47f9-86df-bcdb-bbe1-eac9db68ec33@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/12/2018 03:52 PM, Timur Tabi wrote:
> On 02/12/2018 05:45 PM, Florian Fainelli wrote:
>> +config ARM64_L1_CACHE_SHIFT
>> +    int
>> +    default 7 if ARM64_L1_CACHE_SHIFT_7
>> +    default 6
> 
> Shouldn't this be the other way around?  Everyone is used to 7 now, so
> you're changing the default back to 6.  I would think that it should be
> 7 by default, and platforms like Brahma-B53 should force it to 6.

That is debatable, is there a good publicly available table of what the
typical L1 cache line size is on ARMv8 platforms?
-- 
Florian
