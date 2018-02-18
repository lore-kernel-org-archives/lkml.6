Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751484AbeBRRA3 (ORCPT <rfc822;w@1wt.eu>);
        Sun, 18 Feb 2018 12:00:29 -0500
Received: from merlin.infradead.org ([205.233.59.134]:39502 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751259AbeBRRA2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Feb 2018 12:00:28 -0500
Subject: Re: Seeking guidance on spelling fixes
To: David Frey <dpfrey@gmail.com>,
        linux kernel <linux-kernel@vger.kernel.org>
References: <7912182.YNFVRYok70@roach>
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <b94c703e-fd4c-0273-cdff-391f99ded3ee@infradead.org>
Date: Sun, 18 Feb 2018 09:00:25 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <7912182.YNFVRYok70@roach>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/18/2018 07:34 AM, David Frey wrote:
> I noticed a common spelling mistake in some Linux kernel code that I was
> reading the other day and it made me wonder how prevalent common spelling
> mistakes are in the kernel.  I did some grepping and it seems that there
> are a large number of spelling mistakes.  I did a bit of searching and I
> found (http://www.kegel.com/kerspell/) which includes some comments/tools
> relating to spelling and the Linux kernel.
> 
> I have gone ahead and corrected about 100 total instances based on 25
> common misspellings.  There are many, many more common misspellings that I
> could check, but I don't want to sink more time into this if the changes
> won't be accepted.
> 
> Is this type of change likely to be accepted?  Right now I am making
> individual git commits for each correction.  For example "aditional ->
> additional".  I figured that it would be easier to review the list of
> replacements rather than a mega-patch which fixes many different errors.
> This way if any of the changes are controversial, I can easily rebase them
> out.
> 
> I am trying to only correct true misspellings.  I'm not trying to choose
> the "most correct" spelling for cases where there are acceptable alternate
> spellings.
> 
> I've pushed the changes I have made so far to a "spelling_fixes" branch
> here: https://github.com/dpfrey/linux/commits/spelling_fixes just in case
> there is any question about what I am doing based on the above description.
> 
> Just to be clear, I'm not trying to get this portion of the work merged at
> this point.  I'm trying to get a feel for whether I should keep working on
> this.

I can't answer for others, of course, but fixing spelling in user-visible
messages will usually be accepted/merged (e.g., error messages or Kconfig
help text).  I looked at a few of the commits and they are fixes in comments.
I would accept them, but I'm not a maintainer, just a contributor.

thanks,
-- 
~Randy
