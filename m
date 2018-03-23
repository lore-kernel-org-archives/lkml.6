Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751661AbeCWETG (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Mar 2018 00:19:06 -0400
Received: from shards.monkeyblade.net ([184.105.139.130]:36514 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751080AbeCWETE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Mar 2018 00:19:04 -0400
Date: Fri, 23 Mar 2018 00:19:00 -0400 (EDT)
Message-Id: <20180323.001900.849305099701511845.davem@davemloft.net>
To: dledford@redhat.com
Cc: sfr@canb.auug.org.au, netdev@vger.kernel.org, jgg@mellanox.com,
        linux-next@vger.kernel.org, linux-kernel@vger.kernel.org,
        markb@mellanox.com, leonro@mellanox.com
Subject: Re: linux-next: manual merge of the net-next tree with the
 rdma-fixes tree
From: David Miller <davem@davemloft.net>
In-Reply-To: <1521163082.18703.191.camel@redhat.com>
References: <20180316115610.3d7f232a@canb.auug.org.au>
        <1521163082.18703.191.camel@redhat.com>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Doug Ledford <dledford@redhat.com>
Date: Thu, 15 Mar 2018 21:18:02 -0400

> Here's the commit (from the rdma git repo) with the proper merge fix
> (although it also has other minor merge stuff that needs to be ignored):
> 
> 2d873449a202 (Merge branch 'k.o/wip/dl-for-rc' into k.o/wip/dl-for-next)

Really?

[davem@localhost GIT]$ git clone --reference linux/.git git://git.kernel.org/pub/scm/linux/kernel/git/dledford/rdma.git
Cloning into 'rdma'...
remote: Counting objects: 32, done.        
remote: Compressing objects: 100% (31/31), done.        
remote: Total 32 (delta 0), reused 32 (delta 0)        
Receiving objects: 100% (32/32), 186.52 KiB | 3.01 MiB/s, done.
Checking connectivity: 5706198, done.
Checking out files: 100% (61622/61622), done.
[davem@localhost GIT]$ cd rdma
[davem@localhost rdma]$ git show 2d873449a202
fatal: ambiguous argument '2d873449a202': unknown revision or path not in the working tree.
Use '--' to separate paths from revisions, like this:
'git <command> [<revision>...] -- [<file>...]'
[davem@localhost rdma]$
