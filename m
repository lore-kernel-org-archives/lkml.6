Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751022AbeDGEBs (ORCPT <rfc822;w@1wt.eu>);
        Sat, 7 Apr 2018 00:01:48 -0400
Received: from mail-pf0-f170.google.com ([209.85.192.170]:44279 "EHLO
        mail-pf0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750768AbeDGEBq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Apr 2018 00:01:46 -0400
X-Google-Smtp-Source: AIpwx49b3yj2pLG6DkMiWeeXxaT1LVE2TU4XG1qQSGq5f7wr7HM8K1ILcZ3VG0EXaAIfAHoORhBdLg==
Date: Fri, 6 Apr 2018 21:01:44 -0700
From: Omar Sandoval <osandov@osandov.com>
To: Johannes Thumshirn <jthumshirn@suse.de>
Cc: Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>,
        Linux NVMe Mailinglist <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH] test/nvme/003: add test case for patch "nvme: don't send
 keep-alives to the discovery controller"
Message-ID: <20180407040144.GB533@vader>
References: <20180327092848.10404-1-jthumshirn@suse.de>
 <20180327093147.10684-1-jthumshirn@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180327093147.10684-1-jthumshirn@suse.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 27, 2018 at 11:31:47AM +0200, Johannes Thumshirn wrote:
> Add a regression test for the patch titled "nvme: don't send
> keep-alives to the discovery controller".
> 
> This patch creates a local loopback nvme target and then connects to
> it. If the patch is not applied we see two error messages in dmesg:
> "failed nvme_keep_alive_end_io error=" from the nvme host and "nvmet:
> unsupported cmd 24" from the nvme target. If the patch is applied
> dmesg is quiet.
> 
> Signed-off-by: Johannes Thumshirn <jthumshirn@suse.de>

Applied, thanks, Johannes!
