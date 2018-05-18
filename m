Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752459AbeERHgD (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 03:36:03 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:44438 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751921AbeERHgC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 03:36:02 -0400
X-Google-Smtp-Source: AB8JxZqnjcgRlBVt3hmRZhS6Pt7Qx66BE7S391XocrWEjOwEmFGbCx7JZ5g8hNqW/CMSGaeIN9iang==
From: Holger Schurig <holgerschurig@gmail.com>
To: Alexander Duyck <alexander.duyck@gmail.com>
Cc: Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        intel-wired-lan <intel-wired-lan@lists.osuosl.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [BUG] igb: reconnecting of cable not always detected
In-Reply-To: <CAKgT0Udtw2ZffwmPf16efcKPKz=C0BVZaJ_DofnyF6LxbH_nPw@mail.gmail.com>
References: <87h8o0ocul.fsf@gmail.com> <CAKgT0Udj+d7yzPN4Jph8uk7Z6fz0oyWrO+6W6CfygSYTkGJ0Xw@mail.gmail.com> <877eovobxl.fsf@gmail.com> <CAKgT0UdTf5pf53==hB71Ba_N1gJ-TH_3uMajozr1wykLEbK80g@mail.gmail.com> <87wowumj21.fsf@gmail.com> <CAKgT0Udtw2ZffwmPf16efcKPKz=C0BVZaJ_DofnyF6LxbH_nPw@mail.gmail.com>
Date: Fri, 18 May 2018 09:35:59 +0200
Message-ID: <87603lbelc.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Alexander Duyck <alexander.duyck@gmail.com> writes:
> Thanks for the data. It is actually useful. There are a few things
> that I see that seem to point to an obvious issue.

Any news on this?

A collegue of mine states (I have not checked this) that a kernel
4.9.0-6-686 from a Debian Live ISO (debian-live-9.4.0-i386-kde.iso)
didn't show this behavior, so we have some kind of regression perhaps?


Greetings,
Holger
