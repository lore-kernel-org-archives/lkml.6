Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753479AbeCTNQL (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 09:16:11 -0400
Received: from mx2.suse.de ([195.135.220.15]:57878 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753019AbeCTNQI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 09:16:08 -0400
Date: Tue, 20 Mar 2018 14:16:05 +0100 (CET)
From: Miroslav Benes <mbenes@suse.cz>
To: Joe Lawrence <joe.lawrence@redhat.com>
cc: Petr Mladek <pmladek@suse.com>, Jiri Kosina <jikos@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>, Jason Baron <jbaron@akamai.com>,
        Jessica Yu <jeyu@kernel.org>,
        Evgenii Shatokhin <eshatokhin@virtuozzo.com>,
        live-patching@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v10 00/10] livepatch: Atomic replace feature
In-Reply-To: <1520881024-29386-1-git-send-email-joe.lawrence@redhat.com>
Message-ID: <alpine.LSU.2.21.1803201413480.1312@pobox.suse.cz>
References: <2f94c399-fe72-58f9-bd63-b08c46bb47b3@redhat.com> <1520881024-29386-1-git-send-email-joe.lawrence@redhat.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 12 Mar 2018, Joe Lawrence wrote:

> These are the callback tests that I hacked up into a livepatch
> kselftest.  (Basically I copied a bunch of the sample modules and
> verified the expected dmesg output as I had listed in in the
> Documentation/livepatch/callbacks.txt file.)  The script is still a
> little rough and maybe this isn't the direction we want to go for proper
> kselftests, but perhaps it saves you some time/sanity for verifying this
> patchset.
> 
> Hope this helps,

Hi Joe,

it helps a lot. Thanks for implementing it.

Miroslav
