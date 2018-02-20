Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751334AbeBTHeu (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Feb 2018 02:34:50 -0500
Received: from mail-wr0-f195.google.com ([209.85.128.195]:44203 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751158AbeBTHes (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Feb 2018 02:34:48 -0500
X-Google-Smtp-Source: AH8x224NSN9CMXQSMGr1HcHjRQii0MnvikFOmgxXQr+P2lDl90xtuy1VDNwSUwINMi61VvGyioUq/iGwXPC1loAOtBM=
MIME-Version: 1.0
In-Reply-To: <20180219194556.6575-16-willy@infradead.org>
References: <20180219194556.6575-1-willy@infradead.org> <20180219194556.6575-16-willy@infradead.org>
From: Philippe Ombredanne <pombredanne@nexb.com>
Date: Tue, 20 Feb 2018 08:34:06 +0100
Message-ID: <CAOFm3uFQsycp1LpCwsMYJ0TynO03c5v3wBsNmE6mJxXaXyk+yA@mail.gmail.com>
Subject: Re: [PATCH v7 15/61] xarray: Add xa_load
To: Matthew Wilcox <willy@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <mawilcox@microsoft.com>,
        LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Matthew,

On Mon, Feb 19, 2018 at 8:45 PM, Matthew Wilcox <willy@infradead.org> wrote:
> From: Matthew Wilcox <mawilcox@microsoft.com>
>
> This first function in the XArray API brings with it a lot of support
> infrastructure.  The advanced API is based around the xa_state which is
> a more capable version of the radix_tree_iter.
>
> As the test-suite demonstrates, it is possible to use the xarray and
> radix tree APIs on the same data structure.
>
> Signed-off-by: Matthew Wilcox <mawilcox@microsoft.com>

<snip>


> --- /dev/null
> +++ b/tools/testing/radix-tree/xarray-test.c
> @@ -0,0 +1,56 @@
> +/*
> + * xarray-test.c: Test the XArray API
> + * Copyright (c) 2017 Microsoft Corporation <mawilcox@microsoft.com>
> + *
> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms and conditions of the GNU General Public License,
> + * version 2, as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope it will be useful, but WITHOUT
> + * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
> + * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
> + * more details.
> + */

Do you mind using SPDX tags per [1] rather that this fine but long legalese?
Unless you are a legalese lover of course.

You will also get bonus karma points if you can spread the word within
your group!

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/license-rules.rst
-- 
Cordially
Philippe Ombredanne
