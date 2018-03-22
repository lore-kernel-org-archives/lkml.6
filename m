Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751857AbeCVTzE (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Mar 2018 15:55:04 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:46114 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751734AbeCVTzC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Mar 2018 15:55:02 -0400
X-Google-Smtp-Source: AG47ELs2WpHfLmc1RgvkP87ZsqGHSIY+9BOqVgZpeA1rHszisO3zXiIhXdzaq5g8cgzynP3bbegSqQ==
To: Linus Torvalds <torvalds@linux-foundation.org>,
        Junio C Hamano <gitster@pobox.com>, git ml <git@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
From: Xose Vazquez Perez <xose.vazquez@gmail.com>
Subject: git: cover letter and automatic Cc: [was Re: [PATCH 23/45] sched: add
 do_sched_yield() helper; remove in-kernel call to sched_yield()]
Message-ID: <ca4949ba-ed8b-3c99-f3f6-e4feee7bc66c@gmail.com>
Date: Thu, 22 Mar 2018 20:54:58 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:

> On Thu, Mar 22, 2018 at 10:29 AM, Peter Zijlstra <peterz@infradead.org> wrote:
>>
>> But why !? Either Cc me on more of the series such that the whole makes
>> sense, or better yet, write a proper Changelog.
> 
> This is a common issue. We should encourage people to always send at
> least the cover-page to everybody who gets cc'd, even if they don't
> get the whole series.


git should be smart enough to do it automatically by itself.
