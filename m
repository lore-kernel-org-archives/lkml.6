Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753196AbeE1FW1 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 01:22:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:48328 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750765AbeE1FWY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 01:22:24 -0400
Date: Mon, 28 May 2018 07:22:02 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: nixiaoming <nixiaoming@huawei.com>
Cc: schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com,
        akpm@linux-foundation.org, vbabka@suse.cz, mhocko@suse.com,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: Re: [PATCH 3/3] s390:add missing CONFIG_STRICT_KERNEL_RWX for
 mark_rodata_ro
Message-ID: <20180528052202.GA1894@kroah.com>
References: <20180528033355.54815-1-nixiaoming@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180528033355.54815-1-nixiaoming@huawei.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 28, 2018 at 11:33:55AM +0800, nixiaoming wrote:
> Signed-off-by: nixiaoming <nixiaoming@huawei.com>

Please do not submit patches without any changelog text.  I do not
accept such patches, but other maintainers might be easier...

greg k-h
