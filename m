Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751343AbeEDDpT (ORCPT <rfc822;w@1wt.eu>);
        Thu, 3 May 2018 23:45:19 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:46164 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751236AbeEDDpS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 May 2018 23:45:18 -0400
X-Google-Smtp-Source: AB8JxZpOZKm86a14xzNXlStUpE/K+WDwbTQz68r+cdC1aDKb7GsDrK/s93knuSWlTVimLqC/mkKMhQ==
Date: Fri, 4 May 2018 11:45:06 +0800
From: Hangbin Liu <liuhangbin@gmail.com>
To: syzbot <syzbot+e51e2a7401ab556ffde1@syzkaller.appspotmail.com>
Cc: davem@davemloft.net, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org, netdev@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, ubraun@linux.vnet.ibm.com
Subject: Re: possible deadlock in smc_close_non_accepted
Message-ID: <20180504034505.GD8958@leo.usersys.redhat.com>
References: <001a114218b2f8c0fe05666a2fb6@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <001a114218b2f8c0fe05666a2fb6@google.com>
User-Agent: Mutt/1.7.0 (2016-08-17)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

#syz fix: net/smc: simplify wait when closing listen socket
