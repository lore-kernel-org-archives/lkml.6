Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754702AbeBGUfn (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Feb 2018 15:35:43 -0500
Received: from ozlabs.org ([103.22.144.67]:53055 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754221AbeBGUfl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Feb 2018 15:35:41 -0500
Date: Thu, 8 Feb 2018 07:35:39 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commit in the s390 tree
Message-ID: <20180208073539.706e942f@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Commit

  b175210bd231 ("s390/kconfig: Remove ARCH_WANTS_PROT_NUMA_PROT_NONE select")

is missing a Signed-off-by from its committer.

-- 
Cheers,
Stephen Rothwell
