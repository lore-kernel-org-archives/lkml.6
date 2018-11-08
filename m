Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A511C43441
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 22:23:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 292DD20818
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 22:23:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 292DD20818
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731667AbeKIIAt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 03:00:49 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:53072 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728014AbeKIIAt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 03:00:49 -0500
Received: from akpm3.svl.corp.google.com (unknown [104.133.8.65])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 341467F6;
        Thu,  8 Nov 2018 22:23:13 +0000 (UTC)
Date:   Thu, 8 Nov 2018 14:23:12 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Jongseok Kim <ks77sj@gmail.com>
Cc:     Vitaly Wool <vitalywool@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] z3fold: fix wrong handling of headless pages
Message-Id: <20181108142312.f5efdc72ca0d64dc80046c92@linux-foundation.org>
In-Reply-To: <20181108134540.12756-1-ks77sj@gmail.com>
References: <CAMJBoFP3C5NffHf2bPaY-W2qXPLs6z+Ker+Z+Sq_3MHV5xekHQ@mail.gmail.com>
        <20181108134540.12756-1-ks77sj@gmail.com>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu,  8 Nov 2018 22:45:40 +0900 Jongseok Kim <ks77sj@gmail.com> wrote:

> Yes, you are right.
> I think that's the best way to deal it.
> Thank you.


I did this:

Link: http://lkml.kernel.org/r/20181105162225.74e8837d03583a9b707cf559@gmail.com
Signed-off-by: Vitaly Wool <vitaly.vul@sony.com>
Signed-off-by: Jongseok Kim <ks77sj@gmail.com>
Reported-by-by: Jongseok Kim <ks77sj@gmail.com>
Reviewed-by: Snild Dolkow <snild@sony.com>
