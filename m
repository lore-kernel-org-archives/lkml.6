Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751800AbeEDRbP (ORCPT <rfc822;w@1wt.eu>);
        Fri, 4 May 2018 13:31:15 -0400
Received: from shards.monkeyblade.net ([184.105.139.130]:36268 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751709AbeEDRbL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 May 2018 13:31:11 -0400
Date: Fri, 04 May 2018 13:31:08 -0400 (EDT)
Message-Id: <20180504.133108.824679852510791586.davem@davemloft.net>
To: dh.herrmann@gmail.com
Cc: linux-kernel@vger.kernel.org, jmorris@namei.org, paul@paul-moore.com,
        teg@jklm.no, sds@tycho.nsa.gov, selinux@tycho.nsa.gov,
        linux-security-module@vger.kernel.org, eparis@parisplace.org,
        serge@hallyn.com, casey@schaufler-ca.com, netdev@vger.kernel.org
Subject: Re: [PATCH v2 2/4] net: hook socketpair() into LSM
From: David Miller <davem@davemloft.net>
In-Reply-To: <20180504142822.15233-3-dh.herrmann@gmail.com>
References: <20180504142822.15233-1-dh.herrmann@gmail.com>
        <20180504142822.15233-3-dh.herrmann@gmail.com>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Herrmann <dh.herrmann@gmail.com>
Date: Fri,  4 May 2018 16:28:20 +0200

> Use the newly created LSM-hook for socketpair(). The default hook
> return-value is 0, so behavior stays the same unless LSMs start using
> this hook.
> 
> Acked-by: Serge Hallyn <serge@hallyn.com>
> Signed-off-by: Tom Gundersen <teg@jklm.no>
> Signed-off-by: David Herrmann <dh.herrmann@gmail.com>

Acked-by: David S. Miller <davem@davemloft.net>
