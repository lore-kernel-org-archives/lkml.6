Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751719AbeCNVzK (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 17:55:10 -0400
Received: from mail-oi0-f41.google.com ([209.85.218.41]:38627 "EHLO
        mail-oi0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751302AbeCNVzJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 17:55:09 -0400
X-Google-Smtp-Source: AG47ELsEE1jDSLQ7uOZeyNZByS+Fp83US1875fOeeLa1beMTo01v1aCKvdAU4xdfYJuuRmmnRw1ah22iaBiNsdOzoGU=
MIME-Version: 1.0
In-Reply-To: <20180315074316.3bd7c719@canb.auug.org.au>
References: <20180315074316.3bd7c719@canb.auug.org.au>
From: Dan Williams <dan.j.williams@intel.com>
Date: Wed, 14 Mar 2018 14:55:08 -0700
Message-ID: <CAPcyv4gf7ZmBS+SY3r5BV2EjsbcK79ntH5U9rkhyo1Ai=LNdGA@mail.gmail.com>
Subject: Re: linux-next: Signed-off-by missing for commit in the nvdimm tree
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Colin King <colin.king@canonical.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ adding Colin ]

On Wed, Mar 14, 2018 at 1:43 PM, Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> Hi Dan,
>
> Commit
>
>   07974c130d5d ("libnvdimm: remove redundant assignment to pointer 'dev'")
>
> is missing a Signed-off-by from its committer.

Thanks Stephen, fixed.
