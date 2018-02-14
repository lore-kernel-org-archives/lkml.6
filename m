Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031959AbeBNW7v (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 17:59:51 -0500
Received: from mx2.suse.de ([195.135.220.15]:38005 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1031852AbeBNW7u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 17:59:50 -0500
Date: Wed, 14 Feb 2018 22:59:47 +0000
From: "Luis R. Rodriguez" <mcgrof@kernel.org>
To: Junichi Nomura <j-nomura@ce.jp.nec.com>
Cc: Tejun Heo <tj@kernel.org>, Andi Kleen <andi@firstfloor.org>,
        Andrew Morton <akpm@linux-foundation.org>, Jan Kara <jack@suse.cz>,
        linux-kernel@vger.kernel.org
Subject: [TEST for] fs: global sync to not clear error status of individual
 inodes
Message-ID: <20180214225947.GB1686@wotan.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.6.0 (2016-04-01)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Junichi,

curious if you ever got to adapt a test case for xfstests for your patch
"fs: global sync to not clear error status of individual inodes", which
got merged as of v4.4 as:

aa750fd71c242dba02ee2034e15fbd7d0cdb2461 mm/filemap.c: make global sync not clear error status of individual inodes

You said you'd work on it, so curious if you ever got to it.

[0] https://patchwork.kernel.org/patch/7183351/

  Luis
