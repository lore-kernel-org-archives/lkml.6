Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752471AbeFDKP2 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 06:15:28 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:46325 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752071AbeFDKP0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 06:15:26 -0400
X-Google-Smtp-Source: ADUXVKIJZofApcs38R4GwtsTIE8fRlELGQOt8V0Jo0+GCM04R21LCzbl+0wIOrWlbco6sj3F/QGalw==
Subject: Re: [PATCH 4.9 00/29] 4.9.106-stable review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc: torvalds@linux-foundation.org, akpm@linux-foundation.org,
        shuah@kernel.org, patches@kernelci.org, ben.hutchings@codethink.co.uk,
        lkft-triage@lists.linaro.org, stable@vger.kernel.org
References: <20180604065802.157744637@linuxfoundation.org>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <a4a96a37-0958-ca4e-ea32-826a29db1476@roeck-us.net>
Date: Mon, 4 Jun 2018 03:15:23 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180604065802.157744637@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/03/2018 11:57 PM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.9.106 release.
> There are 29 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed Jun  6 06:57:52 UTC 2018.
> Anything received after that time might be too late.
> 

Are you testing us ?

Building x86_64:tools/perf ... failed
--------------
Error log:
make[4]: execvp: ./check-headers.sh: Permission denied
make[4]: *** [sub-make] Error 127

Something went wrong with the patch creating the file. In the original
commit it is created as 755, in the backport it is created as 644.

Guenter
