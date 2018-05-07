Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752402AbeEGPje (ORCPT <rfc822;w@1wt.eu>);
        Mon, 7 May 2018 11:39:34 -0400
Received: from mail-yw0-f193.google.com ([209.85.161.193]:40079 "EHLO
        mail-yw0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751931AbeEGPjc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 May 2018 11:39:32 -0400
X-Google-Smtp-Source: AB8JxZoeXT6WM1TTOPa3mHtwl3hS59BgbYUOyqtEIR1nfdbzzrZmNVfWECz5LoPm15Ad94VVAFd+Sw==
Date: Mon, 7 May 2018 08:32:36 -0700
From: Tejun Heo <tj@kernel.org>
To: Mathieu Malaterre <malat@debian.org>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] driver core: add __printf verification to
 __ata_ehi_pushv_desc
Message-ID: <20180507153236.GE2368884@devbig577.frc2.facebook.com>
References: <20180505200038.17840-1-malat@debian.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180505200038.17840-1-malat@debian.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 05, 2018 at 10:00:37PM +0200, Mathieu Malaterre wrote:
> __printf is useful to verify format and arguments. Remove the following
> warning (with W=1):
> 
>   drivers/ata/libata-eh.c:183:10: warning: function might be possible candidate for ‘gnu_printf’ format attribute [-Wsuggest-attribute=format]
> 
> Signed-off-by: Mathieu Malaterre <malat@debian.org>

Applied to libata/for-4.17-fixes.

Thanks.

-- 
tejun
