Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752424AbeE3LVp (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 07:21:45 -0400
Received: from mail-lf0-f41.google.com ([209.85.215.41]:40721 "EHLO
        mail-lf0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751559AbeE3LVl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 07:21:41 -0400
X-Google-Smtp-Source: ADUXVKJoMYl1rQcYvHY8FWo2X8ZYwhYi3dWEHgkr+phU2ipxcN/6nUPO1mWEVV7KPE/9k8hN2wzaEDPPDD+AjSJRwh4=
MIME-Version: 1.0
In-Reply-To: <20180530111715.GA19410@amd>
References: <CA+55aFwUqz9z1Rf4Wwr29W7DeKxQ67qKEW5xty+JPyCY3aNQ=A@mail.gmail.com>
 <20180530111715.GA19410@amd>
From: Daniel Stone <daniel@fooishbar.org>
Date: Wed, 30 May 2018 12:21:38 +0100
Message-ID: <CAPj87rOuoTM_EHDHkPrA_RE=2=az8jS+Xdcqgh1emBg4oEoRiA@mail.gmail.com>
Subject: Re: Linux 4.17-rc7
To: Pavel Machek <pavel@ucw.cz>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Sebastian Reichel <sre@kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Dave Airlie <airlied@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pavel,

On 30 May 2018 at 12:17, Pavel Machek <pavel@ucw.cz> wrote:
>> The bulk of it is really pretty trivial one-liners, and nothing looks
>> particularly scary. Let's see how next week looks, but if nothing really
>> happens I suspect we can make do without an rc8.
>>
>> Shortlog appended as usual. Go out and test.
>
> Any chance to still get in this one?
>
> https://github.com/freedesktop/drm-misc/commit/2bc5ff0bdc00d81d719dad74589317a260d583ed
>
> ...it fixes display on Nokia N900, and display is rather important for
> cellphone.

The pull request was sent to Dave just yesterday:
https://lists.freedesktop.org/archives/dri-devel/2018-May/178606.html

Cheers,
Daniel
