Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752903AbeEUP1p (ORCPT <rfc822;w@1wt.eu>);
        Mon, 21 May 2018 11:27:45 -0400
Received: from ms.lwn.net ([45.79.88.28]:47454 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752311AbeEUP1n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 May 2018 11:27:43 -0400
Date: Mon, 21 May 2018 09:27:41 -0600
From: Jonathan Corbet <corbet@lwn.net>
To: Mike Rapoport <rppt@linux.vnet.ibm.com>
Cc: linux-doc <linux-doc@vger.kernel.org>, linux-mm <linux-mm@kvack.org>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/3] docs/vm: transhuge: split userspace bits to
 admin-guide/mm
Message-ID: <20180521092741.40f2cbd7@lwn.net>
In-Reply-To: <1526285620-453-1-git-send-email-rppt@linux.vnet.ibm.com>
References: <1526285620-453-1-git-send-email-rppt@linux.vnet.ibm.com>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 14 May 2018 11:13:37 +0300
Mike Rapoport <rppt@linux.vnet.ibm.com> wrote:

> Here are minor updates to transparent hugepage docs. Except from minor
> formatting and spelling updates, these patches re-arrange the transhuge.rst
> so that userspace interface description will not be interleaved with the
> implementation details and it would be possible to split the userspace
> related bits to Documentation/admin-guide/mm, which is done by the third
> patch.

Looks good, I've applied the set, after adding a changelog for #3.

Thanks,

jon
