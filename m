Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752130AbeBCCD7 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Feb 2018 21:03:59 -0500
Received: from ozlabs.org ([103.22.144.67]:58089 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751669AbeBCCDv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Feb 2018 21:03:51 -0500
Date: Sat, 3 Feb 2018 13:03:48 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commits in the s390 tree
Message-ID: <20180203130348.74f7b89b@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Commits

  a39892ed47bf ("s390/runtime_instrumentation: re-add signum system call parameter")
  279d2cea3aad ("s390/cio: fix kernel-doc usage")

are missing a Signed-off-by from their committer.

-- 
Cheers,
Stephen Rothwell
