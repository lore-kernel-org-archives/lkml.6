Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B83EC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 13:23:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04DB0214DA
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 13:23:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728850AbfAJNXt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 08:23:49 -0500
Received: from seldsegrel01.sonyericsson.com ([37.139.156.29]:10164 "EHLO
        SELDSEGREL01.sonyericsson.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727704AbfAJNXs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 08:23:48 -0500
X-Greylist: delayed 602 seconds by postgrey-1.27 at vger.kernel.org; Thu, 10 Jan 2019 08:23:47 EST
Subject: Re: [PATCH] lib/genalloc.c: include vmalloc.h
To:     Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
CC:     Olof Johansson <olof@lixom.net>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Huang Shijie <sjhuang@iluvatar.ai>,
        Alexey Skidanov <alexey.skidanov@intel.com>
References: <20190105212118.61022-1-olof@lixom.net>
 <CAHk-=wiwLK8uPuzh3OABUHHi9D4PO5+fPaizRnviGno5oGevbA@mail.gmail.com>
 <20190107145614.2152eb5e59248d17994759ea@linux-foundation.org>
From:   peter enderborg <peter.enderborg@sony.com>
Message-ID: <1b876fba-28dc-ba7d-41f3-04580bc0c4b6@sony.com>
Date:   Thu, 10 Jan 2019 14:13:44 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190107145614.2152eb5e59248d17994759ea@linux-foundation.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/7/19 11:56 PM, Andrew Morton wrote:
> On Sat, 5 Jan 2019 13:35:33 -0800 Linus Torvalds <torvalds@linux-foundation.org> wrote:
>
>> On Sat, Jan 5, 2019 at 1:21 PM Olof Johansson <olof@lixom.net> wrote:
>>> Fixes build break on most ARM/ARM64 defconfigs:
>> Interesting.
>>
>> Andrew, I thought ARM was one of the platforms that your tree compiled
>> against? Or was some other change just hiding this?
>>
> I've become a bit lazy with the cross-compiling because linux-next's
> build coverage is pretty broad.  But Stephen's holiday interrupted
> things and this one fell in that window.
>
Is it now OK to use vmalloc in fast path's on all platforms?

