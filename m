Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1166509AbeBOSaM (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Feb 2018 13:30:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:43854 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1163154AbeBOSaK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Feb 2018 13:30:10 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61C3F2171F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=sstabellini@kernel.org
Date: Thu, 15 Feb 2018 10:30:07 -0800 (PST)
From: Stefano Stabellini <sstabellini@kernel.org>
X-X-Sender: sstabellini@sstabellini-ThinkPad-X260
To: Juergen Gross <jgross@suse.com>
cc: Stefano Stabellini <sstabellini@kernel.org>,
        boris.ostrovsky@oracle.com, xen-devel@lists.xenproject.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/2] pvcalls-front improvements
In-Reply-To: <320c6565-b003-ad4c-dcb0-f4eda4ed456f@suse.com>
Message-ID: <alpine.DEB.2.10.1802151030010.5392@sstabellini-ThinkPad-X260>
References: <alpine.DEB.2.10.1802141023400.5392@sstabellini-ThinkPad-X260> <320c6565-b003-ad4c-dcb0-f4eda4ed456f@suse.com>
User-Agent: Alpine 2.10 (DEB 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 15 Feb 2018, Juergen Gross wrote:
> On 14/02/18 19:26, Stefano Stabellini wrote:
> > Hi all,
> > 
> > this small series introduces a per socket refcount to increase the
> > efficiency on socket release operations, and makes releasing passive
> > sockets safe.
> > 
> > Cheers,
> > 
> > Stefano
> > 
> > 
> > Changes in v3:
> > - remove pointless initializers
> > - reorder pvcalls_enter_sock
> > 
> > Changes in v2:
> > - add acked-by
> > - fix check in pvcalls_enter_soc
> > - fix code style
> > - nicer checks in pvcalls_front_release
> > 
> > 
> > Stefano Stabellini (2):
> >       pvcalls-front: introduce a per sock_mapping refcount
> >       pvcalls-front: wait for other operations to return when release passive sockets
> 
> Both patches committed to xen/tip.git for-linus-4.16

Thank you!
