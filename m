Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755636AbeEaQcw (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 12:32:52 -0400
Received: from verein.lst.de ([213.95.11.211]:39001 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755456AbeEaQcu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 12:32:50 -0400
Date: Thu, 31 May 2018 18:39:19 +0200
From: Christoph Hellwig <hch@lst.de>
To: Colin King <colin.king@canonical.com>
Cc: Benjamin LaHaise <bcrl@kvack.org>, Christoph Hellwig <hch@lst.de>,
        linux-fsdevel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] aio: fix missing break in switch statement
Message-ID: <20180531163919.GB31181@lst.de>
References: <20180530180415.17572-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180530180415.17572-1-colin.king@canonical.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 30, 2018 at 07:04:15PM +0100, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> The addition of the IOCB_CMD_POLL command removed the break
> statement for the IOCM_CMD_FDSYNC. From my understanding, this
> should not have been removed as the fall-through does not seem
> to make sense.  Fix this by adding the break back again.
> 
> Detected by CoverityScan, CID#1469469 ("Missing break in switch")

Thanks.  I've actually send a fix to Al for this a few days ago
already.
