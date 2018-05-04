Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751874AbeEDVOD (ORCPT <rfc822;w@1wt.eu>);
        Fri, 4 May 2018 17:14:03 -0400
Received: from mail-vk0-f68.google.com ([209.85.213.68]:45445 "EHLO
        mail-vk0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751781AbeEDVOB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 May 2018 17:14:01 -0400
X-Google-Smtp-Source: AB8JxZqQX9HFcwXff8EyM4PwBJPoggHflff7iWVR6HRTfRQj9Imcg4s0qrJmmIPbVl9EjqCU+AMBahlPpYWujxyc7EA=
MIME-Version: 1.0
In-Reply-To: <1525468309-5310-1-git-send-email-andrea.parri@amarulasolutions.com>
References: <1525468309-5310-1-git-send-email-andrea.parri@amarulasolutions.com>
From: Kees Cook <keescook@chromium.org>
Date: Fri, 4 May 2018 14:13:59 -0700
X-Google-Sender-Auth: EquFrQ8Dmr3BjaoqOrK2TghzyfY
Message-ID: <CAGXu5jKHb8-P-Y2ecnH9sd6vWhY9cWPfow1Lx_gzRMbHWusRXg@mail.gmail.com>
Subject: Re: [PATCH] Documentation: refcount-vs-atomic: Update reference to
 LKMM doc.
To: Andrea Parri <andrea.parri@amarulasolutions.com>
Cc: Jonathan Corbet <corbet@lwn.net>,
        Elena Reshetova <elena.reshetova@intel.com>, linux-doc@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 4, 2018 at 2:11 PM, Andrea Parri
<andrea.parri@amarulasolutions.com> wrote:
> The LKMM project has moved to 'tools/memory-model/'.
>
> Signed-off-by: Andrea Parri <andrea.parri@amarulasolutions.com>
> ---
>  Documentation/core-api/refcount-vs-atomic.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/core-api/refcount-vs-atomic.rst b/Documentation/core-api/refcount-vs-atomic.rst
> index 83351c258cdb9..322851bada167 100644
> --- a/Documentation/core-api/refcount-vs-atomic.rst
> +++ b/Documentation/core-api/refcount-vs-atomic.rst
> @@ -17,7 +17,7 @@ in order to help maintainers validate their code against the change in
>  these memory ordering guarantees.
>
>  The terms used through this document try to follow the formal LKMM defined in
> -github.com/aparri/memory-model/blob/master/Documentation/explanation.txt
> +tools/memory-model/Documentation/explanation.txt.
>
>  memory-barriers.txt and atomic_t.txt provide more background to the
>  memory ordering in general and for atomic operations specifically.

Will this get linkified by rst ?

-Kees

-- 
Kees Cook
Pixel Security
