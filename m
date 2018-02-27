Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751798AbeB0WMb (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Feb 2018 17:12:31 -0500
Received: from mail-io0-f182.google.com ([209.85.223.182]:46586 "EHLO
        mail-io0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751552AbeB0WMa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Feb 2018 17:12:30 -0500
X-Google-Smtp-Source: AG47ELssK8oPamYm2LpADYkHWlyh+IpcSOdxFriOZjBjdq52NpaK5O5yz6aGc8FpzEBaAnn1VYeUdhrEnWQ2hEAMRrg=
MIME-Version: 1.0
In-Reply-To: <5a85a7cf-c59c-f338-2087-c9de799adbe8@infradead.org>
References: <20180227194828.GA29918@bombadil.infradead.org> <5a85a7cf-c59c-f338-2087-c9de799adbe8@infradead.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 27 Feb 2018 14:12:28 -0800
X-Google-Sender-Auth: xAwBxlJkpDHf4KbjjqaEYDoTTdI
Message-ID: <CA+55aFxNksRJEwsYFGY3_Zy+wqvQVu3h4Bq3Go3KZpbxE8F6fQ@mail.gmail.com>
Subject: Re: [PATCH] sparse doesn't support indirect_branch attribute
To: Randy Dunlap <rdunlap@infradead.org>
Cc: Matthew Wilcox <willy@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 27, 2018 at 12:18 PM, Randy Dunlap <rdunlap@infradead.org> wrote:
>
> I don't mind the patch, but I did send a patch for this attribute on Feb. 13, 2018,
> to the sparse mailing list.

I think the sparse plan is to just stop warning about unknown
attributes, because it doesn't really help users (at most it's a note
to a sparse developer).

But sparse doesn't have the same regular releases the kernel has. Oh well.

            Linus
