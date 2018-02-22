Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933660AbeBVSI3 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 13:08:29 -0500
Received: from mail-it0-f51.google.com ([209.85.214.51]:35733 "EHLO
        mail-it0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933504AbeBVSI2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 13:08:28 -0500
X-Google-Smtp-Source: AG47ELt6gSd2BHroUwJu40+bAPjosQlilHi+OE8LFVsOM4P36bVQmc1CH6eONWi+J8xH+e38YKHgRVhPQ5BrUm9RVto=
MIME-Version: 1.0
In-Reply-To: <CA+55aFwbjdLpXc4wnN5t7fQ5Zy1vbc+ysH+bsFkaJkStEBwr=A@mail.gmail.com>
References: <3908561D78D1C84285E8C5FCA982C28F7B37F130@ORSMSX110.amr.corp.intel.com>
 <CA+55aFx3WKAL7e3TAs-2okggW6Z+DHANdmcsr+WTDh3N-Mx+Xw@mail.gmail.com>
 <20180222014505.2l76ccrrs36y3b26@agluck-desk> <CA+55aFzJXsPcsJ5MtsxTp2n+43xC0yGzANLNcDm1mFbZKR75FQ@mail.gmail.com>
 <3908561D78D1C84285E8C5FCA982C28F7B37FE28@ORSMSX110.amr.corp.intel.com>
 <CA+55aFy0hRexJkLbN7t31LjfGr4Ae0W5g6sBMqHHJi8aYuGKeA@mail.gmail.com>
 <612E894E-62C8-4155-AED8-D53702EDC8DC@intel.com> <CA+55aFxeBaTbwvbWqx1MKYjKKzLUs=1O43Bx2=JaO8qrnY-8HA@mail.gmail.com>
 <20180222171506.wwsichkiyc5f74pr@agluck-desk> <CA+55aFyOLYAbvTX0F8WLHgBnhwAPWr7EOPbO_sEepmB5GsCBKQ@mail.gmail.com>
 <20180222175411.xzx2d2r2fahn7llo@agluck-desk> <CA+55aFwbjdLpXc4wnN5t7fQ5Zy1vbc+ysH+bsFkaJkStEBwr=A@mail.gmail.com>
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date: Thu, 22 Feb 2018 18:08:26 +0000
Message-ID: <CAKv+Gu8q-9enjK=WLiB5tWvRKQu9+xh=dCqBtB6X9wazKuYiMA@mail.gmail.com>
Subject: Re: [PATCH v2] efivarfs: Limit the rate for non-root to read files
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "Luck, Tony" <tony.luck@intel.com>, Andi Kleen <ak@linux.intel.com>,
        Joe Konno <joe.konno@linux.intel.com>,
        "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jeremy Kerr <jk@ozlabs.org>, Matthew Garrett <mjg59@google.com>,
        Peter Jones <pjones@redhat.com>, Andy Lutomirski <luto@kernel.org>,
        James Bottomley <james.bottomley@hansenpartnership.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22 February 2018 at 18:07, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> On Thu, Feb 22, 2018 at 9:54 AM, Luck, Tony <tony.luck@intel.com> wrote:
>> With the new "while/nap" change there would still be one message
>> per second, but the number of callbacks suppressed should be 1
>> (unless the user has many threads doing reads).
>>
>> Maybe it is good to know that an application is doing something
>> stupid and we should drop that line from the patch and let the
>> warnings flow?
>
> I think the "one message per second" is fine.
>
> Looks good. Do I get this through the EFI tree, or should I just take
> it directly?
>

Please take it directly if everybody is happy with it.

Acked-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
