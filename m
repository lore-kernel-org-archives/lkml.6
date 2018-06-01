Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751581AbeFAJgo (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 05:36:44 -0400
Received: from mout.kundenserver.de ([212.227.17.13]:35739 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750816AbeFAJgk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 05:36:40 -0400
Subject: Re: [PATCH 2/4] thermal: bcm2835: Stop using printk format %pCr
To: Geert Uytterhoeven <geert+renesas@glider.be>,
        Jia-Ju Bai <baijiaju1990@gmail.com>, Jonathan Corbet <corbet@lwn.net>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>, Eric Anholt <eric@anholt.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Petr Mladek <pmladek@suse.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Steven Rostedt <rostedt@goodmis.org>, linux-doc@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1527845302-12159-1-git-send-email-geert+renesas@glider.be>
 <1527845302-12159-3-git-send-email-geert+renesas@glider.be>
From: Stefan Wahren <stefan.wahren@i2se.com>
Message-ID: <49541212-0bf7-06ec-7a3d-f01f7b658481@i2se.com>
Date: Fri, 1 Jun 2018 11:35:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <1527845302-12159-3-git-send-email-geert+renesas@glider.be>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Provags-ID: V03:K1:UgdPpJ+wLybP7wp1eWe/hGYMisFPhdm7zeXmYnwbL1/99EcI1uz
 /4Y7Zc+IQPTufFWMJD84i0nIfsmcc+lL7NfFe84RWyQV0zAMwSLXlBC8q8a3Z8yQyY8avOe
 GCMBkpH2hSvOZ8jRUmdDDzaI44HpfSTfMqoV08z1tXlWUZSC1ZQUo+qJgQEuMEoXG9sQqQZ
 YsgO8Li3dgIy2TF4aJFQQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:cfj0fvKgMgY=:iYlln2x1qyYm6YXGDSRDKc
 tikQPD3rgKcMlZde2tSuEeewZbh3BlFSWFv/1rZd9OkI4Qkmk3TGM/kbEZZLEvTLzwt6tThIe
 uhJdO+WVIB80JJfohhLsNhWLB4JDmOPpophBsSlXou+gM9E2DOq4Vz4uuK693dSTKBSLbznrS
 0MNBuZQBvRCleOIL99MYIgjHbyoN2J0Ert0hpmljwfO/L6vMjo2gT0jmiZY6Ae4SoI1Tjr5Tl
 ePnPaNrptI+/Ty/htkS3Urve9vh+Ddy8s4cEC8Xel8m9yNNewC9rLBeunWSUo+mmAipAZ0Iji
 a+VahqXJTymZVfl9vfcW3DfR4S5NGDqTW9sPryNc9TvWssqxa69QUhRiUhVvip6XJHme9uWbG
 wH2siaFfKknpFW9mlOm7l1uU2FNt8VMUbVeMUuUVqTwvq9YOMmfkc1VZzJ9fkToyusjFdts+y
 zV2OUss6wVwNC7lXkIcz7L0dDhE8kfj98VrG/hxwfmtDNzIXTvntIcqoPtZ0tLqMENzMBBsof
 zRB7wQyGFCa6iopFkQySv1bsHevRCS8dfauSZkvoQsUonvRuP7x/zprV2x8nwWM94OCqMv2i3
 rTDHtEyg9SbYxMWySfcxYB+mEFtQ6Q3jOGQUbNK+klXvD+irmfE/Z0k/BdCNHQCfurAqgg850
 qQbKchpZptmls6lIX5j8CL46JDWP7LI6Jsc5bcm9ua8eRcHVboXtMTA9k56gAqz6qdMxMhUkf
 xp7VmGrXpnv+tpZC
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Am 01.06.2018 um 11:28 schrieb Geert Uytterhoeven:
> Printk format "%pCr" will be removed soon, as clk_get_rate() must not be
> called in atomic context.
>
> Replace it by printing the variable that already holds the clock rate.
> Note that calling clk_get_rate() is safe here, as the code runs in task
> context.
>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Stefan Wahren <stefan.wahren@i2se.com>

Thanks
