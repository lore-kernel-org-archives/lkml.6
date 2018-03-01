Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1032941AbeCAQWW (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 11:22:22 -0500
Received: from lilium.sigma-star.at ([109.75.188.150]:57586 "EHLO
        lilium.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1032868AbeCAQWT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 11:22:19 -0500
From: Richard Weinberger <richard@nod.at>
To: Jiang Biao <jiang.biao2@zte.com.cn>
Cc: dedekind1@gmail.com, adrian.hunter@intel.com,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        zhong.weidong@zte.com.cn
Subject: Re: [PATCH] fs/ubifs: remove useless parameter of lpt_heap_replace
Date: Thu, 01 Mar 2018 17:23:41 +0100
Message-ID: <3489822.spB4g6dZPN@blindfold>
In-Reply-To: <1519784557-105528-1-git-send-email-jiang.biao2@zte.com.cn>
References: <1519784557-105528-1-git-send-email-jiang.biao2@zte.com.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mittwoch, 28. Februar 2018, 03:22:37 CET schrieb Jiang Biao:
> The parameter *old_lprops* is never used in lpt_heap_replace(),
> remove it to avoid compile warning.

Makes sense. But what compiler warning do you get?

Thanks,
//richard
