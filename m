Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935599AbeBLNj1 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 08:39:27 -0500
Received: from mx2.suse.de ([195.135.220.15]:52344 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932747AbeBLNj0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 08:39:26 -0500
Subject: Re: [PATCH 2/2] pvcalls-front: wait for other operations to return
 when release passive sockets
To: Stefano Stabellini <sstabellini@kernel.org>,
        boris.ostrovsky@oracle.com
Cc: xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        Stefano Stabellini <stefano@aporeto.com>
References: <alpine.DEB.2.10.1802051448460.10160@sstabellini-ThinkPad-X260>
 <1517871107-15349-1-git-send-email-sstabellini@kernel.org>
 <1517871107-15349-2-git-send-email-sstabellini@kernel.org>
From: Juergen Gross <jgross@suse.com>
Message-ID: <e2d6f037-cb0c-7669-0efc-c1e9bcf69a07@suse.com>
Date: Mon, 12 Feb 2018 14:39:24 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1517871107-15349-2-git-send-email-sstabellini@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/02/18 23:51, Stefano Stabellini wrote:
> Passive sockets can have ongoing operations on them, specifically, we
> have two wait_event_interruptable calls in pvcalls_front_accept.
> 
> Add two wake_up calls in pvcalls_front_release, then wait for the
> potential waiters to return and release the sock_mapping refcount.
> 
> Signed-off-by: Stefano Stabellini <stefano@aporeto.com>

Acked-by: Juergen Gross <jgross@suse.com>


Juergen
