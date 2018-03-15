Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751829AbeCOKf6 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 06:35:58 -0400
Received: from mx2.suse.de ([195.135.220.15]:54399 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751470AbeCOKf4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 06:35:56 -0400
Subject: Re: [PATCH v2 2/3] xen: xenbus: Catch closing of non existent
 transactions
To: Simon Gaiser <simon@invisiblethingslab.com>,
        xen-devel@lists.xenproject.org
Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        linux-kernel@vger.kernel.org
References: <20180315024322.27429-1-simon@invisiblethingslab.com>
 <20180315024322.27429-2-simon@invisiblethingslab.com>
From: Juergen Gross <jgross@suse.com>
Message-ID: <993d84d7-c901-6365-0392-600e320a1d24@suse.com>
Date: Thu, 15 Mar 2018 11:34:02 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180315024322.27429-2-simon@invisiblethingslab.com>
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/03/18 03:43, Simon Gaiser wrote:
> Users of the xenbus functions should never close a non existent
> transaction (for example by trying to closing the same transaction
> twice) but better catch it in xs_request_exit() than to corrupt the
> reference counter.
> 
> Signed-off-by: Simon Gaiser <simon@invisiblethingslab.com>

Reviewed-by: Juergen Gross <jgross@suse.com>


Juergen
