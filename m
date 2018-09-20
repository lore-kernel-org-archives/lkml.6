Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EA1DECE566
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 13:59:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C89E421522
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 13:59:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C89E421522
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732792AbeITTnR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 15:43:17 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:37620 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727242AbeITTnR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 15:43:17 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 0ACDA1285;
        Thu, 20 Sep 2018 13:59:39 +0000 (UTC)
Date:   Thu, 20 Sep 2018 15:59:36 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Eli Friedman <efriedma@codeaurora.org>,
        Christopher Li <sparse@chrisli.org>,
        Kees Cook <keescook@chromium.org>,
        Ingo Molnar <mingo@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Joe Perches <joe@perches.com>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Stefan Agner <stefan@agner.ch>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-sparse@vger.kernel.org
Subject: Re: [PATCH v2 0/2] Compiler Attributes: (naked only, for v4.19)
Message-ID: <20180920135936.GA9117@kroah.com>
References: <20180918165542.4691-1-miguel.ojeda.sandonis@gmail.com>
 <20180920135748.GA7749@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180920135748.GA7749@kroah.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 20, 2018 at 03:57:48PM +0200, Greg Kroah-Hartman wrote:
> On Tue, Sep 18, 2018 at 06:55:40PM +0200, Miguel Ojeda wrote:
> > These two patches are the 5th and 6th of the Compiler Attributes series,
> > which Stefan and Nick requested to go into v4.19 so that the clang ARM32
> > build is fixed. The v5 of Compiler Attributes will have these two removed
> > if this goes in.
> 
> As these seem pretty "obvious" and they do fix a problem for one
> system/compiler that we want to support, and because odds are I would
> end up getting them submitted to the 4.19-stable tree eventually, I've
> now applied them to the tree.

Also, it passed my build tests, I didn't just throw these in without
doing that :)

greg k-h
