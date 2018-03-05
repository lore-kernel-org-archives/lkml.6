Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752932AbeCEUnt (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Mar 2018 15:43:49 -0500
Received: from erebus.the-tk.com ([109.74.205.187]:40078 "EHLO
        erebus.the-tk.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751779AbeCEUns (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Mar 2018 15:43:48 -0500
Date: Mon, 5 Mar 2018 20:43:41 +0000
From: Tomasz Kramkowski <tk@the-tk.com>
To: stable@vger.kernel.org
Cc: Ben Hutchings <ben@decadent.org.uk>,
        Sasha Levin <Alexander.Levin@microsoft.com>,
        linux-kernel@vger.kernel.org
Subject: Patch to consider for stable 3.18, 4.4 and 4.9
Message-ID: <20180305204341.GB4897@gaia.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In September last year, Ben Hutchings submitted commit [9547837bdccb]
for 3.16.48-rc1 and I informed him that it would be useless without
[3f3752705dbd] (and that maybe [c3883fe06488] would be useful as well).
Ben dropped the patch but suggested I email this list with the
information of the other two patches but I never quite got around to it.

Now I see Sasha Levin is submitting [3f3752705dbd] and [c3883fe06488]
for 4.9, 4.4 and 3.18 it would now make sense to include [9547837bdccb].
This patch fixes a minor problem where a certain USB adapter for Sega
Genesis controllers appears as one input device when it has two ports
for two controllers. I imagine some users of emulator distributions
might use stable kernels and might benefit from this fix.

I'm actually not entirely sure that patch is something suitable for
stable but since it was already submitted once then I don't think it
hurts to bring it up again (despite it breaking stable-kernel-rules as
far as I understand it).

Commits mentioned:
[9547837bdccb]: HID: usbhid: add quirk for innomedia INNEX GENESIS/ATARI adapter
[3f3752705dbd]: HID: reject input outside logical range only if null state is set
[c3883fe06488]: HID: clamp input to logical range if no null state

If the patch [9547837bdccb] is not relevant then feel free to ignore
this email.

Thanks,

-- 
Tomasz Kramkowski
