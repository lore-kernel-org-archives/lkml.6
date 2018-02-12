Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753781AbeBLPux (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 10:50:53 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:51137 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753159AbeBLPuv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 10:50:51 -0500
X-IronPort-AV: E=Sophos;i="5.46,501,1511798400";
   d="scan'208";a="71266092"
Subject: Re: [PATCH] blk: optimization for classic polling
To: Nitesh Shetty <nj.shetty@samsung.com>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, viro@zeniv.linux.org.uk
Cc: linux-block@vger.kernel.org, axboe@fb.com,
        linux-nvme@lists.infradead.org, joshi.k@samsung.com
References: <CGME20180208143655epcas1p444bf34705526b7839a5a135f82761aad@epcas1p4.samsung.com>
 <3578876466-3733-1-git-send-email-nj.shetty@samsung.com>
From: Bart Van Assche <bart.vanassche@wdc.com>
Message-ID: <3efa5f64-27e8-1c2e-233e-5813c6c8493c@wdc.com>
Date: Mon, 12 Feb 2018 07:50:50 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <3578876466-3733-1-git-send-email-nj.shetty@samsung.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/29/83 20:21, Nitesh Shetty wrote:
> [ ... ]

Hello Nitesh,

Can you check the clock of the system you used to send this e-mail? In 
the header of your e-mail I found the following:

Date: Sun, 30 May 2083 09:51:06 +0530

Thanks,

Bart.
