Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752686AbeBAUpG (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Feb 2018 15:45:06 -0500
Received: from ozlabs.org ([103.22.144.67]:51469 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752632AbeBAUoz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Feb 2018 15:44:55 -0500
Date: Fri, 2 Feb 2018 07:44:51 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Jeff Layton <jlayton@kernel.org>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commit in the iversion tree
Message-ID: <20180202074451.21081cf6@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jeff,

Commit

  9b796f330111 ("Rename make inode_cmp_iversion{+raw} to inode_eq_iversion{+raw}")

is missing a Signed-off-by from its committer.

-- 
Cheers,
Stephen Rothwell
