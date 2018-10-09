Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CB09C64EB0
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 20:42:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEAFD214DC
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 20:42:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CEAFD214DC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726515AbeJJEB3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 00:01:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:37720 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725748AbeJJEB3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 00:01:29 -0400
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6200F213A2;
        Tue,  9 Oct 2018 20:42:44 +0000 (UTC)
Date:   Tue, 9 Oct 2018 16:42:42 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Nicolin Chen <nicoleotsuka@gmail.com>, jdelvare@suse.com,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        mingo@redhat.com
Subject: Re: [PATCH] hwmon: (core) Add trace events to _attr_show/store
 functions
Message-ID: <20181009164242.76e397ad@gandalf.local.home>
In-Reply-To: <20181009203937.GA11222@roeck-us.net>
References: <20181009182602.3085-1-nicoleotsuka@gmail.com>
        <20181009145721.0669e412@gandalf.local.home>
        <20181009191111.GA6166@Asurada-Nvidia.nvidia.com>
        <20181009154945.65300231@gandalf.local.home>
        <20181009195654.GA7963@Asurada-Nvidia.nvidia.com>
        <20181009203937.GA11222@roeck-us.net>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 9 Oct 2018 13:39:37 -0700
Guenter Roeck <linux@roeck-us.net> wrote:

> > Personally a checkpatch warning bugs me more than having an extra
> > line :)
> >   
> Same here. If we no longer believe in the 80-column limit, we should remove it,
> not use it to hide other problems in the noise.

Yes, please, can we?

I personally hate the 80 character limit rule, because I like
descriptive variables and function names, which itself causes the 80
character limit to be broken. I find line breaks to avoid that limit
just makes the code look worse. Or at least up it to 100 chars.

-- Steve
