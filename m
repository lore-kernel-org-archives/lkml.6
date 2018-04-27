Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933129AbeD0XZ0 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 27 Apr 2018 19:25:26 -0400
Received: from ms.lwn.net ([45.79.88.28]:55466 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933033AbeD0XZZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Apr 2018 19:25:25 -0400
Date: Fri, 27 Apr 2018 17:25:23 -0600
From: Jonathan Corbet <corbet@lwn.net>
To: Mike Rapoport <rppt@linux.vnet.ibm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        linux-doc <linux-doc@vger.kernel.org>, linux-mm <linux-mm@kvack.org>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/7] docs/vm: update KSM documentation
Message-ID: <20180427172523.746d2ffd@lwn.net>
In-Reply-To: <1524552028-7017-1-git-send-email-rppt@linux.vnet.ibm.com>
References: <1524552028-7017-1-git-send-email-rppt@linux.vnet.ibm.com>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 24 Apr 2018 09:40:21 +0300
Mike Rapoport <rppt@linux.vnet.ibm.com> wrote:

> These patches extend KSM documentation with high level design overview and
> some details about reverse mappings and split the userspace interface
> description to Documentation/admin-guide/mm.
> 
> The description of some KSM sysfs attributes is changed so that it won't
> include implementation detail. The description of these implementation
> details are moved to the new "Design" section.
> 
> The last patch in the series depends on the patchset that create
> Documentation/admin-guide/mm [1], all the rest applies cleanly to the
> current docs-next.

I've applied the set, thanks.

jon
