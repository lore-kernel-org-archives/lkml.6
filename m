Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932631AbeENPLC (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 11:11:02 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:36773 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753433AbeENPK7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 11:10:59 -0400
X-Google-Smtp-Source: AB8JxZqJsIHykYZ4CJtWdKGjceyf9VnXHu8kezKH5yTFD3Ye7U7utzOFM4sWKU5fdPqq9Hh6D5mNrA==
Date: Mon, 14 May 2018 17:10:56 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Vlad Buslov <vladbu@mellanox.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, jhs@mojatatu.com,
        xiyou.wangcong@gmail.com, pablo@netfilter.org,
        kadlec@blackhole.kfki.hu, fw@strlen.de, ast@kernel.org,
        daniel@iogearbox.net, edumazet@google.com, keescook@chromium.org,
        linux-kernel@vger.kernel.org, netfilter-devel@vger.kernel.org,
        coreteam@netfilter.org, kliteyn@mellanox.com
Subject: Re: [PATCH 01/14] net: sched: use rcu for action cookie update
Message-ID: <20180514151056.GA1848@nanopsycho>
References: <1526308035-12484-1-git-send-email-vladbu@mellanox.com>
 <1526308035-12484-2-git-send-email-vladbu@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1526308035-12484-2-git-send-email-vladbu@mellanox.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mon, May 14, 2018 at 04:27:02PM CEST, vladbu@mellanox.com wrote:
>Implement functions to atomically update and free action cookie
>using rcu mechanism.
>
>Signed-off-by: Vlad Buslov <vladbu@mellanox.com>

Signed-off-by: Jiri Pirko <jiri@mellanox.com>
