Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAB76C282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 14:31:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E63F21726
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 14:31:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726719AbfAWOa7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 09:30:59 -0500
Received: from mx2.suse.de ([195.135.220.15]:60256 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726236AbfAWOa7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 09:30:59 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 2051EAFCA;
        Wed, 23 Jan 2019 14:30:58 +0000 (UTC)
Date:   Wed, 23 Jan 2019 15:30:57 +0100 (CET)
From:   Miroslav Benes <mbenes@suse.cz>
To:     Nicholas Mc Guire <hofrat@osadl.org>
cc:     Josh Poimboeuf <jpoimboe@redhat.com>, Jessica Yu <jeyu@kernel.org>,
        Jiri Kosina <jikos@kernel.org>, Petr Mladek <pmladek@suse.com>,
        live-patching@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V3] livepatch: non static warnings fix
In-Reply-To: <1548226584-20579-1-git-send-email-hofrat@osadl.org>
Message-ID: <alpine.LSU.2.21.1901231518320.31908@pobox.suse.cz>
References: <1548226584-20579-1-git-send-email-hofrat@osadl.org>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, 23 Jan 2019, Nicholas Mc Guire wrote:

> Sparse reported warnings about non-static symbols. For the variables
> a simple static attribute is fine - for the functions referenced by
> livepatch via klp_func the symbol-names must be unmodified in the
> symbol table and the patchable code has to be emitted. The resolution
> is to attach __used attribute to the shared statically declared functions.
> 
> Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
> Suggested-by: Joe Lawrence <joe.lawrence@redhat.com>
> Link: https://lkml.org/lkml/2018/12/13/827

could you reorder the tags and change Link: tag to 
https://lkml.kernel.org/r/<message_id> as asked for when we reviewed v2?

With that

Acked-by: Miroslav Benes <mbenes@suse.cz>

M
