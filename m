Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752025AbeEKCs5 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 10 May 2018 22:48:57 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:36194 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750751AbeEKCs4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 May 2018 22:48:56 -0400
Date: Fri, 11 May 2018 03:48:51 +0100
From: Al Viro <viro@ZenIV.linux.org.uk>
To: "Luis R. Rodriguez" <mcgrof@kernel.org>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, ast@kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org
Subject: Re: [PATCH] coredump: rename umh_pipe_setup() to
 coredump_pipe_setup()
Message-ID: <20180511024851.GB30522@ZenIV.linux.org.uk>
References: <20180507233002.5571-1-mcgrof@kernel.org>
 <20180510231907.xbok4h6rjopwdq6e@ast-mbp>
 <20180510233247.GG27853@wotan.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180510233247.GG27853@wotan.suse.de>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 10, 2018 at 11:32:47PM +0000, Luis R. Rodriguez wrote:

> I think net-next makes sense if Al Viro is OK with that. This way it could go
> in regardless of the state of your series, but it also lines up with your work.

Fine by me...
