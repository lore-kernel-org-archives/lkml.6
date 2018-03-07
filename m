Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934181AbeCGRgr (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 12:36:47 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:58746 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933478AbeCGRgk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 12:36:40 -0500
Subject: Re: Re[v2]: Use of GCC plugin instead ISO C
To: Progyan Bhattacharya <bprogyan@gmail.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <1518941218.12663.1.camel@gmail.com>
 <7bd655df-39a1-2098-0d1c-256c0900b7ed@infradead.org>
 <1519310261.20003.1.camel@acm.org> <1519890640.7987.0.camel@acm.org>
 <5b4d0708-c375-02b0-9014-9400992addf8@infradead.org>
 <1520342938.6596.1.camel@acm.org>
 <d3ce60f9-7838-a98b-c807-fa0603544f9d@infradead.org>
 <1520402470.4309.3.camel@acm.org>
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <76f019e1-0343-92bf-2be8-045b13b6946f@infradead.org>
Date: Wed, 7 Mar 2018 09:36:32 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1520402470.4309.3.camel@acm.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/06/2018 10:01 PM, Progyan Bhattacharya wrote:
> On Tue, 2018-03-06 at 09:24 -0800, Randy Dunlap wrote:
>> First, please make sure that this file does not already exist before
>> starting
>> a build:  /home/progyan/Programs/Linux/tools/objtool/.objtool-
>> in.o.cmd
> 
> Yes, it was there and I removed it.
> 
>> Then I will look at this more if you will send me your kernel .config
>> file and
>> the exact command(s) that you use to run the build.

I'm still not seeing any problems.

> I am running build by:
>   make V=1

That's all?  anything after the "V=1"?

> 
> Here is my config and build log this time.
> 

/bin/sh: scripts/genksyms/modules.order: Permission denied

To me that message most likely means that the file is present in your O=<path>
directory, but that it is owned by someone else (possibly root).

Can you remove everything in the O=<path> directory (rm -rf <directory>;
mkdir <directory>) and then try again?

-- 
~Randy
