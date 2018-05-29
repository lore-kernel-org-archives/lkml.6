Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755849AbeE2Apv (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 20:45:51 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:46781 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755808AbeE2Aps (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 20:45:48 -0400
X-Google-Smtp-Source: AB8JxZqJMz58p8JoLI1W8ZO7UxENSzhTCbt0glN72BrSa0AT6PlDMP01fbSx9XnPFKBuCQEFO+sKBQ==
Subject: Re: [PATCH 4.14 000/496] 4.14.45-stable review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc: torvalds@linux-foundation.org, akpm@linux-foundation.org,
        shuah@kernel.org, patches@kernelci.org, ben.hutchings@codethink.co.uk,
        lkft-triage@lists.linaro.org, stable@vger.kernel.org
References: <20180528100319.498712256@linuxfoundation.org>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <4ba75e82-27ee-c09a-d116-579bcb5cabea@roeck-us.net>
Date: Mon, 28 May 2018 17:45:45 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180528100319.498712256@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/28/2018 02:56 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.14.45 release.
> There are 496 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed May 30 10:00:57 UTC 2018.
> Anything received after that time might be too late.
> 

Build results:
	total: 146 pass: 146 fail: 0
Qemu test results:
	total: 143 pass: 143 fail: 0

Details are available at http://kerneltests.org/builders.

Guenter
