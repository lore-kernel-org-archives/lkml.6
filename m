Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753051AbeDRSTw (ORCPT <rfc822;w@1wt.eu>);
        Wed, 18 Apr 2018 14:19:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:54764 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751870AbeDRSTv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Apr 2018 14:19:51 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2EFAC2175C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=rostedt@goodmis.org
Date: Wed, 18 Apr 2018 14:19:48 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Dominik Brodowski <linux@dominikbrodowski.net>
Cc: LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>, x86@kernel.org
Subject: Re: [PATCH v3] tracing/x86: Update syscall trace events to handle
 new prefixed syscall func names
Message-ID: <20180418141948.46a77ebc@gandalf.local.home>
In-Reply-To: <20180418181729.GA4816@light.dominikbrodowski.net>
References: <20180418114509.5a76847d@gandalf.local.home>
        <20180418181729.GA4816@light.dominikbrodowski.net>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 18 Apr 2018 20:17:29 +0200
Dominik Brodowski <linux@dominikbrodowski.net> wrote:

> Acked-by: Dominik Brodowski <linux@dominikbrodowski.net>

Thanks!

Ingo, Thomas, Peter,

I can take this in my tree, as I have a couple of patches that need to
go mainline as well.

OK with you if I do?

-- Steve
