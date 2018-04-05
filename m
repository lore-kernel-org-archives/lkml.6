Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751534AbeDEUmJ (ORCPT <rfc822;w@1wt.eu>);
        Thu, 5 Apr 2018 16:42:09 -0400
Received: from mail-qk0-f180.google.com ([209.85.220.180]:34342 "EHLO
        mail-qk0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750726AbeDEUmI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Apr 2018 16:42:08 -0400
X-Google-Smtp-Source: AIpwx49ZwpPPW+htnIfKa2e0fjr5wX3MbciDWLA/ysHrPkxixX5NfEuxKhHc8woDMB3OuGMc7I3bNORwnv8bRx8xQ7M=
MIME-Version: 1.0
In-Reply-To: <CAP6Zq1j9i0Zdt3wPCGLLnPZJPGf8BaG9Nh1pLAsnwczqWHtthQ@mail.gmail.com>
References: <1521155412-29229-1-git-send-email-tmaimon77@gmail.com>
 <1521155412-29229-3-git-send-email-tmaimon77@gmail.com> <CAFd5g44NOFRmQbDJfRLw_SwsHwVB-hxsUYMYSmkqeyRKmXqSqQ@mail.gmail.com>
 <CAP6Zq1jvCvM+uG8kU_JAYzm9e3BG28AS80ANmn_0a0HmiVBm3A@mail.gmail.com>
 <CAK8P3a3HBkqgas-QkAr_J767ffBMXJTJeqqVY9fFxw2Yexi27g@mail.gmail.com> <CAP6Zq1j9i0Zdt3wPCGLLnPZJPGf8BaG9Nh1pLAsnwczqWHtthQ@mail.gmail.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Thu, 5 Apr 2018 22:42:06 +0200
X-Google-Sender-Auth: LLU4H9ShoGJJhg_E4nkL-jcxouU
Message-ID: <CAK8P3a1zvjc8EyXX+c4r++pVHrVQ84CSUrnMA=+9kf7FZojiGg@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] arm: npcm: Enable L2 Cache in NPCM7xx
To: Tomer Maimon <tmaimon77@gmail.com>
Cc: Brendan Higgins <brendanhiggins@google.com>,
        Patrick Venture <venture@google.com>,
        Avi Fishman <avifishman70@gmail.com>, Joel Stanley <joel@jms.id.au>,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Nancy Yuen <yuenn@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 5, 2018 at 6:56 PM, Tomer Maimon <tmaimon77@gmail.com> wrote:
> On 5 April 2018 at 15:54, Arnd Bergmann <arnd@arndb.de> wrote:
>> On Fri, Mar 16, 2018 at 10:51 PM, Tomer Maimon <tmaimon77@gmail.com> wrote:
>
> It seems that I have to add l2c_aux_val, l2c_aux_mask parameters to the
> DT_MACHINE_START
> to enable the L2 Cache.
>>
>>
>> The last email in that thread mentions
>> L310_AUX_CTRL_CACHE_REPLACE_RR, is that required after all?
>
>
> No it is not require this is why I added:
> .l2c_aux_val    = 0x0,
> .l2c_aux_mask   = ~0x0,
>
> Can I resend it on Sunday?

Yes, please resend it as soon as you have the time to improve the changelog,
no need to wait if you can do it right away. We can always merge bugfixes,
but doing it earlier rather than later is better.

      Arnd
