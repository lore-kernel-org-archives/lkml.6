Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752096AbeDSLPg (ORCPT <rfc822;w@1wt.eu>);
        Thu, 19 Apr 2018 07:15:36 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:39181 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751147AbeDSLPf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Apr 2018 07:15:35 -0400
Date: Thu, 19 Apr 2018 13:15:26 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
To: Steven Rostedt <rostedt@goodmis.org>
cc: Dominik Brodowski <linux@dominikbrodowski.net>,
        LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>, x86@kernel.org
Subject: Re: [PATCH v3] tracing/x86: Update syscall trace events to handle
 new prefixed syscall func names
In-Reply-To: <20180418141948.46a77ebc@gandalf.local.home>
Message-ID: <alpine.DEB.2.21.1804191315010.1563@nanos.tec.linutronix.de>
References: <20180418114509.5a76847d@gandalf.local.home> <20180418181729.GA4816@light.dominikbrodowski.net> <20180418141948.46a77ebc@gandalf.local.home>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 18 Apr 2018, Steven Rostedt wrote:
> On Wed, 18 Apr 2018 20:17:29 +0200
> Dominik Brodowski <linux@dominikbrodowski.net> wrote:
> 
> > Acked-by: Dominik Brodowski <linux@dominikbrodowski.net>
> 
> Thanks!
> 
> Ingo, Thomas, Peter,
> 
> I can take this in my tree, as I have a couple of patches that need to
> go mainline as well.
> 
> OK with you if I do?
 
Acked-by: Thomas Gleixner <tglx@linutronix.de>
