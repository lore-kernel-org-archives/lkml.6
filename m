Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E84E1C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 17:52:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C68C3218D3
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 17:52:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388203AbeLTRwC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 12:52:02 -0500
Received: from gateway20.websitewelcome.com ([192.185.49.40]:26831 "EHLO
        gateway20.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729481AbeLTRwB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 12:52:01 -0500
Received: from cm16.websitewelcome.com (cm16.websitewelcome.com [100.42.49.19])
        by gateway20.websitewelcome.com (Postfix) with ESMTP id 142F6400E2884
        for <linux-kernel@vger.kernel.org>; Thu, 20 Dec 2018 11:52:01 -0600 (CST)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id a2ULgjzza4FKpa2ULgFDR4; Thu, 20 Dec 2018 11:52:01 -0600
X-Authority-Reason: nr=8
Received: from [189.250.106.44] (port=59410 helo=[192.168.1.76])
        by gator4166.hostgator.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.91)
        (envelope-from <gustavo@embeddedor.com>)
        id 1ga2UK-000ZKN-OI; Thu, 20 Dec 2018 11:52:00 -0600
Subject: Re: [PATCH] ALSA: isa/wavefront: Fix potential Spectre v1
 vulnerabilities
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Jaroslav Kysela <perex@perex.cz>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
References: <20181219233143.GA14518@embeddedor> <s5ha7l0obxk.wl-tiwai@suse.de>
 <c367ab0f-6b07-fa4f-0e05-0050a02875ae@embeddedor.com>
 <s5hlg4km77z.wl-tiwai@suse.de>
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Message-ID: <16ea3722-c1e7-b82a-2708-e26132ed7c78@embeddedor.com>
Date:   Thu, 20 Dec 2018 11:51:59 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <s5hlg4km77z.wl-tiwai@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 189.250.106.44
X-Source-L: No
X-Exim-ID: 1ga2UK-000ZKN-OI
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.1.76]) [189.250.106.44]:59410
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 8
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/20/18 11:35 AM, Takashi Iwai wrote:

> 
> Well, no, my question is whether it makes sense to patch the code path
> for such ISA drivers.  Spectre seems applicable since the model around
> 2006 or so, and ISA slot has been already dead for very long time.
> And yet with this minor board...  I bet no one hits this in the
> world.
> 

Oh, I see.  I'm not stopping to analyze all the context around a driver 
other than the code itself.  So, thanks for pointing this out. I won't 
touch those drivers from now on.

Thanks
--
Gustavo
