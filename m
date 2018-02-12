Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754147AbeBLVAm (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 16:00:42 -0500
Received: from ozlabs.org ([103.22.144.67]:42623 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754025AbeBLVAl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 16:00:41 -0500
Date: Tue, 13 Feb 2018 08:00:36 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Mauro Carvalho Chehab <mchehab@osg.samsung.com>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linus <torvalds@linux-foundation.org>
Subject: linux-next: unnecessary merge in the v4l-dvb tree
Message-ID: <20180213080036.3bf3a908@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mauro,

By merging the v4.16-rc1 tag into the v4l-dvb tree, you have created an
unnecessary merge commit.  The v4l-dvb tree was already contained in
v4.16-rc1, so a fast forward merge was possible, but explicitly merging
a signed tag will give you a commit instead.  In this case, you could
have just reset your branch to v4.16-rc1 or merged v4.16-rc1^0.

Linus, this happens a bit after the merge window, so I am wondering
about the rational of not doing a fast forward merge when merging a
signed tag (I forget the reasoning).
-- 
Cheers,
Stephen Rothwell
