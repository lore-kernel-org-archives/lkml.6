Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752354AbeEOGKV (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 02:10:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:38186 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752307AbeEOGKR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 02:10:17 -0400
X-Google-Smtp-Source: AB8JxZqQpKZjLq8ISCLe+qkD/XiVn5eKablzC2hCJ9Ytd3sb0WJ59HkEoaYVyqF1aiMBVCRG4wyjTT2XO4VX5H7ATe8=
MIME-Version: 1.0
In-Reply-To: <20180515090901.74c9429e@canb.auug.org.au>
References: <20180510091634.7fb3aaf2@canb.auug.org.au> <20180515090901.74c9429e@canb.auug.org.au>
From: Krzysztof Kozlowski <krzk@kernel.org>
Date: Tue, 15 May 2018 08:10:14 +0200
X-Gmail-Original-Message-ID: <CAJKOXPdUi6SxhyYcm5GeS=6+=52kZevkn=ws4i8uKjpaiwXNYA@mail.gmail.com>
Message-ID: <CAJKOXPdUi6SxhyYcm5GeS=6+=52kZevkn=ws4i8uKjpaiwXNYA@mail.gmail.com>
Subject: Re: linux-next: manual merge of the samsung-krzk tree with the
 dma-mapping tree
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Christoph Hellwig <hch@lst.de>, Olof Johansson <olof@lixom.net>,
        Arnd Bergmann <arnd@arndb.de>,
        ARM <linux-arm-kernel@lists.infradead.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 15, 2018 at 1:09 AM, Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> Hi all,
>
> On Thu, 10 May 2018 09:16:34 +1000 Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>>
>> Today's linux-next merge of the samsung-krzk tree got a conflict in:
>>
>>   arch/arm/mach-exynos/Kconfig
>>
>> between commit:
>>
>>   4965a68780c5 ("arch: define the ARCH_DMA_ADDR_T_64BIT config symbol in lib/Kconfig")
>>
>> from the dma-mapping tree and commit:
>>
>>   c5deb598089c ("ARM: exynos: Remove support for Exynos5440")
>>
>> from the samsung-krzk tree.
>>
>> I fixed it up (the latter removed the whole section modified by
>> the former, so I just removed the section) and can carry the fix as
>> necessary. This is now fixed as far as linux-next is concerned, but any
>> non trivial conflicts should be mentioned to your upstream maintainer
>> when your tree is submitted for merging.  You may also want to consider
>> cooperating with the maintainer of the conflicting tree to minimise any
>> particularly complex conflicts.
>
> This is now a conflict between the arm-soc tree and the dma-mapping tree.

Yes, this is expected. Thanks for letting us know. I mentioned this
also in my pull request to arm-soc.

Best regards,
Krzysztof
