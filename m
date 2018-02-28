Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934553AbeB1UTL (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 15:19:11 -0500
Received: from mail-qt0-f194.google.com ([209.85.216.194]:45996 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934107AbeB1UTJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 15:19:09 -0500
X-Google-Smtp-Source: AG47ELtvjUkT3OaP0Q6qEtODEpj8D1BEi/8DHK0nPHmmbb7RIyek2sXsCVM085DCMlXljnnOsCvB4NFQI0+VTiNEjiY=
MIME-Version: 1.0
In-Reply-To: <c5d81c10-8b92-0a5d-93c2-8b8377b1396f@gmail.com>
References: <1519844656-16443-1-git-send-email-frowand.list@gmail.com>
 <1519844656-16443-2-git-send-email-frowand.list@gmail.com>
 <CAHp75VfD6Hi0NScdZrYozp9dAqmUUYjcLuPPyRwM31ezxNO2fw@mail.gmail.com> <c5d81c10-8b92-0a5d-93c2-8b8377b1396f@gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 28 Feb 2018 22:19:08 +0200
Message-ID: <CAHp75Vc4jbJqM0=Yy-1SY6E2WhzHOAAcrn1+KE-jT7MWPtWPpA@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] of: cache phandle nodes to reduce cost of of_find_node_by_phandle()
To: Frank Rowand <frowand.list@gmail.com>
Cc: Rob Herring <robh+dt@kernel.org>, cpandya@codeaurora.org,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 28, 2018 at 9:44 PM, Frank Rowand <frowand.list@gmail.com> wrote:
> On 02/28/18 11:31, Andy Shevchenko wrote:
>> On Wed, Feb 28, 2018 at 9:04 PM,  <frowand.list@gmail.com> wrote:

>> The question is why O(1) is so important? O(log(n)) wouldn't work?
>
> O(1) is not critical.  It was just a nice side result.
>
>
>> Using radix_tree() I suppose allows to dynamically extend or shrink
>> the cache which would work with DT overlays.
>
> The memory usage of the phandle cache in this patch is fairly small.
> The memory overhead of a radix_tree() would not be justified.

OTOH the advantage I mentioned isn't a good argument?

-- 
With Best Regards,
Andy Shevchenko
