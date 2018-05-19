Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752612AbeESVEu (ORCPT <rfc822;w@1wt.eu>);
        Sat, 19 May 2018 17:04:50 -0400
Received: from mail-qk0-f195.google.com ([209.85.220.195]:40083 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752515AbeESVEq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 May 2018 17:04:46 -0400
X-Google-Smtp-Source: AB8JxZpszuJ8jlPSJkhngfPgVFhYzdeBYNc3zm12MZBgSdgrt0hfrOttsyjOeC6+lwM1SdkTAQokyw==
Date: Sat, 19 May 2018 18:04:42 -0300
From: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
To: Vlad Buslov <vladbu@mellanox.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, jhs@mojatatu.com,
        xiyou.wangcong@gmail.com, jiri@resnulli.us, pablo@netfilter.org,
        kadlec@blackhole.kfki.hu, fw@strlen.de, ast@kernel.org,
        daniel@iogearbox.net, edumazet@google.com, keescook@chromium.org,
        linux-kernel@vger.kernel.org, netfilter-devel@vger.kernel.org,
        coreteam@netfilter.org, kliteyn@mellanox.com
Subject: Re: [PATCH 02/14] net: sched: change type of reference and bind
 counters
Message-ID: <20180519210442.GA5488@localhost.localdomain>
References: <1526308035-12484-1-git-send-email-vladbu@mellanox.com>
 <1526308035-12484-3-git-send-email-vladbu@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1526308035-12484-3-git-send-email-vladbu@mellanox.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 14, 2018 at 05:27:03PM +0300, Vlad Buslov wrote:
> Change type of action reference counter to refcount_t.
>
> Change type of action bind counter to atomic_t.
> This type is used to allow decrementing bind counter without testing
> for 0 result.

... and in what does not testing for 0 result helps?

  Marcelo
