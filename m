Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752026AbeCVEcj (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Mar 2018 00:32:39 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:46995 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751843AbeCVEcg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Mar 2018 00:32:36 -0400
X-Google-Smtp-Source: AG47ELsqtzDyhbyo07EZwIL1Es7nGUSO6Wsecf/o7o47MA7+LtzpB2V2NndaSHtuYv4qFsEt9xCCTA==
Date: Thu, 22 Mar 2018 13:32:30 +0900
From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To: Nick Terrell <terrelln@fb.com>
Cc: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        kernel-team@fb.com, Chris Mason <clm@fb.com>,
        Herbert Xu <herbert@gondor.apana.org.au>, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org, Geliang Tang <geliangtang@gmail.com>
Subject: Re: [RESEND PATCH] crypto: Add zstd support
Message-ID: <20180322043230.GD3181@jagdpanzerIV>
References: <20180321224929.3076350-1-terrelln@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180321224929.3076350-1-terrelln@fb.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (03/21/18 15:49), Nick Terrell wrote:
> depends on CONFIG_CRYPTO_ZSTD, which isn't defined until this patch is in

Yikes! How come I missed that... :)

> [0] lkml.kernel.org/r/9c9416b2dff19f05fb4c35879aaa83d11ff72c92.1521626182.git.geliangtang@gmail.com

Signed-off-by: Nick Terrell <terrelln@fb.com> ?

	-ss
