Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76E3AC43144
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 23:35:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28B57259C0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 23:35:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28B57259C0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752575AbeF0Xfe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 19:35:34 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:43058 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752210AbeF0Xfd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 19:35:33 -0400
Received: from localhost.localdomain (c-24-4-125-7.hsd1.ca.comcast.net [24.4.125.7])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 7C6C8CC8;
        Wed, 27 Jun 2018 23:35:32 +0000 (UTC)
Date:   Wed, 27 Jun 2018 16:35:31 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     Cannon Matthews <cannonmatthews@google.com>,
        Nadia Yvette Chambers <nyc@holomorphy.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        andreslc@google.com, pfeiner@google.com, gthelen@google.com
Subject: Re: [PATCH] mm: hugetlb: yield when prepping struct pages
Message-Id: <20180627163531.600a312b8f49088e3e4aa72f@linux-foundation.org>
In-Reply-To: <89c34814-ee1a-6339-1daf-fff02ce947e5@oracle.com>
References: <20180627214447.260804-1-cannonmatthews@google.com>
        <89c34814-ee1a-6339-1daf-fff02ce947e5@oracle.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Jun 2018 16:27:24 -0700 Mike Kravetz <mike.kravetz@oracle.com> wrote:

> My only suggestion would be to remove the mention of 2M pages in the
> commit message.  Thanks for adding this.

I have removed that sentence.

> Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>

Thanks again.
