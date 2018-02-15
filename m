Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755395AbeBOJtd (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Feb 2018 04:49:33 -0500
Received: from mx2.suse.de ([195.135.220.15]:37222 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755338AbeBOJt2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Feb 2018 04:49:28 -0500
Subject: Re: [PATCH v3 1/2] pvcalls-front: introduce a per sock_mapping
 refcount
To: Stefano Stabellini <sstabellini@kernel.org>,
        boris.ostrovsky@oracle.com
Cc: xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        Stefano Stabellini <stefano@aporeto.com>
References: <alpine.DEB.2.10.1802141023400.5392@sstabellini-ThinkPad-X260>
 <1518632904-20267-1-git-send-email-sstabellini@kernel.org>
From: Juergen Gross <jgross@suse.com>
Message-ID: <22b701d1-6ce1-2b15-f5da-9ad2545641ac@suse.com>
Date: Thu, 15 Feb 2018 10:49:26 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1518632904-20267-1-git-send-email-sstabellini@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/02/18 19:28, Stefano Stabellini wrote:
> Introduce a per sock_mapping refcount, in addition to the existing
> global refcount. Thanks to the sock_mapping refcount, we can safely wait
> for it to be 1 in pvcalls_front_release before freeing an active socket,
> instead of waiting for the global refcount to be 1.
> 
> Signed-off-by: Stefano Stabellini <stefano@aporeto.com>

Acked-by: Juergen Gross <jgross@suse.com>


Juergen
