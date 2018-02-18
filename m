Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751518AbeBRN1N (ORCPT <rfc822;w@1wt.eu>);
        Sun, 18 Feb 2018 08:27:13 -0500
Received: from mail-qt0-f179.google.com ([209.85.216.179]:41877 "EHLO
        mail-qt0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751377AbeBRN1K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Feb 2018 08:27:10 -0500
X-Google-Smtp-Source: AH8x226fr6lsteKujrabN4EwlugeWt/YdNFbsQMpx5HHHHBPTSwsQ19aSe6uMjQelPFlWmq5Y7Vdgw==
Date: Sun, 18 Feb 2018 05:27:06 -0800
From: Tejun Heo <tj@kernel.org>
To: SF Markus Elfring <elfring@users.sourceforge.net>
Cc: linux-ide@vger.kernel.org,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH 1/2] pata_it821x: Delete an error message for a failed
 memory allocation in it821x_firmware_command()
Message-ID: <20180218132706.GF695913@devbig577.frc2.facebook.com>
References: <6cdadc5e-bfbd-9866-a69f-d225e68c3b22@users.sourceforge.net>
 <939014fc-8c9e-99a4-99fb-2fde4694cd29@users.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <939014fc-8c9e-99a4-99fb-2fde4694cd29@users.sourceforge.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 16, 2018 at 03:22:18PM +0100, SF Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Fri, 16 Feb 2018 14:04:49 +0100
> 
> Omit an extra message for a memory allocation failure in this function.
> 
> This issue was detected by using the Coccinelle software.
> 
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>

Applying this one to libata/for-4.17 but skipping the next one.
There's no point in making these trivial changes.  It's just churn
without actual benefits but only risks.

Thanks.

-- 
tejun
