Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89787C5CFEB
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 23:55:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A64D20873
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 23:55:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A64D20873
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754617AbeGIXzz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 19:55:55 -0400
Received: from mx2.suse.de ([195.135.220.15]:35036 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754529AbeGIXzx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 19:55:53 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id CA12FACB6;
        Mon,  9 Jul 2018 23:55:51 +0000 (UTC)
Date:   Mon, 9 Jul 2018 16:55:46 -0700
From:   Davidlohr Bueso <dave@stgolabs.net>
Cc:     Manfred Spraul <manfred@colorfullife.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        LKML <linux-kernel@vger.kernel.org>, 1vier1@web.de,
        Kees Cook <keescook@chromium.org>,
        Davidlohr Bueso <dbueso@suse.de>
Subject: Re: [PATCH 11/12] ipc: simplify ipc initialization
Message-ID: <20180709235546.6bewqyrhztc22py2@linux-r8p5>
References: <20180709151019.1336-1-manfred@colorfullife.com>
 <20180709151019.1336-12-manfred@colorfullife.com>
 <20180709144255.9d572c2e5b7064e15a60caa1@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20180709144255.9d572c2e5b7064e15a60caa1@linux-foundation.org>
1;5002;0cTo: Andrew Morton <akpm@linux-foundation.org>
User-Agent: NeoMutt/20170912 (1.9.0)
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 09 Jul 2018, Andrew Morton wrote:

>On Mon,  9 Jul 2018 17:10:18 +0200 Manfred Spraul <manfred@colorfullife.com> wrote:
>
>> From: Davidlohr Bueso <dave@stgolabs.net>
>>
>> ...
>>
>> Signed-off-by: Davidlohr Bueso <dbueso@suse.de>
>
>Should these be From: dbueso@suse.de?

Not really, I've been doing this for years now -- makes backports
easier.

Thanks,
Davidlohr
