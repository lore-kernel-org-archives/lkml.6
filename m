Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751664AbeBBHnW (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Feb 2018 02:43:22 -0500
Received: from mail-lf0-f65.google.com ([209.85.215.65]:33202 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751671AbeBBHnO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Feb 2018 02:43:14 -0500
X-Google-Smtp-Source: AH8x227qtk1Wvv5hSii3m1dSdlDVvgDGn/a2TrM1tFjxLzRn3jIxy+rcXxRLcEKuUnThDXMfeJioCVmQaNrG/eiYJYM=
MIME-Version: 1.0
In-Reply-To: <CAPM=9tyqDtVPqJ0Gv7LOmmBQQfoU6G0VsNkN0mPymg+Bv5VTSw@mail.gmail.com>
References: <CAPM=9tzdZucx_zkMESOfTV5tp9tP+g_tVkCmcQ7R9vYLaXq3Gw@mail.gmail.com>
 <CA+55aFzZiPJEoOViZh4hdKC=y9iEv8xAU_aCE2SxBqENZNO9_w@mail.gmail.com>
 <CAPM=9twxZtrNO8r_cQtXrMjkZ1jfvRD_3-dVPXAkLObE99DBFg@mail.gmail.com>
 <CA+55aFyEEKa48WADO0-5=vdGxGDug801u4C6+Cn7Gg6RoxCWZA@mail.gmail.com> <CAPM=9tyqDtVPqJ0Gv7LOmmBQQfoU6G0VsNkN0mPymg+Bv5VTSw@mail.gmail.com>
From: Daniel Stone <daniel@fooishbar.org>
Date: Fri, 2 Feb 2018 07:43:11 +0000
Message-ID: <CAPj87rOyvJyaS_MGZru3E0PZ+WiOjTEWApA7zeqHV0wiLJiBTQ@mail.gmail.com>
Subject: Re: [git pull] drm pull for v4.16-rc1
To: Dave Airlie <airlied@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2 February 2018 at 02:50, Dave Airlie <airlied@gmail.com> wrote:
> On 2 February 2018 at 12:44, Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
>> On Thu, Feb 1, 2018 at 6:22 PM, Dave Airlie <airlied@gmail.com> wrote:
>>>
>>> Turned out I was running on wayland instead of X.org and my cut-n-paste from
>>> gedit to firefox got truncated, wierd. I'll go annoy some people, and make sure
>>> it doesn't happen again.
>>
>> Heh, so there's some Wayland clipboard buffer limit.
>
> Yup or some bug getting the second chunks across from one place to another.

The transfer part of Wayland's clipboard protocol is an FD between
both clients for them to send data directly. But Firefox isn't yet
native, and I can fully believe that GNOME Shell's Xwayland clipboard
translator isn't perfect.

>> But that reminds me: is there any *standard* tool to programmatically
>> feed into the clipboard?
>>
>> I occasionally do things like
>>
>>     git shortlog A..B | xsel
>>
>> in order to then paste it into some browser window or other.
>>
>> And sure, that works well. But I do it seldom enough that I never
>> remember the command, and half the time it's not even installed
>> because I've switched machines or something, and xsel is always some
>> add-on.
>>
>> What's the thing "real" X people do/use?
>
> I use gedit to move things from files to clip now, for mostly the same reasons,
> I know it's installed usually. xclip and xsel are two utilities I know
> off, but I don'
> think anything gets installed by default.

That's the state of the art for X11.

Cheers,
Daniel
