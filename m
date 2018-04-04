Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751672AbeDDSmx (ORCPT <rfc822;w@1wt.eu>);
        Wed, 4 Apr 2018 14:42:53 -0400
Received: from h2.hallyn.com ([78.46.35.8]:49576 "EHLO mail.hallyn.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751593AbeDDSmw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Apr 2018 14:42:52 -0400
Date: Wed, 4 Apr 2018 13:42:50 -0500
From: "Serge E. Hallyn" <serge@hallyn.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Alban Crequy <alban.crequy@gmail.com>,
        Iago Lopez Galeiras <iago@kinvolk.io>,
        containers@lists.linux-foundation.org,
        Daniel J Walsh <dwalsh@redhat.com>,
        Akihiro Suda <suda.akihiro@lab.ntt.co.jp>,
        linux-kernel@vger.kernel.org, Michael Crosby <crosbymichael@gmail.com>,
        Stephen J Day <stephen.day@docker.com>,
        Alban Crequy <alban@kinvolk.io>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, Jess Frazelle <acidburn@microsoft.com>
Subject: Re: [PATCH] [RFC][WIP] namespace.c: Allow some unprivileged proc
 mounts when not fully visible
Message-ID: <20180404184250.GA9997@mail.hallyn.com>
References: <20180404115311.725-1-alban@kinvolk.io>
 <87tvsrjai0.fsf@xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87tvsrjai0.fsf@xmission.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Eric W. Biederman (ebiederm@xmission.com):
> It looks like a cruft free cousin of proc that is just processes would
> be applicable to your usecase.

Just to check - is that something you're working on?

-serge
