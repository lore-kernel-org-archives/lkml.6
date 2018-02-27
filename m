Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751740AbeB0CRA (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 21:17:00 -0500
Received: from mail-qt0-f176.google.com ([209.85.216.176]:39308 "EHLO
        mail-qt0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751553AbeB0CQ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 21:16:58 -0500
X-Google-Smtp-Source: AG47ELvAKbxeJ8S7mcDIW8MTMMMu2sbBdZVx9gVfMGIwrFptDD4rNxejJCT1YEyoC9Na/UBKP+BKcA==
Date: Tue, 27 Feb 2018 10:16:40 +0800
From: Leo Yan <leo.yan@linaro.org>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: Alexei Starovoitov <ast@kernel.org>, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, Jesper Dangaard Brouer <brouer@redhat.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: Re: [PATCH bpf-next v2] samples/bpf: Add program for CPU state
 statistics
Message-ID: <20180227021640.GA16801@leoy-ThinkPad-T440>
References: <1519607952-12299-1-git-send-email-leo.yan@linaro.org>
 <1e487d11-4f15-09e5-2f53-08b9b30e1494@iogearbox.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1e487d11-4f15-09e5-2f53-08b9b30e1494@iogearbox.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 26, 2018 at 11:26:52AM +0100, Daniel Borkmann wrote:
> On 02/26/2018 02:19 AM, Leo Yan wrote:

[...]

> > CPU states statistics:
> > state(ms)  cstate-0    cstate-1    cstate-2    pstate-0    pstate-1    pstate-2    pstate-3    pstate-4
> > CPU-0      767         6111        111863      561         31          756         853         190
> > CPU-1      241         10606       107956      484         125         646         990         85
> > CPU-2      413         19721       98735       636         84          696         757         89
> > CPU-3      84          11711       79989       17516       909         4811        5773        341
> > CPU-4      152         19610       98229       444         53          649         708         1283
> > CPU-5      185         8781        108697      666         91          671         677         1365
> > CPU-6      157         21964       95825       581         67          566         684         1284
> > CPU-7      125         15238       102704      398         20          665         786         1197
> > 
> > Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> > Cc: Vincent Guittot <vincent.guittot@linaro.org>
> > Signed-off-by: Leo Yan <leo.yan@linaro.org>
> 
> Applied to bpf-next, thanks Leo!

Thanks for help, Daniel.
