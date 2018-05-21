Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751559AbeEUAng (ORCPT <rfc822;w@1wt.eu>);
        Sun, 20 May 2018 20:43:36 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:56019 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751021AbeEUAnd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 May 2018 20:43:33 -0400
X-ME-Proxy: <xmx:NBYCWzIeOF_QrRwRUJQDwvL_a0VcBhcFFPrFjKP8r-NyOH747G6lOA>
X-ME-Proxy: <xmx:NBYCWz1CEZVy0KOvnXt0xDB5OBpsu4WI1pUOE6M0BA7LIvWCnqf9tQ>
X-ME-Proxy: <xmx:NBYCW8J0cu-FXMryi1YJz8rpBxyQVMNel2wW9a3OLJswrpJofx8Rvg>
X-ME-Proxy: <xmx:NBYCWy8etgsA84FNq6gGyOixdwVyJY4myAq_bpVKdms6Jna488Qy3w>
X-ME-Proxy: <xmx:NBYCWw-HaOaBu921x6twtL_X6_h3hKHIyxOySYwuZH0x_bcAkw0ppw>
X-ME-Proxy: <xmx:NBYCW20Izh6nJz2ak1RvJqKp3kFNJtPMbCgI1LDwLRv67EQOHFOfZA>
X-ME-Sender: <xms:NBYCWzo0xteZY4gcVJV096ed7gaVHUL_VjvH-Kx6hSbAm3iAbcJ1hQ>
Subject: Re: mmotm 2018-05-17-16-26 uploaded (autofs)
To: Randy Dunlap <rdunlap@infradead.org>, akpm@linux-foundation.org,
        broonie@kernel.org, mhocko@suse.cz, sfr@canb.auug.org.au,
        linux-next@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        mm-commits@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>
References: <20180517232639.sD6Cz%akpm@linux-foundation.org>
 <19926e1e-6dba-3b9f-fd97-d9eb88bfb7dd@infradead.org>
 <49acf718-da2e-73dc-a3bf-c41d7546576e@themaw.net>
 <9e3dfece-46a0-8ab2-2c7e-3edf956703a8@infradead.org>
 <6441e45b-6216-a20a-5b1d-6f5663d701dd@themaw.net>
 <80c2dcf5-b9a9-3d75-7f6f-d0e9c1a11fb9@themaw.net>
 <22ae3b7e-bfbd-6537-9656-9fd429255d69@infradead.org>
From: Ian Kent <raven@themaw.net>
Message-ID: <d225202d-fcba-851d-63a6-ae6a1c3ae0e7@themaw.net>
Date: Mon, 21 May 2018 08:43:25 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <22ae3b7e-bfbd-6537-9656-9fd429255d69@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/05/18 00:22, Randy Dunlap wrote:
> On 05/17/2018 11:09 PM, Ian Kent wrote:
>> On 18/05/18 12:38, Ian Kent wrote:
>>> On 18/05/18 12:23, Randy Dunlap wrote:
>>>> On 05/17/2018 08:50 PM, Ian Kent wrote:
>>>>> On 18/05/18 08:21, Randy Dunlap wrote:
>>>>>> On 05/17/2018 04:26 PM, akpm@linux-foundation.org wrote:
>>>>>>> The mm-of-the-moment snapshot 2018-05-17-16-26 has been uploaded to
>>>>>>>
>>>>>>>    http://www.ozlabs.org/~akpm/mmotm/
>>>>>>>
>>>>>>> mmotm-readme.txt says
>>>>>>>
>>>>>>> README for mm-of-the-moment:
>>>>>>>
>>>>>>> http://www.ozlabs.org/~akpm/mmotm/
>>>>>>>
>>>>>>> This is a snapshot of my -mm patch queue.  Uploaded at random hopefully
>>>>>>> more than once a week.
>>>>>>>
>>>>>>> You will need quilt to apply these patches to the latest Linus release (4.x
>>>>>>> or 4.x-rcY).  The series file is in broken-out.tar.gz and is duplicated in
>>>>>>> http://ozlabs.org/~akpm/mmotm/series
>>>>>>>
>>>>>>> The file broken-out.tar.gz contains two datestamp files: .DATE and
>>>>>>> .DATE-yyyy-mm-dd-hh-mm-ss.  Both contain the string yyyy-mm-dd-hh-mm-ss,
>>>>>>> followed by the base kernel version against which this patch series is to
>>>>>>> be applied.
>>>>>>>
>>>>>>> This tree is partially included in linux-next.  To see which patches are
>>>>>>> included in linux-next, consult the `series' file.  Only the patches
>>>>>>> within the #NEXT_PATCHES_START/#NEXT_PATCHES_END markers are included in
>>>>>>> linux-next.
>>>>>>>
>>>>>>> A git tree which contains the memory management portion of this tree is
>>>>>>> maintained at git://git.kernel.org/pub/scm/linux/kernel/git/mhocko/mm.git
>>>>>>> by Michal Hocko.  It contains the patches which are between the
>>>>>>> "#NEXT_PATCHES_START mm" and "#NEXT_PATCHES_END" markers, from the series
>>>>>>> file, http://www.ozlabs.org/~akpm/mmotm/series.
>>>>>>>
>>>>>>>
>>>>>>> A full copy of the full kernel tree with the linux-next and mmotm patches
>>>>>>> already applied is available through git within an hour of the mmotm
>>>>>>> release.  Individual mmotm releases are tagged.  The master branch always
>>>>>>> points to the latest release, so it's constantly rebasing.
>>>>>>
>>>>>>
>>>>>> on x86_64: with (randconfig):
>>>>>> CONFIG_AUTOFS_FS=y
>>>>>> CONFIG_AUTOFS4_FS=y
>>>>>
>>>>> Oh right, I need to make these exclusive.
>>>>>
>>>>> I seem to remember trying to do that along the way, can't remember why
>>>>> I didn't do it in the end.
>>>>>
>>>>> Any suggestions about potential problems when doing it?
>>>>
>>>> I think that just using "depends on" for each of them will cause kconfig to
>>>> complain about circular dependencies, so probably using "choice" will be
>>>> needed.  Or (since this is just temporary?) just say "don't do that."
>>>>
>>>
>>> No doubt that was what happened, unfortunately I forgot to return to it.
>>>
>>> Right, a conditional with a message should work .... thanks.
>>
>> It looks like adding:
>> depends on AUTOFS_FS = n && AUTOFS_FS != m
> 
> Hi.  Is there a typo on the line above?

Don't think so.

This was straight out of:

diff --git a/fs/autofs4/Kconfig b/fs/autofs4/Kconfig
index 53bc592a250d..2f9bafabac1b 100644
--- a/fs/autofs4/Kconfig
+++ b/fs/autofs4/Kconfig
@@ -1,6 +1,7 @@
 config AUTOFS4_FS
        tristate "Kernel automounter version 4 support (also supports v3 and v5)"
        default n
+       depends on AUTOFS_FS = n && AUTOFS_FS != m
        help
          The automounter is a tool to automatically mount remote file systems
          on demand. This implementation is partially kernel-based to reduce
@@ -30,3 +31,10 @@ config AUTOFS4_FS
          - any "alias autofs autofs4" will need to be removed.
 
          Please configure AUTOFS_FS instead of AUTOFS4_FS from now on.
+
+         NOTE: Since the modules autofs and autofs4 use the same file system
+               type name of "autofs" only one can be built. The "depends"
+               above will result in AUTOFS4_FS not appearing in .config for
+               any setting of AUTOFS_FS other than n and AUTOFS4_FS will
+               appear under the AUTOFS_FS entry otherwise which is intended
+               to draw attention to the module rename change.

which appears to do what's needed about as well as can be done and deals
with the AUTOFS4_FS=y && AUTOFS_FS=y case.

Ian
