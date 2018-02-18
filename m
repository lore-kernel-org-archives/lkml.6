Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751502AbeBRNXp (ORCPT <rfc822;w@1wt.eu>);
        Sun, 18 Feb 2018 08:23:45 -0500
Received: from mail-qt0-f170.google.com ([209.85.216.170]:33378 "EHLO
        mail-qt0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751407AbeBRNXm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Feb 2018 08:23:42 -0500
X-Google-Smtp-Source: AH8x226UWsZdUrDZDcLQr3Wc9u66BFzuzFrsDtDSVD9Dq6u5L2Ngc8KcntndMskRd0UO1MKtr892tA==
Date: Sun, 18 Feb 2018 05:23:38 -0800
From: Tejun Heo <tj@kernel.org>
To: SF Markus Elfring <elfring@users.sourceforge.net>
Cc: linux-ide@vger.kernel.org,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] pata_mpc52xx: Delete an error message for a failed
 memory allocation in mpc52xx_ata_probe()
Message-ID: <20180218132338.GD695913@devbig577.frc2.facebook.com>
References: <b9749bf6-0bbb-2b2d-b946-aae893f3e305@users.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b9749bf6-0bbb-2b2d-b946-aae893f3e305@users.sourceforge.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 16, 2018 at 11:44:13AM +0100, SF Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Fri, 16 Feb 2018 11:34:53 +0100
> 
> Omit an extra message for a memory allocation failure in this function.
> 
> This issue was detected by using the Coccinelle software.
> 
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>

Applied to libata/for-4.17.

Thanks.

-- 
tejun
