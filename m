Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752177AbeDPVfg (ORCPT <rfc822;w@1wt.eu>);
        Mon, 16 Apr 2018 17:35:36 -0400
Received: from hermes.apache.org ([140.211.11.3]:11019 "HELO mail.apache.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751002AbeDPVfe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Apr 2018 17:35:34 -0400
Message-ID: <544367d71f0a89a3c2517d82462e283368eb9f89.camel@apache.org>
Subject: Re: [PATCH v5] Fix modifier keys for Redragon Asura Keyboard
From: Robert Munteanu <rombert@apache.org>
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Jiri Kosina <jikos@kernel.org>, lkml <linux-kernel@vger.kernel.org>,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>
Date: Tue, 17 Apr 2018 00:35:29 +0300
In-Reply-To: <CAO-hwJKF-=5jXN__csRJRTLBHt3cbwHWM+eTm4i8UXknuZzfHA@mail.gmail.com>
References: <20180411094953.12053-1-rombert@apache.org>
         <CAO-hwJKbYyZdtq=zg_ZeJOiL=5cTbD4oKuWmpF-P_7TgBkqVYA@mail.gmail.com>
         <149a44d0456b2f0b48be13ba51aeaccc33651073.camel@apache.org>
         <CAO-hwJKF-=5jXN__csRJRTLBHt3cbwHWM+eTm4i8UXknuZzfHA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.0 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-04-16 at 15:36 +0200, Benjamin Tissoires wrote:
> > > > +MODULE_LICENSE("GPL");
> > > 
> > > The SPDX header says GPL-v2. And IIRC if there is the SPDX header
> > > you
> > > can drop the MODULE_LICENSE (not entirely sure though).
> > 
> > Ack, will adjust and re-test.
> 
> Actually, you might be correct. I just read Mauro's blog:
> https://blogs.s-osg.org/linux-kernel-license-practices-revisited-spdx
> /
> and it says "Types of licenses for MODULE_LICENSE() macro -> 'GPL' ->
> GNU Public License v2 or later" (in the second table).

Currently the header says 'SPDX-License-Identifier: GPL-2.0', which is
'GNU General Public License v2.0 only' according to 

  https://spdx.org/licenses/

So we can't use that with MODULE_LICENSE("GPL") which means 'GNU
General Public License v2.0 or later' . I don't have a strong
preference for either, but I'll go with the 'or later' part since that
seems to be more in favour ( shorter argument for the MODULE_LICENSE
macro ).

Robert
