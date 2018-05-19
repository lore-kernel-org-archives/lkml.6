Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752522AbeESWUd (ORCPT <rfc822;w@1wt.eu>);
        Sat, 19 May 2018 18:20:33 -0400
Received: from mail-qt0-f196.google.com ([209.85.216.196]:46416 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752389AbeESWUb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 May 2018 18:20:31 -0400
X-Google-Smtp-Source: AB8JxZpxd2STYT9M8LofV1w9PQ9VKPU4ft4/WLVKNOnYBziR9554atIxSvZ4WgDLPFkl7cMp0SOR3w==
Date: Sat, 19 May 2018 19:20:28 -0300
From: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
To: Vlad Buslov <vladbu@mellanox.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, jhs@mojatatu.com,
        xiyou.wangcong@gmail.com, jiri@resnulli.us, pablo@netfilter.org,
        kadlec@blackhole.kfki.hu, fw@strlen.de, ast@kernel.org,
        daniel@iogearbox.net, edumazet@google.com, keescook@chromium.org,
        linux-kernel@vger.kernel.org, netfilter-devel@vger.kernel.org,
        coreteam@netfilter.org, kliteyn@mellanox.com
Subject: Re: [PATCH 13/14] net: sched: use unique idr insert function in
 unlocked actions
Message-ID: <20180519222028.GF5488@localhost.localdomain>
References: <1526308035-12484-1-git-send-email-vladbu@mellanox.com>
 <1526308035-12484-14-git-send-email-vladbu@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1526308035-12484-14-git-send-email-vladbu@mellanox.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 14, 2018 at 05:27:14PM +0300, Vlad Buslov wrote:
> Substitute calls to action insert function with calls to action insert
> unique function that warns if insertion overwrites index in idr.

I know this patch may be gone on V2, but a general comment, please use
the function names themselves instead of a textualized version. I.e.,
s/action insert unique/tcf_idr_insert_unique/
