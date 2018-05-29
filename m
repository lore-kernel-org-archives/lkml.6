Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966150AbeE2TTn (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 15:19:43 -0400
Received: from mail-qt0-f195.google.com ([209.85.216.195]:33050 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965541AbeE2TTk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 15:19:40 -0400
X-Google-Smtp-Source: ADUXVKKXQnH5aPG2nH4lWHZmnKtfdUHBMJo9j6z6yBVRrR83sqZ0qsLysH5tF+kiXVf7mS7LEvqd4A==
Content-Type: text/plain;
        charset=utf-8
Subject: Re: [PATCH 4.16 000/272] 4.16.13-stable review
From: Rafael Tinoco <rafael.tinoco@linaro.org>
In-Reply-To: <20180529070815.GB20225@kroah.com>
Date: Tue, 29 May 2018 16:19:34 -0300
Cc: Naresh Kamboju <naresh.kamboju@linaro.org>,
        Ben Hutchings <ben.hutchings@codethink.co.uk>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        open list <linux-kernel@vger.kernel.org>,
        linux- stable <stable@vger.kernel.org>, patches@kernelci.org,
        lkft-triage@lists.linaro.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>, Guenter Roeck <linux@roeck-us.net>
Message-Id: <BBE1C638-60BE-4F73-820C-D1E1EFBD33E3@linaro.org>
References: <20180528100240.256525891@linuxfoundation.org>
 <CA+G9fYu1NuW6vB+bHEsYSmyJAB27kw8vP=0uwhVR962Yq4C43g@mail.gmail.com>
 <20180529070815.GB20225@kroah.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w4TJK5f8016542

The following bug has been opened for LTP:

https://github.com/linux-test-project/ltp/issues/319

for the CVE-2017-5669's wrong assumptions (based on Davidlohr's work). 

I'll change the test to cover both scenarios and expect the right results from them.

> On 29 May 2018, at 04:08, Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
> 
> On Tue, May 29, 2018 at 10:55:34AM +0530, Naresh Kamboju wrote:
>> On 28 May 2018 at 15:30, Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
>>> This is the start of the stable review cycle for the 4.16.13 release.
>>> There are 272 patches in this series, all will be posted as a response
>>> to this one.  If anyone has any issues with these being applied, please
>>> let me know.
>>> 
>>> Responses should be made by Wed May 30 10:01:02 UTC 2018.
>>> Anything received after that time might be too late.
>>> 
>>> The whole patch series can be found in one patch at:
>>>        https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.16.13-rc1.gz
>>> or in the git tree and branch at:
>>>        git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.16.y
>>> and the diffstat can be found below.
>>> 
>>> thanks,
>>> 
>>> greg k-h
>> 
>> Results from Linaro’s test farm.
>> No regressions on arm64, arm and x86_64.
>> 
>> NOTE:
>> The failed LTP test case "cve-2017-5669" is a waiver here.
> 
> Thanks for figuring that one out :)
> 
> Also, thanks for testing all of these and letting me know.
