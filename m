Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751485AbeDGKSZ (ORCPT <rfc822;w@1wt.eu>);
        Sat, 7 Apr 2018 06:18:25 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:37969 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751334AbeDGKSX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Apr 2018 06:18:23 -0400
X-Google-Smtp-Source: AIpwx49B/gtNrw5aTfHvmY7ZPKCd8ZRZ8Tu3j4aoBadsVbffEnuYt6+67YUXg1eyK1xizZwbP1YxVLqWMuiSfwz74s8=
MIME-Version: 1.0
In-Reply-To: <65fe26f0-f2ce-2011-c497-270673041a80@xs4all.nl>
References: <CAEk1YH75md=-v++Q8_sS9Q_3FS6xt0RMdRy8eBG=0NsUnCmk7Q@mail.gmail.com>
 <65fe26f0-f2ce-2011-c497-270673041a80@xs4all.nl>
From: Damjan Georgievski <gdamjan@gmail.com>
Date: Sat, 7 Apr 2018 12:18:21 +0200
Message-ID: <CAEk1YH6a0rRd0vCok+rL5R0FW7c1bWMs1r6yoh9tmrMh0KA6xw@mail.gmail.com>
Subject: Re: uvcvideo stopped working in 4.16
To: Hans Verkuil <hverkuil@xs4all.nl>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7 April 2018 at 11:11, Hans Verkuil <hverkuil@xs4all.nl> wrote:
> On 06/04/18 18:54, Damjan Georgievski wrote:
>> Since the 4.16 kernel my uvcvideo webcam on Thinkpad X1 Carbon (5th
>> gen) stopped working with gst-launch-1.0, kamoso (kde webcam app),
>> Firefox and Chromium on sites like appear.in, talky.io, Google
>> Hangouts and meet.jit.si.
>
> Do you see a /dev/v4l-touchX (X is probably 0) device? If so, then this
> patch will probably fix the issue:
>
> https://patchwork.linuxtv.org/patch/48417/
>
> It will appear in a stable 4.16 release soon.

Thanks Hans,
that patch indeed fixes my issue


-- 
damjan
