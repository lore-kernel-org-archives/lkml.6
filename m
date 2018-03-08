Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935583AbeCHJG4 convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 04:06:56 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:44242 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751588AbeCHJGx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 04:06:53 -0500
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.2 \(3445.5.20\))
Subject: Re: Atheros 1525/QCA6174 BT issue
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <s5hd10fkm49.wl-tiwai@suse.de>
Date: Thu, 8 Mar 2018 10:06:51 +0100
Cc: Johan Hedberg <johan.hedberg@gmail.com>,
        Linux Bluetooth mailing list
        <linux-bluetooth@vger.kernel.org>,
        linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <184DA6FB-F23C-4C37-B89B-FE865DC9731C@holtmann.org>
References: <s5hd10fkm49.wl-tiwai@suse.de>
To: Takashi Iwai <tiwai@suse.de>
X-Mailer: Apple Mail (2.3445.5.20)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Takashi,

> we've got a but report about the broken Atheros BT on the recent
> kernels:
>  http://bugzilla.opensuse.org/show_bug.cgi?id=1082504
> 
> In short, btusb can't load the patch ar3k/AthrBT_0x00000200.dfu, and
> this could be worked around by the patch to move 0cf3:3004 blacklist
> entry to use BTUSB_QCA_ROM instead of BTUSB_ATH3012.
> 
> And this looks like a long-standing problem, at least for over two
> years.  Many web pages suggest the same patch, but it's never merged
> to upstream.
> 
> So this made me wonder what's going on.  I see that the BTUSB_ATH3012
> quirk was originally introduced just for this chip id (0cf3:3004).
> Is it a different variant from the original chip that causes a
> problem?

not all patches from distro kernel are sent upstream. I have not heard of this specific issues, but happy to accept patches to get it fixed.

Regards

Marcel
