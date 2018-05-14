Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754091AbeENPLP (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 11:11:15 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:33366 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932633AbeENPLL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 11:11:11 -0400
X-Google-Smtp-Source: AB8JxZqpUfdbpWRAk7HATNdoZtSqWkZaZcakiwor81gcuScvAZcfvTkQjsVYRPPcy0vUKn+XkCWR2Q==
Date: Mon, 14 May 2018 17:11:09 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Vlad Buslov <vladbu@mellanox.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, jhs@mojatatu.com,
        xiyou.wangcong@gmail.com, pablo@netfilter.org,
        kadlec@blackhole.kfki.hu, fw@strlen.de, ast@kernel.org,
        daniel@iogearbox.net, edumazet@google.com, keescook@chromium.org,
        linux-kernel@vger.kernel.org, netfilter-devel@vger.kernel.org,
        coreteam@netfilter.org, kliteyn@mellanox.com
Subject: Re: [PATCH 02/14] net: sched: change type of reference and bind
 counters
Message-ID: <20180514151109.GB1848@nanopsycho>
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

Mon, May 14, 2018 at 04:27:03PM CEST, vladbu@mellanox.com wrote:
>Change type of action reference counter to refcount_t.
>
>Change type of action bind counter to atomic_t.
>This type is used to allow decrementing bind counter without testing
>for 0 result.
>
>Signed-off-by: Vlad Buslov <vladbu@mellanox.com>

Signed-off-by: Jiri Pirko <jiri@mellanox.com>
