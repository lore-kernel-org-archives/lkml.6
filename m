Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754876AbeDDBvS (ORCPT <rfc822;w@1wt.eu>);
        Tue, 3 Apr 2018 21:51:18 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:44387 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753916AbeDDBvR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Apr 2018 21:51:17 -0400
X-Google-Smtp-Source: AIpwx4/0DDhtTa+ipy/pRBunU6IAyFXYDO8GfUFnTWyFq41f9NHvj0u60r+cSnY+ztzURypWc+rZvA==
Date: Tue, 03 Apr 2018 18:51:16 -0700 (PDT)
X-Google-Original-Date: Tue, 03 Apr 2018 17:43:48 PDT (-0700)
Subject: Re: [GIT pull] irq updates for 4.17
In-Reply-To: <CA+55aFynLQp=n0_e=AQfMpwsGpCLhgFsw3uGPfuVCS1wJD3v4w@mail.gmail.com>
CC: tglx@linutronix.de, linux-kernel@vger.kernel.org, mingo@kernel.org,
        Arnd Bergmann <arnd@arndb.de>
From: Palmer Dabbelt <palmer@sifive.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Message-ID: <mhng-99170edc-de54-4394-aaae-555658220549@palmer-si-x1c4>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 03 Apr 2018 17:27:41 PDT (-0700), Linus Torvalds wrote:
> On Tue, Apr 3, 2018 at 3:39 PM, Palmer Dabbelt <palmer@sifive.com> wrote:
>>
>> I assume it's too late to swap this out for that?  If so that's OK, I can
>> just send a follow-on.
>>
>> Sorry for breaking things!
>
> Thomas,
>  I'll delay pulling your trees until tomorrow in case you want to fix
> things up.
>
> And after that, I guess we can fix it up after-the-fact too.

Thanks!  The linked patch set should be fully bisectable, while this one will 
fail on some ARM randconfigs.
