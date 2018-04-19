Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751182AbeDSGzk (ORCPT <rfc822;w@1wt.eu>);
        Thu, 19 Apr 2018 02:55:40 -0400
Received: from mga06.intel.com ([134.134.136.31]:7797 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750732AbeDSGzj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Apr 2018 02:55:39 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,468,1517904000";
   d="scan'208";a="44442611"
Date: Thu, 19 Apr 2018 14:55:31 +0800
From: Fengguang Wu <fengguang.wu@intel.com>
To: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc: Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Pavel Tatashin <pasha.tatashin@oracle.com>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Nicolas Pitre <nicolas.pitre@linaro.org>,
        Nikitas Angelinas <nikitas.angelinas@gmail.com>,
        Matt Redfearn <matt.redfearn@mips.com>,
        LKML <linux-kernel@vger.kernel.org>, LKP <lkp@01.org>,
        Steven Sistare <steven.sistare@oracle.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        Bob Picco <bob.picco@oracle.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        kasan-dev <kasan-dev@googlegroups.com>
Subject: Re: [console_unlock] BUG: KASAN: use-after-scope in
 console_unlock+0x9cd/0xd10
Message-ID: <20180419065531.l6kblbziddplgcwi@wfg-t540p.sh.intel.com>
References: <20180419021757.66xxs5fgvlrusiup@wfg-t540p.sh.intel.com>
 <CACT4Y+bmYk_A4NcOhCeHcG4t5_c=Q1fmQOPxHLtC8G0hLrxSLA@mail.gmail.com>
 <20180419062050.GA8683@jagdpanzerIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20180419062050.GA8683@jagdpanzerIV>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 19, 2018 at 03:20:50PM +0900, Sergey Senozhatsky wrote:
>On (04/19/18 08:04), Dmitry Vyukov wrote:
>[..]
>> We could also make them mutually exclusive in config to prevent people
>> from hitting these false positives again and again.
>
>Let's do it. Ard and Kees agreed on making them mutually exclusive [1][2].
>Dmitry, could send out a patch?
>
>[1] lkml.kernel.org/r/CAKv+Gu8HN-t2om8sCfjxCWbsgSir54fZw222dsed0Xwqph2aNg@mail.gmail.com
>[2] lkml.kernel.org/r/CAGXu5j+mcfo4aB3PM1We6O62bFBJcMFX-9obJE4jFU1Dp=gNwg@mail.gmail.com

That'd be great, thank you very much!

Cheers,
Fengguang
