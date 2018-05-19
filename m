Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752533AbeESWfx (ORCPT <rfc822;w@1wt.eu>);
        Sat, 19 May 2018 18:35:53 -0400
Received: from mail-qt0-f193.google.com ([209.85.216.193]:36956 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752407AbeESWfv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 May 2018 18:35:51 -0400
X-Google-Smtp-Source: AB8JxZp4oHJJ2K5cA+jnIaIXaUcqPY89vFidWU0k8NDItfBEb+VdzoFLIxkGGYgbUhAayFODjxYHaA==
Date: Sat, 19 May 2018 19:35:46 -0300
From: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
To: Jiri Pirko <jiri@resnulli.us>
Cc: Vlad Buslov <vladbu@mellanox.com>, netdev@vger.kernel.org,
        davem@davemloft.net, jhs@mojatatu.com, xiyou.wangcong@gmail.com,
        pablo@netfilter.org, kadlec@blackhole.kfki.hu, fw@strlen.de,
        ast@kernel.org, daniel@iogearbox.net, edumazet@google.com,
        keescook@chromium.org, linux-kernel@vger.kernel.org,
        netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
        kliteyn@mellanox.com
Subject: Re: [PATCH 12/14] net: sched: retry action check-insert on
 concurrent modification
Message-ID: <20180519223546.GG5488@localhost.localdomain>
References: <1526308035-12484-1-git-send-email-vladbu@mellanox.com>
 <1526308035-12484-13-git-send-email-vladbu@mellanox.com>
 <20180516095953.GI1972@nanopsycho>
 <vbf4lj724th.fsf@reg-r-vrt-018-180.mtr.labs.mlnx>
 <20180516122600.GM1972@nanopsycho>
 <vbfwow322k1.fsf@reg-r-vrt-018-180.mtr.labs.mlnx>
 <20180516132135.GN1972@nanopsycho>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180516132135.GN1972@nanopsycho>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 16, 2018 at 03:21:35PM +0200, Jiri Pirko wrote:
...
> int tcf_idr_check_alloc(struct tc_action_net *tn, u32 *index,
> 			struct tc_action **a, int bind)

Considering we don't have any other variant of it, maybe just
"tcf_idr_alloc()" instead?
