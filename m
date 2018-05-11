Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752018AbeEKQRE (ORCPT <rfc822;w@1wt.eu>);
        Fri, 11 May 2018 12:17:04 -0400
Received: from mx2.suse.de ([195.135.220.15]:40461 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751474AbeEKQRD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 May 2018 12:17:03 -0400
Date: Fri, 11 May 2018 16:17:00 +0000
From: "Luis R. Rodriguez" <mcgrof@kernel.org>
To: Al Viro <viro@ZenIV.linux.org.uk>,
        "David S. Miller" <davem@davemloft.net>
Cc: "Luis R. Rodriguez" <mcgrof@kernel.org>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>, ast@kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org
Subject: Re: [PATCH] coredump: rename umh_pipe_setup() to
 coredump_pipe_setup()
Message-ID: <20180511161700.GH27853@wotan.suse.de>
References: <20180507233002.5571-1-mcgrof@kernel.org>
 <20180510231907.xbok4h6rjopwdq6e@ast-mbp>
 <20180510233247.GG27853@wotan.suse.de>
 <20180511024851.GB30522@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180511024851.GB30522@ZenIV.linux.org.uk>
User-Agent: Mutt/1.6.0 (2016-04-01)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 11, 2018 at 03:48:51AM +0100, Al Viro wrote:
> On Thu, May 10, 2018 at 11:32:47PM +0000, Luis R. Rodriguez wrote:
> 
> > I think net-next makes sense if Al Viro is OK with that. This way it could go
> > in regardless of the state of your series, but it also lines up with your work.
> 
> Fine by me...

OK thanks.

Dave, I'll bounce a copy of the original patch to you, if anything else is needed
please let me know.

  Luis
