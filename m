Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933559AbeBVR3U (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 12:29:20 -0500
Received: from merlin.infradead.org ([205.233.59.134]:55702 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933462AbeBVR3K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 12:29:10 -0500
Subject: Re: [PATCH] doc: process: Add "Root-caused-by" and "Suggested-by"
To: Kees Cook <keescook@chromium.org>
Cc: Jonathan Corbet <corbet@lwn.net>, LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-doc@vger.kernel.org, Andy Whitcroft <apw@canonical.com>,
        Joe Perches <joe@perches.com>
References: <20180222003749.GA4724@beast>
 <1753aad2-6a9b-bf4f-72b9-921587424f79@infradead.org>
 <CAGXu5jKn_8JSe8i2X9sJ-r4MhHkBVdC6rYMeKCZcBK_LtFJ8rA@mail.gmail.com>
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <edd0d5ec-b85a-9351-3614-adea369372e2@infradead.org>
Date: Thu, 22 Feb 2018 09:29:05 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <CAGXu5jKn_8JSe8i2X9sJ-r4MhHkBVdC6rYMeKCZcBK_LtFJ8rA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/21/2018 10:03 PM, Kees Cook wrote:
> On Wed, Feb 21, 2018 at 8:43 PM, Randy Dunlap <rdunlap@infradead.org> wrote:
>> On 02/21/2018 04:37 PM, Kees Cook wrote:
>>> As recently pointed out by Linus, "Root-caused-by" is a good tag to include
>>> since it can indicate significantly more work than "just" a Reported-by.
>>> This adds it and "Suggested-by" (which was also missing) to the documented
>>> list of tags. Additionally updates checkpatch.pl to match the process docs.
>>>
>>> Signed-off-by: Kees Cook <keescook@chromium.org>
>>> ---
>>>  Documentation/process/5.Posting.rst | 7 +++++++
>>>  scripts/checkpatch.pl               | 2 ++
>>>  2 files changed, 9 insertions(+)
>>
>> I would still rather see Co-developed-by: in both the docs and in checkpatch. :(
> 
> Hm? It is in docs. This syncs the process doc to checkpatch...

Yes, I understand that.  I'm just saying that it's "wrong" in both places.

-- 
~Randy
