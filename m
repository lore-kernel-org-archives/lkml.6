Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753919AbeDRPpG (ORCPT <rfc822;w@1wt.eu>);
        Wed, 18 Apr 2018 11:45:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:39862 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753279AbeDRPpD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Apr 2018 11:45:03 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE8392175C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=rostedt@goodmis.org
Date: Wed, 18 Apr 2018 11:45:00 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Dominik Brodowski <linux@dominikbrodowski.net>
Cc: LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>, x86@kernel.org
Subject: Re: [PATCH v2] tracing/x86: Update syscall trace events to handle
 new x86 syscall func names
Message-ID: <20180418114500.59dc69a7@gandalf.local.home>
In-Reply-To: <20180417172236.GA17342@light.dominikbrodowski.net>
References: <20180417130702.01575029@gandalf.local.home>
        <20180417172236.GA17342@light.dominikbrodowski.net>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 17 Apr 2018 19:22:36 +0200
Dominik Brodowski <linux@dominikbrodowski.net> wrote:

> >   Added back original compare to not miss 32bit kernel syscalls  
> 
> s/32bit/32bit and 0-parameter syscalls.
> 
> Looks good otherwise.
> 

You want to send an Acked or Reviewed-by to my final patch (v3).

-- Steve
