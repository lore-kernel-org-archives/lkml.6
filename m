Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932110AbeENQ2q (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 12:28:46 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:51517 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753342AbeENQ2n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 12:28:43 -0400
X-Google-Smtp-Source: AB8JxZpxjro4QVnEHnPrrSRJoDKhE5EnhuzuZqTVNAUUjciUgT2DdQMW3bwfcsDyU/zKNKoBHiYKWQ==
Date: Mon, 14 May 2018 18:28:39 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Vlad Buslov <vladbu@mellanox.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, jhs@mojatatu.com,
        xiyou.wangcong@gmail.com, pablo@netfilter.org,
        kadlec@blackhole.kfki.hu, fw@strlen.de, ast@kernel.org,
        daniel@iogearbox.net, edumazet@google.com, keescook@chromium.org,
        linux-kernel@vger.kernel.org, netfilter-devel@vger.kernel.org,
        coreteam@netfilter.org, kliteyn@mellanox.com
Subject: Re: [PATCH 06/14] net: sched: implement reference counted action
 release
Message-ID: <20180514162839.GD2134@nanopsycho.orion>
References: <1526308035-12484-1-git-send-email-vladbu@mellanox.com>
 <1526308035-12484-7-git-send-email-vladbu@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1526308035-12484-7-git-send-email-vladbu@mellanox.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mon, May 14, 2018 at 04:27:07PM CEST, vladbu@mellanox.com wrote:
>Implement helper function to delete action using new action ops delete
>function implemented by each action for lockless execution.

Reading this sentense for 4 times. I still don't understand what you say :(

>
>Implement action put function that releases reference to action and frees

When you write "Implement action put function" it is cryptic. Just
say "Implement function __tcf_action_put()".


>it if necessary. Refactor action deletion code to use new put function and
>not to rely on rtnl lock. Remove rtnl lock assertions that are no longer
>needed.

[...]
