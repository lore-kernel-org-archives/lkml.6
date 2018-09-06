Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2304DC43334
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 13:59:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDB8F20645
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 13:59:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CDB8F20645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729990AbeIFSeu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 14:34:50 -0400
Received: from mail-qt0-f196.google.com ([209.85.216.196]:46102 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726949AbeIFSeu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 14:34:50 -0400
Received: by mail-qt0-f196.google.com with SMTP id d4-v6so12277581qtn.13;
        Thu, 06 Sep 2018 06:59:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SCmfoEHF6tpswy7RJzvTM57796B+XTWiu04ipvfdkWM=;
        b=QZFA7YModPMGnTRDnef3wKaVHpKXNVRQsCC+3CZrggVJWva6sG3LZvwE6zhGHszlVd
         fI1ntU1ptc37WSLRQ4rKbl4ww5d1VyZB8SQjS7yE9uMIZDp/P54OTwOS/vpvAV05xQDm
         bJ56P9zaG6oV6Y2SdRYDlHFS1JlVTBip1hKwHKjMcAodNFJkVNaC/z8atwqi+ekUDqMp
         wfa6vQ8ziIbIk1szv4eTY49+nUTCmn92KBYEigKrR8BNUGlpN1fpbWCVmXHWIbU8/jNR
         0zmh7i4eGsSq2FeWt4nMzQR4r10qHziaClZJoQ4puPIqfi0oWgQje27hjgFkeC38rZmK
         joTQ==
X-Gm-Message-State: APzg51Bl5RgZo3L1+QukLibQLK4uCB+KUQh1/tLwf6CWB0QClHvgNa9O
        tbGoIml5kd87oZZ4wSmSNiE5Wl0+O4i5GG3DodI=
X-Google-Smtp-Source: ANB0VdZQxzaqrCesjgEtw38CZi7F7UKcCvbid+Ki7GdynuayQxsReT/kFPRwjwGEvt10FnaFVfPKFu2t9hEuxbUgmsY=
X-Received: by 2002:ac8:c9:: with SMTP id d9-v6mr2170117qtg.213.1536242348011;
 Thu, 06 Sep 2018 06:59:08 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1536138304.git.ren_guo@c-sky.com> <dc7a52f2c2571a85c87e163d49cecddd3c2f2430.1536138304.git.ren_guo@c-sky.com>
In-Reply-To: <dc7a52f2c2571a85c87e163d49cecddd3c2f2430.1536138304.git.ren_guo@c-sky.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 6 Sep 2018 15:58:51 +0200
Message-ID: <CAK8P3a1obhCyZcY6D-X7_HnGnHCO3+srZQXniThiMNqvxLSQzA@mail.gmail.com>
Subject: Re: [PATCH V3 02/26] csky: defconfig
To:     Guo Ren <ren_guo@c-sky.com>
Cc:     linux-arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Jason Cooper <jason@lakedaemon.net>,
        c-sky_gcc_upstream@c-sky.com, gnu-csky@mentor.com,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        wbx@uclibc-ng.org, Greentime Hu <green.hu@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 5, 2018 at 2:08 PM Guo Ren <ren_guo@c-sky.com> wrote:
>
> Signed-off-by: Guo Ren <ren_guo@c-sky.com>
> ---
>  arch/csky/configs/defconfig | 76 +++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 76 insertions(+)
>  create mode 100644 arch/csky/configs/defconfig
>
> diff --git a/arch/csky/configs/defconfig b/arch/csky/configs/defconfig
> new file mode 100644
> index 0000000..c6a5a40
> --- /dev/null
> +++ b/arch/csky/configs/defconfig
> @@ -0,0 +1,76 @@
> +# CONFIG_LOCALVERSION_AUTO is not set
> +CONFIG_DEFAULT_HOSTNAME="csky"
> +# CONFIG_SWAP is not set
> +CONFIG_SYSVIPC=y
> +CONFIG_POSIX_MQUEUE=y
> +CONFIG_USELIB=y

CONFIG_USELIB seems misplaced here, very few architectures can even
call that, and it's not in the asm-generic/unistd.h file.

> +CONFIG_RELAY=y

relay is selected by drivers that need it, you should not need to turn
it on here.

> +CONFIG_SYSCTL_SYSCALL=y

Also not in the asm-generic syscall table. We should probably hide the
CONFIG_USELIB and CONFIG_SYSCTL_SYSCALL options so they
only appear on architectures that can use them (patches welcome).

> +CONFIG_KALLSYMS_ALL=y

While useful for debugging, this is also something I would not expect
in the defconfig file

> +CONFIG_USERFAULTFD=y

Probably not needed either, unless you have a specific use
case.

> +CONFIG_EMBEDDED=y

This (and CONFIG_EXPERT) is mostly there to expose options
that are otherwise hidden for good reasons. Is there any option
you tweak that depends on this? If not, then remove this as well.

> +CONFIG_PROFILING=y

This is only for oprofile, which new architectures should generally
no longer implement. Better implement PERF only.

> +CONFIG_BLK_DEV_INTEGRITY=y

This is also fairly unusual.

> +CONFIG_EXT2_FS=y
> +CONFIG_EXT2_FS_XATTR=y
> +CONFIG_EXT2_FS_POSIX_ACL=y
> +CONFIG_EXT2_FS_SECURITY=y
> +CONFIG_EXT3_FS=y
> +CONFIG_EXT3_FS_POSIX_ACL=y
> +CONFIG_EXT3_FS_SECURITY=y

Better enable only EXT4 and drop EXT2/EXT3.

> +CONFIG_UNUSED_SYMBOLS=y

You should only need this to work around bugs, so
I'd turn it off.

       Arnd
