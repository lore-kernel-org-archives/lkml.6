Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933033AbeBVPYD (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 10:24:03 -0500
Received: from mx2.suse.de ([195.135.220.15]:35294 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932948AbeBVPX7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 10:23:59 -0500
Date: Thu, 22 Feb 2018 16:23:57 +0100 (CET)
From: Miroslav Benes <mbenes@suse.cz>
To: Petr Mladek <pmladek@suse.com>
cc: Jiri Kosina <jikos@kernel.org>, Josh Poimboeuf <jpoimboe@redhat.com>,
        Jason Baron <jbaron@akamai.com>,
        Joe Lawrence <joe.lawrence@redhat.com>, Jessica Yu <jeyu@kernel.org>,
        Evgenii Shatokhin <eshatokhin@virtuozzo.com>,
        live-patching@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 0/8] livepatch: Atomic replace feature
In-Reply-To: <20180221132914.4809-1-pmladek@suse.com>
Message-ID: <alpine.LSU.2.21.1802221621340.12659@pobox.suse.cz>
References: <20180221132914.4809-1-pmladek@suse.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> I have found one bug in v7. We were not able to initialize NOP
> struct klp_func when the patches module is not loaded. It was
> because func->new_func was NULL. I have fixed it in separate patch
> for an easier review.

This is embarassing. I'd swear I tested this. At least it was a part of my 
tests. So I made a mistake somewhere :/

Thanks for fixing it.

Miroslav
