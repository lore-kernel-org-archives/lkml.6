Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751974AbeB0Wnl (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Feb 2018 17:43:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:49872 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751754AbeB0Wnk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Feb 2018 17:43:40 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9657C21771
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=rostedt@goodmis.org
Date: Tue, 27 Feb 2018 17:43:37 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: "Du, Changbin" <changbin.du@intel.com>
Cc: corbet@lwn.net, mingo@kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/17] Include linux trace docs to Sphinx TOC tree
Message-ID: <20180227174337.37ecb348@vmware.local.home>
In-Reply-To: <20180227093421.yd674oaklthaljgh@intel.com>
References: <1518845990-20733-1-git-send-email-changbin.du@intel.com>
        <20180227093421.yd674oaklthaljgh@intel.com>
X-Mailer: Claws Mail 3.15.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 Feb 2018 17:34:22 +0800
"Du, Changbin" <changbin.du@intel.com> wrote:

> Hello Steven and Corbet,
> Ten days past, will you accept this serias? Thank you!
> 
> On Sat, Feb 17, 2018 at 01:39:33PM +0800, changbin.du@intel.com wrote:
> > From: Changbin Du <changbin.du@intel.com>
> > 
> > Hi All,
> > The linux tracers are so useful that I want to make the docs better. The kernel
> > now uses Sphinx to generate intelligent and beautiful documentation from
> > reStructuredText files. I converted most of the Linux trace docs to rst format
> > in this serias.
> > 
> > For you to preview, please visit below url:
> > http://docservice.askxiong.com/linux-kernel/trace/index.html
> > 
> > Thank you!

Currently I'm very overloaded with other code that needs to get done
ASAP, and I need to balance what is critical and what is not. I don't
have time to review this, as this isn't critical, and can wait.

If Jon can review it to make sure that it doesn't change the
readability of the text, then I'll trust his judgment. 

-- Steve
