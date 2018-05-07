Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752360AbeEGPIj (ORCPT <rfc822;w@1wt.eu>);
        Mon, 7 May 2018 11:08:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:49014 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752085AbeEGPI1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 May 2018 11:08:27 -0400
Date: Mon, 7 May 2018 12:08:25 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Yisheng Xie <xieyisheng1@huawei.com>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>, jolsa@redhat.com,
        mingo@redhat.com, peterz@infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf bench numa: Fixes typo in options
Message-ID: <20180507150825.GB3259@kernel.org>
References: <1524644707-11030-1-git-send-email-xieyisheng1@huawei.com>
 <d333c15b-e0cd-4d6e-cbf5-17bbdfc55ccd@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d333c15b-e0cd-4d6e-cbf5-17bbdfc55ccd@huawei.com>
X-Url: http://acmel.wordpress.com
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, May 07, 2018 at 06:45:31PM +0800, Yisheng Xie escreveu:
> Hi Arnaldo,
> 
> Just in case that you may miss this minor fix.
> 
> Thanks
> Yisheng

Thanks, applied to my perf/core branch.

- Arnaldo
