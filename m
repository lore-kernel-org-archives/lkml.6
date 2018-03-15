Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751790AbeCOIHn (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 04:07:43 -0400
Received: from mail-qt0-f194.google.com ([209.85.216.194]:46408 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750726AbeCOIHl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 04:07:41 -0400
X-Google-Smtp-Source: AG47ELuGPZyrJ2tHboVGckYYydMT+TA8G9mZZawMwyXX++Be+YPH+63JKVvsaPsHxImZelkxp32HCvnGZ9gJrDLLVl8=
MIME-Version: 1.0
In-Reply-To: <alpine.LNX.2.21.1803151556420.19@nippy.intranet>
References: <20180314153603.3127932-1-arnd@arndb.de> <20180314153603.3127932-7-arnd@arndb.de>
 <nycvar.YSQ.7.76.1803141144200.28583@knanqh.ubzr> <alpine.LNX.2.21.1803151556420.19@nippy.intranet>
From: Arnd Bergmann <arnd@arndb.de>
Date: Thu, 15 Mar 2018 09:07:39 +0100
X-Google-Sender-Auth: KJd16nwJK1inuHdB_5vRLauSE1E
Message-ID: <CAK8P3a3ZWUk4=rByhGe8-=Ho+gCAZCP82kTwn6WvAmzgGxnFng@mail.gmail.com>
Subject: Re: [PATCH 06/47] net: smsc: remove m32r specific smc91x configuration
To: Finn Thain <fthain@telegraphics.com.au>
Cc: Nicolas Pitre <nico@fluxnic.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Networking <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 15, 2018 at 5:58 AM, Finn Thain <fthain@telegraphics.com.au> wrote:

>
> MN103 is a separate architecture, unrelated to M32R afaict...

That is correct. They are both being removed, but I must have made
a mistake when writing the changelog text here. I've fixed it now
to say

8<---
net: smsc: remove m32r/mn10300 specific smc91x configuration

The m32r and mn10300 architectures are getting removed, so this
part can be cleaned up as well.

Acked-by: Nicolas Pitre <nico@fluxnic.net>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
--->8

       Arnd
