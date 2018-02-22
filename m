Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933089AbeBVPPo (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 10:15:44 -0500
Received: from mail-io0-f196.google.com ([209.85.223.196]:34307 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932995AbeBVPPj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 10:15:39 -0500
X-Google-Smtp-Source: AG47ELv/CezAHbFraCzXNAgIPTIMnrDFLcZ5aG7rm2/Iyf+rZ//9ckjsEnTvqCIlgk/Vwv+JdhK8VJ9c+AInMyHQmWQ=
MIME-Version: 1.0
In-Reply-To: <01000161bdd7f206-c8d87cce-1b8c-4888-8d6a-5247198b3ead-000000@email.amazonses.com>
References: <01000161bbeed4e3-8160ffbc-0998-453d-9afd-14b7dd80dd53-000000@email.amazonses.com>
 <1628582.nV6hDClBbL@phobos> <01000161bdd7f206-c8d87cce-1b8c-4888-8d6a-5247198b3ead-000000@email.amazonses.com>
From: Marco Martin <notmart@gmail.com>
Date: Thu, 22 Feb 2018 16:15:37 +0100
Message-ID: <CAD6_Bos5Qrvz=Mr_rYCZXZ1s=5+8rawfZXxzXSvyc-tLBO07fg@mail.gmail.com>
Subject: Re: Regression: Dell XPS 13 9360 keyboard no longer works
To: Jeremy Cline <jeremy@jcline.org>
Cc: Mario Limonciello <mario.limonciello@dell.com>,
        =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali.rohar@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        Darren Hart <dvhart@infradead.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 22, 2018 at 3:08 PM, Jeremy Cline <jeremy@jcline.org> wrote:
> Input driver version is 1.0.1
> Input device ID: bus 0x19 vendor 0x0 product 0x0 version 0x0
> Input device name: "Intel Virtual Button driver"
> Supported events:
>   Event type 0 (EV_SYN)
>   Event type 1 (EV_KEY)
>     Event code 114 (KEY_VOLUMEDOWN)
>     Event code 115 (KEY_VOLUMEUP)
>     Event code 116 (KEY_POWER)
>     Event code 125 (KEY_LEFTMETA)
>     Event code 240 (KEY_UNKNOWN)
>     Event code 561 (?)
>   Event type 4 (EV_MSC)
>     Event code 4 (MSC_SCAN)
>   Event type 5 (EV_SW)
>     Event code 1 (SW_TABLET_MODE) state 1
> Properties:
> Testing ... (interrupt to exit)

Indeed, it's thinking a switch exists and that is on, which is wrong,
then i guess VGBS() reports a wrong status..
Mario, do you have any ideas about that?

--
Marco Martin
