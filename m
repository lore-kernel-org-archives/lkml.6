Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751979AbeCLQIH (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 12:08:07 -0400
Received: from mail-lf0-f42.google.com ([209.85.215.42]:37938 "EHLO
        mail-lf0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751758AbeCLQIF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 12:08:05 -0400
X-Google-Smtp-Source: AG47ELuywbiPSY6xu0dEAZxjPmdJGS5mqJ+gVi2VsoqXCtSls8hnxTSFFFxHVxWke4B7l9rWzWBzCd40BVWgQ01bdV4=
MIME-Version: 1.0
X-Originating-IP: [108.20.156.165]
In-Reply-To: <20180312155256.4j7uglv7jiyppozm@madcap2.tricolour.ca>
References: <cover.1520835596.git.rgb@redhat.com> <ce98e9600a8d7d0169067ae9f3e3a5ae2fb1f54a.1520835596.git.rgb@redhat.com>
 <CAHC9VhRh094wMJkiBY+iStfwMEotHMrOCWUSW23gva_ccknuqg@mail.gmail.com>
 <20180312152614.qvcxng3biug46lms@madcap2.tricolour.ca> <CAHC9VhR-2tQAsDHDNto7GWkSrCLWGuURexxsxDxECfY9KoVvww@mail.gmail.com>
 <20180312155256.4j7uglv7jiyppozm@madcap2.tricolour.ca>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 12 Mar 2018 12:08:03 -0400
Message-ID: <CAHC9VhT_JkTYGheWp+467XBvp1j451ayvosd1uLtLsn44GgCnQ@mail.gmail.com>
Subject: Re: [PATCH ghak21 V2 3/4] audit: add refused symlink to audit_names
To: Richard Guy Briggs <rgb@redhat.com>
Cc: Linux-Audit Mailing List <linux-audit@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 12, 2018 at 11:52 AM, Richard Guy Briggs <rgb@redhat.com> wrote:
> On 2018-03-12 11:53, Paul Moore wrote:
>> On Mon, Mar 12, 2018 at 11:26 AM, Richard Guy Briggs <rgb@redhat.com> wrote:
>> > On 2018-03-12 11:12, Paul Moore wrote:
>> >> On Mon, Mar 12, 2018 at 2:31 AM, Richard Guy Briggs <rgb@redhat.com> wrote:
>> >> > Audit link denied events for symlinks had duplicate PATH records rather
>> >> > than just updating the existing PATH record.  Update the symlink's PATH
>> >> > record with the current dentry and inode information.
>> >> >
>> >> > See: https://github.com/linux-audit/audit-kernel/issues/21
>> >> > Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
>> >> > ---
>> >> >  fs/namei.c | 1 +
>> >> >  1 file changed, 1 insertion(+)
>> >>
>> >> Why didn't you include this in patch 4/4 like I asked during the
>> >> previous review?
>> >
>> > Please see the last comment of:
>> > https://www.redhat.com/archives/linux-audit/2018-March/msg00070.html
>>
>> Yes, I just saw that ... I hadn't seen your replies on the v1 patches
>> until I had finished reviewing v2.  I just replied to that mail in the
>> v1 thread, but basically you need to figure out what is necessary here
>> and let us know.  If I have to figure it out it likely isn't going to
>> get done with enough soak time prior to the upcoming merge window.
>
> Steve?  I was hoping you could chime in here.
>
> I'd just include it for completeness unless Steve thinks it will stand
> on its own and doesn't want the overhead.

If that's the argument, I'd rather just include it.  We've been burned
by not including stuff in the past and fixing those omissions has
proven to be a major source of contention.

-- 
paul moore
www.paul-moore.com
