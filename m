Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751695AbeEMNUg (ORCPT <rfc822;w@1wt.eu>);
        Sun, 13 May 2018 09:20:36 -0400
Received: from mail-it0-f49.google.com ([209.85.214.49]:51154 "EHLO
        mail-it0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751263AbeEMNUe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 May 2018 09:20:34 -0400
X-Google-Smtp-Source: AB8JxZqrft+x11ifVVtSGDUJDSi8j+0rl1G7zJv7h2D9ULtDLFEhUdbMuCR1TtRMGB93A+8zSJYFI1+9hVcmniERyAE=
MIME-Version: 1.0
In-Reply-To: <CANoib0FoY86caY-zABHssXq_G8zmt3zJemvYrTyvQ1R58xseoQ@mail.gmail.com>
References: <CANoib0FoY86caY-zABHssXq_G8zmt3zJemvYrTyvQ1R58xseoQ@mail.gmail.com>
From: Dmitry Tunin <hanipouspilot@gmail.com>
Date: Sun, 13 May 2018 16:20:33 +0300
Message-ID: <CANoib0ENa5LX4hFrQJvdBsHFVs6+3eH+VbzNJ=iW-nGd11Ga-g@mail.gmail.com>
Subject: Re: [REGRESSION] And a drity fix for 0cf3:3004 QCA Rome device
To: Marcel Holtmann <marcel@holtmann.org>,
        linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

And the worst thing is that if has been CCed to
stable@vger.kernel.org. This means that the regression will affect all
supported kernels soon. This should be fixed!!

2018-05-13 16:08 GMT+03:00 Dmitry Tunin <hanipouspilot@gmail.com>:
> Hi, Marcel
>
> Since  f44cb4b older AR3012 devices stopped working. We discussed that
> before that QCA released a ROME device with a duplicate code.
>
> If there is no easy way to check which one is used, then it may be a
> good decision to change the kernel code for the newer device in new
> kernels.
>
> But anyway it should be made cleaner. The device is still listed in
> ath3k.o as an AR3012.
>
> Regards,
>
> Dmitry.
