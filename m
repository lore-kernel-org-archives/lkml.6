Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02A2DC282D9
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 01:13:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D28CB21872
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 01:13:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727192AbfBABNK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 20:13:10 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:36210 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725807AbfBABNJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 20:13:09 -0500
Received: from localhost.localdomain (c-73-223-200-170.hsd1.ca.comcast.net [73.223.200.170])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id AB8BE4FF5;
        Fri,  1 Feb 2019 01:13:08 +0000 (UTC)
Date:   Thu, 31 Jan 2019 17:13:06 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     "Tobin C. Harding" <me@tobin.cc>
Cc:     "Tobin C. Harding" <tobin@kernel.org>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/slab: Increase width of first /proc/slabinfo column
Message-Id: <20190131171306.55710d0820deb12282873fab@linux-foundation.org>
In-Reply-To: <20190201005838.GA8082@eros.localdomain>
References: <20190201004242.7659-1-tobin@kernel.org>
        <20190201005838.GA8082@eros.localdomain>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 1 Feb 2019 11:58:38 +1100 "Tobin C. Harding" <me@tobin.cc> wrote:

> On Fri, Feb 01, 2019 at 11:42:42AM +1100, Tobin C. Harding wrote:
> [snip]
> 
> This applies on top of Linus' tree
> 
> 	commit e74c98ca2d6a ('gfs2: Revert "Fix loop in gfs2_rbm_find"')
> 
> For this patch I doubt very much that it matters but for the record I
> can't find mention in MAINTAINERS which tree to base work on for slab
> patches.  Are mm patches usually based of an mm tree or do you guys work
> off linux-next?

It's usually best to work off current mainline and I handle the
integration stuff.

