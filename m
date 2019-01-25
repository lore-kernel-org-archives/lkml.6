Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4C14C282C0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 14:43:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 928E321904
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 14:43:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548427437;
	bh=qvqKhzumQRG+63wB4GWTjW6W8QHWSBbA8s9L29d+a9w=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=xlmvUrGE+J1DlC89/hSWb9CBqH+AZv14yOTdlnfsqA+ogA2YRbvNi0iijuTu385TK
	 tgj3qwUQDYru0sgfvikOEz0ileAwuhWEily2V+9TzJMXGqpugTW6BrWVAbJpznunN6
	 RKu9WCkj5RzEYSsIMFHM1qImy9c2n+rhiOXgoRX4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727112AbfAYOnz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 09:43:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:35614 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726100AbfAYOnz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 09:43:55 -0500
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4ECFC218CD;
        Fri, 25 Jan 2019 14:43:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548427434;
        bh=qvqKhzumQRG+63wB4GWTjW6W8QHWSBbA8s9L29d+a9w=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=IAdxV054AvNx4tioxdsv7wiHP1HKID8IU/UxxRs6LdcgVLMGzu4cBxhyvflTXDrSr
         EgGOAnoz5i9cVIh51HFdPofumR+Toapw751AafRPd8td1PbFY8BkYWVoBOMMaEMTs4
         Db/9vdEs8y4S4IWt8cLzjSKPlHTpnKVm+aFE1deE=
Subject: Re: [PATCH 4.9 00/39] 4.9.153-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org, shuah <shuah@kernel.org>
References: <20190124190448.232316246@linuxfoundation.org>
From:   shuah <shuah@kernel.org>
Message-ID: <9a5808a0-a627-4fdb-1a28-5d9271b8da94@kernel.org>
Date:   Fri, 25 Jan 2019 07:43:53 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190124190448.232316246@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/24/19 12:20 PM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.9.153 release.
> There are 39 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat Jan 26 19:04:38 UTC 2019.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.9.153-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.9.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 

Compiled and booted on my test system. No dmesg regressions.

thanks,
-- Shuah
