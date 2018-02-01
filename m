Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754705AbeBAT3C (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Feb 2018 14:29:02 -0500
Received: from ex13-edg-ou-002.vmware.com ([208.91.0.190]:12867 "EHLO
        EX13-EDG-OU-002.vmware.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753368AbeBAT2x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Feb 2018 14:28:53 -0500
Date: Thu, 1 Feb 2018 11:28:52 -0800
From: Shrikrishna Khare <skhare@shri-linux.eng.vmware.com>
To: Colin King <colin.king@canonical.com>
CC: Shrikrishna Khare <skhare@vmware.com>, <pv-drivers@vmware.com>,
        <netdev@vger.kernel.org>, <kernel-janitors@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] vmxnet3: remove redundant initialization of pointer
 'rq'
In-Reply-To: <20180201172921.22770-1-colin.king@canonical.com>
Message-ID: <alpine.DEB.2.10.1802011125140.23969@shri-linux.eng.vmware.com>
References: <20180201172921.22770-1-colin.king@canonical.com>
User-Agent: Alpine 2.10 (DEB 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 1 Feb 2018, Colin King wrote:

> From: Colin Ian King <colin.king@canonical.com>
> 
> Pointer rq is being initialized but this value is never read, it
> is being updated inside a for-loop. Remove the initialization and
> move it into the scope of the for-loop.
> 
> Cleans up clang warning:
> drivers/net/vmxnet3/vmxnet3_drv.c:2763:27: warning: Value stored
> to 'rq' during its initialization is never read
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Acked-by: Shrikrishna Khare <skhare@vmware.com>
