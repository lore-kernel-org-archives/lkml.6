Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1165633AbeBOR2v (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Feb 2018 12:28:51 -0500
Received: from mx2.suse.de ([195.135.220.15]:32926 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1165016AbeBOR2t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Feb 2018 12:28:49 -0500
Subject: Re: [PATCH v3 0/2] pvcalls-front improvements
To: Stefano Stabellini <sstabellini@kernel.org>,
        boris.ostrovsky@oracle.com
Cc: xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org
References: <alpine.DEB.2.10.1802141023400.5392@sstabellini-ThinkPad-X260>
From: Juergen Gross <jgross@suse.com>
Message-ID: <320c6565-b003-ad4c-dcb0-f4eda4ed456f@suse.com>
Date: Thu, 15 Feb 2018 18:28:47 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.10.1802141023400.5392@sstabellini-ThinkPad-X260>
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/02/18 19:26, Stefano Stabellini wrote:
> Hi all,
> 
> this small series introduces a per socket refcount to increase the
> efficiency on socket release operations, and makes releasing passive
> sockets safe.
> 
> Cheers,
> 
> Stefano
> 
> 
> Changes in v3:
> - remove pointless initializers
> - reorder pvcalls_enter_sock
> 
> Changes in v2:
> - add acked-by
> - fix check in pvcalls_enter_soc
> - fix code style
> - nicer checks in pvcalls_front_release
> 
> 
> Stefano Stabellini (2):
>       pvcalls-front: introduce a per sock_mapping refcount
>       pvcalls-front: wait for other operations to return when release passive sockets

Both patches committed to xen/tip.git for-linus-4.16


Juergen
