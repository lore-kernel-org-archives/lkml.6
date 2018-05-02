Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751678AbeEBNgM (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 09:36:12 -0400
Received: from mail-qk0-f177.google.com ([209.85.220.177]:33925 "EHLO
        mail-qk0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751637AbeEBNgI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 May 2018 09:36:08 -0400
X-Google-Smtp-Source: AB8JxZrclficC4iIuOcjqu0I9RJnYkEjsrdb/qUIrwve4ccQaWtnJUSry9IyamioYNJWR5zpjladBw==
Date: Wed, 2 May 2018 10:36:03 -0300
From: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
To: Michal Kubecek <mkubecek@suse.cz>
Cc: Xin Long <lucien.xin@gmail.com>, network dev <netdev@vger.kernel.org>,
        linux-sctp@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Vlad Yasevich <vyasevich@gmail.com>,
        Neil Horman <nhorman@tuxdriver.com>, Gang He <ghe@suse.com>,
        GuoQing Jiang <gqjiang@suse.com>
Subject: Re: non-blocking connect for kernel SCTP sockets
Message-ID: <20180502133603.GC5105@localhost.localdomain>
References: <20180502090639.j55mnclmkzdts6xb@unicorn.suse.cz>
 <CADvbK_fT5qYmOKHgBf6KWyuRcDUT3Fa8DyMQkN75C8PFkPKLXw@mail.gmail.com>
 <20180502123227.x7yucbi4lejj55o5@unicorn.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180502123227.x7yucbi4lejj55o5@unicorn.suse.cz>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 02, 2018 at 02:32:28PM +0200, Michal Kubecek wrote:
> On Wed, May 02, 2018 at 05:46:23PM +0800, Xin Long wrote:
...
> > It is a bug, https://bugzilla.redhat.com/show_bug.cgi?id=1251530
>
> Not authorized. :-)

Oups! I just made it public.

  Marcelo
