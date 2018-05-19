Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752199AbeESC7o (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 22:59:44 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:46883 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751323AbeESC7l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 22:59:41 -0400
X-Google-Smtp-Source: AB8JxZq9J2gjgztKxcs43Eyv7Z6ZSaoe1uLtfrd0xWhkafQdvi8HX0fDdd3HMi7F2I2MdUjUiN6/GPY7zW9RQydmb20=
MIME-Version: 1.0
In-Reply-To: <1526658324-6570-1-git-send-email-vladbu@mellanox.com>
References: <1526658324-6570-1-git-send-email-vladbu@mellanox.com>
From: Cong Wang <xiyou.wangcong@gmail.com>
Date: Fri, 18 May 2018 19:59:20 -0700
Message-ID: <CAM_iQpUKjFPKAONSW42_6Mdp-VTTvaOx-GPDH2bJqW7LW1QYBw@mail.gmail.com>
Subject: Re: [PATCH] net: sched: don't disable bh when accessing action idr
To: Vlad Buslov <vladbu@mellanox.com>
Cc: Linux Kernel Network Developers <netdev@vger.kernel.org>,
        Jamal Hadi Salim <jhs@mojatatu.com>, Jiri Pirko <jiri@resnulli.us>,
        David Miller <davem@davemloft.net>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 18, 2018 at 8:45 AM, Vlad Buslov <vladbu@mellanox.com> wrote:
> Underlying implementation of action map has changed and doesn't require
> disabling bh anymore. Replace all action idr spinlock usage with regular
> calls that do not disable bh.

Please explain explicitly why it is not required, don't let people
dig, this would save everyone's time.

Also, this should be targeted for net-next, right?

Thanks.
