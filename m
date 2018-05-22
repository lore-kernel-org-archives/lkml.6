Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751380AbeEVI30 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 04:29:26 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:54149 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751177AbeEVI3X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 04:29:23 -0400
X-Google-Smtp-Source: AB8JxZqFaOIiTyKKdOH7Mph5b6LiWKl9FYVtMKmLsi7d+iPBpHGSoe0/VauV/DN8iPqTOP0F1OhWEFAApXOF9kMV9ok=
MIME-Version: 1.0
In-Reply-To: <1526973160.8186.60.camel@infradead.org>
References: <00a60e88ed75601a69f6cf4b194ef9ee6b22056f.camel@kernel.crashing.org>
 <1526973160.8186.60.camel@infradead.org>
From: =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Date: Tue, 22 May 2018 10:29:21 +0200
Message-ID: <CACna6rwaaC-4xLOG91aBRVmFeexkU+TgN5z4POrC4rj2C9XMzw@mail.gmail.com>
Subject: Re: Lockdep complaint in jffs2
To: David Woodhouse <dwmw2@infradead.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-mtd@lists.infradead.org, Al Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w4M8TVIl016651

On 22 May 2018 at 09:12, David Woodhouse <dwmw2@infradead.org> wrote:
> On Tue, 2018-05-22 at 13:17 +1000, Benjamin Herrenschmidt wrote:
>> Hi David !
>>
>> I noticed this on my BMC when building OpenBMC with Lockdep...
>> something worth investigating/digging ?
>
> Hm, I have a feeling a saw a patch to fix this fairly recently and was
> bikeshedding it. Will check...

This one maybe?
https://patchwork.ozlabs.org/patch/906633/

You may consider looking at all patches delegated to you:
https://patchwork.ozlabs.org/project/linux-mtd/list/?delegate=20

-- 
Rafał
