Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752345AbeDIMXr (ORCPT <rfc822;w@1wt.eu>);
        Mon, 9 Apr 2018 08:23:47 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:35450 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752200AbeDIMXq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Apr 2018 08:23:46 -0400
Date: Mon, 9 Apr 2018 20:23:31 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Li Wang <liwang@redhat.com>
Cc: Stefan Haberland <sth@linux.vnet.ibm.com>,
        Jan Hoeppner <hoeppner@linux.vnet.ibm.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Mikulas Patocka <mpatocka@redhat.com>, linux-kernel@vger.kernel.org,
        Xiao Ni <xni@redhat.com>
Subject: Re: [s390x] New regression was found on kernel-4.16
Message-ID: <20180409122330.GB31165@ming.t460p>
References: <CAEemH2d_0DCUR9jnwu7ka-ngQBASuCOYMK5hd2oX582pF6fogQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEemH2d_0DCUR9jnwu7ka-ngQBASuCOYMK5hd2oX582pF6fogQ@mail.gmail.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Li Wang,

On Mon, Apr 09, 2018 at 06:18:04PM +0800, Li Wang wrote:
> Hi,
> 
> I got this BUG_ON() on s390x platform with kernel-v4.16.0.

Today I saw this bug too, from my first look, seems it is because
that get_max_io_size() returns zero in blk_bio_segment_split().

And I trigger that in one MD queue, and Xiao Ni is looking at it.

Thanks,
Ming
