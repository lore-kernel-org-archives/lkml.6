Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751936AbeDFVao (ORCPT <rfc822;w@1wt.eu>);
        Fri, 6 Apr 2018 17:30:44 -0400
Received: from mail-pl0-f52.google.com ([209.85.160.52]:41401 "EHLO
        mail-pl0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751445AbeDFVan (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Apr 2018 17:30:43 -0400
X-Google-Smtp-Source: AIpwx4/9intxHDwNjGfHqzkw9QDj/wO3XuIGVzF4Dt/W4x6A5XzNEIwebbJV5834apjNeJRFBmRAhA==
Date: Fri, 6 Apr 2018 14:30:41 -0700
From: Omar Sandoval <osandov@osandov.com>
To: Randy Dunlap <rdunlap@infradead.org>,
        Al Viro <viro@zeniv.linux.org.uk>
Cc: Andrew Kelley <superjoe30@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Omar Sandoval <osandov@fb.com>
Subject: Re: atomic file replacing status?
Message-ID: <20180406213041.GA533@vader>
References: <CACXN+=SEtu4js9okymyw5vYwXdcoXKuW=sbmq+gudh46oNimaw@mail.gmail.com>
 <124ce5cf-d9d8-a50a-0d2d-2069247ed203@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <124ce5cf-d9d8-a50a-0d2d-2069247ed203@infradead.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 06, 2018 at 02:22:06PM -0700, Randy Dunlap wrote:
> On 02/11/2018 10:40 PM, Andrew Kelley wrote:
> > Whatever happened to this patch?
> > 
> > https://patchwork.kernel.org/patch/9636735/
> > 
> > It looks fine and addresses a legitimate issue.
> > 
> > Please CC me on replies as I am not subscribed to the LKML.
> > 
> > Kind regards,
> > Andrew Kelley
> 
> 
> There was some discussion and then nothing happened... (AFAICT)
> 
> Cc: Omar (patch author) to see what he knows about it.

I was going to do my yearly "bug Al about it at LSF/MM" in a couple of
weeks ;)

As far as I know, there weren't any other concerns about v2 (v1 had some
legitimate objections, see https://patchwork.kernel.org/patch/9440605/).
Al, do you have any thoughts on the patch linked above?
