Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752726AbeDRU5s (ORCPT <rfc822;w@1wt.eu>);
        Wed, 18 Apr 2018 16:57:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:39486 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752255AbeDRU5q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Apr 2018 16:57:46 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB65E21745
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=jeyu@kernel.org
Date: Wed, 18 Apr 2018 22:57:39 +0200
From: Jessica Yu <jeyu@kernel.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Adding modules-linus branch to linux-next
Message-ID: <20180418205739.7bvi3hfmhozztbnf@redbean>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
X-OS: Linux redbean 4.15.3-200.fc26.x86_64 x86_64
User-Agent: NeoMutt/20180323
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen,

Could you please add the modules-linus branch at:

    git://git.kernel.org/pub/scm/linux/kernel/git/jeyu/linux.git modules-linus

to linux-next? The branch will contain rc fixes intended for the
current release. A good name for it might be modules-current.

Thanks!

Jessica
