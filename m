Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754836AbeDFNyo (ORCPT <rfc822;w@1wt.eu>);
        Fri, 6 Apr 2018 09:54:44 -0400
Received: from mail-qk0-f195.google.com ([209.85.220.195]:42363 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752622AbeDFNyl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Apr 2018 09:54:41 -0400
X-Google-Smtp-Source: AIpwx48oS/i/XfK6C+pFU4XDruMmH93lqRo6zJP4sAmlYO2qAVY38UIlzw0JLiGD/NWk7TwHnAWxq9X4+7pFLiTSF1I=
MIME-Version: 1.0
In-Reply-To: <CA+55aFzTKu8um8wu5EtZS83+vepPnGM9KG+fPZ91ZjTESOatYg@mail.gmail.com>
References: <CAK8P3a1rJc+3MMMwcYSZ0n14=5e_1v_UdnHexysuqy4RfQPxmA@mail.gmail.com>
 <CA+55aFzTKu8um8wu5EtZS83+vepPnGM9KG+fPZ91ZjTESOatYg@mail.gmail.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Fri, 6 Apr 2018 15:54:35 +0200
X-Google-Sender-Auth: 41vGoBoZxkBnUBOktPJh_WfyBOk
Message-ID: <CAK8P3a1gT=xzCrHQtPTn+ciqze2mArH07+FWEUtkfQgU_ohSjw@mail.gmail.com>
Subject: Re: [GIT PULL 3/3] ARM: SoC driver updates for 4.17
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        arm-soc <arm@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 6, 2018 at 6:34 AM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> On Thu, Apr 5, 2018 at 2:23 PM, Arnd Bergmann <arnd@arndb.de> wrote:
>>
>> - the ARM CCN driver is moved out of drivers/bus into drivers/perf,
>>   which makes more sense. Similarly, the performance monitoring
>>   portion of the CCI driver are moved the same way and cleaned up
>>   a little more.
>
> This caused a trivial merge with the perf tree.
>
> But since I don't *build* the trivial merge resolution due to it being
> an arm-only file, I wanted to point it out.
>
> Because "not tested" very possibly means "I screwed something silly up
> and didn't notice".
>
> So as trivial as it seemed, it should still be checked.

Looks good to me and it survived the randconfig build tests,
so I assume it's fine.

       Arnd
