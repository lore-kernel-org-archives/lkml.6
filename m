Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937127AbeE3I0R (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 04:26:17 -0400
Received: from mail-oi0-f52.google.com ([209.85.218.52]:36223 "EHLO
        mail-oi0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935918AbeE3I0N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 04:26:13 -0400
X-Google-Smtp-Source: ADUXVKISgHRQxr/9ty3J3KVidq3l9oVWKsOyApBblic3X4uxGm/zBPJdBpP3UD7qicv0PrZpPAa/Vv5x3mbcGbSHIgY=
MIME-Version: 1.0
X-Originating-IP: [194.176.227.33]
In-Reply-To: <CAOQ4uxgbj0x+zMn47PiF819+kFE9Byos-KVGiGp7Mp=Gc0N8Wg@mail.gmail.com>
References: <20180529144339.16538-1-mszeredi@redhat.com> <20180529144339.16538-28-mszeredi@redhat.com>
 <CAOQ4uxgbj0x+zMn47PiF819+kFE9Byos-KVGiGp7Mp=Gc0N8Wg@mail.gmail.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Wed, 30 May 2018 10:26:12 +0200
Message-ID: <CAJfpegsK2y3M1zY9FPDM1EZ1fmkoWmTYQx=heQdhx6eqH7881A@mail.gmail.com>
Subject: Re: [PATCH 27/39] ovl: obsolete "check_copy_up" module option
To: Amir Goldstein <amir73il@gmail.com>
Cc: Miklos Szeredi <mszeredi@redhat.com>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 29, 2018 at 5:13 PM, Amir Goldstein <amir73il@gmail.com> wrote:
> On Tue, May 29, 2018 at 5:43 PM, Miklos Szeredi <mszeredi@redhat.com> wrote:

>> +       WARN(1, "overlayfs: \"check_copy_up\" module option is obsolete\n");
>
> I was under the impression that user controlled input should not be generating
> WARNings... did you mean pr_warm?

Okay.

Thanks,
Miklos
