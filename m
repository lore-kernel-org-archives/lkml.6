Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932110AbeBGOkb (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Feb 2018 09:40:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:52230 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754291AbeBGOka (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Feb 2018 09:40:30 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B37C21789
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=rostedt@goodmis.org
Date: Wed, 7 Feb 2018 09:40:17 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Zamir SUN <sztsian@gmail.com>
Cc: Vladislav Valtchev <vladislav.valtchev@gmail.com>,
        johannes.berg@intel.com, johannes@sipsolutions.net,
        linux-kernel@vger.kernel.org, zsun@redhat.com
Subject: Re: [PATCH 1/2] trace-cmd: Fix the detection for swig
Message-ID: <20180207094017.5a130e6a@gandalf.local.home>
In-Reply-To: <df980185-aa29-f65b-d5b0-f42d85a66a51@gmail.com>
References: <20180204032014.6962-1-sztsian@gmail.com>
        <20180204032014.6962-2-sztsian@gmail.com>
        <20180206181807.2d35393e@gandalf.local.home>
        <df980185-aa29-f65b-d5b0-f42d85a66a51@gmail.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 7 Feb 2018 22:01:46 +0800
Zamir SUN <sztsian@gmail.com> wrote:


> Thanks for the heads-up! I did not see that before.
> 
> While just a note for this, in Fedora 27:
> 
> $ if command -v swig; then echo 1; else echo 0; fi
> /usr/bin/swig
> 1
> 
> Actually this test has the same problem as of `which swig` - When swig
> exists, the var SWIG_DEFINED will not be 1 (as shown above).
> 
> I see Vladislav is already on this thread. I hope this can be fixed
> before merging the patch set.
>

After doing some more testing, I'm going to push out the changes today.
Would you be able to add patches on top of the changes? We are doing a
restructuring of the directory such that it can grow more.

I'll be backporting these fixes to 2.6 and 2.7 as well.

Thanks!

-- Steve
