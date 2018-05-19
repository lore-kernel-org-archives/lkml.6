Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752550AbeESSLl (ORCPT <rfc822;w@1wt.eu>);
        Sat, 19 May 2018 14:11:41 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:56398 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752451AbeESSLk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 May 2018 14:11:40 -0400
Subject: Re: [PATCH 3/5] kconfig: refactor GTK+ package checks for building
 gconf
To: Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kbuild@vger.kernel.org
Cc: Sam Ravnborg <sam@ravnborg.org>, Ulf Magnusson <ulfalizer@gmail.com>,
        linux-kernel@vger.kernel.org
References: <1526619146-1895-1-git-send-email-yamada.masahiro@socionext.com>
 <1526619146-1895-4-git-send-email-yamada.masahiro@socionext.com>
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <3a474920-8d62-a018-1869-5f5abb7bbfa1@infradead.org>
Date: Sat, 19 May 2018 11:11:39 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <1526619146-1895-4-git-send-email-yamada.masahiro@socionext.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/17/18 21:52, Masahiro Yamada wrote:
> Refactor the necessary package checks for building gconf in the same
> way as for qconf.
> 
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>


This patch works for me.


Tested-by: Randy Dunlap <rdunlap@infradead.org>
Acked-by: Randy Dunlap <rdunlap@infradead.org>


thanks.
-- 
~Randy
