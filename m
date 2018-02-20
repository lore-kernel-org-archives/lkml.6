Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751807AbeBTMrq (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Feb 2018 07:47:46 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:37904 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751688AbeBTMro (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Feb 2018 07:47:44 -0500
Date: Tue, 20 Feb 2018 04:47:42 -0800
From: Matthew Wilcox <willy@infradead.org>
To: Philippe Ombredanne <pombredanne@nexb.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <mawilcox@microsoft.com>,
        LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v7 15/61] xarray: Add xa_load
Message-ID: <20180220124742.GA21243@bombadil.infradead.org>
References: <20180219194556.6575-1-willy@infradead.org>
 <20180219194556.6575-16-willy@infradead.org>
 <CAOFm3uFQsycp1LpCwsMYJ0TynO03c5v3wBsNmE6mJxXaXyk+yA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOFm3uFQsycp1LpCwsMYJ0TynO03c5v3wBsNmE6mJxXaXyk+yA@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 20, 2018 at 08:34:06AM +0100, Philippe Ombredanne wrote:
> > +++ b/tools/testing/radix-tree/xarray-test.c
> > @@ -0,0 +1,56 @@
> > +/*
> > + * xarray-test.c: Test the XArray API
> > + * Copyright (c) 2017 Microsoft Corporation <mawilcox@microsoft.com>
> > + *
> > + * This program is free software; you can redistribute it and/or modify it
> > + * under the terms and conditions of the GNU General Public License,
> > + * version 2, as published by the Free Software Foundation.
> > + *
> > + * This program is distributed in the hope it will be useful, but WITHOUT
> > + * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
> > + * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
> > + * more details.
> > + */
> 
> Do you mind using SPDX tags per [1] rather that this fine but long legalese?
> Unless you are a legalese lover of course.

Argh, missed that one.

I'm more concerned with the documentation license, though.  I didn't
get a response from you to the email I sent Feb 12, Subject: License
documentation.
