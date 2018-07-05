Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7C7EC6778C
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 22:07:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77A5E24075
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 22:07:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77A5E24075
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753787AbeGEWHp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 18:07:45 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:35098 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753346AbeGEWHo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 18:07:44 -0400
Received: from localhost.localdomain (c-24-4-125-7.hsd1.ca.comcast.net [24.4.125.7])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id A8574E7C;
        Thu,  5 Jul 2018 22:07:43 +0000 (UTC)
Date:   Thu, 5 Jul 2018 15:07:42 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     AKASHI Takahiro <takahiro.akashi@linaro.org>,
        Baoquan He <bhe@redhat.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        linux-kernel@vger.kernel.org, Wei Yang <richard.weiyang@gmail.com>
Subject: Re: [PATCH] resource: Use 2-factor allocator calls
Message-Id: <20180705150742.82f6efdf2cd8475a5d94e84a@linux-foundation.org>
In-Reply-To: <20180704173153.GA34386@beast>
References: <20180704173153.GA34386@beast>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 4 Jul 2018 10:31:53 -0700 Kees Cook <keescook@chromium.org> wrote:

> As already done treewide, switch from open-coded multiplication to using
> 2-factor allocation helpers.
> 

This is against resource-add-walk_system_ram_res_rev.patch
(http://lkml.kernel.org/r/20180322033722.9279-2-bhe@redhat.com).

That patch is awaiting (for several months!) a v2.  Will this be happening?
