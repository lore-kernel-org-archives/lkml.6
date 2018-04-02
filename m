Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754496AbeDBUs5 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 2 Apr 2018 16:48:57 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:4804 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753393AbeDBUsz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Apr 2018 16:48:55 -0400
X-IronPort-AV: E=Sophos;i="5.48,397,1517846400";
   d="scan'208";a="75769502"
Subject: Re: [PATCH 1/2] blk-mq: Factor out [s]rcu synchronization
To: Tejun Heo <tj@kernel.org>, Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
References: <20180402190053.GC388343@devbig577.frc2.facebook.com>
From: Bart Van Assche <bart.vanassche@wdc.com>
Message-ID: <f3ad5e36-11b8-2371-d634-a97280c4407e@wdc.com>
Date: Mon, 2 Apr 2018 13:48:54 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180402190053.GC388343@devbig577.frc2.facebook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/02/18 12:00, Tejun Heo wrote:
> Factor out [s]rcu synchronization in blk_mq_timeout_work() into
> blk_mq_timeout_sync_rcu().  This is to add another user in the future
> and doesn't cause any functional changes.

Reviewed-by: Bart Van Assche <bart.vanassche@wdc.com>
