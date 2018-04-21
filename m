Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753332AbeDUTlW (ORCPT <rfc822;w@1wt.eu>);
        Sat, 21 Apr 2018 15:41:22 -0400
Received: from mail-lf0-f53.google.com ([209.85.215.53]:40895 "EHLO
        mail-lf0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753183AbeDUTlU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Apr 2018 15:41:20 -0400
X-Google-Smtp-Source: AIpwx49wIsP7V4hUTMXpKQn8AQm85bHykba92oqtCh76xb4Wi41T7pTWaVOvzh1CRky7+dwx3eTpqz3ajeGsDGGHwkY=
MIME-Version: 1.0
In-Reply-To: <20180421193409.GD14610@bombadil.infradead.org>
References: <20180421170540.GA17849@jordon-HP-15-Notebook-PC> <20180421193409.GD14610@bombadil.infradead.org>
From: Souptick Joarder <jrdr.linux@gmail.com>
Date: Sun, 22 Apr 2018 01:11:18 +0530
Message-ID: <CAFqt6zafW0m6V2a6RK=Y+kuhpu3Dg3J+JAdCztZjezDY8_HSiA@mail.gmail.com>
Subject: Re: [PATCH] mm: memory: Introduce new vmf_insert_mixed_mkwrite
To: Matthew Wilcox <willy@infradead.org>
Cc: Hugh Dickins <hughd@google.com>, Minchan Kim <minchan@kernel.org>,
        ying.huang@intel.com, Ross Zwisler <ross.zwisler@linux.intel.com>,
        Linux-MM <linux-mm@kvack.org>, linux-kernel@vger.kernel.org,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 22, 2018 at 1:04 AM, Matthew Wilcox <willy@infradead.org> wrote:
> On Sat, Apr 21, 2018 at 10:35:40PM +0530, Souptick Joarder wrote:
>> As of now vm_insert_mixed_mkwrite() is only getting
>> invoked from fs/dax.c, so this change has to go first
>> in linus tree before changes in dax.
>
> No.  One patch which changes both at the same time.  The history should
> be bisectable so that it compiles and works at every point.
>
> The rest of the patch looks good.

Sure, I will send in a single patch.
