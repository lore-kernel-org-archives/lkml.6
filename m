Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751080AbeEAWNW (ORCPT <rfc822;w@1wt.eu>);
        Tue, 1 May 2018 18:13:22 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:56274 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750823AbeEAWNV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 May 2018 18:13:21 -0400
Date: Tue, 1 May 2018 15:13:19 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Alexey Dobriyan <adobriyan@gmail.com>
Cc: dsterba@suse.cz, Christoph Hellwig <hch@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] proc: use #pragma once
Message-Id: <20180501151319.33dcb1d48a8526ed521fae9c@linux-foundation.org>
In-Reply-To: <20180426192444.GA4919@avx2>
References: <20180423213534.GA9043@avx2>
        <20180424135409.GA22709@infradead.org>
        <20180425205531.GA9020@avx2>
        <20180426102629.scwtdeijbo3342gp@twin.jikos.cz>
        <20180426192444.GA4919@avx2>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 26 Apr 2018 22:24:44 +0300 Alexey Dobriyan <adobriyan@gmail.com> wrote:

> > The LOC argument also does not sound very convincing.
> 
> When was the last time you did -80 kLOC patch for free?

That would be the way to do it - sell the idea to Linus, send him a
script to do it then stand back.  The piecemeal approach is ongoing
pain.
