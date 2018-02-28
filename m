Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752602AbeB1ORQ (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 09:17:16 -0500
Received: from mail-ot0-f175.google.com ([74.125.82.175]:44444 "EHLO
        mail-ot0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752417AbeB1ORO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 09:17:14 -0500
X-Google-Smtp-Source: AG47ELsTwB2y/JHgnqsJ4tudYBMIJwGGXFzUMCeE9dPwVGonm1LXpNCBBN3G0aBZ4CAeAwUoVQQs2A==
Reply-To: minyard@acm.org
Subject: Re: Regression in IPMI on 4.15.6
From: Corey Minyard <minyard@acm.org>
To: Laura Abbott <labbott@redhat.com>
Cc: openipmi-developer@lists.sourceforge.net,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <7b4cd699-1a77-5412-5346-b30e44bfc9c9@redhat.com>
 <33fb6125-7ffa-0d3a-e1d6-1a849b816867@acm.org>
Message-ID: <bdb67791-9a2c-bd04-5678-efb6b3cdf962@acm.org>
Date: Wed, 28 Feb 2018 08:17:10 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <33fb6125-7ffa-0d3a-e1d6-1a849b816867@acm.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/28/2018 07:53 AM, Corey Minyard wrote:
> On 02/27/2018 05:55 PM, Laura Abbott wrote:
>> Hi,
>>
>> Fedora got a bug report of a crash in IPMI on 4.15.6
>> https://bugzilla.redhat.com/show_bug.cgi?id=1549316
>> Unfortunately, it's only a screenshot but it's fairly
>> clear. It looks like a panic in the error handling path
>> in platform_device_unregister. Any ideas?
>>
>

You may also run into another issue.  You can pull the
individual patch at

https://github.com/cminyard/linux-ipmi.git 
c8a1972e77dbe321ce5ce0247056e727234cbaec

for that fix.

-corey

> Yeah, this is fixed by 174134ac7602 "ipmi_si: Fix error
> handling of platform device" in mainstream.
>
> I guess I need to request a backport of this.
>
> Thanks for reporting.
>
> -corey
>
>
>> Thanks,
>> Laura
>
>
