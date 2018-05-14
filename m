Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752017AbeENFtI (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 01:49:08 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:45509 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751198AbeENFtG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 01:49:06 -0400
X-ME-Sender: <xms:USP5WlznrTuqpZOKIws4TTOy8q9tsfECba9BiOP8VEDE9aMhd2s4RA>
Subject: Re: [PATCH 01/10] autofs4 - merge auto_fs.h and auto_fs4.h
To: Al Viro <viro@ZenIV.linux.org.uk>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        autofs mailing list <autofs@vger.kernel.org>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <152626703024.28589.9571964661718767929.stgit@pluto.themaw.net>
 <20180514031509.GC30522@ZenIV.linux.org.uk>
From: Ian Kent <raven@themaw.net>
Message-ID: <5a7355b4-7bf1-c911-e010-263e3380794a@themaw.net>
Date: Mon, 14 May 2018 13:49:00 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180514031509.GC30522@ZenIV.linux.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/05/18 11:15, Al Viro wrote:
> On Mon, May 14, 2018 at 11:03:50AM +0800, Ian Kent wrote:
>> The autofs module has long since been removed so there's no need to have
>> two separate include files for autofs.
> 
> Umm...  Why does fs/compat_ioctl.c need either include, actually?
> 
>> --- a/fs/compat_ioctl.c
>> +++ b/fs/compat_ioctl.c
>> @@ -39,7 +39,6 @@
>>  #include <linux/if_pppox.h>
>>  #include <linux/mtio.h>
>>  #include <linux/auto_fs.h>
>> -#include <linux/auto_fs4.h>
>>  #include <linux/tty.h>
>>  #include <linux/vt_kern.h>
>>  #include <linux/fb.h>
> 
> AFAICS, we can just delete both.  Matter of fact, a *lot* of those includes are
> pointless nowadays...
> 

OK, I'll have a look at that and post a follow up patch.

Thanks for having a look at these Al.
