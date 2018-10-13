Return-Path: <SRS0=sHJz=MZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB866C28CF8
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Oct 2018 05:36:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EB242087D
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Oct 2018 05:36:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7EB242087D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ZenIV.linux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726299AbeJMNMj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Oct 2018 09:12:39 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:46424 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726077AbeJMNMj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Oct 2018 09:12:39 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gBCbZ-0003HN-Fs; Sat, 13 Oct 2018 05:36:49 +0000
Date:   Sat, 13 Oct 2018 06:36:49 +0100
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg KH <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 09/50] amiserial: switch to ->[sg]et_serial()
Message-ID: <20181013053649.GP32577@ZenIV.linux.org.uk>
References: <20180913023119.GQ19965@ZenIV.linux.org.uk>
 <20180913024049.24567-1-viro@ZenIV.linux.org.uk>
 <20180913024049.24567-9-viro@ZenIV.linux.org.uk>
 <CAMuHMdXqfzz-eE+SDnun-SHm0ma69sYipgMjVhn1ipLrfXzD8w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdXqfzz-eE+SDnun-SHm0ma69sYipgMjVhn1ipLrfXzD8w@mail.gmail.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 11, 2018 at 07:58:28PM +0200, Geert Uytterhoeven wrote:

> drivers/tty/amiserial.c:1076:3: error: 'retval' undeclared (first use
> in this function)
> 
> http://kisskb.ellerman.id.au/kisskb/buildresult/13544535/
> http://kisskb.ellerman.id.au/kisskb/buildresult/13544413/

Fixed and folded.
