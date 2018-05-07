Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752335AbeEGOMr (ORCPT <rfc822;w@1wt.eu>);
        Mon, 7 May 2018 10:12:47 -0400
Received: from mail-qt0-f193.google.com ([209.85.216.193]:42992 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751860AbeEGOMp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 May 2018 10:12:45 -0400
X-Google-Smtp-Source: AB8JxZrtSrBszUKPgseVDythFF+IuYnGTupG5+cwA4u9H9kbKd42IEHHxykEjE8jyJgSS61l857enjL9pptSJeSqkIc=
MIME-Version: 1.0
In-Reply-To: <20180501111154.9244-1-pali.rohar@gmail.com>
References: <20180501111154.9244-1-pali.rohar@gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Mon, 7 May 2018 17:12:44 +0300
Message-ID: <CAHp75VdJ23PEY_7MBJ6o7DTj=Pk2no2KBkL_+sqWQry1q_pgYA@mail.gmail.com>
Subject: Re: [PATCH v2] dell-wmi: Set correct keycode for Fn + left arrow hotkey
To: =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali.rohar@gmail.com>
Cc: Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Mario Limonciello <mario.limonciello@dell.com>,
        Henk <henk.vergonet@gmail.com>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w47ECpc9027423

On Tue, May 1, 2018 at 2:11 PM, Pali Rohár <pali.rohar@gmail.com> wrote:
> From: Henk <henk.vergonet@gmail.com>
>
> Fn + left arrow hotkey combination is used for enabling/disabling automatic
> display brigthness based on integrated ALS sensor. For this purpose there
> is standard linux key KEY_BRIGHTNESS_AUTO so use it instead of KEY_UNKNOWN.
>
> Tested on Dell Lattitude E6500.
>

Pushed to my review and testing queue, thanks!


> Signed-off-by: Henk Vergonet <henk.vergonet@gmail.com>
> Reviewed-By: Pali Rohár <pali.rohar@gmail.com>
> Reviewed-By: Mario Limonciello <mario.limonciello@dell.com>
> ---
> Changes since v1 by Pali
> * Update commit description
> ---
>  drivers/platform/x86/dell-wmi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/platform/x86/dell-wmi.c b/drivers/platform/x86/dell-wmi.c
> index 8d102195..7c918e37 100644
> --- a/drivers/platform/x86/dell-wmi.c
> +++ b/drivers/platform/x86/dell-wmi.c
> @@ -233,7 +233,7 @@ static const u16 bios_to_linux_keycode[256] = {
>         [18]    = KEY_PROG1,
>         [19]    = KEY_BRIGHTNESSDOWN,
>         [20]    = KEY_BRIGHTNESSUP,
> -       [21]    = KEY_UNKNOWN,
> +       [21]    = KEY_BRIGHTNESS_AUTO,
>         [22]    = KEY_KBDILLUMTOGGLE,
>         [23]    = KEY_UNKNOWN,
>         [24]    = KEY_SWITCHVIDEOMODE,
> --
> 2.11.0
>



-- 
With Best Regards,
Andy Shevchenko
