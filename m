Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752156AbeDDTut (ORCPT <rfc822;w@1wt.eu>);
        Wed, 4 Apr 2018 15:50:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:48100 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751517AbeDDTur (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Apr 2018 15:50:47 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA6F421707
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=rostedt@goodmis.org
Date: Wed, 4 Apr 2018 15:50:44 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Tim Tianyang Chen <tianyang.chen@oracle.com>
Cc: Dhaval Giani <dhaval.giani@oracle.com>, linux-kernel@vger.kernel.org,
        tim.tianyang.chen@alumni.upenn.edu
Subject: Re: [PATCH v3 0/4] Ktest: add email support
Message-ID: <20180404155045.0137e8f5@gandalf.local.home>
In-Reply-To: <20180403183819.5dbb89d9@gandalf.local.home>
References: <1522094884-22718-1-git-send-email-tianyang.chen@oracle.com>
        <ba4461ff-57ea-0861-4aab-e704b549474f@oracle.com>
        <26923e02-7eef-dc80-c9fc-7ecfa9842229@oracle.com>
        <20180403183819.5dbb89d9@gandalf.local.home>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 3 Apr 2018 18:38:19 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Tue, 3 Apr 2018 12:52:20 -0700
> Tim Tianyang Chen <tianyang.chen@oracle.com> wrote:
> 
> > Hi Steve, did you get a chance to take a look? cc'ing myself and a 
> > personal email. When I sent the patchset I forgot to include.  
> 
> Sorry, I'm trying to get my own ktest patches in (I have a bunch of non
> committed changes) and I need to clean them up before adding yours.
> 
> I'll take a look at them tonight or tomorrow.

I started working on ktest again, but didn't get as far as I wanted.
I'll be continuing more on it tomorrow. I want this ready for this
merge window, so it is high on my priority list (including your
patches).

-- Steve
