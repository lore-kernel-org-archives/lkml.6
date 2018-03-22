Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752084AbeCVEnA (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Mar 2018 00:43:00 -0400
Received: from leo.clearchain.com ([199.73.29.74]:13513 "EHLO
        mail.clearchain.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751291AbeCVEm6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Mar 2018 00:42:58 -0400
Date: Thu, 22 Mar 2018 14:42:26 +1000
From: Peter Hutterer <peter.hutterer@who-t.net>
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Jiri Kosina <jikos@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/7] HID core and multitouch fixups
Message-ID: <20180322044226.GA16269@jelly>
References: <20180320110451.16582-1-benjamin.tissoires@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180320110451.16582-1-benjamin.tissoires@redhat.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 20, 2018 at 12:04:44PM +0100, Benjamin Tissoires wrote:
> Hi,
> 
> Patches 1 and 2 are related to the Razer Blade Stealth that has some dead zone
> near the edges of the touchpad.
> Patches 3 was previously sent and reviewed by Dmitry and he suggested patch 4
> at the time.
> Patches 5..7 are cleanups I realized while trying to merge hid-multitouch
> into hid-core, so that other drivers could reuse the hid-mt logic (but it's
> not that easy I must confess).

Series: Acked-by: Peter Hutterer <peter.hutterer@who-t.net>

Cheers,
   Peter

> 
> Cheers,
> Benjamin
> 
> Benjamin Tissoires (7):
>   HID: multitouch: export a quirk for the button handling of touchpads
>   HID: multitouch: remove dead zones of Razer Blade Stealth
>   HID: use BIT macro instead of plain integers for flags
>   HID: use BIT() macro for quirks too
>   HID: core: remove the need for HID_QUIRK_NO_EMPTY_INPUT
>   HID: multitouch: do not set HID_QUIRK_NO_INIT_REPORTS
>   HID: core: reset the quirks before calling probe again
> 
>  drivers/hid/hid-asus.c       |  3 +-
>  drivers/hid/hid-core.c       |  2 ++
>  drivers/hid/hid-input.c      | 10 +++----
>  drivers/hid/hid-multitouch.c | 61 ++++++++++++++++-------------------------
>  drivers/hid/hid-uclogic.c    |  1 -
>  include/linux/hid.h          | 65 ++++++++++++++++++++++----------------------
>  6 files changed, 65 insertions(+), 77 deletions(-)
> 
> -- 
> 2.14.3
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-input" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
