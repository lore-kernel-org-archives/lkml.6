Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756579AbeDZQKg (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 12:10:36 -0400
Received: from conssluserg-04.nifty.com ([210.131.2.83]:19250 "EHLO
        conssluserg-04.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753207AbeDZQKc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 12:10:32 -0400
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-04.nifty.com w3QGAFtw004720
X-Nifty-SrcIP: [209.85.217.179]
X-Google-Smtp-Source: AIpwx4928TElJLgbMgToX9B5pDE7rva8qytPzzxQ0T5zloIewlfIhqYYd367SrAd8D0wJJhW3gSSyQ+Wa32j7lOHDHc=
MIME-Version: 1.0
In-Reply-To: <20180426075735.2f72e7fd@canb.auug.org.au>
References: <20180426075735.2f72e7fd@canb.auug.org.au>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Fri, 27 Apr 2018 01:09:34 +0900
X-Gmail-Original-Message-ID: <CAK7LNAR6cL=-kVnJ6oUSa-Cv6C0yNQdpLMD-1jX8GL2SXBKqAw@mail.gmail.com>
Message-ID: <CAK7LNAR6cL=-kVnJ6oUSa-Cv6C0yNQdpLMD-1jX8GL2SXBKqAw@mail.gmail.com>
Subject: Re: linux-next: unable to fetch the kbuild-current tree
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-04-26 6:57 GMT+09:00 Stephen Rothwell <sfr@canb.auug.org.au>:
> Hi Masahiro,
>
> Fetching the kbuild-current tree produces this error:
>
> fatal: Couldn't find remote ref refs/heads/fixes
>

Sorry, I fixed it now.



-- 
Best Regards
Masahiro Yamada
