Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753320AbeB1RYi (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 12:24:38 -0500
Received: from mail-wr0-f181.google.com ([209.85.128.181]:40382 "EHLO
        mail-wr0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753119AbeB1RYg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 12:24:36 -0500
X-Google-Smtp-Source: AH8x226LCI3ff6XwaY93wIdM0kszml1efZ9zH8+OMtmPYq3rsYgm/42/XKVe7pqssF1yU321i64rQA==
Date: Wed, 28 Feb 2018 18:24:20 +0100
From: Robin Jarry <robin.jarry@6wind.com>
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 0/3] kbuild: fix host progs build with libs in non
 standard locations
Message-ID: <20180228172420.usinpmathg4gvvav@6wind.com>
References: <cover.1519393674.git.robin.jarry@6wind.com>
 <cover.1519668832.git.robin.jarry@6wind.com>
 <20180227174518.qzw6eqmuyggcvjl6@treble>
 <CAK7LNAQLDRefb34KzF=3UUBdRLsDXtaZhRVQjRE2ZMaqNEb4LA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK7LNAQLDRefb34KzF=3UUBdRLsDXtaZhRVQjRE2ZMaqNEb4LA@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-02-28, Masahiro Yamada:
[snip]
> So, my idea is to rename existing
> 
>  HOSTCFLAGS     ->  KBUILD_HOSTCFLAGS
>  HOSTCXXFLAGS   ->  KBUILD_HOSTCXXFLAGS
>  HOSTLDFLAGS    ->  KBUILD_HOSTLDFLAGS
>  HOST_LOADLIBES ->  KBUILD_HOSTLDLIBS
> 
> 
> ("LOADLIBES" is too long, so rename it to "LDLIBS")
> 
> 
> Then, re-add no-prefix ones as user interface.

Hi Masahiro,

Ok, I'll add the rename patch in a v3 of my series.

-- 
Robin
