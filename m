Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753998AbeE3Qoa (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 12:44:30 -0400
Received: from mail-yw0-f196.google.com ([209.85.161.196]:45069 "EHLO
        mail-yw0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753560AbeE3QoY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 12:44:24 -0400
X-Google-Smtp-Source: ADUXVKK5Rra1JvfHeKEezV019zr2xTrYhDIOh1PJ29GZsOkms9GuMK2UbCn216OXWvisePagjpfipQ==
Date: Wed, 30 May 2018 09:44:21 -0700
From: Tejun Heo <tj@kernel.org>
To: Josef Bacik <josef@toxicpanda.com>
Cc: axboe@kernel.dk, kernel-team@fb.com, linux-block@vger.kernel.org,
        akpm@linux-foundation.org, linux-mm@kvack.org, hannes@cmpxchg.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Josef Bacik <jbacik@fb.com>
Subject: Re: [PATCH 13/13] Documentation: add a doc for blk-iolatency
Message-ID: <20180530164421.GQ1351649@devbig577.frc2.facebook.com>
References: <20180529211724.4531-1-josef@toxicpanda.com>
 <20180529211724.4531-14-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180529211724.4531-14-josef@toxicpanda.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Tue, May 29, 2018 at 05:17:24PM -0400, Josef Bacik wrote:
> diff --git a/Documentation/blk-iolatency.txt b/Documentation/blk-iolatency.txt
> new file mode 100644
> index 000000000000..9dd86f4f64b6
> --- /dev/null
> +++ b/Documentation/blk-iolatency.txt

Can you make it a part of Documentation/cgroup-v2.txt?

> +Interface
> +=========
> +
> +- io.latency.  This takes a similar format as the other controllers
> +
> +	"MAJOR:MINOR target=<target time in microseconds"
                                                        >

> +HOWTO
> +=====
> +
> +The limits are only applied at the peer level in the heirarchy.  This means that
							^hierarchy

Thanks.

-- 
tejun
