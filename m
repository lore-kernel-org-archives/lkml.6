Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752229AbeB0WaI (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Feb 2018 17:30:08 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:53412 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752008AbeB0WaG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Feb 2018 17:30:06 -0500
Subject: Re: [PATCH] sparse doesn't support indirect_branch attribute
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Matthew Wilcox <willy@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20180227194828.GA29918@bombadil.infradead.org>
 <5a85a7cf-c59c-f338-2087-c9de799adbe8@infradead.org>
 <CA+55aFxNksRJEwsYFGY3_Zy+wqvQVu3h4Bq3Go3KZpbxE8F6fQ@mail.gmail.com>
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <a9b65d60-a3c0-f46a-c10e-5d649e75d9ce@infradead.org>
Date: Tue, 27 Feb 2018 14:30:03 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <CA+55aFxNksRJEwsYFGY3_Zy+wqvQVu3h4Bq3Go3KZpbxE8F6fQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/27/2018 02:12 PM, Linus Torvalds wrote:
> On Tue, Feb 27, 2018 at 12:18 PM, Randy Dunlap <rdunlap@infradead.org> wrote:
>>
>> I don't mind the patch, but I did send a patch for this attribute on Feb. 13, 2018,
>> to the sparse mailing list.
> 
> I think the sparse plan is to just stop warning about unknown
> attributes, because it doesn't really help users (at most it's a note
> to a sparse developer).

Yes, there are sparse discussions about that.

There is also a kernel kbuild patch from Luc that Masahiro has also merged that
does -Wno-unknown-attributes (or however that is spelled).

> But sparse doesn't have the same regular releases the kernel has. Oh well.

Right.


-- 
~Randy
