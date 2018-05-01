Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752355AbeEAIA2 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 1 May 2018 04:00:28 -0400
Received: from smtp.ctxuk.citrix.com ([185.25.65.24]:34264 "EHLO
        SMTP.EU.CITRIX.COM" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751171AbeEAIAX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 May 2018 04:00:23 -0400
X-IronPort-AV: E=Sophos;i="5.49,350,1520899200";
   d="scan'208";a="72417881"
Date: Tue, 1 May 2018 09:00:09 +0100
From: Roger Pau =?utf-8?B?TW9ubsOp?= <roger.pau@citrix.com>
To: Boris Ostrovsky <boris.ostrovsky@oracle.com>
CC: <linux-kernel@vger.kernel.org>, <xen-devel@lists.xenproject.org>,
        <jgross@suse.com>
Subject: Re: [Xen-devel] [PATCH 4/4] xen/PVH: Remove reserved entry in PVH GDT
Message-ID: <20180501080009.wnjmno5pietptixo@MacBook-Pro-de-Roger.local>
References: <20180430162339.17143-1-boris.ostrovsky@oracle.com>
 <20180430162339.17143-5-boris.ostrovsky@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20180430162339.17143-5-boris.ostrovsky@oracle.com>
User-Agent: NeoMutt/20180323
X-ClientProxiedBy: AMSPEX02CAS02.citrite.net (10.69.22.113) To
 AMSPEX02CL02.citrite.net (10.69.22.126)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 30, 2018 at 12:23:39PM -0400, Boris Ostrovsky wrote:
> And without it we can't use _BOOT_XX macros any longer so define new ones.

Not being that familiar with Linux internals I'm not sure I see the
benefit of this. Isn't there a risk that some other code is going to
use the __BOOT_XX defines?

Thanks, Roger.
