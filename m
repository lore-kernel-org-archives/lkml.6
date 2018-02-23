Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752002AbeBWPIB (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Feb 2018 10:08:01 -0500
Received: from verein.lst.de ([213.95.11.211]:33069 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751407AbeBWPH6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Feb 2018 10:07:58 -0500
Date: Fri, 23 Feb 2018 16:07:57 +0100
From: Christoph Hellwig <hch@lst.de>
To: Nikolay Borisov <nborisov@suse.com>
Cc: viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, axboe@kernel.dk, hch@lst.de,
        rgoldwyn@suse.de
Subject: Re: [PATCH 1/2] direct-io: Remove unused DIO_ASYNC_EXTEND flag
Message-ID: <20180223150757.GA16628@lst.de>
References: <1519386329-2734-1-git-send-email-nborisov@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1519386329-2734-1-git-send-email-nborisov@suse.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Looks fine,

Reviewed-by: Christoph Hellwig <hch@lst.de>
