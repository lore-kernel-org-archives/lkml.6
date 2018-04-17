Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753577AbeDQNLy (ORCPT <rfc822;w@1wt.eu>);
        Tue, 17 Apr 2018 09:11:54 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:43903 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753164AbeDQNLu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Apr 2018 09:11:50 -0400
X-Google-Smtp-Source: AIpwx4/9Vvup8L8qgQmFMn7ODBHCSmneqOOjWQspvRRNeEt3rvmWg8J6NC7htyUEbClwKF1uOK+6CA==
Message-ID: <5AD5F292.3040808@gmail.com>
Date: Tue, 17 Apr 2018 21:11:46 +0800
From: zoucao-ipc <zoucaox@gmail.com>
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:24.0) Gecko/20100101 Thunderbird/24.2.0
MIME-Version: 1.0
To: Thomas Gleixner <tglx@linutronix.de>
CC: mingo@redhat.com, hpa@zytor.com, zoucao@linux.alibaba.com,
        x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/boot/e820: add new chareater "-" to free BIOS memory
 in memmap bootargs
References: <20180410025912.49830-1-zoucao@linux.alibaba.com> <20180410025912.49830-2-zoucao@linux.alibaba.com> <5AD591D0.5040404@gmail.com> <alpine.DEB.2.21.1804171221160.1694@nanos.tec.linutronix.de>
In-Reply-To: <alpine.DEB.2.21.1804171221160.1694@nanos.tec.linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi thomas:

Sorry, i don't receive yesterday email, i think the ping email is lost,
so bad me.
Anyway，have you some suggestions for this little patch? i really need 
your help.

Regards,
czou

On 2018/4/17 下午6:22, Thomas Gleixner wrote:
> On Tue, 17 Apr 2018, zoucao-ipc wrote:
>
>> ping?
> You already pinged yesterday. Are you going to switch to hourly pings
> tomorrow?
>
