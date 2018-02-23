Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751846AbeBWPIT (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Feb 2018 10:08:19 -0500
Received: from verein.lst.de ([213.95.11.211]:33077 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751407AbeBWPIR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Feb 2018 10:08:17 -0500
Date: Fri, 23 Feb 2018 16:08:16 +0100
From: Christoph Hellwig <hch@lst.de>
To: Nikolay Borisov <nborisov@suse.com>
Cc: viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, axboe@kernel.dk, hch@lst.de,
        rgoldwyn@suse.de
Subject: Re: [PATCH 2/2] direct-io: Remove unused DIO_SKIP_DIO_COUNT logic
Message-ID: <20180223150816.GB16628@lst.de>
References: <1519386329-2734-1-git-send-email-nborisov@suse.com> <1519386329-2734-2-git-send-email-nborisov@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1519386329-2734-2-git-send-email-nborisov@suse.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Looks fine,

Reviewed-by: Christoph Hellwig <hch@lst.de>
