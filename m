Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751931AbeBVCQi (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 21:16:38 -0500
Received: from mail-vk0-f51.google.com ([209.85.213.51]:44838 "EHLO
        mail-vk0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751849AbeBVCQg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 21:16:36 -0500
X-Google-Smtp-Source: AH8x227XRHLGLHzoUdHwTsODZUGnHDZ4PQpvAkh5lH1zrdB8MTyqPA6jReSgDvzENEVErx2HyG1IlSdZCksYgeY1fWM=
MIME-Version: 1.0
In-Reply-To: <1519265600.4326.22.camel@perches.com>
References: <20180222003749.GA4724@beast> <1519265600.4326.22.camel@perches.com>
From: Kees Cook <keescook@chromium.org>
Date: Wed, 21 Feb 2018 18:16:34 -0800
X-Google-Sender-Auth: Lgb50JqcZq1NrTUotPsxXWuSUfI
Message-ID: <CAGXu5j+JsK_JaU4pHpGP9s6sdV5j0F7c=22PADcndGD_VPHAUw@mail.gmail.com>
Subject: Re: [PATCH] doc: process: Add "Root-caused-by" and "Suggested-by"
To: Joe Perches <joe@perches.com>
Cc: Jonathan Corbet <corbet@lwn.net>, LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-doc@vger.kernel.org, Andy Whitcroft <apw@canonical.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 21, 2018 at 6:13 PM, Joe Perches <joe@perches.com> wrote:
> On Wed, 2018-02-21 at 16:37 -0800, Kees Cook wrote:
>> As recently pointed out by Linus, "Root-caused-by" is a good tag to include
>> since it can indicate significantly more work than "just" a Reported-by.
>> This adds it and "Suggested-by" (which was also missing) to the documented
>> list of tags. Additionally updates checkpatch.pl to match the process docs.
> []
>> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> []
>> @@ -464,9 +464,11 @@ our $logFunctions = qr{(?x:
>>  our $signature_tags = qr{(?xi:
>>       Signed-off-by:|
>>       Acked-by:|
>> +     Co-Developed-by:|
>>       Tested-by:|
>>       Reviewed-by:|
>>       Reported-by:|
>> +     Root-caused-by:|
>>       Suggested-by:|
>>       To:|
>>       Cc:
>
> Patch does not match commit description

Hm? Why not? It's updating checkpatch.pl to match the process docs.
checkpatch.pl was missing Co-Developed-by and Root-caused-by, relative
to the process docs.

-Kees

-- 
Kees Cook
Pixel Security
