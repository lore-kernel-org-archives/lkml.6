Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753196AbeFAT6s (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 15:58:48 -0400
Received: from merlin.infradead.org ([205.233.59.134]:43992 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752105AbeFAT6p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 15:58:45 -0400
Subject: Re: linux-next: Tree for Jun 1 (pwm/pwm-stm32)
To: Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Fabrice Gasnier <fabrice.gasnier@st.com>, linux-pwm@vger.kernel.org
References: <20180601205621.11f1b9dd@canb.auug.org.au>
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <daca554e-90ea-de33-845e-65a13d9acfe2@infradead.org>
Date: Fri, 1 Jun 2018 12:58:37 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180601205621.11f1b9dd@canb.auug.org.au>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/01/2018 03:56 AM, Stephen Rothwell wrote:
> Hi all,
> 
> Changes since 20180531:
> 


on i386:

drivers/pwm/pwm-stm32.o: In function `stm32_pwm_raw_capture.isra.0':
pwm-stm32.c:(.text+0xa01): undefined reference to `stm32_timers_dma_burst_read'

when CONFIG_PWM_STM32=y and CONFIG_MFD_STM32_TIMERS=m
and CONFIG_COMPILE_TEST=y.


-- 
~Randy
