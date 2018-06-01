Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753198AbeFARDj (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 13:03:39 -0400
Received: from mail-ot0-f195.google.com ([74.125.82.195]:43931 "EHLO
        mail-ot0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752687AbeFARDh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 13:03:37 -0400
X-Google-Smtp-Source: ADUXVKJUgLLHNa/tY3Ju8m3PEfLdLw/Cq+5M91+UMPwlLZA10J3nQY9KrGv4izZgyPfaBxLsImsexmXgU+qnNWIE8Dg=
MIME-Version: 1.0
X-Originating-IP: [176.63.54.97]
In-Reply-To: <1d1b5ffb-4786-6b7a-fbf3-84b79080ccff@infradead.org>
References: <20180529132148.GC23785@veci.piliscsaba.redhat.com>
 <20180601152625.GD23785@veci.piliscsaba.redhat.com> <1d1b5ffb-4786-6b7a-fbf3-84b79080ccff@infradead.org>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Fri, 1 Jun 2018 19:03:36 +0200
Message-ID: <CAJfpegvON3nNumNhSbG2nozkMPuPGNX4m3HPpk6Cdj0skYna4g@mail.gmail.com>
Subject: Re: [GIT PULL] overlayfs update for 4.18
To: Randy Dunlap <rdunlap@infradead.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        overlayfs <linux-unionfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 1, 2018 at 6:18 PM, Randy Dunlap <rdunlap@infradead.org> wrote:
> On 06/01/2018 08:26 AM, Miklos Szeredi wrote:
>> On Tue, May 29, 2018 at 03:21:48PM +0200, Miklos Szeredi wrote:
>>> Hi Al,
>>>
>>> I'm sending this pull request to you instead of Linus, because a bigger than
>>> usual chunk involves the VFS.
>>>
>>> Please pull from:
>>>
>>>   git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/vfs.git for-viro
>>>
>>> This update contains the following:
>
>
>> ---
>>
>> diff --git a/Documentation/filesystems/overlayfs.txt b/Documentation/filesystems/overlayfs.txt
>> index 0a8e3c4543d1..79be4a77ca08 100644
>> --- a/Documentation/filesystems/overlayfs.txt
>> +++ b/Documentation/filesystems/overlayfs.txt
>> @@ -280,7 +280,7 @@ parameter metacopy=on/off. Lastly, there is also a per mount option
>>  metacopy=on/off to enable/disable this feature per mount.
>>
>>  Do not use metacopy=on with untrusted upper/lower directories. Otherwise
>> -it is possible that an attacker can create a handcrafted file with
>> +it is possible that an attacker can create an handcrafted file with
>
> bad change:
>                                        create a handcrafted
>
> Wait. Is this patch -R (reversed)?

Oops, yes, reversed diff.

Thanks,
Miklos
