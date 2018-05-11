Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752207AbeEKDmc (ORCPT <rfc822;w@1wt.eu>);
        Thu, 10 May 2018 23:42:32 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:45200 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750751AbeEKDma (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 May 2018 23:42:30 -0400
Date: Thu, 10 May 2018 23:42:29 -0400
From: Joe Lawrence <joe.lawrence@redhat.com>
To: Ye Xiaolong <xiaolong.ye@intel.com>
Cc: live-patching@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, Philip Li <philip.li@intel.com>
Subject: Re: [PATCH v4 0/1] Add livepatch kselftests
Message-ID: <20180511034229.7s7saxcf5c5ffjap@redhat.com>
References: <1524680930-28168-1-git-send-email-joe.lawrence@redhat.com>
 <148c3baf-ab6f-c1f2-2911-79e5c8b361bd@redhat.com>
 <20180511025324.GA17456@yexl-desktop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180511025324.GA17456@yexl-desktop>
User-Agent: Mutt/1.6.2-neo (2016-08-08)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 11, 2018 at 10:53:24AM +0800, Ye Xiaolong wrote:
> Hi, Joe
> 
> Sorry for the late response.

Hi Xiaolong, no worries...

> On 04/26, Joe Lawrence wrote:
> >>On 04/25/2018 02:28 PM, Joe Lawrence wrote:
> >
> >> [ ... snip ... ]
> >> 
> >> base-commit: 0adb32858b0bddf4ada5f364a84ed60b196dbcda
> >> prerequisite-patch-id: 5ed747c1a89a5dc4bba08186e21f927d7f3bf049
> >> prerequisite-patch-id: e9800288b71a9f339ea066e58d9ef70dece67083
> >> prerequisite-patch-id: 415f2e190b1b50142c78f2940c7b8dd39b5321a0
> >> prerequisite-patch-id: d229d9cf08af087e0a758d9df1da467103c2c200
> >> prerequisite-patch-id: b8c7ef99b13c6b321cba5e8919ed0b3e29f213e9
> >> prerequisite-patch-id: 4e10c0d08f151b18310fe0b1e5013d62db94cfeb
> >> prerequisite-patch-id: 33046b190c114d202f3a52e0e274dbb2b1907a4c
> >> prerequisite-patch-id: 6978944a725756317dd4e005d479b6101784aaf0
> >> prerequisite-patch-id: cce9d3c7e1ae8887f387ca9e072552dc63479749
> >> prerequisite-patch-id: c44ccc5dd7b1be6fe2b1f32ca6abde1da73fae79
> >> 
> >
> >Hi kbuild test robot folks,
> >
> >I attempted to use the --base option with git format-patch as suggested
> >by Philip, but the bot still sent me mail (addressed only to myself and
> >cc'd kbuild-all@01.org) about build test ERRORs against the wrong base:
> >
> >> [auto build test ERROR on v4.16]
> >> [also build test ERROR on next-20180424]
> >> [cannot apply to linus/master jikos-livepatching/for-next]
> 
> I noticed this error report was for [PATCH v3] selftests/livepatch: introduce tests
> which doesn't include the base commit info.

That must have been it!  Looking back in my mail archives, I don't see
any complaints against v4.  The bot must have sent me v3 mail just after I
fired off v4.

> > [ ... snip workflow detail ... ]
> I think the work flow you described above is ok, you can just send them with
> git send-email after doing that, and base commit/prerequisite patch info in
> cover-letter is fine, the question here is I can't find the patch emails of
> your patchset except the cover letter in 0day's mail archive, do you send them
> as a whole series, could you tell the subjects of them so I can take a look in
> 0day's log.

My patchset v4 (this subject/thread):

  [PATCH v4 0/1] Add livepatch kselftests
  https://lkml.org/lkml/2018/4/25/1139

based on Petr's patchsets:

  [PATCH 0/8] livepatch: Atomic replace feature
  https://lkml.org/lkml/2018/3/23/665

  [PATCH v3 0/2] livepatch: Allocate and free shadow variables more safely
  https://lkml.org/lkml/2018/4/16/326

All of which should have been posted to linux-kernel as well as
linux-livepatching.  I can dig up Message-Ids or other headers if that
helps any.

Regards,

-- Joe
