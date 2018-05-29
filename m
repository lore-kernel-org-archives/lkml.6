Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755834AbeE2Aob (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 20:44:31 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:41798 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754910AbeE2Ao3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 20:44:29 -0400
X-Google-Smtp-Source: ADUXVKKBZRV4Vc8QTdX7Ttu43gGGMHCza5K5ix7ekLI79mCHJ5nLSty09ddsW13Wr7Z4RYT+eEsWYg==
Subject: Re: [PATCH 4.9 000/329] 4.9.104-stable review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc: torvalds@linux-foundation.org, akpm@linux-foundation.org,
        shuah@kernel.org, patches@kernelci.org, ben.hutchings@codethink.co.uk,
        lkft-triage@lists.linaro.org, stable@vger.kernel.org
References: <20180528100241.796630982@linuxfoundation.org>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <55b11dcf-487a-37fe-48bc-9949e67395a1@roeck-us.net>
Date: Mon, 28 May 2018 17:44:26 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180528100241.796630982@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/28/2018 02:58 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.9.104 release.
> There are 329 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed May 30 10:00:51 UTC 2018.
> Anything received after that time might be too late.
> 

Build results:
	total: 146 pass: 146 fail: 0
Qemu test results:
	total: 139 pass: 139 fail: 0

Details are available at http://kerneltests.org/builders.

Guenter
