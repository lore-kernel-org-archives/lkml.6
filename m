Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EF60C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 14:57:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E48402146D
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 14:57:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="tBJdPVSJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E48402146D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727774AbeLEO5R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 09:57:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:60334 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727094AbeLEO5R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 09:57:17 -0500
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B4250206B7;
        Wed,  5 Dec 2018 14:57:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544021837;
        bh=hs/PgCaS1ZDsyB5ecFoim71C6sGywSoWhD8Q4Ky9cgA=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=tBJdPVSJ9YaoBq0uxygrTACw2xQsT+waZ0HFw2B/xDprWvZp+RngBcE7DWArXDih5
         Bt0p0pmEyjM9FZzhHq+OsX13gpSiDGCfuG2eYktMyr3IqJppZYOF0DS87+OWDJZXa6
         XLS+85WjM7AeoZh8GmblRnlyNdPIWBTHXgTWAvow=
Subject: Re: [PATCH] cpupower : Auto-completion for cpupower tool
To:     Thomas Renninger <trenn@suse.de>,
        Abhishek Goel <huntbag@linux.vnet.ibm.com>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        ego@linux.vnet.ibm.com, akshay.adiga@linux.vnet.ibm.com,
        Bharath Thodla <bharath.thodla@in.ibm.com>,
        shuah <shuah@kernel.org>
References: <20181205113104.71319-1-huntbag@linux.vnet.ibm.com>
 <2133486.u21R1XiQqC@house>
From:   shuah <shuah@kernel.org>
Message-ID: <89d66277-ed2c-d3d5-ab62-b8244e9108f2@kernel.org>
Date:   Wed, 5 Dec 2018 07:57:01 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <2133486.u21R1XiQqC@house>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/5/18 4:48 AM, Thomas Renninger wrote:
> On Wednesday, December 5, 2018 12:31:04 PM CET Abhishek Goel wrote:
>> This script adds support for auto-completion for cpupower tool.
>> Added support for auto-completion of all the eight commands for
>> cpupower tool and their all subsequent sub-commands, wherever
>> possible.
> 
>>From what I see all changes I proposed in a previous review round
> with a "not that broad audience" have been addressed.
> 
> I already integrated the patch (slightly different, without functional
> changes) into the latest cpupower sources of our build service and
> things work out nice.
> 
> Shuah: Can you pick this up for next cpupower submission round, please.
> 
> Thanks,
> 
>         Thomas
> 

Thanks Thomas.

Patch applied to

git.kernel.org/pub/scm/linux/kernel/git/shuah/linux cpupower branch to 
be included in the next pull request to Rafael.

thanks,
-- Shuah
