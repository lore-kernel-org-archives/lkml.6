Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751699AbeFALkj (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 07:40:39 -0400
Received: from mail-qk0-f195.google.com ([209.85.220.195]:46544 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751012AbeFALkg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 07:40:36 -0400
X-Google-Smtp-Source: ADUXVKIY6uwOQQ6Cg1i+8bjpHxKyBVdPjSJhOjLGRxK5aYk/TgAzut8bvGvK5A+dW/NPwpt1TUbD1u634t1jOZgPwlc=
MIME-Version: 1.0
In-Reply-To: <20180601213639.74f49e51@canb.auug.org.au>
References: <20180601213639.74f49e51@canb.auug.org.au>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Fri, 1 Jun 2018 14:40:35 +0300
Message-ID: <CAHp75VeULdbi3_V8JPffYCocmGtjC3QPdE-yPz5eDrkpONeE-A@mail.gmail.com>
Subject: Re: linux-next: Signed-off-by missing for commit in the drivers-x86 tree
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Darren Hart <dvhart@infradead.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Haruka Kawajiri <yukx00@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 1, 2018 at 2:36 PM, Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> Hi all,
>
> Commit
>
>   bba074f926d1 ("platform/x86: silead_dmi: Add entry for Chuwi Hi8 S806_206 tablet touchscreen")
>
> is missing a Signed-off-by from its author.

Oops. What is the proposed fix for that? It seems we can't rebase
published branches.

-- 
With Best Regards,
Andy Shevchenko
