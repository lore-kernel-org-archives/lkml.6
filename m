Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752465AbeCXPS7 (ORCPT <rfc822;w@1wt.eu>);
        Sat, 24 Mar 2018 11:18:59 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:41085 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752380AbeCXPS6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Mar 2018 11:18:58 -0400
Date: Sat, 24 Mar 2018 16:18:52 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Rahul Lakkireddy <rahul.lakkireddy@chelsio.com>
Cc: netdev@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
        davem@davemloft.net, viro@zeniv.linux.org.uk, ebiederm@xmission.com,
        stephen@networkplumber.org, akpm@linux-foundation.org,
        torvalds@linux-foundation.org, ganeshgr@chelsio.com,
        nirranjan@chelsio.com, indranil@chelsio.com
Subject: Re: [PATCH net-next v2 2/2] cxgb4: collect hardware dump in second
 kernel
Message-ID: <20180324151852.GE31941@lunn.ch>
References: <cover.1521888444.git.rahul.lakkireddy@chelsio.com>
 <f06cca21650affa10d83a28dbd7fb577792e35a9.1521888444.git.rahul.lakkireddy@chelsio.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f06cca21650affa10d83a28dbd7fb577792e35a9.1521888444.git.rahul.lakkireddy@chelsio.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 24, 2018 at 04:26:34PM +0530, Rahul Lakkireddy wrote:
> Register callback to collect hardware/firmware dumps in second kernel
> before hardware/firmware is initialized.  The dumps for each device
> will be available under /sys/kernel/crashdd/cxgb4/ directory in second
> kernel.
> 
> Signed-off-by: Rahul Lakkireddy <rahul.lakkireddy@chelsio.com>
> Signed-off-by: Ganesh Goudar <ganeshgr@chelsio.com>

Thanks for adding generic documentation about the files in sysfs.

However, you don't add any specific documentation here about the cxgb4
crash dump. How am i supposed to interpret it? Does it follow any of
the standard core dump formats? How do i use gdb with it? Are there
some specific tools i should use to analyse it?

Thanks
	Andrew
