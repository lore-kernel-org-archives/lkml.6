Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752630AbeDDRDn (ORCPT <rfc822;w@1wt.eu>);
        Wed, 4 Apr 2018 13:03:43 -0400
Received: from mail-vk0-f53.google.com ([209.85.213.53]:43060 "EHLO
        mail-vk0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752079AbeDDRDl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Apr 2018 13:03:41 -0400
X-Google-Smtp-Source: AIpwx48EEWgbAh+hFR/EeD8x6+p6CTW8qbBRpR8Fi/D9K3g/jFYo4PoH6DVdqzgXsLJ5OItD779639wWOh+RLcwkP7o=
MIME-Version: 1.0
In-Reply-To: <1694587.16DWc6HTFx@minivanes>
References: <20180403175220.GA148162@dtor-ws> <10651380.a6EbCRfp8J@minivanes>
 <nycvar.YFH.7.76.1804041032560.15778@cbobk.fhfr.pm> <1694587.16DWc6HTFx@minivanes>
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Date: Wed, 4 Apr 2018 10:03:39 -0700
Message-ID: <CAKdAkRTrHsRdRCj6b2dci6WsufQeU09nA0ijZt54t9529uGRLA@mail.gmail.com>
Subject: Re: [PATCH] HID: input: fix battery level reporting on BT mice
To: Martin van Es <martin@mrvanes.com>
Cc: Jiri Kosina <jikos@kernel.org>, Martin <bugs@mrvanes.com>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 4, 2018 at 1:51 AM, Martin van Es <martin@mrvanes.com> wrote:
>
> On Wednesday, April 4, 2018 10:33:16 AM CEST Jiri Kosina wrote:
> > Can I add your Tested-by: while applying the commit?
>
> That's ok.

Martin is also the reporter of the issue, I did not put down his name
because I wasn't sure if he wanted it there.

Thanks.

-- 
Dmitry
