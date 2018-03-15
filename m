Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752813AbeCOURK (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 16:17:10 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:54536 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752640AbeCOURI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 16:17:08 -0400
Date: Thu, 15 Mar 2018 21:17:05 +0100 (CET)
From: Thomas Gleixner <tglx@linutronix.de>
To: jason.vas.dias@gmail.com
cc: linux-kernel@vger.kernel.org, x86@kernel.org, mingo@kernel.org,
        peterz@infradead.org, andi@firstfloor.org
Subject: Re: [PATCH v4.16-rc5 (3)] x86/vdso: on Intel, VDSO should handle
 CLOCK_MONOTONIC_RAW
In-Reply-To: <1521129648-20889-1-git-send-email-jason.vas.dias@gmail.com>
Message-ID: <alpine.DEB.2.21.1803152047380.1520@nanos.tec.linutronix.de>
References: <1521129648-20889-1-git-send-email-jason.vas.dias@gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jason,

On Thu, 15 Mar 2018, jason.vas.dias@gmail.com wrote:

>   Resent to address reviewer comments.

I was being patient so far and tried to guide you through the patch
submission process, but unfortunately this turns out to be just waste of my
time.

You have not addressed any of the comments I made here:

[1]  https://lkml.kernel.org/r/alpine.DEB.2.21.1803141511340.2481@nanos.tec.linutronix.de
[2]  https://lkml.kernel.org/r/alpine.DEB.2.21.1803141527300.2481@nanos.tec.linutronix.de

But still you claim that you addressed reviewer comments.

The delta between the two patch series shows clearly that you ignored both
review mails completely. You merily changed the implementation of a
function, which I not even reviewed, and fiddled in the big fat comment.

Feel free to ignore me, but rest assured that this is the last chance
before you end up in the /dev/null mail filter.

I recommend you to try to fixup only the first patch and once that is good
to go you might try to submit the rest. But please take your time and
address _ALL_ of my comments and follow the documented rules.

If you have questions regarding my comments or the process after working
through them and the Documentation I pointed to, feel free to ask them on
the list and not in private mail. If you think that my comments or
recommendations are wrong, discuss them on list instead of silently
ignoring them.

Yours grumpy

      tglx
