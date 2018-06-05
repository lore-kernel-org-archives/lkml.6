Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752700AbeFEXDM (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 19:03:12 -0400
Received: from mail-ua0-f195.google.com ([209.85.217.195]:34806 "EHLO
        mail-ua0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752365AbeFEXDL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 19:03:11 -0400
X-Google-Smtp-Source: ADUXVKIRjsivTGiFg/PYW/27WLKlgyPk1XDLw6PAZQxjcf2RFQ8yOCc37c1OV0km1ATfE0kH/qNMyUJ/Ss6mpPv1FE8=
MIME-Version: 1.0
In-Reply-To: <CABeXuvqG_DQMOwa0vrmJB+kx7DPbuMo=s-aS-DK7LdBy_ZGtTw@mail.gmail.com>
References: <20180606075535.09b41c23@canb.auug.org.au> <CABeXuvqG_DQMOwa0vrmJB+kx7DPbuMo=s-aS-DK7LdBy_ZGtTw@mail.gmail.com>
From: Kees Cook <keescook@chromium.org>
Date: Tue, 5 Jun 2018 16:03:09 -0700
X-Google-Sender-Auth: pvRadwcD5l0BLqXRLQb0bOMVjjk
Message-ID: <CAGXu5j+wz-CK60Y=1zRKsWPimBpwdoAa+uoEYzk1st9NP+u7iQ@mail.gmail.com>
Subject: Re: linux-next: Signed-off-by missing for commit in the y2038 tree
To: Deepa Dinamani <deepa.kernel@gmail.com>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Arnd Bergmann <arnd@arndb.de>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 5, 2018 at 3:00 PM, Deepa Dinamani <deepa.kernel@gmail.com> wrote:
> That patch belongs to Kees.
>
> -Deepa
>
> On Tue, Jun 5, 2018 at 2:55 PM, Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>> Hi Arnd,
>>
>> Commit
>>
>>   0f0d83b99ef7 ("pstore: Convert internal records to timespec64")
>>
>> is missing a Signed-off-by from its committer.

Hm, Deepa, maybe it got lost somewhere? It has my S-o-b in my tree.
Regardless, yes, please add it back. :)

-Kees

-- 
Kees Cook
Pixel Security
