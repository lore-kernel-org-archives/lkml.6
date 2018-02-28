Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932135AbeB1NxK (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 08:53:10 -0500
Received: from mail-pl0-f42.google.com ([209.85.160.42]:44640 "EHLO
        mail-pl0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752441AbeB1NxI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 08:53:08 -0500
X-Google-Smtp-Source: AH8x224174ZZeNNZkPCQOnMQWAikxrIPDZiJ5IFTt31Fgy4mSckiwZWXj+LFluN7g7mkzAOoKdaf+g==
Reply-To: minyard@acm.org
Subject: Re: Regression in IPMI on 4.15.6
To: Laura Abbott <labbott@redhat.com>
Cc: openipmi-developer@lists.sourceforge.net,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <7b4cd699-1a77-5412-5346-b30e44bfc9c9@redhat.com>
From: Corey Minyard <minyard@acm.org>
Message-ID: <33fb6125-7ffa-0d3a-e1d6-1a849b816867@acm.org>
Date: Wed, 28 Feb 2018 07:53:01 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <7b4cd699-1a77-5412-5346-b30e44bfc9c9@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/27/2018 05:55 PM, Laura Abbott wrote:
> Hi,
>
> Fedora got a bug report of a crash in IPMI on 4.15.6
> https://bugzilla.redhat.com/show_bug.cgi?id=1549316
> Unfortunately, it's only a screenshot but it's fairly
> clear. It looks like a panic in the error handling path
> in platform_device_unregister. Any ideas?
>

Yeah, this is fixed by 174134ac7602 "ipmi_si: Fix error
handling of platform device" in mainstream.

I guess I need to request a backport of this.

Thanks for reporting.

-corey


> Thanks,
> Laura
