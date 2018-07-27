Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4142C6778F
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 20:25:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 860C820671
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 20:25:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 860C820671
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389586AbeG0VtC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 17:49:02 -0400
Received: from mailout.easymail.ca ([64.68.200.34]:33017 "EHLO
        mailout.easymail.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731012AbeG0VtB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 17:49:01 -0400
Received: from localhost (localhost [127.0.0.1])
        by mailout.easymail.ca (Postfix) with ESMTP id 9EBEEC0D04;
        Fri, 27 Jul 2018 20:25:30 +0000 (UTC)
Received: from mailout.easymail.ca ([127.0.0.1])
        by localhost (emo01-pco.easydns.vpn [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id iv14kStAlmuN; Fri, 27 Jul 2018 20:25:30 +0000 (UTC)
Received: from [192.168.1.87] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mailout.easymail.ca (Postfix) with ESMTPSA id CAA12BFE01;
        Fri, 27 Jul 2018 20:25:15 +0000 (UTC)
Subject: Re: [PATCH 3.18 00/27] 3.18.117-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org, Shuah Khan <shuah@kernel.org>
References: <20180727102649.049641021@linuxfoundation.org>
From:   Shuah Khan <shuah@kernel.org>
Message-ID: <8b9f5f22-d764-05ea-8462-f91087208c6d@kernel.org>
Date:   Fri, 27 Jul 2018 14:25:14 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180727102649.049641021@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/27/2018 04:26 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 3.18.117 release.
> There are 27 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun Jul 29 10:26:38 UTC 2018.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v3.x/stable-review/patch-3.18.117-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-3.18.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 

Compiled and booted on my test system. No dmesg regressions.

thanks,
-- Shuah

