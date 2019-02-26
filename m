Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81F3AC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 15:40:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DDC12184D
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 15:40:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551195617;
	bh=BaMc58UrC6tsaxdqN5pFlKIexnJiF+gXkkbDF0TRbPE=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=uYVcQduNSLgyVD/0+9mNfAD7thgnojVnP30hyVwqgDoEZJR4chE5oVQGE5CToqWlk
	 145jXm9VAXgSIKcn4uo5NE6xBMILN0B676wBRJQElwCFlYbHeUo5FwdLMkO/Tn6EAL
	 TAoIHMB7Rp3DycT+v1Wv5MDIQgIr12l2KziU6My0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727665AbfBZPkP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 10:40:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:35644 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726539AbfBZPkP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 10:40:15 -0500
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5F42A2173C;
        Tue, 26 Feb 2019 15:40:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551195614;
        bh=BaMc58UrC6tsaxdqN5pFlKIexnJiF+gXkkbDF0TRbPE=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=k1W1zqAJZnAQIaboOmgImP1cYkORedagRc85KuDdfRJh0fQmPlVI6x2Rawkd4oVMR
         eNhAI/LS1q0twnV7lcmfKBmQMOq+jcWRh/9lx3VCb9jF0ZcCJL/Y667NnWnqfOVHob
         4dHFrsoUAycZ594mtWOnRFm3ix5OaFq0kt6oE0Gs=
Subject: Re: [PATCH 4.14 00/71] 4.14.104-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org, shuah <shuah@kernel.org>
References: <20190225195034.555044862@linuxfoundation.org>
From:   shuah <shuah@kernel.org>
Message-ID: <cc720613-061d-0d48-5d30-7b0ef7690ebd@kernel.org>
Date:   Tue, 26 Feb 2019 08:40:13 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190225195034.555044862@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/25/19 2:11 PM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.14.104 release.
> There are 71 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed Feb 27 19:50:01 UTC 2019.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.14.104-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.14.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 

Compiled and booted on my test system. No dmesg regressions.

thanks,
-- Shuah

