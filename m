Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751262AbeDYDaU (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 23:30:20 -0400
Received: from mail-pf0-f181.google.com ([209.85.192.181]:42138 "EHLO
        mail-pf0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751110AbeDYDaR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 23:30:17 -0400
X-Google-Smtp-Source: AIpwx4/0H8qFsJmpo/Cj4zUngN9mr6NTK/KqWG2vsSjxMKUbgay1QFXvV8sKBxkLQ3hQpbVK6o9pmg==
Date: Tue, 24 Apr 2018 20:30:13 -0700
From: Richard Cochran <richardcochran@gmail.com>
To: Alexander Duyck <alexander.duyck@gmail.com>
Cc: Holger Schurig <holgerschurig@gmail.com>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        intel-wired-lan <intel-wired-lan@lists.osuosl.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [BUG] igb: reconnecting of cable not always detected
Message-ID: <20180425033013.wsguf6w36zeua3mw@localhost>
References: <87h8o0ocul.fsf@gmail.com>
 <CAKgT0Udj+d7yzPN4Jph8uk7Z6fz0oyWrO+6W6CfygSYTkGJ0Xw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKgT0Udj+d7yzPN4Jph8uk7Z6fz0oyWrO+6W6CfygSYTkGJ0Xw@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 24, 2018 at 11:09:02AM -0700, Alexander Duyck wrote:
> On Tue, Apr 24, 2018 at 8:14 AM, Holger Schurig <holgerschurig@gmail.com> wrote:
> > Sometimes, plugging the cable back in is detected ...
> >
> > [   43.736922] igb 0000:02:00.0 eth0: igb: eth0 NIC Link is Up 1000 Mbps Full Duplex, Flow Control: RX/TX
> >
> > ... but sometimes this is *NOT* detected. I can put the cable in and
> > even after two minutes nothing has been detected.
> >
> > But when I run "rmmod igb" followed by "modpobe igb", the link is
> > detected again:

FWIW, I have noticed over the past months (or even years?) that my
i210 cards (or the igb driver) also fail to detect link changes after
a few physical link interruptions.  I never bothered to try and debug
this, but it is super annoying.

Thanks,
Richard
