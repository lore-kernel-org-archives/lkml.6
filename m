Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5D97C43142
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 00:43:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24D56258DF
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 00:43:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24D56258DF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ZenIV.linux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752449AbeF1AnS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 20:43:18 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:41756 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751986AbeF1AnR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 20:43:17 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.87 #1 (Red Hat Linux))
        id 1fYL1m-0003Jo-7u; Thu, 28 Jun 2018 00:43:14 +0000
Date:   Thu, 28 Jun 2018 01:43:14 +0100
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Chunyu Hu <chuhu@redhat.com>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] proc: add proc_seq_release
Message-ID: <20180628004314.GG30522@ZenIV.linux.org.uk>
References: <1528573884-9133-1-git-send-email-chuhu@redhat.com>
 <20180611062354.GA32641@lst.de>
 <1113263100.13594710.1530015652549.JavaMail.zimbra@redhat.com>
 <20180627070940.GA9790@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180627070940.GA9790@lst.de>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 27, 2018 at 09:09:40AM +0200, Christoph Hellwig wrote:
> Al, can you pick up this fix from Chunyu?

Applied.
