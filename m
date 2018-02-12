Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932099AbeBLSah (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 13:30:37 -0500
Received: from mail-qt0-f195.google.com ([209.85.216.195]:37327 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751527AbeBLSag (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 13:30:36 -0500
X-Google-Smtp-Source: AH8x225LhDvKsTISVkfPG4AMyU1+a//0RdzZTqoaRkOVZjfBBJAhWDwNqqSuXpMZREv+e0yyvsA8Lw==
Subject: Re: [PATCH] irqchip: Remove hashed address printing
To: Jaedon Shin <jaedon.shin@gmail.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>
Cc: Kevin Cernekee <cernekee@gmail.com>,
        Brian Norris <computersforpeace@gmail.com>,
        Gregory Fong <gregory.0xf0@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20180212021812.3882-1-jaedon.shin@gmail.com>
From: Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <20e9fd4b-ef57-effa-26b6-e0db2b584735@gmail.com>
Date: Mon, 12 Feb 2018 10:30:25 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180212021812.3882-1-jaedon.shin@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/11/2018 06:18 PM, Jaedon Shin wrote:
> Since commit ad67b74d2469 ("printk: hash addresses printed with %p")
> pointers are being hashed when printed. Displaying the virtual memory at
> bootup time is not helpful. so delete the prints.
> 
> Signed-off-by: Jaedon Shin <jaedon.shin@gmail.com>

Acked-by: Florian Fainelli <f.fainelli@gmail.com>

Thanks Jaedon!
-- 
Florian
