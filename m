Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753195AbeFDNUt (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 09:20:49 -0400
Received: from mail-pl0-f44.google.com ([209.85.160.44]:37724 "EHLO
        mail-pl0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752843AbeFDNUr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 09:20:47 -0400
X-Google-Smtp-Source: ADUXVKK+63dfFl8awO8ZloHK4wPd6u0xVxkbfN7rY+pZHfBAP5VwiJj+Xs0RoJ7RYeVmYF/zvh9c6Q==
Subject: Re: [PATCH 4.16 00/47] 4.16.14-stable review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc: torvalds@linux-foundation.org, akpm@linux-foundation.org,
        shuah@kernel.org, patches@kernelci.org, ben.hutchings@codethink.co.uk,
        lkft-triage@lists.linaro.org, stable@vger.kernel.org
References: <20180604065549.468488465@linuxfoundation.org>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <b28c44a5-92c9-f9e5-a056-0a6ebf5326a1@roeck-us.net>
Date: Mon, 4 Jun 2018 06:20:44 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180604065549.468488465@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/03/2018 11:58 PM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.16.14 release.
> There are 47 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed Jun  6 06:55:34 UTC 2018.
> Anything received after that time might be too late.
> 

Build results:
	total: 136 pass: 136 fail: 0
Qemu test results:
	total: 141 pass: 141 fail: 0

Details are available at http://kerneltests.org/builders/.

Guenter
