Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751115AbeCHVA4 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 16:00:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:38646 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750728AbeCHVAz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 16:00:55 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B85A1208FE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=jeyu@kernel.org
Date: Thu, 8 Mar 2018 22:00:50 +0100
From: Jessica Yu <jeyu@kernel.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: Signed-off-by missing for commit in the modules tree
Message-ID: <20180308210047.3rvg2auukohidjy3@redbean>
References: <20180309075457.5fb444d1@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20180309075457.5fb444d1@canb.auug.org.au>
X-OS: Linux redbean 4.15.0-next-20180207 x86_64
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+++ Stephen Rothwell [09/03/18 07:54 +1100]:
>Hi Jessica,
>
>Commit
>
>  934ccf7248dd ("module: propagate error in modules_open()")
>
>is missing a Signed-off-by from its committer.
>

Whoops, thanks for catching that. Should be fixed now.

Jessica
