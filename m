Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751965AbeEQSfD (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 14:35:03 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:51604 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751017AbeEQSfC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 14:35:02 -0400
Subject: Re: linux-next: Tree for May 17 (drivers/pwm/pwm-stm32.c)
To: Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Gerald Baeza <gerald.baeza@st.com>, linux-pwm@vger.kernel.org
References: <20180517170656.1f746914@canb.auug.org.au>
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <b611bea0-d77b-7841-2127-277acda55747@infradead.org>
Date: Thu, 17 May 2018 11:34:59 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180517170656.1f746914@canb.auug.org.au>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/17/2018 12:06 AM, Stephen Rothwell wrote:
> Hi all,
> 

on x86_64:

drivers/pwm/pwm-stm32.o: In function `stm32_pwm_raw_capture':
pwm-stm32.c:(.text+0x53d): undefined reference to `stm32_timers_dma_burst_read'

when COMPILE_TEST=y and MFD_STM32_TIMERS is not set.


Any suggestions?

thanks,
-- 
~Randy
