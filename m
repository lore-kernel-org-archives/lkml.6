Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932283AbeBSXqV (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Feb 2018 18:46:21 -0500
Received: from edison.jonmasters.org ([173.255.233.168]:59960 "EHLO
        edison.jonmasters.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932232AbeBSXqU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Feb 2018 18:46:20 -0500
To: Florian Fainelli <f.fainelli@gmail.com>,
        Timur Tabi <timur@codeaurora.org>,
        linux-arm-kernel@lists.infradead.org
Cc: tchalamarla@cavium.com, rrichter@cavium.com, opendmb@gmail.com,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>, Mark Rutland <mark.rutland@arm.com>,
        open list <linux-kernel@vger.kernel.org>
References: <1518479125-14428-1-git-send-email-f.fainelli@gmail.com>
 <ca6c47f9-86df-bcdb-bbe1-eac9db68ec33@codeaurora.org>
 <ffc090d5-62c9-e608-32e2-8d13d01234e6@gmail.com>
 <f5d6d768-d354-56b5-ce0c-4f46d4e6d642@codeaurora.org>
 <126b2cc2-a61e-b30d-1ff9-ea30af7abf57@gmail.com>
From: Jon Masters <jcm@jonmasters.org>
Organization: World Organi{s,z}ation Of Broken Dreams
Message-ID: <9a5190d1-eb8d-0275-d8d9-39de622a679c@jonmasters.org>
Date: Mon, 19 Feb 2018 18:46:14 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <126b2cc2-a61e-b30d-1ff9-ea30af7abf57@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 81.171.212.148
X-SA-Exim-Mail-From: jcm@jonmasters.org
Subject: Re: [PATCH] arm64: Make L1_CACHE_SHIFT configurable
X-SA-Exim-Version: 4.2.1 (built Sun, 08 Nov 2009 07:31:22 +0000)
X-SA-Exim-Scanned: Yes (on edison.jonmasters.org)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/12/2018 07:17 PM, Florian Fainelli wrote:
> On 02/12/2018 04:10 PM, Timur Tabi wrote:
>> On 02/12/2018 05:57 PM, Florian Fainelli wrote:
>>> That is debatable, is there a good publicly available table of what the
>>> typical L1 cache line size is on ARMv8 platforms?

With a server hat on...

There are many ARMv8 server platforms that do 64b today, but future
designs are likely to head toward 128b (for a variety of reasons). Many
of the earlier designs were 64b because that's what certain other arches
were using in their server cores. I doubt Vulcan will remain a unique
and special case for very long. On the CCIX side of things, I've been
trying to push people to go with 128b lines in future designs too.

Jon.
