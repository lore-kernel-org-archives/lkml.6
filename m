Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752514AbeDQHdj (ORCPT <rfc822;w@1wt.eu>);
        Tue, 17 Apr 2018 03:33:39 -0400
Received: from mx2.suse.de ([195.135.220.15]:40294 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752145AbeDQHdi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Apr 2018 03:33:38 -0400
Subject: Re: [PATCH] xen: xenbus_dev_frontend: Really return response string
To: Simon Gaiser <simon@invisiblethingslab.com>,
        xen-devel@lists.xenproject.org
Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        linux-kernel@vger.kernel.org
References: <20180315030803.27781-1-simon@invisiblethingslab.com>
From: Juergen Gross <jgross@suse.com>
Message-ID: <8eb5cb63-c733-a543-be6d-cf7348f5092a@suse.com>
Date: Tue, 17 Apr 2018 09:33:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180315030803.27781-1-simon@invisiblethingslab.com>
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/03/18 04:08, Simon Gaiser wrote:
> xenbus_command_reply() did not actually copy the response string and
> leaked stack content instead.
> 
> Fixes: 9a6161fe73bd ("xen: return xenstore command failures via response instead of rc")
> Signed-off-by: Simon Gaiser <simon@invisiblethingslab.com>

Reviewed-by: Juergen Gross <jgross@suse.com>


Juergen
