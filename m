Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751968AbeCIION (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Mar 2018 03:14:13 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:38390 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751679AbeCIIOL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Mar 2018 03:14:11 -0500
X-Google-Smtp-Source: AG47ELtCeJFhne4PcnhSSgnO/b9htGbDz7a/tg3JU7arXLQkWAi3p3GfCVrAbj2QCBdl4SlTHgsSKA==
Content-Type: text/plain;
        charset=utf-8;
        delsp=yes;
        format=flowed
Mime-Version: 1.0 (Mac OS X Mail 11.3 \(3445.6.15\))
Subject: Re: [PATCH v2 2/3] platform/x86: dell-*: Add interface for switchable
 graphics status query
From: Kai Heng Feng <kai.heng.feng@canonical.com>
In-Reply-To: <20180308163837.myfmnowz5ogto52w@pali>
Date: Fri, 9 Mar 2018 16:14:03 +0800
Cc: mjg59@srcf.ucam.org, dvhart@infradead.org, andy@infradead.org,
        Mario Limonciello <mario.limonciello@dell.com>, tiwai@suse.com,
        platform-driver-x86@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        alsa-devel@alsa-project.org
Content-Transfer-Encoding: 8bit
Message-Id: <DC881209-6C71-4B13-BF48-05F1F93E207A@canonical.com>
References: <20180308091023.9061-1-kai.heng.feng@canonical.com>
 <20180308091023.9061-2-kai.heng.feng@canonical.com>
 <20180308163837.myfmnowz5ogto52w@pali>
To: =?utf-8?Q?Pali_Roh=C3=A1r?= <pali.rohar@gmail.com>
X-Mailer: Apple Mail (2.3445.6.15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Mar 9, 2018, at 12:38 AM, Pali Rohár <pali.rohar@gmail.com> wrote:
>
> On Thursday 08 March 2018 17:10:22 Kai-Heng Feng wrote:
>> +int dell_switchable_gfx_enabled(bool *enabled);
>
> What about following API?
>
> bool dell_switchable_gfx_is_enabled(void);
>
> Are you really interested in errors? Then what about?

Not really. We can assume it's false when there's any error.

I'll update the function in next version, thanks!

Kai-Heng

>
> int dell_switchable_gfx_is_enabled(void);
>
> with e.g.
>   < 0 - error
>   = 0 - disabled
>> 0 - enabled
>
> -- 
> Pali Rohár
> pali.rohar@gmail.com
