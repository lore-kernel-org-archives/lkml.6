Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751964AbeCUI0h (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Mar 2018 04:26:37 -0400
Received: from mail-pl0-f49.google.com ([209.85.160.49]:40995 "EHLO
        mail-pl0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751879AbeCUI0d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Mar 2018 04:26:33 -0400
X-Google-Smtp-Source: AG47ELv2G48lVH7SB6KZaFtgFKjF1ssR4fczsnBgz4dE5O9QWIuoTujMouF/gszjJVncFcoYzKxKiQ==
Date: Wed, 21 Mar 2018 17:26:28 +0900
From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To: Nick Terrell <terrelln@fb.com>,
        Maninder Singh <maninder1.s@samsung.com>
Cc: herbert@gondor.apana.org.au, davem@davemloft.net, minchan@kernel.org,
        ngupta@vflare.org, sergey.senozhatsky.work@gmail.com,
        keescook@chromium.org, anton@enomsg.org, ccross@android.com,
        tony.luck@intel.com, akpm@linux-foundation.org,
        colin.king@canonical.com, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, pankaj.m@samsung.com,
        a.sahrawat@samsung.com, v.narang@samsung.com
Subject: Re: [PATCH 0/1] cover-letter/lz4: Implement lz4 with dynamic offset
 length.
Message-ID: <20180321082628.GB2746@jagdpanzerIV>
References: <CGME20180321044137epcas5p221e7ee4a0b7464eaa00dad8320f0251d@epcas5p2.samsung.com>
 <1521607242-3968-1-git-send-email-maninder1.s@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1521607242-3968-1-git-send-email-maninder1.s@samsung.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CC-ing Nick

Nick, can you take a look?

Message-IDs:
lkml.kernel.org/r/1521607242-3968-1-git-send-email-maninder1.s@samsung.com
lkml.kernel.org/r/1521607242-3968-2-git-send-email-maninder1.s@samsung.com

	-ss
