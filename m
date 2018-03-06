Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753559AbeCFMjz (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Mar 2018 07:39:55 -0500
Received: from mail-wm0-f46.google.com ([74.125.82.46]:33967 "EHLO
        mail-wm0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753291AbeCFMjv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Mar 2018 07:39:51 -0500
X-Google-Smtp-Source: AG47ELsau19mSH0qaJVG8W//0xSmjdEarjG1vKGzR+rJdCD4pmYL6HXbfWZnR53yGhft2pfKfJEm1Q==
Subject: Re: [PATCH 0/5 V2] tpm: timeouts revamp
To: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Tomas Winkler <tomas.winkler@intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
Cc: Alexander Usyskin <alexander.usyskin@intel.com>,
        linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20180306092503.11568-1-tomas.winkler@intel.com>
 <1520338622.3779.1.camel@linux.intel.com>
From: Javier Martinez Canillas <javierm@redhat.com>
Message-ID: <031568ca-8999-478d-8c53-8b206f312e90@redhat.com>
Date: Tue, 6 Mar 2018 13:39:49 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1520338622.3779.1.camel@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/06/2018 01:17 PM, Jarkko Sakkinen wrote:
> On Tue, 2018-03-06 at 11:24 +0200, Tomas Winkler wrote:
>> This series cleans up tpm timeouts setting and handling.
>>
>> First motivation was to fix failures coming from too short timeouts
>> for commands that creates keys.
>> Key generation may take significant time depending on the underlying
>> hardware. Rather than increasing default timeout a new constant is
>> added, to not stall too long on regular commands failures.
>>
>> Second is to define timeouts for new tpm2 commands
>> defined in TCG 1.36 spec.
>

Probably a typo, since the latest TCG spec version is the 1.38 [0].
 
> Where can we get that specification? I don't have that new
> version and couldn't find it from the public internet.
> 
> /Jarkko
> 

[0]: https://trustedcomputinggroup.org/tpm-library-specification/

Best regards,
-- 
Javier Martinez Canillas
Software Engineer - Desktop Hardware Enablement
Red Hat
