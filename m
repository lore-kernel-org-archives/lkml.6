Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030195AbeCAKHd (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 05:07:33 -0500
Received: from mail-wm0-f66.google.com ([74.125.82.66]:50856 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S967231AbeCAKGq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 05:06:46 -0500
X-Google-Smtp-Source: AG47ELtg8U+u4MnZ5GV1HRzQRsm3ZXasinlwjvVCAR2Dr1K6xZWAVvLvsOL6+QCmwF3PixQDrkMkgQ==
Date: Thu, 1 Mar 2018 11:06:42 +0100
From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] sparse doesn't support indirect_branch attribute
Message-ID: <20180301100640.7hi4lbx6a4gzhw2k@ltop.local>
References: <20180227194828.GA29918@bombadil.infradead.org>
 <5a85a7cf-c59c-f338-2087-c9de799adbe8@infradead.org>
 <CA+55aFxNksRJEwsYFGY3_Zy+wqvQVu3h4Bq3Go3KZpbxE8F6fQ@mail.gmail.com>
 <20180227223611.vglxasfco524cdy7@ltop.local>
 <CAK7LNASjV8jH+BMd0_4v9GeXiizyY9+hAQiBs+sZnz4S3eGB5Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK7LNASjV8jH+BMd0_4v9GeXiizyY9+hAQiBs+sZnz4S3eGB5Q@mail.gmail.com>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 28, 2018 at 10:30:58AM +0900, Masahiro Yamada wrote:
> 2018-02-28 7:36 GMT+09:00 Luc Van Oostenryck <luc.vanoostenryck@gmail.com>:
> >
> > To compensate this, I sent a patch  to use '-Wno-unknown-attribute' for kernel
> > builds. Masahiro Yamada has already taken it to the linux-kbuild tree.
> > I'm not sure if it's planned for the next -rc or for 4.17, though.
> 
> I am planning to send it in the next MW (i.e. v4.17-rc1)
> 
> If you want me to send this earlier as fixes PR,
> please let me know.
> 

Hi,

Thanks for having taken this patch promptly.
Given that the warnings is issued more than 148000 and thus tend
to drown the other, more useful, warnings in the noise, I think
it would be a good thing to have this patch already in 4.16.
I should have put this clearly in the patch description.

Best regards,
-- Luc Van Oostenryck
