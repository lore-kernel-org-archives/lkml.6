Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754605AbeEaKyp (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 06:54:45 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:43525 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754459AbeEaKyn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 06:54:43 -0400
X-Google-Smtp-Source: ADUXVKIerhdzdRHeox26C50PRny46fbDx8w7H5Id1lwOzebnt/rMlACpue3ASGPM0TOKUGkdDiE9+Q==
Date: Thu, 31 May 2018 19:54:38 +0900
From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To: Maninder Singh <maninder1.s@samsung.com>
Cc: pmladek@suse.com, sergey.senozhatsky@gmail.com, rostedt@goodmis.org,
        linux-kernel@vger.kernel.org, a.sahrawat@samsung.com,
        pankaj.m@samsung.com, v.narang@samsung.com
Subject: Re: [PATCH 1/2] printk: remove unused flag LOG_NOCONS
Message-ID: <20180531105438.GG477@jagdpanzerIV>
References: <CGME20180531102133epcas5p2e8d47887c1708836c9b70964983093e2@epcas5p2.samsung.com>
 <20180531102133epcas5p2e8d47887c1708836c9b70964983093e2~zs4eTmEuv0380103801epcas5p2U@epcas5p2.samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180531102133epcas5p2e8d47887c1708836c9b70964983093e2~zs4eTmEuv0380103801epcas5p2U@epcas5p2.samsung.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (05/31/18 15:47), Maninder Singh wrote:
> 
> This patch removes unused flag LOG_NOCONS for printk.
> usage of this flag is removed long back with below commit.
> 
> "5c2992ee7fd8a29d04125dc0aa3522784c5fa5eb"
> printk: remove console flushing special cases for
>  partial buffered lines
> 
> Signed-off-by: Maninder Singh <maninder1.s@samsung.com>
> Signed-off-by: Vaneet Narang <v.narang@samsung.com>

Makes sense.

Reviewed-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>

	-ss
