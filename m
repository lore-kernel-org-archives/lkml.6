Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751340AbeBZRbn (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 12:31:43 -0500
Received: from wp227.webpack.hosteurope.de ([80.237.132.234]:45548 "EHLO
        wp227.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750767AbeBZRbl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 12:31:41 -0500
Subject: Re: DM Regression in 4.16-rc1 - read() returns data when it shouldn't
To: NeilBrown <neilb@suse.com>, Mike Snitzer <snitzer@redhat.com>
Cc: Milan Broz <gmazyland@gmail.com>,
        device-mapper development <dm-devel@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <70cda2a3-f246-d45b-f600-1f9d15ba22ff@gmail.com>
 <5fca4e3f-536c-9c52-31bb-927e8ab5b6c8@leemhuis.info>
 <20180219171531.GA27498@redhat.com>
 <3fa615bf-8239-f189-8557-cb2d072181c0@leemhuis.info>
 <87606khv5z.fsf@notabene.neil.brown.name>
From: Thorsten Leemhuis <regressions@leemhuis.info>
Message-ID: <c312f639-5fe6-d47f-2395-3985c80c0fc6@leemhuis.info>
Date: Mon, 26 Feb 2018 18:31:37 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <87606khv5z.fsf@notabene.neil.brown.name>
Content-Type: text/plain; charset=utf-8
Content-Language: en-MW
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1519666301;1084e998;
X-HE-SMSGID: 1eqMck-0006VX-Fp
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26.02.2018 12:01, NeilBrown wrote:
> On Mon, Feb 26 2018, Thorsten Leemhuis wrote:
>> Hi Mike! On 19.02.2018 18:15, Mike Snitzer wrote:
>>> On Mon, Feb 19 2018 at  8:44am -0500,
>>> Thorsten Leemhuis <regressions@leemhuis.info> wrote:
>>>> JFYI: This issues is tracked in the regression reports for Linux 4.16
>>>> (http://bit.ly/lnxregrep416 ) with this id:
>>>> Linux-Regression-ID: lr#9e195f
>>>> Please include this line in the comment section of patches that are
>>> […]
>>> The fix was already merged by Linus on Friday, see:
>>> git.kernel.org/linus/8dd601fa8317243be887458c49f6c29c2f3d719f
>> Ohh, thx for the pointer. Could you please next time add a tag like
>> Fixes: 18a25da84354 ("dm: ensure bio submission follows a depth-first
>> tree walk")
> 
> The thing is... it didn't fix that commit.  That commit was fine.
> If fixed something else much further back, which that commit just made
> more problematic.
> That is why I added the Cc: stable with the earliest version that needed
> fixing.
> 
> Unfortunately, reality isn't always neat and tidy :-(  when it is, I do
> use Fixes:

Ha, okay, sorry for the noise then.

Side note:  At the same time this is might be a reason why a
"Linux-Regression-ID" or something like that might make sense, because
it shows that even a bisected commit sometimes isn't enough to build a
obvious connection between a regression report and the commit with the
fix...
 Ciao, Thorsten
