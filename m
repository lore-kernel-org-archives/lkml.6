Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752205AbeB0WgV (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Feb 2018 17:36:21 -0500
Received: from mail-wm0-f66.google.com ([74.125.82.66]:36222 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751735AbeB0WgS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Feb 2018 17:36:18 -0500
X-Google-Smtp-Source: AG47ELtaFenMPsBQ83jcnmAe+fb6mwlqrocm1PJak5YUOPIe/1r03cGdu37OiGWmn61dw2TKVVjkGA==
Date: Tue, 27 Feb 2018 23:36:13 +0100
From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Randy Dunlap <rdunlap@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: Re: [PATCH] sparse doesn't support indirect_branch attribute
Message-ID: <20180227223611.vglxasfco524cdy7@ltop.local>
References: <20180227194828.GA29918@bombadil.infradead.org>
 <5a85a7cf-c59c-f338-2087-c9de799adbe8@infradead.org>
 <CA+55aFxNksRJEwsYFGY3_Zy+wqvQVu3h4Bq3Go3KZpbxE8F6fQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+55aFxNksRJEwsYFGY3_Zy+wqvQVu3h4Bq3Go3KZpbxE8F6fQ@mail.gmail.com>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 27, 2018 at 02:12:28PM -0800, Linus Torvalds wrote:
> On Tue, Feb 27, 2018 at 12:18 PM, Randy Dunlap <rdunlap@infradead.org> wrote:
> >
> > I don't mind the patch, but I did send a patch for this attribute on Feb. 13, 2018,
> > to the sparse mailing list.
> 
> I think the sparse plan is to just stop warning about unknown
> attributes, because it doesn't really help users (at most it's a note
> to a sparse developer).
> 
> But sparse doesn't have the same regular releases the kernel has. Oh well.

To compensate this, I sent a patch  to use '-Wno-unknown-attribute' for kernel
builds. Masahiro Yamada has already taken it to the linux-kbuild tree.
I'm not sure if it's planned for the next -rc or for 4.17, though.

-- Luc Van Oostenryck
