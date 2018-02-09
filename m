Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752999AbeBIVaL (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Feb 2018 16:30:11 -0500
Received: from mail-oi0-f52.google.com ([209.85.218.52]:38626 "EHLO
        mail-oi0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752816AbeBIVaK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Feb 2018 16:30:10 -0500
X-Google-Smtp-Source: AH8x227ANHADqc/swCUFGhykisXhTnOaahDv+/OUndXeZv9xL3fjQ/08BISdesKKols6bh8pIvYnoA==
Subject: Re: New project: get_maintainer.pl web app
To: Joe Perches <joe@perches.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Jeremy Cline <jcline@redhat.com>, Jonathan Corbet <corbet@lwn.net>
References: <8089f485-a0f6-aa5f-ad19-16b69eb07f46@redhat.com>
 <1518211292.14014.34.camel@perches.com>
From: Laura Abbott <labbott@redhat.com>
Message-ID: <f218e7ce-2a36-362d-96c5-193bca68dad2@redhat.com>
Date: Fri, 9 Feb 2018 13:30:07 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <1518211292.14014.34.camel@perches.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/09/2018 01:21 PM, Joe Perches wrote:
> On Fri, 2018-02-09 at 13:07 -0800, Laura Abbott wrote:
>> Hi,
>>
>> get_maintainers.pl has been the standard script for figuring out where to
>> send patches or bug reports. It has the disadvantage of requiring a kernel
>> tree to actually run though, which makes it harder for bug reports to
>> came in. I've started working on a small project to expose get_maintainers.pl
>> as a web app. This would let users enter information from a patch or crash
>> and call out to get_maintainers.pl. The current project just lets users
>> enter in a file path and it displays the output as is. There's lots of options
>> for what we could do with the output (omitting e-mails for those maintainers
>> who don't want to participate, printing out more helpful warnings etc.)
>>
>> The project is at https://pagure.io/get_maintainers and is not even close
>> to ready for primetime (passing data to get_maintainer.pl almost certainly
>> needs more thought). I'm mostly interested if anyone else would find this
>> useful or has general feedback.
> 
> Is there a website already setup too?
> 

Not yet. You have to run the app locally.
