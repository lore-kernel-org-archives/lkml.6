Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1759469AbeD1CE2 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 27 Apr 2018 22:04:28 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:48608 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1759215AbeD1CE1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Apr 2018 22:04:27 -0400
Subject: Re: [PATCH] documentation: core-api: rearrange a few kernel-api
 chapters and sections
To: Jonathan Corbet <corbet@lwn.net>
Cc: "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <f05c8785-e9e1-0a5e-b362-50669b75d80b@infradead.org>
 <20180427171712.4e09233a@lwn.net>
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <3b6a2a91-2921-0e34-6f80-2f2726d96977@infradead.org>
Date: Fri, 27 Apr 2018 19:04:23 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180427171712.4e09233a@lwn.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/27/2018 04:17 PM, Jonathan Corbet wrote:
> On Thu, 26 Apr 2018 18:11:02 -0700
> Randy Dunlap <rdunlap@infradead.org> wrote:
> 
>> Rearrange some kernel-api chapters and sections to group them
>> together better.
>>
>> - move Bit Operations from Basic C Library Functions to Basic
>>   Kernel Library Functions (now adjacent to Bitmap Operations since
>>   they are not typical C library functions)
>>
>> - move Sorting from Math Functions to Basic Kernel Library Functions
>>   since sort functions are more Basic than Math Functions
>>
>> - move Text Searching from Math Functions to Basic Kernel Library
>>   Functions (keep Sorting and Searching close to each other)
>>
>> - combine CRC and Math functions together into the (newly named)
>>   CRC and Math Functions chapter
> 
> The changes look good.  But ... grr... some of the stuff you are moving
> around was introduced in -rc2 via the networking tree.  That kind of thing
> makes life harder than it needs to be.  I've sorted it out and applied the
> patch, thanks.

Sorry, I thought that making the patch on linux-next 20180426 (which is based
on -rc2 and a few hundred git trees) would help with that.

Thanks for fixing.
-- 
~Randy
