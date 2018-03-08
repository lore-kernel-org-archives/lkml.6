Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754781AbeCHDlP (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 22:41:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:39646 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753901AbeCHDlO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 22:41:14 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EAE5A2172D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=rostedt@goodmis.org
Date: Wed, 7 Mar 2018 22:41:11 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Jonathan Corbet <corbet@lwn.net>
Cc: "Du, Changbin" <changbin.du@intel.com>, mingo@kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/17] Include linux trace docs to Sphinx TOC tree
Message-ID: <20180307224111.0c961fbb@vmware.local.home>
In-Reply-To: <20180307104649.4db521a5@lwn.net>
References: <1518845990-20733-1-git-send-email-changbin.du@intel.com>
        <20180227093421.yd674oaklthaljgh@intel.com>
        <20180227174337.37ecb348@vmware.local.home>
        <20180307104649.4db521a5@lwn.net>
X-Mailer: Claws Mail 3.15.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 7 Mar 2018 10:46:49 -0700
Jonathan Corbet <corbet@lwn.net> wrote:

> Anyway, with that, the patch series is applied.  Thanks for helping to
> improve the docs, and my apologies for taking so long to get to this.

Thanks for doing this Jon. I'm going to have to find some time to
revisit all the documentation in the tracing directory, because I'm
sure they have fallen out of date.

-- Steve
