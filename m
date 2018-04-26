Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755278AbeDZLGS (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 07:06:18 -0400
Received: from outpost1.zedat.fu-berlin.de ([130.133.4.66]:53691 "EHLO
        outpost1.zedat.fu-berlin.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1755074AbeDZLGP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 07:06:15 -0400
Subject: Re: moving affs + RDB partition support to staging?
To: dsterba@suse.cz, Martin Steigerwald <martin@lichtvoll.de>,
        Matthew Wilcox <willy@infradead.org>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        linux-m68k@vger.kernel.org, Debian m68k <debian-68k@lists.debian.org>
References: <20180425154602.GA8546@bombadil.infradead.org>
 <20180425203029.GQ21272@twin.jikos.cz>
 <20180426025717.GA32430@bombadil.infradead.org> <1613268.lKBQxPXt8J@merkaba>
 <76ca15e2-7b43-8b02-43e1-9ee65ab85356@physik.fu-berlin.de>
 <20180426105940.smn3447igebe5r34@twin.jikos.cz>
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Message-ID: <dedb4126-1b7f-2ad5-07ce-307de6cbf422@physik.fu-berlin.de>
Date: Thu, 26 Apr 2018 13:06:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180426105940.smn3447igebe5r34@twin.jikos.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: 87.77.146.231
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/26/2018 12:59 PM, David Sterba wrote:
>> The answer is that we are still very much actively using RDB and AFFS
>> supoort in the Linux kernel and if you were to remove it, you would
>> directly hit users.
> 
> Based on that I think removing affs will not happen, but the upstream
> maintenance status should be updated accordingly.

As a fellow SUSE employee, I'm very happy to hear that someone
from SUSE is picking up the work <3. FWIW, Andreas Schwab from
SUSE maintains an internal port of openSUSE for m68k :).

>> Exactly. It works fine as is:
> ...
>> There is nothing at the moment that needs fixing.
> 
> So, I'm willing to act as upstream maintainer for affs, send pull
> requests with fixes if you ever need that (unless you find someone
> else).

Thanks a thousand times. If we happen to meet at a SUSE event,
I'll invite you to beverage of your choice ;-).

Thanks!
Adrian

-- 
  .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer - glaubitz@debian.org
`. `'   Freie Universitaet Berlin - glaubitz@physik.fu-berlin.de
   `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
