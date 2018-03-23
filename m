Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752175AbeCWPuf (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Mar 2018 11:50:35 -0400
Received: from mail-lf0-f41.google.com ([209.85.215.41]:35158 "EHLO
        mail-lf0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751504AbeCWPud (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Mar 2018 11:50:33 -0400
X-Google-Smtp-Source: AG47ELvnjAPPowy9IEeBLkNX66kEdQXtukOrHNnVSMII4mYCHNrxulRmrg0MD3w6Ix1pSDLlAKHwBo8XPd30iBxDlN0=
MIME-Version: 1.0
In-Reply-To: <20180323151913.GG15012@1wt.eu>
References: <E513F076-24D5-4F67-A204-D2E6E1135FDE@einstein.yu.edu>
 <20180323145428.GF15012@1wt.eu> <8BF385DA-7EB8-446D-9005-64509D7C7CB8@einstein.yu.edu>
 <20180323151913.GG15012@1wt.eu>
From: Gabriel C <nix.or.die@gmail.com>
Date: Fri, 23 Mar 2018 16:50:01 +0100
Message-ID: <CAEJqkgjj2dR4GLOEzsUJiWOsoqFWArioh32KW1We5xgp4qSb1Q@mail.gmail.com>
Subject: Re: Did kernel 3.11 never work?
To: Willy Tarreau <w@1wt.eu>
Cc: Maurice R Volaski <maurice.volaski@einstein.yu.edu>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-03-23 16:19 GMT+01:00 Willy Tarreau <w@1wt.eu>:
> On Fri, Mar 23, 2018 at 02:58:46PM +0000, Maurice R Volaski wrote:
>> I'm trying to build a computer with network diagnostic tool,
>> https://software.internet2.edu/ndt/ and it requires patches to the kernel,
>> https://www.web10g.org/. The latest kernel for which there are patches, 3.17,
>> doesn't compile with the patches, so I had to progressively retrogress until
>> I can found one that did.
>
> In my opinion you'd waste much less time trying to port these patches to
> a more recent, still maintained kernel. 3.16 is still maintained by Ben,
> and not too far from 3.17 (less than 3.11). You may have more luck there
> and also more luck to get it to boot on a recent machine.
>
> Also on web10g I'm seeing patches for kernels 3.2 to 3.4. 3.2 is also
> still maintained by Ben. You can try this one, maybe it'll work, who
> knows.
>

I don't really remeber  but some  TCP_ESTATS_* exists in 4.x kernels.
So some based-on or these patches got somewho merged.
Also some work  is still done from Chris Rapier on github.

Maybe have a look there ?
https://github.com/rapier1

Regards,

Gabriel C
