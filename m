Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753320AbeDQNSm (ORCPT <rfc822;w@1wt.eu>);
        Tue, 17 Apr 2018 09:18:42 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:39220 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753070AbeDQNSk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Apr 2018 09:18:40 -0400
From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
To: Jiri Kosina <jikos@kernel.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Peter Hutterer <peter.hutterer@who-t.net>, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH v2 2/2] HID: input: do not increment usages when a duplicate is found
Date: Tue, 17 Apr 2018 15:18:31 +0200
Message-Id: <20180417131833.8551-1-benjamin.tissoires@redhat.com>
In-Reply-To: <CAO-hwJKQRFBP8g_o5rZ68k1XGG3DPHoeaM64gNoDeF9ngYE9rg@mail.gmail.com>
References: <CAO-hwJKQRFBP8g_o5rZ68k1XGG3DPHoeaM64gNoDeF9ngYE9rg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

FYI, these are the two patches I mentioned earlier.

checkpatch.pl still complains about them so do not merge them right away, but
this should give you a better idea.
Also, this is the tip of my local tree, so there is a high chance it doesn't
apply cleanly on your for-next branch.

Cheers,
Benjamin

Benjamin Tissoires (2):
  HID: generic: create one input report per application type
  HID: input: append a suffix matching the application

 drivers/hid/hid-core.c       | 10 ++++--
 drivers/hid/hid-generic.c    | 15 ++++++++
 drivers/hid/hid-gfrm.c       |  2 +-
 drivers/hid/hid-input.c      | 84 +++++++++++++++++++++++++++++++++++++++-----
 drivers/hid/hid-magicmouse.c |  6 ++--
 drivers/hid/hid-multitouch.c | 34 ++++++------------
 include/linux/hid.h          |  6 +++-
 7 files changed, 117 insertions(+), 40 deletions(-)

-- 
2.14.3
