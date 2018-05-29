Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755863AbeE2Aqc (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 20:46:32 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:36796 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755808AbeE2Aq2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 20:46:28 -0400
X-Google-Smtp-Source: AB8JxZpYPP8N65FNJRDrXaS2gjTBPGMpeFx++VbKBbAOr8IFTfA2p4YyY7GBnH+5e0bypX1pBhLVRQ==
Subject: Re: [PATCH 4.16 000/272] 4.16.13-stable review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc: torvalds@linux-foundation.org, akpm@linux-foundation.org,
        shuah@kernel.org, patches@kernelci.org, ben.hutchings@codethink.co.uk,
        lkft-triage@lists.linaro.org, stable@vger.kernel.org
References: <20180528100240.256525891@linuxfoundation.org>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <b1529156-a65e-1aa6-43e4-88c895befefc@roeck-us.net>
Date: Mon, 28 May 2018 17:46:26 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180528100240.256525891@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/28/2018 03:00 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.16.13 release.
> There are 272 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed May 30 10:01:02 UTC 2018.
> Anything received after that time might be too late.
> 

Build results:
	total: 143 pass: 143 fail: 0
Qemu test results:
	total: 141 pass: 141 fail: 0

Details are available at http://kerneltests.org/builders.

Guenter
