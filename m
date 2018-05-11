Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752142AbeEKCZD (ORCPT <rfc822;w@1wt.eu>);
        Thu, 10 May 2018 22:25:03 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:41719 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751764AbeEKCZB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 May 2018 22:25:01 -0400
X-Google-Smtp-Source: AB8JxZr0HGApQNbMZMzpIILUYitpS/qBdFPPaJ1He81mXOyiPZKwf82KbjT+e90pwyess9jF8vKMVw==
Date: Fri, 11 May 2018 11:24:57 +0900
From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To: Joe Perches <joe@perches.com>
Cc: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 03/18] printk: Convert pr_fmt from blank define to
 KBUILD_MODNAME
Message-ID: <20180511022457.GB491@jagdpanzerIV>
References: <cover.1525964381.git.joe@perches.com>
 <deb55d864f0bf266e019a74456612db36f8921a9.1525964383.git.joe@perches.com>
 <20180511015140.GB895@jagdpanzerIV>
 <18d24efb4d5dafae2360cb2103b366098311998a.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <18d24efb4d5dafae2360cb2103b366098311998a.camel@perches.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (05/10/18 18:57), Joe Perches wrote:
> 
> What about them?
> 
> All those defines above are non-generic as they are
> specified to start with "OF: " and then some optional
> extra bit.
> 
> Why should these defines be updated or modified?

Nevermind, my bad. I, for some reason, assumed that you were going
to drop all of those pr_fmt, but you obviously was speaking only
about those that have "KBUILD_MODNAME".

	-ss
