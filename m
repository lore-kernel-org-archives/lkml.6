Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932816AbeBLWb6 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 17:31:58 -0500
Received: from ozlabs.org ([103.22.144.67]:55907 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932628AbeBLWb5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 17:31:57 -0500
Date: Tue, 13 Feb 2018 09:31:53 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Boris Brezillon <boris.brezillon@free-electrons.com>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commits in the nand tree
Message-ID: <20180213093153.0958cff1@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Boris,

A whole series of commits

  558783726c98 ("mtd: nand: mxc: reorder functions to avoid forward declarations")
to
  e385e291129e ("mtd: nand: mxc: remove now unused code")

are missing a Signed-off-by from their committer.

-- 
Cheers,
Stephen Rothwell
