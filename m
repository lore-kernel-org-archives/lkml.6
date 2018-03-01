Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1033079AbeCAQY6 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 11:24:58 -0500
Received: from lilium.sigma-star.at ([109.75.188.150]:57718 "EHLO
        lilium.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1033068AbeCAQY4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 11:24:56 -0500
From: Richard Weinberger <richard@nod.at>
To: Liu Song <liu.song11@zte.com.cn>
Cc: dedekind1@gmail.com, adrian.hunter@intel.com,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        jiang.biao2@zte.com.cn, zhong.weidong@zte.com.cn
Subject: Re: [PATCH] fs/UBIFS: make 'sum' definition closer to where it is used
Date: Thu, 01 Mar 2018 17:26:19 +0100
Message-ID: <49033492.RPiX3hNQUc@blindfold>
In-Reply-To: <1519785723-105686-1-git-send-email-liu.song11@zte.com.cn>
References: <1519785723-105686-1-git-send-email-liu.song11@zte.com.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mittwoch, 28. Februar 2018, 03:42:03 CET schrieb Liu Song:
> Local var sum is only used in one branch, and it may be not used if
> it is defined outside the branch. Try to move the definition into
> the branch to make it closer to where it is actually used.

Does this fix a problem?
I'm not a huge fan of defining variables in the middle of functions unless it 
makes the code really better.

Thanks,
//richard
