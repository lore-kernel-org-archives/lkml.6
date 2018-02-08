Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752054AbeBHXzB (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Feb 2018 18:55:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:53010 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750750AbeBHXzA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Feb 2018 18:55:00 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95F55204EF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=rostedt@goodmis.org
Date: Thu, 8 Feb 2018 18:54:56 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: sztsian@gmail.com
Cc: johannes.berg@intel.com, johannes@sipsolutions.net,
        linux-kernel@vger.kernel.org, zsun@redhat.com
Subject: Re: [PATCH 2/2] trace-cmd: Change the way of getting python
 ldflags.
Message-ID: <20180208185456.55e6e712@gandalf.local.home>
In-Reply-To: <20180204032014.6962-3-sztsian@gmail.com>
References: <20180204032014.6962-1-sztsian@gmail.com>
        <20180204032014.6962-3-sztsian@gmail.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun,  4 Feb 2018 11:20:14 +0800
sztsian@gmail.com wrote:

> From: Zamir SUN <sztsian@gmail.com>
> 
> Prior than this patch, Makefile detects python ldflags using a hardcoded
> python command. It will cause problems if we are building against
> python3 in the future when ldflags for python2 and python3 are
> different. With this patch, python ldflags are detected by
> corresponding python{,3}-config which will detect the right config for
> python plugins.

Thanks, applied.

-- Steve
