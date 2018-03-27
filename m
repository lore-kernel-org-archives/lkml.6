Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751398AbeC0H7q (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 03:59:46 -0400
Received: from mail-qt0-f179.google.com ([209.85.216.179]:36629 "EHLO
        mail-qt0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751195AbeC0H7o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 03:59:44 -0400
X-Google-Smtp-Source: AIpwx48WJHUEmXWc6cTZBaf/n49l7H1IWOqbZNZK1X8u/qku4QtJQ9JtI8Nkx3YO4Zr8wnxX8CO8mOGzKcKjznC0ZSI=
MIME-Version: 1.0
In-Reply-To: <20180327075520.GA3245@dragon>
References: <20180327091026.3facbb9d@canb.auug.org.au> <20180327075520.GA3245@dragon>
From: Arnd Bergmann <arnd@arndb.de>
Date: Tue, 27 Mar 2018 09:59:43 +0200
X-Google-Sender-Auth: DPyIIy_Kah80yaVRHVmWfawSlqY
Message-ID: <CAK8P3a3QBmRBgaJg2n=DcwY7wJaB902Rk7h5kGd_WxqTVSTGog@mail.gmail.com>
Subject: Re: linux-next: manual merge of the imx-mxs tree with the arm-soc tree
To: Shawn Guo <shawn.guo@linaro.org>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
        Olof Johansson <olof@lixom.net>,
        ARM <linux-arm-kernel@lists.infradead.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Fabio Estevam <fabio.estevam@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 27, 2018 at 9:55 AM, Shawn Guo <shawn.guo@linaro.org> wrote:
> On Tue, Mar 27, 2018 at 09:10:26AM +1100, Stephen Rothwell wrote:
>> Hi Shawn,
>>
>> Today's linux-next merge of the imx-mxs tree got a conflict in:
>>
>>   arch/arm/configs/mxs_defconfig
>>
>> between commit:
>>
>>   e3e583e7a293 ("ARM: mxs_defconfig: Re-sync defconfig")
>>
>> from the arm-soc tree and commit:
>>
>>   8bc2c29b550c ("ARM: mxs_defconfig: Re-sync defconfig")
>>
>> from the imx-mxs tree.
>>
>> I fixed it up (I just used the latter version) and can carry the fix as
>> necessary. This is now fixed as far as linux-next is concerned, but any
>> non trivial conflicts should be mentioned to your upstream maintainer
>> when your tree is submitted for merging.  You may also want to consider
>> cooperating with the maintainer of the conflicting tree to minimise any
>> particularly complex conflicts.
>
> Thanks, Stephen.  We will sort this out on arm-soc tree.
>
> Arnd,
>
> You pulled "[GIT PULL 6/6] i.MX defconfig updates for 4.17" [1]?
> I thought you did not pull it, and updated it with v2 to address your
> comment.  Let me know which one you want to send upstream.  Thanks.

I also thought I had not pulled it, but it seems that I did: I definitely
pulled it in at first and then sent the email about it, planning to undo
the merge before pushing the branch to git.kernel.org.

The merge is currently at the top of the next/soc branch, so I'll undo
that and pull your new one instead.

Sorry about messing it up.

        Arnd
