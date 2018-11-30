Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6C7CC04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 20:42:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61E8D2080A
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 20:42:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61E8D2080A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=iki.fi
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726709AbeLAHwr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Dec 2018 02:52:47 -0500
Received: from emh02.mail.saunalahti.fi ([62.142.5.108]:33826 "EHLO
        emh02.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726637AbeLAHwr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Dec 2018 02:52:47 -0500
Received: from darkstar.musicnaut.iki.fi (85-76-84-209-nat.elisa-mobile.fi [85.76.84.209])
        by emh02.mail.saunalahti.fi (Postfix) with ESMTP id DF0F020065;
        Fri, 30 Nov 2018 22:42:14 +0200 (EET)
Date:   Fri, 30 Nov 2018 22:42:14 +0200
From:   Aaro Koskinen <aaro.koskinen@iki.fi>
To:     Kees Cook <keescook@chromium.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Subject: Re: Fwd: [PATCH RFC 00/15] Zero ****s, hugload of hugs <3
Message-ID: <20181130204214.GA2287@darkstar.musicnaut.iki.fi>
References: <20181130192737.15053-1-jarkko.sakkinen@linux.intel.com>
 <CAGXu5j+jBNBsD3pvUSfEh6Lc5T1YMpbM0HeG1c6BHiJe+cKVOQ@mail.gmail.com>
 <CAGXu5j+DE0CkRf92yyPo6dzG8FODBCz_=3J6S2oFat4UyLKwjw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGXu5j+DE0CkRf92yyPo6dzG8FODBCz_=3J6S2oFat4UyLKwjw@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 30, 2018 at 11:48:24AM -0800, Kees Cook wrote:
> Better yet, since it's only 17 files, how about doing context-specific
> changes? "This API is terrible"

I think we should only use "good" with selected operators like !, ++, --

E.g. "This API is !good++"

Suggested-by: George Orwell

A.
