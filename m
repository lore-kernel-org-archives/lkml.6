Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751447AbeBRNVI (ORCPT <rfc822;w@1wt.eu>);
        Sun, 18 Feb 2018 08:21:08 -0500
Received: from mail-qk0-f182.google.com ([209.85.220.182]:41606 "EHLO
        mail-qk0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751361AbeBRNVG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Feb 2018 08:21:06 -0500
X-Google-Smtp-Source: AH8x227LgHF3PFTMczDoQ6xNq8CWiVdrcEwqxDH1u8hr5JWK7KaF6pY+wY8US3QhjqtwQn8g3oB0zQ==
Date: Sun, 18 Feb 2018 05:21:02 -0800
From: Tejun Heo <tj@kernel.org>
To: SF Markus Elfring <elfring@users.sourceforge.net>
Cc: linux-ide@vger.kernel.org,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] pata_samsung_cf: Delete an error message for a failed
 memory allocation in pata_s3c_probe()
Message-ID: <20180218132102.GB695913@devbig577.frc2.facebook.com>
References: <b757fb06-dde6-b1f6-77fa-f5301fb6fec1@users.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b757fb06-dde6-b1f6-77fa-f5301fb6fec1@users.sourceforge.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 16, 2018 at 11:08:18AM +0100, SF Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Fri, 16 Feb 2018 10:55:51 +0100
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
